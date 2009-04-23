xquery version "1.0";
declare namespace eml="eml://ecoinformatics.org/project-2.1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace transform="http://exist-db.org/xquery/transform";
declare option exist:serialize "method=xhtml media-type=text/html";


for $researchProject in collection('/db/projects')/project
return
	$researchProject

