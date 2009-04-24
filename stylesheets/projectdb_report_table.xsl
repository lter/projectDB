<?xml version="1.0" encoding="UTF-8"?>
<!-- Sample xsl to output projects --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!-- call main template to generate page layout and scaffolding, which calls topnav and body templates at appropriate points in doc -->
    <xsl:template match="/">
        <html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <style type="text/css">
                    body { height: auto;  background-color: #360 }        
                    #lter_projects { width: 90%; margin: 2em auto 2em auto; padding: 20px; background-color: #FFF }
                    #lter_projects a, #lter_projects a:link, #lter_projects a:visited  { color: #360; text-decoration: none }
                    #lter_projects a:hover { text-decoration: underline; color: #660 }
                    #lter_projects table { width: 96%; margin: .5em auto 2em auto; padding: 0; border-collapse:collapse }
                    #lter_projects th { padding: 3px 8px 3px 8px; border-bottom: 1px solid Black; background-color: #F3F3F8; text-align: center; 
                          border-top: 1px solid Black; border-bottom: 1px solid Black }
                    #lter_projects td { vertical-align: top; padding: 5px 8px 3px 8px; border-bottom: 1px solid Black }
                    #lter_projects h2 { margin: 0 auto 0.5em auto; text-align: center }
                    #lter_projects td.personnel { white-space:nowrap }
                </style>
                <title>LTER Research Projects</title>
            </head>
            <body><xsl:call-template name="projects_query"/>
            </body>
        </html>        
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
                    <tr><td><xsl:element name="a">
                                <xsl:attribute name="href">/exist/rest/db/util/xquery/getProjectById.xql?_xsl=/db/util/xslt/capProjectHTML.xsl&amp;id=<xsl:value-of select="@id"/></xsl:attribute>
                                <xsl:value-of select="title"/>
                            </xsl:element>
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