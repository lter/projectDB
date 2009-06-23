xquery version "1.0";
(: getProjectByKeyword: Xquery to return LTER research projects matching a specified keyword

   Parameters:
       keyword = keyword to search / partial string match (string, required, case-insensitive)
       keywordSet = keyword set name to search (string, optional, case-insensitive)
       siteID = LTER site 3-letter acronym (string, optional, case-insensitive)
       
   Usage notes:
       1. if keywordSet is omitted, all keywordSet elements will be searched
       2. an xml document will be returned with a root of <projects>, with a subset of researchProject
              in a <project> element for each match, sorted by project id
       
     Attribution:
        Author: Wade Sheldon <wsheldon@lternet.edu>
        Date: 23-Jun-2009
        Revision: 1.2

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
declare namespace lter="eml://ecoinformatics.org/project-2.1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace xs="http://www.w3.org/2001/XMLSchema";
 
(: set output to xhtml with standards-compliant doctype and no xml declaration for IE compatibility :)
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes 
        doctype-public=-//W3C//DTD&#160;XHTML&#160;1.0&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd";

(: get input arguments :)
let $keyword := request:get-parameter("keyword","")
let $keywordSet := request:get-parameter("keywordSet","")
let $siteId := request:get-parameter("siteId", "")

return

if (string-length($keyword) > 0)
then (
<projects>
{ 
   for $p in collection(concat('/db/projects/data/',lower-case($siteId)))/lter:researchProject

	let $title := $p/title/text()
	let $idstr := $p/@id
	let $time := $p/coverage/temporalCoverage

           let $kw := if(string-length($keywordSet)>0) then $p/keywordSet[@name=$keywordSet] else $p/keywordSet
           
         	where matches($kw/keyword,$keyword,'i')
              	
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
	</project>
}
</projects>)
else (<projects/>)