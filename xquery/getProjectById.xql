xquery version "1.0";
declare namespace lter="eml://ecoinformatics.org/lter-project-2.1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare option exist:serialize "method=xhtml media-type=text/html";

let $id:= request:get-parameter("id",0)

for $researchProject in collection('/db/projects')//lter:researchProject[@id = $id]

return 
	$researchProject
