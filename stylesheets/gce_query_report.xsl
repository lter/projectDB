<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href="/db/util/xslt/gce_projects_template.xsl"/>
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" media-type="text/xml"/>

    <!-- call main template to generate page layout and scaffolding, which calls topnav and body templates at appropriate points in doc -->
    <xsl:template match="/">
        <xsl:call-template name="main"/>
    </xsl:template>

    <xsl:template name="projects_query">
        <div id="lter_projects">
            <h2>LTER Research Projects</h2>
            <table><tr><th>Project Name</th>
                    <th>Investigator</th>
                    <th>Personnel</th>
                    <th>Keywords</th>
                </tr>
                <xsl:for-each select="projects/project">
                    <!-- <xsl:sort select="title"/>-->
                    <tr><td><xsl:value-of select="title"/>
                        </td>
                        <td class="personnel">
                            <xsl:for-each select="creator">
                                <xsl:value-of select="individualName"/>&#160;<br/>
                            </xsl:for-each>
                        </td>
                        <td class="personnel">
                            <xsl:for-each select="associatedParty">
                                <xsl:value-of select="individualName/surName"/>, <xsl:value-of select="individualName/givenName"/> -
                                    <xsl:value-of select="role"/>
                                <xsl:if test="position() != last()">
                                    <br/>
                                </xsl:if>
                            </xsl:for-each> &#160; </td>
                        <td><xsl:for-each select="keywordSet/keyword">
                                <xsl:value-of select="."/>
                                <xsl:if test="position() != last()">, </xsl:if>
                            </xsl:for-each> &#160; </td>
                    </tr>
                </xsl:for-each>
            </table>
        </div>
    </xsl:template>

</xsl:stylesheet>