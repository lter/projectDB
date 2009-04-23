xquery version "1.0";
(:	getProjectsByTextSearch.xql: XQuery to return all projects or projects from a site by searching
for a string in title, creator/individualName/surname, keywordSet/keyword, or any para tags
	
		Parameters:	
			siteId = the three letter site acronym 
			keyword = the word or sentence to search for 
			sortBy = (optional) default title
			
		Usage Notes:
			search is case sensitive, but can use regex.
		
		Attribution:
       Author: Sven Böhm <bohms@lternet.edu>
       Date: 22-Apr-2009
       Revision: 0.1
	
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
declare namespace eml="eml://ecoinformatics.org/project-2.1.0";

declare option exist:serialize "method=xhtml media-type=text/html";

(: currently a single keyword or phrase is supported :)
let $keyword := request:get-parameter("keyword",'')
let $site := request:get-parameter("siteId",'')
let $sortBy := request:get-parameter('sortBy','title')
 
for $projects in collection(concat('/db/projects/',lower-case($site)))/lter:researchProject
where (matches($projects/title, $keyword)
	or matches($projects/creator/individualName/surName, $keyword)
	or matches($projects/keywordSet/keyword, $keyword)
	or matches($projects//para, $keyword))
order by $sortBy
return
<projects>{
	<project id="{$projects/@id}">
			<title>{$projects/title/text()}</title>
			{for $creators in $projects/creator
			let $individual := $creators/individualName
			let $userid := $creators/userId
			return
			<creator>{$individual}{$userid}</creator>}
			{for $people in $projects/associatedParty
			let $person_name := $people/individualName
			let $person_id := $people/userId
			let $role := $people/role
			return
			<associatedParty>{$person_name}{$person_id}{$role}</associatedParty>}
			<keywordSet>{for $keywords in $projects/keywordSet/keyword
			let $keyword := $keywords/text()
			return
			<keyword>{$keyword}</keyword>}
			</keywordSet>
			{$projects/time}
	</project>}
</projects>