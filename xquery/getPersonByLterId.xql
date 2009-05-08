xquery version "1.0";
(: getPersonByLterId: Xquery to return LTER personnel matching a specified personnel database id

   Parameters:
       required: id = id to retrieve (integer)
     
    Usage notes:
        1. output is an xml file with root <people> and a <person> element for each match 
            containing personnel name and contact information
            
     Attribution:
        Author: James Brunt <jbrunt@lternet.edu>, Wade Sheldon <wsheldon@lternet.edu>
        Date: 08-May-2009
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
declare namespace exist = "http://exist.sourceforge.net/NS/exist"; 
declare namespace request = "http://exist-db.org/xquery/request";
 
(: set output to xml :)
declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=no indent=yes";

(: get input arguments :)
let $strId := request:get-parameter("id","")

return

if (string-length($strId) > 0)
then (
<people>
{ 
for $p in collection("/db/personnel")/*:root/row
    let $id := number($strId)
    where $p/personid = $id
return 
<person>{$p/*}</person>
}
</people>)
else (<people/>)
