<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href="http://amble.lternet.edu:8080/exist/rest/db/projects/util/xslt/gceMainTemplate.xsl"/>
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" media-type="text/xml"/>
    
    <!-- call main template to generate page layout and scaffolding, which calls topnav and body templates at appropriate points in doc -->
    <xsl:template match="/">
        <xsl:call-template name="main">
            <xsl:with-param name="css">/exist/rest/db/projects/util/web/css/gceQueryForm.css</xsl:with-param>
            <xsl:with-param name="javascript">/exist/rest/db/projects/util/web/js/lterQueryForm.js</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="projects_query">
        <div id="projects_query">
            <form method="get" action="http://amble.lternet.edu:8080/exist/rest/db/projects/util/xquery/getProjects.xql">
                <h2>Search for GCE Research Projects</h2>
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
                        <th>Geographic Bounds<br/>
                            <br/>
                            <em style="font-weight:normal">(decimal degrees)</em>
                        </th>
                        <td>
                            <table class="inset-table">
                                <tr>
                                    <td colspan="3" style="text-align: center">
                                        North&#160; <input type="text" id="maxLat_fld" name="maxLat" size="10" value="" onblur="validate('maxLat_fld','latitude')"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right; width: 50%">
                                        West&#160; <input type="text" id="minLon_fld" name="minLon" size="10" value="" onblur="validate('minLon_fld','longitude')"/>
                                    </td>
                                    <td style="width: 5%">&#160;</td>
                                    <td style="width: 45%; text-align:right">
                                        <input type="text" id="maxLon_fld" name="maxLon" size="10" value="" onblur="validate('maxLon_fld','longitude')"/> &#160;East
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="text-align: center">
                                        South&#160; <input type="text" id="minLat_fld" name="minLat" size="10" value="" onblur="validate('minLat_fld','latitude')"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <th>Report Format</th>
                        <td>
                            <select name="_xsl" size="1">
                                <option selected="selected" value="http://amble.lternet.edu:8080/exist/rest/projects/util/xslt/gceProjectsListTable.xsl">Tabular view</option>
                                <option value="http://amble.lternet.edu:8080/exist/rest/projects/util/xslt/gceProjectsListText.xsl">Text report view</option>
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
    </xsl:template>
</xsl:stylesheet>