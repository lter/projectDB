xquery version "1.0";
(: getProjectsByParty: Xquery to return LTER research projects matching specified last name and LTER site criteria

   Parameters:    
        required: surName
        optional: sortBy, default: "title", possible values: "id", "surName"
        optional: startYear
        optional: endYear
        optional: siteId, default: all sites, possible values: three letter LTER site acronym case insensitive      
   Usage notes:
       1. an xml document will be returned with a root of <projects>, with a subset of researchProject
              in a <project> element for each match
       
     Attribution:
        Author: Corinna Gries (cgries@lternet.edu, Wade Sheldon <wsheldon@lternet.edu>
        Date: 08-Mar-2009
        Revision: 1.1

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
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
declare namespace lter="eml://ecoinformatics.org/lter-project-2.1.0";
declare namespace request="http://exist-db.org/xquery/request";

(: set output to xhtml with standards-compliant doctype and no xml declaration for IE compatibility :)
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes 
        doctype-public=-//W3C//DTD&#160;XHTML&#160;1.0&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd";

(:root element:)
<projects>{

(:get input parameters:)
let $startYr := request:get-parameter("startYear", "")
let $endYr := request:get-parameter("endYear", "")
let $siteId := lower-case(request:get-parameter("siteId", ""))
let $surNam := concat("^",request:get-parameter("surName", "\D*"))
let $sortBy := request:get-parameter("sortBy", "title")

(: calculate derived parameters, dealing with empty input arguments:)
let $startYear := number(if(string-length($startYr)>0) then substring($startYr,1,4) else "0")  (: force numeric 4-digit year :)
let $endYear := number(if(string-length($endYr)>0) then substring($endYr,1,4) else "5000")  (: force numeric 4-digit year :)
let $surName := if(string-length($surNam)>0) then concat("^",$surNam) else "^\D*" (: pre-pend carrot to force beginning of string search in regex :)

for $p in collection(concat('/db/projects/data/',lower-case($siteId)))/*:researchProject

   let $title := $p/title/text()
   let $idstr := $p/@id
   let $time := $p/coverage/temporalCoverage
   let $sort := $p/(if ($sortBy = "id") then @id else (if ($sortBy = "surName") then surName else title))

   let $beginDate := number(substring(data($p/coverage/temporalCoverage//beginDate/calendarDate),1,4))
   let $singleDate := number(substring(data($p/coverage/temporalCoverage/singleDateTime/calendarDate),1,4))
   let $endDate := number(substring(data($p/coverage/temporalCoverage//endDate/calendarDate),1,4))

where matches($p//surName,$surName,'i') 
    and ($beginDate >= $startYear or $singleDate >= $startYear)
    and ($endDate <= $endYear or not($endDate))  
    and ($beginDate <= $endYear or $singleDate <= $endYear)

order by $sort

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
    </project>	
}
</projects>

