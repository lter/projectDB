(:	getPermissions.xql: XQuery to return all projects that have a permission temporal coverage 
	within the query dates..
	
		Parameters:	
			site = the three letter site acronym 
			min_date = the earlier date boundary
			max_date = the later date boundary
			recipient = the recipient for the report
			xslt = the xslt styelsheet reference to include (not implemented)
			
		Usage Notes:
		
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
xquery version "1.0";
declare namespace eml="eml://ecoinformatics.org/project-2.1.0";

declare option exist:serialize "method=xml";
declare option exist:serialize "omit-xml-declaration=no";
declare option exist:serialize "indent=yes";

declare function local:yearDate($datestring as xs:string) 
	as xs:gYear {
	    xs:gYear(substring($datestring, 1, 4))};

let $site := request:get-parameter("site",'')
let $xslt := request:get-parameter("xlst",'')
let $recipient := request:get-parameter('recipient','')
let $min_date := local:yearDate(request:get-parameter('min_date',current-date()))
let $max_date := local:yearDate(request:get-parameter('max_date', current_date())) (: minus 1 year? :)

for $projects in collection(concat('/db/projects/',lower-case($site)))/*:researchProject
	let $ids := $projects/@id
	let $dates := $projects/permissions/temporalCoverage
where ((: $projects/reporting[@recipient = $recipient]
 	and :)($dates/ongoing 
	or (($dates/rangeOfDates/beginDate >= $min_date)
			and ($dates/rangeOfDates/endDate <= $max_date))
	or (($dates/singleDateTime/calendarDate >= $min_date) 
			and ($dates/singleDateTime/calendarDate <= $max_date)))
	)
order by $ids
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
			{$projects/permissions}
	</project>}
</projects>