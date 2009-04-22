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
let $start_date := local:yearDate(request:get-parameter('start_date',current-date()))
let $end_date := local:yearDate(request:get-parameter('end_date', current_date())) (: minus 1 year? :)

for $projects in collection(concat('/db/projects/',lower-case($site)))/eml:researchProject
	let $ids := $projects/@id
	let $dates := $projects/permissions/temporalCoverage
where ((: $projects/reporting[@recipient = $recipient]
 	and :)($dates/ongoing 
	or (($dates/rangeOfDates/beginDate > $start_date)
			and ($dates/rangeOfDates/endDate < $end_date))
	or (($dates/singleDateTime/calendarDate > $start_date) 
			and ($dates/singleDateTime/calendarDate < $end_date)))
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