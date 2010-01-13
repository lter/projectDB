<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
                <title>Search for LTER Research Projects</title>
                <style type="text/css">
               <![CDATA[
                  body { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px }
                  #projects_query { width: 60%; margin: 0 auto 0 auto; }
                  #projects_query h2 { font-size: 16px; text-align: center; }
                  #projects_query table { width: 100%; margin: 1em auto 1em auto; border-collapse: collapse; border-top: 2px solid #999; border-bottom: 2px solid #999 }
                  #projects_query th, #projects_query td  { vertical-align: top; white-space: nowrap; border-bottom: 1px solid #EEE; }
                  #projects_query th  { text-align: center; font-weight: bold; padding: 6px 8px 6px 20px; width: 30%; }
                  #projects_query td  { text-align: left; padding: 6px 20px 6px 8px; width: 70%; }
                  #projects_query table.inset-table { margin: 0; width: 90%; border: none; text-align: left; white-space: nowrap; }
                  #projects_query table.inset-table td  { border: none; }
                  #projects_query select, #projects_query input { font-family: Arial, Helvetica, sans-serif; font-size: 12px; }
                  #projects_query em  { font-style: italic; color: #666 }
                  #projects_query td.last  { vertical-align: middle; height: 60px; border: none; text-align: center }               
               ]]>
            </style>
            <script type="text/javascript" language="javascript" src="/exist/rest/db/projects/util/web/js/lterQueryForm.js"><!--null--></script>    
            </head>
            <body>
                <div id="projects_query">
                    <form method="get" name="project_search" action="http://amble.lternet.edu:8080/exist/rest/db/projects/util/xquery/getProjects.xql">
                        <h2>Search for LTER Research Projects</h2>
                        <table>
                            <tr>
                                <th>LTER Site</th>
                                <td>
                                    <select name="siteId" size="1">
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
                                <td>Surname <select name="surName" size="1">
                                        <option selected="selected" value="">&lt; Any &gt;</option>
                                        <xsl:for-each select="surNames/surName">
                                            <xsl:element name="option">
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="."/>
                                                </xsl:attribute>
                                                <xsl:value-of select="."/>
                                            </xsl:element>
                                        </xsl:for-each>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>Subject Keyword</th>
                                <td>
                                    <input id="keyword_fld" name="keyword" value="" size="30" onblur="validate('keyword_fld','alphanumsym')"/>
                                    <em style="padding-left: 10px">partial match</em>
                                </td>
                            </tr>
                            <tr>
                                <th>Subject Text</th>
                                <td>
                                    <input id="text_fld" name="text" value="" size="30" onblur="validate('text_fld','alphanumsym')"/>
                                    <em style="padding-left: 10px">partial match</em>
                                </td>
                            </tr>
                            <tr>
                                <th>Date Range</th>
                                <td>Starting Year: <input id="startYear_fld" name="startYear" value="" size="6" maxlength="4" onblur="validate('startYear_fld','num')"/>
                                    <span style="padding-left: 10px">Ending Year:</span>
                                    <input id="endYear_fld" name="endYear" value="" size="6" maxlength="4" onblur="validate('endYear_fld','num')"/>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: left; padding-left: 48px; border-bottom:none" colspan="2">Geographic Bounds <em style="font-weight:normal">(decimal degrees)</em>
                                </th>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding-bottom: 16px">
                                    <table class="inset-table">
                                        <tr>
                                            <td style="text-align:center; padding: 0 0 0 30px">
                                                <script language="javascript" type="text/javascript">var mapPage = "Search";</script>
                                                <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAaNAtyjO5Rns3WYUATa5Y8xTi4fsO-fAhG9i00B95TE3lWmQBahSspL5z5z0dwOIEz3LDIaSQN3wR2Q" type="text/javascript"/>
                                                <script src="http://amble.lternet.edu:8080/exist/rest/db/projects/util/web/js/dragzoom.js" type="text/javascript"/>
                                                <script src="http://amble.lternet.edu:8080/exist/rest/db/projects/util/web/js/map_functions.js" type="text/javascript"/>
                                                <div id="map" style="width: 300px; height: 240px; margin-left: 25px"/>
                                                <span style="font-size:10px">Zoom in to the region you would like to search<br/>
                                                    (use the magnifying glass to drag a bounding box)</span>
                                                <br/>
                                            </td>
                                            <td style="text-align:left; padding: 80px 0 0 0">
                                                <table class="inset-table" style="width:300px">
                                                    <tr>
                                                        <td colspan="2" style="text-align: center">
                                                            North&#160; <input type="text" id="maxLat_fld" name="maxLat" size="10" value="" onblur="validate('maxLat_fld','latitude')"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: right; width: 50%">
                                                            West&#160; <input type="text" id="minLon_fld" name="minLon" size="10" value="" onblur="validate('minLon_fld','longitude')"/>
                                                        </td>
                                                        <td style="width: 50%; text-align:right">
                                                            <input type="text" id="maxLon_fld" name="maxLon" size="10" value="" onblur="validate('maxLon_fld','longitude')"/> &#160;East
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="text-align: center">
                                                            South&#160; <input type="text" id="minLat_fld" name="minLat" size="10" value="" onblur="validate('minLat_fld','latitude')"/>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <th>Report Format</th>
                                <td>
                                    <select name="_xsl" size="1">
                                        <option selected="selected" value="http://amble.lternet.edu:8080/exist/rest/projects/util/xslt/lterProjectsListTable.xsl">Tabular view</option>
                                        <option value="http://amble.lternet.edu:8080/exist/rest/projects/util/xslt/lterProjectsListText.xsl">Text report view</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="last">
                                    <input type="reset" value="Reset"/>
                                    <input type="submit" value="Run Query" style="margin-left: 20px"/>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>