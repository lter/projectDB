xquery version "1.0";
(: getProjectsById: Xquery to return LTER research projects by project id

   Parameters:    
       required: id = id attribute of project document to retrieve (string, case-sensitive)
       
     Attribution:
        Authors: Sven Bohm <sbohm@lternet.edu>
        Date: 22-Jun-2009
        Revision: 1.1

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

(: declare namespaces referenced in the document :)
declare namespace lter="eml://ecoinformatics.org/lter-project-2.1.0";
declare namespace request="http://exist-db.org/xquery/request";

(: set output to xhtml with standards-compliant doctype and no xml declaration for IE compatibility :)
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes 
        doctype-public=-//W3C//DTD&#160;XHTML&#160;1.0&#160;Transitional//EN 
        doctype-system=http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd";

(: get id parameter from input :)
let $id:= request:get-parameter("id","")

for $researchProject in collection('/db/projects/data')/lter:researchProject[@id = $id]

return 
	$researchProject
