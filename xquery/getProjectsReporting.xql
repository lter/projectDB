(:	getProjectsReporting.xql: XQuery to return reports from the projects

		Parameters:	
			siteId = the three letter site acronym 
			id = (optional) the project id
			sortsBy = default title, other values id, surname
			startYear = the earlier date boundary
			endYear = the later date boundary
			recipient = the recipient of the report
			xslt = the xslt styelsheet reference to include (not implemented)
			
		Usage Notes:
		
		Attribution:
       Author: Sven Böhm <bohms@lternet.edu>
       Date: 23-Apr-2009
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

declare option exist:serialize "method=xml";
declare option exist:serialize "omit-xml-declaration=no";
declare option exist:serialize "indent=yes";

declare function local:yearDate($datestring as xs:string) 
	as xs:gYear {
	    xs:gYear(substring($datestring, 1, 4))};


let $site := request:get-parameter("site",'')
let $xslt := request:get-parameter("xlst",'')
let $recipient := request:get-parameter('recipient','')
let $sortBy := request:get-parameter('sortBy', 'title')
let $min_date := request:get-parameter('startYear', '') cast as xs:string
let $max_date := request:get-parameter('endYear', '') cast as xs:string

(: TODO: check that values are legal :)

(: find the relevant projects within the date range :)

let $ongoingProjects := collection(concat('/db/projects/',lower-case($site)))/*:researchProject[./coverage/temporalCoverage/ongoing/beginDate > $min_date]
let $singleDateProjects := collection(concat('/db/projects/',lower-case($site)))/*:researchProject[./coverage/temporalCoverage/singleDateTime/calendarDate > $min_date]
let $multiDateProjects := collection(concat('/db/projects/',lower-case($site)))/*:researchProject[./coverage/temporalCoverage/rangeOfDates/beginDate > $min_date and ./coverage/temporalCoverage/rangeOfDates/endDate < $max_date]

let $possible_projects := $multiDateProjects union $ongoingProjects union $singleDateProjects

for $project in $possible_projects
where ( $project/reporting[@recipient = $recipient]
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
			{$projects/reporting}
	</project>}
</projects>