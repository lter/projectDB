<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href="http://amble.lternet.edu:8080/exist/rest/db/projects/util/xslt/gceMainTemplate.xsl"/>
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" media-type="text/xml"/>
    
    <!-- call main template to generate page layout and scaffolding, which calls topnav and body templates at appropriate points in doc -->
    <xsl:template match="/">
        <xsl:call-template name="main">
            <xsl:with-param name="css">/exist/rest/db/projects/util/web/css/gceQueryForm.css</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="projects_query">
        <div id="projects_query">
            <form method="get" action="http://amble.lternet.edu:8080/exist/rest/db/projects/util/xquery/getProjects.xql">
                <h2>Search for LTER Research Projects</h2>
                <table><tr><th>LTER Site</th>
                        <td><input type="radio" name="siteId" value="gce" checked="checked"/> GCE only
                            <input type="radio" name="siteId" value="" style="margin-left: 20px"/> LTER Network
                        </td>
                    </tr>
                    <tr><th>Associated Person</th>
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
                    <tr><th>Subject Keyword</th>
                        <td><input name="keyword" value="" size="30"/>
                            <em style="padding-left: 10px">partial match</em>
                        </td>
                    </tr>
                    <tr><th>Date Range</th>
                        <td>Starting Year: <input name="startYear" value="" size="6" maxlength="4"/>
                            <span style="padding-left: 10px">Ending Year:</span>
                            <input name="endYear" value="" size="6" maxlength="4"/>
                        </td>
                    </tr>
                    <tr><th>Geographic Bounds<br/>
                            <br/>
                            <em style="font-weight:normal">(decimal degrees)</em>
                        </th>
                        <td><table class="inset-table">
                                <tr><td colspan="3" style="text-align: center">
                                        North&#160; <input type="text" name="maxLat" size="10" value=""/>
                                    </td>
                                </tr>
                                <tr><td style="text-align: right; width: 50%">
                                        West&#160; <input type="text" name="minLon" size="10" value=""/>
                                    </td>
                                    <td style="width: 5%">&#160;</td>
                                    <td style="width: 45%; text-align:right">
                                        <input type="text" name="maxLon" size="10" value=""/> &#160;East
                                    </td>
                                </tr>
                                <tr><td colspan="3" style="text-align: center">
                                        South&#160; <input type="text" name="minLat" size="10" value=""/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr><th>Report Format</th>
                        <td><select name="_xsl" size="1">
                                <option selected="selected" value="http://amble.lternet.edu:8080/exist/rest/projects/util/xslt/gceProjectsListTable.xsl">Tabular view</option>
                                <option value="http://amble.lternet.edu:8080/exist/rest/projects/util/xslt/gceProjectsListText.xsl">Text report view</option>
                            </select>
                        </td>
                    </tr>
                    <tr><td colspan="2" class="last">
                            <input type="reset" value="Reset"/>
                            <input type="submit" value="Run Query" style="margin-left: 20px"/>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </xsl:template>
</xsl:stylesheet>