xquery version "1.0";
(: getProjectQueryForm - Xquery to return an html project query form

   Parameters:
       optional siteID (string) = LTER site 3-letter acronym (string, optional, case-insensitive)
       optional xslUrl (string) = URL for a stylesheet to use to generate the html (default = '/db/projects/util/xslt/lterQueryForm.xsl',
            'none' to display xml)
       
   Usage notes:
       1. if siteID is omitted or empty, a list of all project-assocatiated surNames will be returned, otherwise
             a list of surNames for all documents from the specified site will be returned
       2. if xslUrl = 'none', an xml document will be returned (<surNames><surName>...)
       
     Attribution:
        Author: Wade Sheldon <wsheldon@lternet.edu>
        Date: 25-Apr-2009
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
declare namespace lter="eml://ecoinformatics.org/lter-project-2.1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace xs="http://www.w3.org/2001/XMLSchema";
declare namespace transform = "http://exist-db.org/xquery/transform";

(: set output to xhtml with standards-compliant doctype and no xml declaration for IE compatibility :)
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes 
        doctype-public=-//W3C//DTD&#160;XHTML&#160;1.0&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd";

let $xsl := request:get-parameter("xslUrl", "http://amble.lternet.edu:8080/exist/rest/db/projects/util/xslt/lterQueryForm.xsl")
let $siteId := request:get-parameter("siteId", "")

(: generate an intermediary document containing distinct names - will contain some dupes :)
let $xml0 := document {
<surNames>
{
for $p in collection(concat('/db/projects/data/',lower-case($siteId)))
    let $surNamesAll := distinct-values($p/lter:researchProject//individualName/surName)
    return
    for $surName in $surNamesAll
    let $surNameDistinct := distinct-values($surName)    
    return
    <surName>{$surNameDistinct}</surName>
 }
 </surNames>
}

(: generate final xml document with unique names sorted for transforming :)
let $xml := document {
<surNames>
{
for $surName in distinct-values($xml0/surNames/surName)
    order by $surName
    return
    <surName>{$surName}</surName>
}
</surNames>
}

(: transform the document to xhtml unless the stylesheet is 'none' :)
return
if(not($xsl = "none")) then transform:transform($xml,$xsl,()) else $xml
