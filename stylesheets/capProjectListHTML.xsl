<?xml version="1.0" encoding="UTF-8"?>
<!-- Sample xsl to output projects --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/">
        <table border="1">
            <tr bgcolor="#eeeeee">
                <th><xsl:variable name="minLon">
                        <xsl:value-of select="projects/project[1]/params/param[@name = 'minLon']"/>
                    </xsl:variable>
                    <!--
                         <xsl:choose>
                            <xsl:when test="projects/project[1]/params/param[@name = 'surName'][. ='^\D*']">
                                <xsl:variable name="lastName"></xsl:variable>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:variable name="lastName">
                                    <xsl:value-of select="."/>
                                </xsl:variable>
                            </xsl:otherwise>
                        </xsl:choose>
                    --> 
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:text>http://amble.lternet.edu:8080/exist/rest/db/util/xquery/getProjects.xql?</xsl:text>
                            <xsl:text>siteId=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'siteId']"/>
                            <xsl:text>&amp;minLon=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'minLon']"/>
                            <xsl:text>&amp;maxLong=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'maxLon']"/>
                            <xsl:text>&amp;minLat=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'minLat']"/>
                            <xsl:text>&amp;maxLat=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'maxLat']"/>
                            <xsl:text>&amp;endYear=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'endYear']"/>
                            <xsl:text>&amp;startYear=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'startYear']"/>
                            <xsl:text>&amp;surName=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'surName']"/>
                            <xsl:text>&amp;sortBy=title</xsl:text>
                            <xsl:text>&amp;_xsl=http://amble.lternet.edu:8080/exist/rest/db/util/xslt/capProjectListHTML.xsl</xsl:text>
                        </xsl:attribute> Title </xsl:element>
                </th>
                <th><xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:text>http://amble.lternet.edu:8080/exist/rest/db/util/xquery/getProjects.xql?</xsl:text>
                            <xsl:text>siteId=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'siteId']"/>
                            <xsl:text>&amp;minLon=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'minLon']"/>
                            <xsl:text>&amp;maxLong=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'maxLon']"/>
                            <xsl:text>&amp;minLat=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'minLat']"/>
                            <xsl:text>&amp;maxLat=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'maxLat']"/>
                            <xsl:text>&amp;endYear=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'endYear']"/>
                            <xsl:text>&amp;startYear=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'startYear']"/>
                            <xsl:text>&amp;surName=</xsl:text>
                            <xsl:value-of select="projects/project[1]/params/param[@name = 'surName']"/>
                            <xsl:text>&amp;sortBy=surName</xsl:text>
                            <xsl:text>&amp;_xsl=http://amble.lternet.edu:8080/exist/rest/db/util/xslt/capProjectListHTML.xsl</xsl:text>
                        </xsl:attribute> People </xsl:element>
                    </th>
            </tr>
            <xsl:for-each select="projects/project">
                <!-- <xsl:sort select="title"/>-->
                <tr><td valign="top">
                        <xsl:value-of select="title"/>
                    </td>
                    <td valign="top">
                        <xsl:for-each select="creator">
                            <xsl:value-of select="individualName/surName"/>, <xsl:value-of select="individualName/givenName"/>
                            <xsl:text>&#160;</xsl:text>
                            <br/>
                        </xsl:for-each>
                        <xsl:for-each select="associatedParty">
                            <xsl:value-of select="individualName/surName"/>, <xsl:value-of select="individualName/givenName"/> - <xsl:value-of select="role"/>
                            &#160; <br/>
                        </xsl:for-each> &#160; </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
</xsl:stylesheet>