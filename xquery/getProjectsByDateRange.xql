xquery version "1.0";
declare namespace eml="eml://ecoinformatics.org/project-2.1.0";
declare namespace res="eml://ecoinformatics.org/resource-2.1.0";

declare option exist:serialize "method=xml";
declare option exist:serialize "omit-xml-declaration=no";
declare option exist:serialize "indent=yes";

(: a function to return the simpleDateTimeType :)
declare function local:yearDate($datestring as xs:string) 
	as xs:gYear {
	    xs:gYear(substring($datestring, 1, 4))};
 
(: grab the request parameters :)
let $site := request:get-parameter("site",'')
let $xslt := request:get-parameter("xlst",'')
let $min_date := xs:date(request:get-parameter('min_date',current-date() cast as xs:string)) 
let $max_date := xs:date(request:get-parameter('max_date', current-date() cast as xs:string))

(: find the relevant projects :)
for $projects in collection(concat('/db/projects/',lower-case($site)))/eml:researchProject
	let $date := $projects/coverage/temporalCoverage
where (
	(($date/rangeOfDates/beginDate > $min_date)
		and ($date/rangeOfDates/endDate < $max_date)) 
	or $date/ongoing 
	or (($date/singleDateTime/calendarDate > $min_date) 
		and ($date/singleDateTime/calendarDate < $max_date))
	)

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
