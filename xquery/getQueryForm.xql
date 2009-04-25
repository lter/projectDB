xquery version "1.0";
(: Xquery to return LTER research projects matching a specified keyword

   Parameters:
       keyword = keyword to search / partial string match (string, required, case-insensitive)
       keywordSet = keyword set name to search (string, optional, case-insensitive)
       siteID = LTER site 3-letter acronym (string, optional, case-insensitive)
       
   Usage notes:
       1. if keywordSet is omitted, all keywordSet elements will be searched
       2. an xml document will be returned with a root of <projects>, with a subset of researchProject
              in a <project> element for each match, sorted by project id
       
     Attribution:
        Author: Wade Sheldon <wsheldon@lternet.edu>
        Date: 22-Apr-2009
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
declare namespace lter="eml://ecoinformatics.org/project-2.1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace xs="http://www.w3.org/2001/XMLSchema";
 
(: set output to xhtml for IE compatibility :)
declare option exist:serialize "method=xhtml media-type=text/html";

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Search for LTER Research Projects</title>
<link rel="stylesheet" media="all" type="text/css" href="http://amble.lternet.edu:8080/exist/rest/eb/projects/util/web/css/query_form.css" />
</head>
<body>
<div id="projects_query">
  <form method="get" action="http://amble.lternet.edu:8080/exist/rest/db/projects/util/xquery/getProjects.xql">
    <h2>Search for LTER Research Projects</h2>
    <table>
      <tr>
        <th>LTER Site</th>
        <td><select name="siteId" size="1">
            <option selected="selected" value="">&lt; Any site &gt;</option>
            <option value="AND">Andrews LTER</option>
            <option value="ARC">Arctic LTER</option>
            <option value="BES">Baltimore Ecosystem Study</option>
            <option value="BNZ">Bonanza Creek LTER</option>
            <option value="CAP">Central Arizona - Phoenix Urban LTER</option>
            <option value="CCE">California Current Ecosystem</option>
            <option value="CDR">Cedar Creek Natural History Area</option>
            <option value="CWT">Coweeta LTER</option>
            <option value="FCE">Florida Coastal Everglades LTER</option>
            <option value="GCE">Georgia Coastal Ecosystems LTER</option>
            <option value="HBR">Hubbard Brook LTER</option>
            <option value="HFR">Harvard Forest LTER</option>
            <option value="JRN">Jornada Basin LTER</option>
            <option value="KBS">Kellogg Biological Station LTER</option>
            <option value="KNZ">Konza Prairie LTER</option>
            <option value="LNO">LTER Network Office</option>
            <option value="LUQ">Luquillo LTER</option>
            <option value="MCM">McMurdo Dry Valleys LTER</option>
            <option value="MCR">Moorea Coral Reef</option>
            <option value="NIN">North Inlet LTER</option>
            <option value="NTL">North Temperate Lakes LTER</option>
            <option value="NWT">Niwot Ridge LTER</option>
            <option value="PAL">Palmer Station LTER</option>
            <option value="PIE">Plum Island Ecosystem LTER</option>
            <option value="SBC">Santa Barbara Coastal LTER</option>
            <option value="SEV">Sevilleta LTER</option>
            <option value="SGS">Shortgrass Steppe</option>
            <option value="VCR">Virginia Coastal Reserve LTER</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>Associated Person</th>
        <td>Surname
          <select name="surName" size="1">
{        
for $p in collection("/db/projects/data")
    let $surNamesAll := $p/lter:researchProject//surName
    let $surNames := distinct-values($surNamesAll)
    order by $surNames
    return
    for $surName in $surNames
    return
    <option value="{$surName}">{$surName}</option>
}
          </select>
        </td>
      </tr>
      <tr>
        <th>Subject Keyword</th>
        <td><input name="keyword" value="" size="30" />
          <em style="padding-left: 10px">partial match</em></td>
      </tr>
      <tr>
        <th>Date Range</th>
        <td>Starting Year:
          <input name="startYear" value="" size="6" maxlength="4" />
          <span style="padding-left: 10px">Ending Year:</span>
          <input name="endYear" value="" size="6" maxlength="4" /></td>
      </tr>
      <tr>
        <th>Geographic Bounds<br/>
          <br/>
          <em style="font-weight:normal">(decimal degrees)</em></th>
        <td><table class="inset-table">
            <tr>
              <td colspan="3" style="text-align: center"><strong>North</strong>&#160;
                <input type="text" name="maxLat" size="12" value="" /></td>
            </tr>
            <tr>
              <td style="text-align: right; width: 50%"><strong>West</strong>&#160;
                <input type="text" name="minLon" size="12" value="" /></td>
              <td style="width: 8%">&#160;</td>
              <td style="width: 42%"><input type="text" name="maxLon" size="12" value="" />
                &#160;<strong>East</strong></td>
            </tr>
            <tr>
              <td colspan="3" style="text-align: center"><strong>South</strong>&#160;
                <input type="text" name="minLat" size="12" value="" /></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <th>Report Format</th>
        <td><select name="_xsl" size="1">
            <option selected="selected" value="http://amble.lternet.edu:8080/exist/rest/projects/util/xslt/lterProjectsListTable.xsl">Tabular view</option>
            <option value="http://amble.lternet.edu:8080/exist/rest/projects/util/xslt/lterProjectsListText.xsl">Text report view</option>
          </select>
        </td>
      </tr>
      <tr>
        <td colspan="2" class="last"><input type="reset" value="Reset" />
          <input type="submit" value="Run Query" style="margin-left: 20px"/>
        </td>
      </tr>
    </table>
  </form>
</div>
</body>
</html>