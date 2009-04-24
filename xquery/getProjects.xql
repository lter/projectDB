xquery version "1.0";
(: getProjectsByParty: Xquery to return LTER research projects matching specified last name and LTER site criteria

   Parameters:    
        optional: surName
        optional: sortBy, default: "title", possible values: "id", "surName"
        optional: startYear
        optional: endYear
        optional: siteId, default: all sites, possible values: three letter LTER site acronym case insensitive      
        optional: minLon = minimum longitude / western search boundary (decimal degrees)
        optional: maxLon = maximum longitude / eastern search boundary (decimal degrees)
        optional: minLat = minimum latiutde / southern search boundary (decimal degrees)
        optional: maxLat = maximum latitude / northern search boundary (decimal degrees)
   Usage notes:
       1. latitudes and longitudes are offset to >=0 to accomodate western and southern hemispheres 
       2. three possible bounding box match cases are evaluated:
              case 1 = project coverage is entirely within query bounds
              case 2 = project coverage overlaps query bounds
              case 3 = project coverage is entirely contained by query bounds
       3. all parameters are optional - omitting a latitude/longitude boundary removes restrictions for that 
              boundary, and omitting the siteId enables searching across all sites 
       4. an xml document will be returned with a root of <projects>, with a subset of researchProject
              in a <project> element for each match
       
     Attribution:
        Author: Wade Sheldon <wsheldon@lternet.edu>, Corinna Gries (corinna@asu.edu
        Date: 22-Apr-2009
        Revision: 1.0

    License:
        This program is free software; you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation; either version 2 of the License, or
        (at your option) any later version.
    
        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details (Free Software Foundation, Inc., 
        59 Temple Place, Suite 330, Boston, MA  02111-1307  USA)
:)

(: declare namespaces referenced in the document :)
declare namespace lter="eml://ecoinformatics.org/lter-project-2.1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace xs="http://www.w3.org/2001/XMLSchema";

(: set output to xml :)
declare option exist:serialize "method=xhtml media-type=text/html";


(:root element:)
<projects>{

(: get input arguments, offsetting lat/lon to >= 0 for comparisons :)
    let $minLo := number(request:get-parameter("minLon",-180.0))
    let $maxLo := number(request:get-parameter("maxLon",180.0))
    let $minLa := number(request:get-parameter("minLat",-90.0))
    let $maxLa := number(request:get-parameter("maxLat",90.0))
    let $minLon := $minLo + 180
    let $maxLon := $maxLo + 180
    let $minLat := $minLa + 90
    let $maxLat := $maxLa + 90
    let $siteId := request:get-parameter("siteId", "")
    let $startYear := substring(request:get-parameter("startYear", "0"),1,4)
    let $endYear := substring(request:get-parameter("endYear", "5000"),1,4)
    let $surNam := request:get-parameter("surName", "\D*")
    let $surName := concat("^", $surNam)
    
for $p in collection(concat('/db/projects/',lower-case($siteId)))/lter:researchProject

(: note: for the project coverage boundaries, both the original extents and offset extents are instantiated as variables
 to support both searching and inclusion of the overall extents in the output without the offsets :)
	let $west0 := min($p/coverage/geographicCoverage/boundingCoordinates/westBoundingCoordinate)
	let $east0 := max($p/coverage/geographicCoverage/boundingCoordinates/eastBoundingCoordinate)
	let $north0 := max($p/coverage/geographicCoverage/boundingCoordinates/northBoundingCoordinate)
	let $south0 := min($p/coverage/geographicCoverage/boundingCoordinates/southBoundingCoordinate)
	
	let $west := $west0 + 180
	let $east := $east0 + 180
	let $north := $north0 + 90
	let $south := $south0 + 90

	let $sortBy := request:get-parameter("sortBy", "title")
	let $sort := $p/(if ($sortBy = "id") then @id else (if ($sortBy = "surName") then creator[1]/individualName/surName else title))
	let $title := $p/title/text()
	let $idstr := $p/@id
	let $time := $p/coverage/temporalCoverage


where (($west >= $minLon and $east <= $maxLon and $south >= $minLat and $north <= $maxLat)	
	    or ((($west >= $minLon and $west <= $maxLon) or ($east >= $minLon and $east <= $maxLon)) 
	    and (($south >= $minLat and $south <= $maxLat) or ($north >= $minLat and $north <= $maxLat)))	
	    or ($west <= $minLon and $east >= $maxLon and $south <= $minLat and $north >= $maxLat))
        and (compare(substring(data($p/coverage/temporalCoverage//beginDate/calendarDate),1,4),$startYear) = 1
	    or compare(substring(data($p/coverage/temporalCoverage/singleDateTime/calendarDate),1,4),$startYear) = 1)
	    and compare(substring(data($p/coverage/temporalCoverage//beginDate/calendarDate),1,4),$endYear) = -1
	    and matches($p//surName,$surName,'i')
	        
order by $sort

return

	<project id="{$idstr}">
	<params>
        <param name="siteId">{$siteId}</param>
        <param name="minLon">{$minLo}</param>
        <param name="maxLon">{$maxLo}</param>
        <param name="minLat">{$minLa}</param>
        <param name="maxLat">{$maxLa}</param>
        <param name="startYear">{$startYear}</param>
        <param name="endYear">{$endYear}</param>
        <param name="surNam">{$surName}</param>
    </params>

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
   	
   	<coverage>
	<geographicCoverage>
	<geographicDescription> {concat("Overall geographic extent of project ",$idstr)}</geographicDescription>
        	<boundingCoordinates>
        	<westBoundingCoordinate>{$west0}</westBoundingCoordinate>
        	<eastBoundingCoordinate>{$east0}</eastBoundingCoordinate>
        	<northBoundingCoordinate>{$north0}</northBoundingCoordinate>
        	<southBoundingCoordinate>{$south0}</southBoundingCoordinate>
        	</boundingCoordinates>
	</geographicCoverage>
	{$time}	
               </coverage>	
	</project>
}	
</projects>