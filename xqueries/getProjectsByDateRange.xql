xquery version "1.0";
declare namespace eml="eml://ecoinformatics.org/project-2.1.0";

declare option exist:serialize "method=xml omit-xml-declaration=no indent=yes encoding=iso-8859-1 media-type=application/rss+xml";
(: comment  :)


let $site := 'bes' (: request:get-parameter("site",'') :)
let $xslt := '' (: request:get-parameter("xlst",'') :)
let $start_date := xs:date("2000-01-01")
let $end_date := xs:date("2015-01-01")
let $start_year := fn:year-from-dateTime($start_date cast as xs:dateTime)
let $end_year := fn:year-from-dateTime($start_date cast as xs:dateTime)

for $projects in collection(concat('/db/projects/',lower-case($site)))/eml:researchProject
where (
	((coverage/temporalCoverage/rangeOfDates/beginDate > $start_date)
		and (coverage/temporalCoverage/rangeOfDates/endDate < $end_date)) 
	or coverage/temporalCoverage/ongoing 
	or ((coverage/temporalCoverage/singleDateTime/calendarDate > $start_date) 
		and (coverage/temporalCoverage/singleDateTime/calendarDate < $end_date))
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