(:	getProjectsDatasets.xql: XQuery to return all the datasets from a project 
	
		Parameters:	
			id = the project id
			
		Usage Notes:
		
		Attribution:
       Author: Sven Böhm <bohms@lternet.edu>
       Date: 22-Apr-2009
       Revision: 0.1
	
		License:
        This program is free software; you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation; either version 2 of the License, or
        (at your option) any later version.
    
        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details (Free Software Foundation, Inc., 
        59 Temple Place, Suite 330, Boston, MA  02111-1307  USA)
:)
xquery version "1.0";
import schema namespace eml="eml://ecoinformatics.org/project-2.1.0";

declare option exist:serialize "method=xml";
declare option exist:serialize "omit-xml-declaration=no";
declare option exist:serialize "indent=yes";

let $id := request:get-parameter('id','')

let $projects := collection('/db/projects')/lter:researchProject[@id=$id]
let $datasets := $projects/associatedMaterial[lower-case(@category)='dataset']

return
$projects
<eml>{
	for $dataset in $datasets
		return
		<dataset id="{data($dataset/@id)}">
			{$dataset/distribution}
		</dataset>
}	
</eml>
