xquery version "1.0";
(: getProjects: Xquery to return LTER research projects matching specified last name and LTER site criteria

   Parameters:    
        optional: surName (string)
        optional: sortBy, default: "title", other possible values: "id", "surName" (string)
        optional: startYear (string, first four characters used)
        optional: endYear (string, first four characters used)
        optional: siteId, default: all sites, possible values: three letter LTER site acronym case (string, case insensitive)      
        optional: minLon = minimum longitude / western search boundary (empty string or number, decimal degrees)
        optional: maxLon = maximum longitude / eastern search boundary (empty string or number, decimal degrees)
        optional: minLat = minimum latiutde / southern search boundary (empty string or number, decimal degrees)
        optional: maxLat = maximum latitude / northern search boundary (empty string or number, decimal degrees)
        optional: keyword = keyword to search / partial string match (string, case-sensitive)
        optional keywordSet = keyword set name to search (string, optional, case-insensitive)
        optional: text = text in the title and abstract to search (string, optional, case-insensitive)

   Usage notes:
       1. latitudes and longitudes are offset to >=0 to accomodate western and southern hemispheres 
       2. three possible bounding box match cases are evaluated:
              case 1 = project coverage is entirely within query bounds
              case 2 = project coverage overlaps query bounds
              case 3 = project coverage is entirely contained by query bounds
       3. all parameters are optional - for example, omitting a latitude/longitude boundary removes restrictions for that 
              boundary, and omitting the siteId enables searching across all sites 
       4. an xml document will be returned with a root of <projects>, with a subset of researchProject
              in a <project> element for each match
       
     Attribution:
        Authors: Wade Sheldon <wsheldon@lternet.edu>, Corinna Gries (cgries@lternet.edu), Sven Bohm <sbohm@lternet.edu>
        Date: 01-May-2009
        Revision: 1.3

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
declare namespace exist = "http://exist.sourceforge.net/NS/exist";

(: set output to xhtml for IE compatibility :)
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes 
        doctype-public=-//W3C//DTD&#160;XHTML&#160;1.0&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd";

(:root element:)
<projects>{

(: get all input arguments as strings, with default values as appropriate :)
    let $siteId := request:get-parameter("siteId", "")
    let $startYr := request:get-parameter("startYear", "")
    let $endYr := request:get-parameter("endYear", "")
    let $surNam := request:get-parameter("surName", "")
    let $minLo := request:get-parameter("minLon","")
    let $maxLo := request:get-parameter("maxLon","")
    let $minLa := request:get-parameter("minLat","")
    let $maxLa := request:get-parameter("maxLat","")
    let $keywrd := request:get-parameter("keyword","")
    let $keywdSet := request:get-parameter("keywordSet","")
    let $txt := request:get-parameter("text","")
    let $sortBy := request:get-parameter("sortBy", "title")

(: generate single parameter cache :)
return

          <params>
            <param name="siteId">{$siteId}</param>
            <param name="minLon">{$minLo}</param>
            <param name="maxLon">{$maxLo}</param>
            <param name="minLat">{$minLa}</param>
            <param name="maxLat">{$maxLa}</param>
            <param name="startYear">{$startYr}</param>
            <param name="endYear">{$endYr}</param>
            <param name="surName">{$surNam}</param>
            <param name="keyword">{$keywrd}</param>
            <param name="keywordSet">{$keywdSet}</param>
            <param name="text">{$txt}</param>
            <param name="sortBy">{$sortBy}</param>
        </params>
}
{
(: get all input arguments as strings, with default values as appropriate :)
    let $siteId := request:get-parameter("siteId", "")
    let $startYr := request:get-parameter("startYear", "")
    let $endYr := request:get-parameter("endYear", "")
    let $surNam := request:get-parameter("surName", "")
    let $minLo := request:get-parameter("minLon","")
    let $maxLo := request:get-parameter("maxLon","")
    let $minLa := request:get-parameter("minLat","")
    let $maxLa := request:get-parameter("maxLat","")
    let $keywrd := request:get-parameter("keyword","")
    let $keywdSet := request:get-parameter("keywordSet","")
    let $txt := request:get-parameter("text","")
    let $sortBy := request:get-parameter("sortBy", "title")

(: calculate derived parameters, dealing with empty input arguments:)
    let $startYear := number(if(string-length($startYr)>0) then substring($startYr,1,4) else "0")  (: force numeric 4-digit year :)
    let $endYear := number(if(string-length($endYr)>0) then substring($endYr,1,4) else "5000")  (: force numeric 4-digit year :)
    let $surName := if(string-length($surNam)>0) then concat("^",$surNam) else "^\D*" (: pre-pend carrot to force beginning of string search in regex :)
    let $keyword := if(string-length($keywrd) > 0) then (if($keywrd = "*") then "\D*" else $keywrd) else "\D*"   (: substitute regex wildcard for empty string or * :)
    let $text := if(string-length($txt) > 0) then (if($txt = "*") then "\D*" else $txt) else "\D*"   (: substitute regex wildcard for empty string or * :)

 (: convert lat/lon to numeric and offset to >= 0 for comparisons, setting empty values to full geographic extent  :)
    let $minLon := if(string-length($minLo) > 0) then (number($minLo) + 180.0) else (0)
    let $maxLon := if(string-length($maxLo) > 0) then (number($maxLo) + 180.0) else (360)
    let $minLat := if(string-length($minLa) > 0) then (number($minLa) + 90.0) else (0)
    let $maxLat := if(string-length($maxLa) > 0) then (number($maxLa) + 90.0) else (180)

for $p in collection(concat('/db/projects/data/',lower-case($siteId)))/lter:researchProject

                (: note: for the project coverage boundaries, both the original extents and offset extents are instantiated as variables
                 to support both searching and inclusion of the overall extents in the output without the offsets :)
	let $west0 := min($p/coverage/geographicCoverage/boundingCoordinates/westBoundingCoordinate)
	let $east0 := max($p/coverage/geographicCoverage/boundingCoordinates/eastBoundingCoordinate)
	let $north0 := max($p/coverage/geographicCoverage/boundingCoordinates/northBoundingCoordinate)
	let $south0 := min($p/coverage/geographicCoverage/boundingCoordinates/southBoundingCoordinate)
	
	(: offset lat/lon for comparisons :)
	let $west := $west0 + 180
	let $east := $east0 + 180
	let $north := $north0 + 90
	let $south := $south0 + 90

               (: get and cache context nodes for comparisons :)
	let $sort := $p/(if ($sortBy = "id") then @id else (if ($sortBy = "surName") then creator[1]/individualName/surName else title))
	let $title := $p/title/text()
	let $idstr := $p/@id
	let $time := $p/coverage/temporalCoverage	
	let $keywordSet := if(string-length($keywdSet)>0) then $p/keywordSet[@name=$keywdSet] else $p/keywordSet
	let $beginDate := number(substring(data($p/coverage/temporalCoverage//beginDate/calendarDate),1,4))
	let $singleDate := number(substring(data($p/coverage/temporalCoverage/singleDateTime/calendarDate),1,4))
	let $endDate := number(substring(data($p/coverage/temporalCoverage//endDate/calendarDate),1,4))

(: define query restriction :)
where (($west >= $minLon and $east <= $maxLon and $south >= $minLat and $north <= $maxLat)	
        or ((($west >= $minLon and $west <= $maxLon) or ($east >= $minLon and $east <= $maxLon)) 
        and (($south >= $minLat and $south <= $maxLat) or ($north >= $minLat and $north <= $maxLat)))	
        or ($west <= $minLon and $east >= $maxLon and $south <= $minLat and $north >= $maxLat))
        and ($beginDate >= $startYear or $singleDate >= $startYear)
        and ($endDate <= $endYear or not($endDate))  
        and ($beginDate <= $endYear or $singleDate <= $endYear)
        and matches($p//surName,$surName,'i') and matches($keywordSet/keyword,$keyword,'i') 
        and matches(($p//title | $p/abstract//para/text() | $p/abstract//literalLayout/text()),$text,'i')             
   
order by $sort

return

    <project id="{$idstr}">

          <title>{$title}</title>
    
          {for $c in $p/creator
           let $individual := $c/individualName
           let $userid := $c/userId
           return
           if (not($individual)) then () else <creator>{$individual}{$userid}</creator>}
        
          {for $c in $p/creator/references
           let $id := $c/text()
           let $ref := $p/associatedParty[@id = $id]
           let $individual := $ref/individualName
           let $userid := $ref/userId
           return
           if (not($individual)) then <id>{data($id)}</id> else <creator>{$individual}{$userid}</creator>}
        
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