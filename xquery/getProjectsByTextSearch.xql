xquery version "1.0";
declare namespace eml="eml://ecoinformatics.org/project-2.1.0";
declare namespace res="eml://ecoinformatics.org/resource-2.1.0";

declare option exist:serialize "method=xml";
declare option exist:serialize "omit-xml-declaration=no";
declare option exist:serialize "indent=yes";

let $keyword := request:get-parameter("keyword",'')
let $site := request:get-parameter("site",'')


for $projects in collection(concat('/db/projects/',lower-case($site)))/eml:researchProject
when $projects//text = $keyword

