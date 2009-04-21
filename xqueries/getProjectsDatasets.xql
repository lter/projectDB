xquery version "1.0";
declare namespace eml="eml://ecoinformatics.org/project-2.1.0";

declare option exist:serialize "method=xml omit-xml-declaration=no indent=yes encoding=iso-8859-1 media-type=application/rss+xml";

let $site := request:get-parameter("site",'')

let $projects := collection(concat('/db/projects/',lower-case($site)))/eml:researchProject
let $datasets := $projects/associatedMaterial[@category='data']

return
<eml>{
	for $dataset in $datasets
		return
		<dataset id="{data($dataset/@id)}">
			{$dataset/distribution}
		</dataset>
}	
</eml>