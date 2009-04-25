xquery version "1.0";
declare namespace lter="eml://ecoinformatics.org/project-2.1.0";

(: set output to xhtml with standards-compliant doctype and no xml declaration for IE compatibility :)
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes 
        doctype-public=-//W3C//DTD&#160;XHTML&#160;1.0&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd";

<projects>{
for $p in collection("/db/projects/data")/lter:researchProject
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