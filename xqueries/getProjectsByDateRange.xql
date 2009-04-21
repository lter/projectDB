xquery version "1.0";
declare namespace eml="eml://ecoinformatics.org/project-2.1.0";

declare option exist:serialize "method=xml omit-xml-declaration=no indent=yes encoding=iso-8859-1 media-type=application/rss+xml";
(: comment  :)


let $site := 'Bes'
let $start_date := xs:date("2000-01-01")
let $end_date := xs:date("2015-01-01")
let $start_year := fn:year-from-dateTime($start_date cast as xs:dateTime)
let $end_year := fn:year-from-dateTime($start_date cast as xs:dateTime)

let $range_projects := collection(concat('/db/projects/',lower-case($site)))/eml:researchProject[(coverage/temporalCoverage/rangeOfDates/beginDate > $start_date and (coverage/temporalCoverage/rangeOfDates/endDate < $end_date))]
let $ongoing_projects := collection(concat('/db/projects/',lower-case($site)))/eml:researchProject[coverage/temporalCoverage/ongoing]
let $single_date_project := collection(concat('/db/projects/', lower-case($site)))/eml:reseachProject[(coverage/temporalCoverage/singleDateTime/calendarDate > $start_date) and (coverage/temporalCoverage/singleDateTime/calendarDate < $end_date) ]

let $projects := $range_projects union $ongoing_projects union $single_date_project
return
	$projects