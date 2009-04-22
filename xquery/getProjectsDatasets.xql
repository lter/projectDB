xquery version "1.0";
import schema namespace eml="eml://ecoinformatics.org/project-2.1.0";

declare option exist:serialize "method=xml";
declare option exist:serialize "omit-xml-declaration=no";
declare option exist:serialize "indent=yes";

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
