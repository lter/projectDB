xquery version "1.0";
(: projects.xql: Xquery to return all project documents as a single xml file

   Parameters:
        none
                
     Attribution:
        Author: Corinna Gries <cgries@lternet.edu>, Wade Sheldon <wsheldon@lternet.edu>
        Date: 08-May-2009
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
declare namespace lter="eml://ecoinformatics.org/project-2.1.0";
declare namespace exist = "http://exist.sourceforge.net/NS/exist"; 

(: set output to xml :)
declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=no indent=yes";

(: dump all documents :)
<projects> {
for $researchProject in collection('/db/projects/data')
return
   $researchProject
}
</projects>
