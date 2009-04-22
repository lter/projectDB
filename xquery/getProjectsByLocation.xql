(: Xquery to return LTER research projects matching specified geographic bounds and LTER site criteria

   Usage notes:
       1. latitudes and longitudes are offset to >=0 to accomodate western and southern hemispheres 
       2. three possible bounding box match cases are evaluated:
              case 1 = project coverage is entirely within query bounds
              case 2 = project coverage overlaps query bounds
              case 3 = project coverage is entirely contained by query bounds
       3. all parameters are optional - omitting a lat/lon removes restrictions for that dimension
       
  by Wade Sheldon <wsheldon@lternet.edu>, GCE-LTER Project
  last modified: 22-Apr-2009 :)

declare namespace eml="eml://ecoinformatics.org/project-2.1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace xs="http://www.w3.org/2001/XMLSchema";

(: set output to xml :)
declare option exist:serialize "method=xml";
declare option exist:serialize "omit-xml-declaration=no";
declare option exist:serialize "indent=yes";

(: get input arguments, offsetting lat/lon to >= 0 for comparisons :)
let $minLon := number(request:get-parameter("minLon",-180.0)) +180
let $maxLon := number(request:get-parameter("maxLon",180.0)) + 180
let $minLat := number(request:get-parameter("minLat",-90.0)) + 90
let $maxLat := number(request:get-parameter("maxLat",90.0)) + 90
let $siteId := request:get-parameter("siteId", "")

return

<projects>

{for $p in collection(concat('/db/projects/',lower-case($siteId)))/eml:researchProject

	let $title := $p/title/text()
	let $idstr := $p/@id
	let $time := $p/coverage/temporalCoverage
	
	let $west := min($p/coverage/geographicCoverage/boundingCoordinates/westBoundingCoordinate) + 180
	let $east := max($p/coverage/geographicCoverage/boundingCoordinates/eastBoundingCoordinate) + 180
	let $south := min($p/coverage/geographicCoverage/boundingCoordinates/southBoundingCoordinate) + 90
	let $north := max($p/coverage/geographicCoverage/boundingCoordinates/northBoundingCoordinate) + 90

	where (($west >= $minLon and $east <= $maxLon and $south >= $minLat and $north <= $maxLat)	
	or ((($west >= $minLon and $west <= $maxLon) or ($east >= $minLon and $east <= $maxLon)) and
	(($south >= $minLat and $south <= $maxLat) or ($north >= $minLat and $north <= $maxLat)))	
	or ($west <= $minLon and $east >= $maxLon and $south <= $minLat and $north >= $maxLat))
	
	order by $idstr
	
	return
	
	<project id="{$idstr}">
   	<title>{$title}</title>

  	{for $c in $p/creator
   	let $individual := $c/individualName
   	let $userid := $c/userId
   	return
   	<creator>{$individual}{$userid}</creator>}

   	{for $ap in $p/associatedParty
   	let $ap_name := $ap/individualName
   	let $ap_id := $ap/userId
   	let $role := $ap/role
   	return
   	<associatedParty>{$ap_name}{$ap_id}{$role}</associatedParty>}

   	<keywordSet>{for $k in $p/keywordSet/keyword
   	let $kw := $k/text()
   	return
   	<keyword>{$kw}</keyword>}
   	</keywordSet>
   	
	{$time}
	</project>}
	
</projects>