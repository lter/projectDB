xquery version "1.0";
declare namespace eml="eml://ecoinformatics.org/project-2.1.0";

declare option exist:serialize "method=xml omit-xml-declaration=no indent=yes encoding=iso-8859-1 media-type=application/rss+xml";
(: comment  :)

let $site := 'bes' (: request:get-parameter("site",'') :)
let $xslt := '' (: request:get-parameter("xlst",'') :)
let $recipient := 'CAP Management' (: request:get-parameter('recipient',''):)
let $start_date := xs:date("2000-01-01")
let $end_date := xs:date("2015-01-01")

for $projects in collection(concat('/db/projects/',lower-case($site)))/eml:researchProject
where ($projects/reporting[@recipient = $recipient]
 	and ($projects/coverage/temporalCoverage/ongoing 
	or (($projects/coverage/temporalCoverage/rangeOfDates/beginDate > $start_date)
			and ($projects/coverage/temporalCoverage/rangeOfDates/endDate < $end_date))
	or (($projects/coverage/temporalCoverage/singleDateTime/calendarDate > $start_date) 
			and ($projects/coverage/temporalCoverage/singleDateTime/calendarDate < $end_date)))
	)
return
<projects>{
		for $projects in collection("/db/projects")/eml:researchProject
			let $title := $projects/title/text()
			let $idstr := $projects/@id
			let $time := $projects/coverage/temporalCoverage
			order by $idstr
			return
		    <project id="{$idstr}">
			<title>{$title}</title>
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
			{$time}
			<reporting>
				{$projects/reporting}
			</reporting>
	</project>}
</projects>