declare namespace eml="eml://ecoinformatics.org/project-2.1.0";
declare option exist:serialize "method=xml";
declare option exist:serialize "omit-xml-declaration=no";
declare option exist:serialize "indent=yes";
<projects>{
for $p in collection("/db/projects")/eml:researchProject
	let $title := $p/title/text()
	let $idstr := $p/@id
	let $time := $p/coverage/temporalCoverage
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
    </project>}
</projects>