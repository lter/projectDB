xquery version "1.0";
(: getEmlPartyByLterId: Xquery to return an EML party fragment for a LTER personnel database entry

   Parameters:
       required: id = id to retrieve (integer)
     
    Usage notes:
        1. output is an xml file with root <party>
            
     Attribution:
        Author: Wade Sheldon <wsheldon@lternet.edu>
        Date: 12-May-2009
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
declare namespace xsi = "http://www.w3.org/2001/XMLSchema-instance";

(: set output to xml :)
declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=no indent=yes";

<party>
{
let $strId := request:get-parameter("id","0")
let $id := if (string-length($strId) > 0) then (number($strId)) else (0)

for $p in doc("/db/personnel/personnel.xml")/root/row
    where $p/personid = $id
return
<individualName>
  <salutation>{data($p/nameprefix)}</salutation>
  <givenName>{normalize-space(concat(data($p/firstname)," ",data($p/middlename)))}</givenName>
  <surName>{data($p/lastname)}</surName>
</individualName>
}
{
let $strId := request:get-parameter("id","0")
let $id := if (string-length($strId) > 0) then (number($strId)) else (0)

for $p in doc("/db/personnel/personnel.xml")/root/row
    where $p/personid = $id
return
<organizationName>{data($p/primarysite)}</organizationName>
}
{
let $strId := request:get-parameter("id","0")
let $id := if (string-length($strId) > 0) then (number($strId)) else (0)

for $p in doc("/db/personnel/personnel.xml")/root/row
    where $p/personid = $id
return
<positionName>{data($p/primaryrole)}</positionName>
}
{
let $strId := request:get-parameter("id","0")
let $id := if (string-length($strId) > 0) then (number($strId)) else (0)

for $p in doc("/db/personnel/personnel.xml")/root/row
    let $phone := data($p/phone1)
    where $p/personid = $id
return
if (string-length($phone) > 0) then <phone>{$phone}</phone> else ()
}
{
let $strId := request:get-parameter("id","0")
let $id := if (string-length($strId) > 0) then (number($strId)) else (0)

for $p in doc("/db/personnel/personnel.xml")/root/row
    let $email := data($p/emailalias)
    where $p/personid = $id
return
<electronicMailAddress>{$email}{"@lternet.edu"}</electronicMailAddress>
}
{
let $strId := request:get-parameter("id","0")
let $id := if (string-length($strId) > 0) then (number($strId)) else (0)

for $p in doc("/db/personnel/personnel.xml")/root/row
    where $p/personid = $id
return
<userId directory="LTER">{data($p/personid)}</userId>
}
</party>
