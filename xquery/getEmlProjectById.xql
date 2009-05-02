xquery version "1.0";
(: getEmlProjectById: Xquery to return an LTER research project documents for insertion into an EML metadata document

   Parameters:    
       optional: id = document id
       optional: siteId, default: all sites, possible values: three letter LTER site acronym case (string, case insensitive)      

   Usage notes:
       1. if "id" is omitted, all projects will be returned
       2. Regular expression parameters can be used to select projects by id
       3. output is an xml document with root element <projects> and a <project> element for each matched research project
       4. for insertion into an EML document, elementName should be "project" or "relatedProject"
       
     Attribution:
        Authors: Wade Sheldon <wsheldon@lternet.edu>, Sven Bohm <sbohm@lternet.edu>
        Date: 01-May-2009
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

declare namespace lter="eml://ecoinformatics.org/lter-project-2.1.0";
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
declare namespace request="http://exist-db.org/xquery/request";

(: set output to xml :)
declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=no indent=yes";

(: get input parameters, setting defaults if omitted :)
let $id := request:get-parameter("id","\D*")
let $siteId := request:get-parameter("siteId","")

(: generate xml, stripping elements in the schema not supported by EML 2.1.0 :)
return
<projects>
{
for $rp in collection(concat('/db/projects/data/',lower-case($siteId)))/lter:researchProject
    where matches($rp/@id,$id)
return
    <project id="{$rp/@id}" system="{$rp/@system}" scope="{$rp/@scope}">
    {$rp/title}
    {for $party in $rp/associatedParty
    return
    <personnel id="{$party/@id}">
    {$party/individualName}
    {$party/positionName}
    {$party/organization}
    {$party/addres}
    {$party/phone}
    {$party/electronicMailAddress}
    {$party/phone}
    {$party/onlineUrl}
    {$party/userId}
    {$party/references}
    {$party/role}
    </personnel>
    }
    {$rp/abstract}
    {$rp/funding}
    {for $studyArea in $rp/studyAreaDescription
    return
    <studyAreaDescription>
    {$studyArea/descriptor}
    {$studyArea/citation}
    {$studyArea/coverage}
    </studyAreaDescription>
    }
    {$rp/designDescription}
    </project>
}
</projects>