<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href="http://amble.lternet.edu:8080/exist/rest/db/projects/util/xslt/gceMainTemplate.xsl"/>
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" media-type="text/xml"/>
    
    <!-- call main template to generate page layout and scaffolding, which calls topnav and body templates at appropriate points in doc -->
    <xsl:template match="/">
        <xsl:call-template name="main">
            <xsl:with-param name="css">/exist/rest/db/projects/util/web/css/gceQueryForm.css</xsl:with-param>
            <xsl:with-param name="javascript">/exist/rest/db/projects/util/web/js/gce/gceQueryForm.js</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="projects_query">
        <div id="projects_query">
            <form method="get" name="project_search" action="http://amble.lternet.edu:8080/exist/rest/db/projects/util/xquery/getProjects.xql">
                <h2 style="margin-bottom: 0">Search for GCE Research Projects</h2>
                <table>
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
                                        <script src="http://amble.lternet.edu:8080/exist/rest/db/projects/util/web/js/gce/dragzoom.js" type="text/javascript"/>
                                        <script src="http://amble.lternet.edu:8080/exist/rest/db/projects/util/web/js/gce/map_functions.js" type="text/javascript"/>
                                        <div id="map" style="width: 300px; height: 280px; margin-left: 25px"/>
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
                                <option selected="selected" value="http://amble.lternet.edu:8080/exist/rest/projects/util/xslt/gceProjectsListTable.xsl">Tabular view</option>
                                <option value="http://amble.lternet.edu:8080/exist/rest/projects/util/xslt/gceProjectsListText.xsl">Text report view</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="last">
                            <input type="reset" value="Reset"/>
                            <input type="submit" value="Run Query" style="margin-left: 20px"/>
                            <input type="hidden" name="siteId" value="gce"/>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </xsl:template>
</xsl:stylesheet>