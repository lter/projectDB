<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
    <xsl:import href="http://amble.lternet.edu:8080/exist/rest/db/projects/util/xslt/gceMainTemplate.xsl"/>
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" media-type="text/xml"/>

    <!-- call main template to generate page layout and scaffolding, which calls topnav and body templates at appropriate points in doc -->
    <xsl:template match="/">
        <xsl:call-template name="main">
            <xsl:with-param name="css">/exist/rest/db/projects/util/web/css/gceProjectsListTable.css</xsl:with-param>
            <xsl:with-param name="navLabel">Search Results</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="projects_query">
        <div id="lter_projects">
            <h2>LTER Research Projects</h2>
            <xsl:choose><xsl:when test="projects/project/*">            
            <table><tr><th><xsl:call-template name="build_xquery">
                        <xsl:with-param name="label">Site</xsl:with-param>
                        <xsl:with-param name="sortBy">id</xsl:with-param>
                    </xsl:call-template>
                    </th>
                    <th><xsl:call-template name="build_xquery">
                        <xsl:with-param name="label">Project Name</xsl:with-param>
                        <xsl:with-param name="sortBy">title</xsl:with-param>
                    </xsl:call-template>
                    </th>
                    <th><xsl:call-template name="build_xquery">
                        <xsl:with-param name="label">Investigator</xsl:with-param>
                        <xsl:with-param name="sortBy">surName</xsl:with-param>
                    </xsl:call-template>
                    </th>
                    <th>Personnel</th>
                </tr>
                <xsl:for-each select="projects/project">
                    <!-- <xsl:sort select="title"/>-->
                    <tr><td><xsl:value-of select="translate(substring(@id,10,3),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
                        </td>
                        <td><xsl:element name="a">
                                <xsl:attribute name="href">/exist/rest/db/projects/util/xquery/getProjectById.xql?id=<xsl:value-of select="@id"/>&amp;_xsl=http://amble.lternet.edu:8080/exist/rest/db/projects/util/xslt/capProjectHTML.xsl
                                </xsl:attribute>
                                <xsl:value-of select="title"/>
                            </xsl:element>
                        </td>
                        <td class="personnel">
                            <xsl:for-each select="creator">
                                <xsl:value-of select="individualName/surName"/>, <xsl:value-of select="individualName/givenName"/>
                                <br/>
                            </xsl:for-each>&#160;
                        </td>
                        <td class="personnel">
                            <xsl:for-each select="associatedParty">
                                <xsl:value-of select="individualName/surName"/>, <xsl:value-of select="individualName/givenName"/> -
                                    <xsl:value-of select="role"/>
                                <xsl:if test="position() != last()">
                                    <br/>
                                </xsl:if>
                            </xsl:for-each> &#160; 
                        </td>
                    </tr>
                </xsl:for-each>
            </table>
                </xsl:when>
                <xsl:otherwise><p style="text-align:center; margin-top:3em">Sorry ... no projects were found. Please <a href="javascript:history.back(1)">return to the search form</a> and select broader criteria</p></xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:template name="build_xquery">
        <xsl:param name="label"/>
        <xsl:param name="sortBy"/>
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:text>/exist/rest/db/projects/util/xquery/getProjects.xql?</xsl:text>
                <xsl:for-each select="/projects/params/param">
                    <xsl:value-of select="@name"/>
                    <xsl:text>=</xsl:text>
                    <xsl:value-of select="."/>
                    <xsl:text>&amp;</xsl:text>
                </xsl:for-each>
                <xsl:text>sortBy=</xsl:text>
                <xsl:value-of select="$sortBy"/>
                <xsl:text>&amp;</xsl:text>
                <xsl:text>_xsl=/db/projects/util/xslt/gceProjectsListTable.xsl</xsl:text>
            </xsl:attribute> 
            <xsl:attribute name="title">
                <xsl:text>Sort projects by </xsl:text>
                <xsl:value-of select="$label"/>
            </xsl:attribute>
            <xsl:value-of select="$label"/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>