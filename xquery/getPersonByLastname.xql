(: Xquery to return LTER personnel matching a specified lastname

   Parameters:
       lastname = lastname to search / string match (string, required, case-sensitive)
     
   Usage notes:
      
     Attribution:
        Author: Wade Sheldon <wsheldon@lternet.edu>
        Date: 23-Apr-2009
        Revision: 1.0

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
declare namespace eml="eml://ecoinformatics.org/project-2.1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace xs="http://www.w3.org/2001/XMLSchema";
 
(: set output to xml :)
declare option exist:serialize "method=xml";
declare option exist:serialize "omit-xml-declaration=no";
declare option exist:serialize "indent=yes";

(: get input arguments :)
let $lastname := request:get-parameter("lastname","")

return

if (string-length($lastname) > 0)
then (
<people>
{ 

for $p in collection("/db/personnel")/*:root/row
where contains ($p/lastname, $lastname)
return $p

}
</people>)
else (<people/>)
