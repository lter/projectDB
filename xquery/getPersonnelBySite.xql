xquery version "1.0";
(: getPersonnelBySite: Xquery to return LTER personnel for a specified site

   Parameters:
       optional: site = 3-letter LTER site acronym (string, case insensitive)
       optional: lastname = last name (string, regular expression match, case sensitive)
       optional: role = LTER role code (string, regular expression match, case sensitive)

    Usage notes:
        1. output is an xml file with root <people> and a <person> element for each match
            containing personnel name and contact information

     Attribution:
        Author: Wade Sheldon <wsheldon@lternet.edu> and James Brunt <james@lternet.edu>
        Date: 11-Jun-2009
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
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
declare namespace request = "http://exist-db.org/xquery/request";

(: set output to xml :)
declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=no indent=yes";

(: increase default output limit for all personnel :)
declare option exist:output-size-limit "50000";

(: get input arguments :)
let $site0 := request:get-parameter("site","")
let $lastname0 := request:get-parameter("lastname","")
let $role0 := request:get-parameter("role","")

(: convert site code to upper case, or set default to 3 letter upper case acronym if omitted :)
let $site := if (string-length($site0) > 0) then (upper-case($site0)) else ("[A-Z]{3}")

(: modify non-blank lastname and role to include beginning of string restriction, otherwise use wildcard if omitted :)
let $lastname := if (string-length($lastname0) > 0) then (concat("^",$lastname0)) else ("\D*")
let $role := if (string-length($role0) > 0) then (concat("^",$role0)) else ("\D*")

(: define return structure, just wrapping existing row elements inside people/party :)
return

<people>
{
for $p in collection("/db/personnel")/*:root/row
where matches($p/primarysite, $site) and matches($p/lastname, $lastname) and matches($p/primaryrole, $role)
return
<person>{$p/*}</person>
}
</people>
