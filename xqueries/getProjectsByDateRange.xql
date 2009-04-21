xquery version "1.0";
declare namespace eml="eml://ecoinformatics.org/project-2.1.0";

declare option exist:serialize "method=xml omit-xml-declaration=no indent=yes encoding=iso-8859-1 media-type=application/rss+xml";

let $site := 'GCE'
let $start_date := '2008-1-1'
let $end_date := '20010-1-1'

let $range_projects := collection(concat('/db/projects/',lower-case($site)))/eml:researchProject[(coverage/temporalCoverage/rangeOfDates/beginDate > $start_date and (coverage/temporalCoverage/rangeOfDates/endDate < $end_date))]
let $ongoing_projects := collection(concat('/db/projects/',lower-case($site)))/eml:researchProject[coverage/temporalCoverage/ongoing]

let $projects := $range_projects union $ongoing_projects
return
	$projects