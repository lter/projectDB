<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!--  xsl to output projects for a single site to select one to edit-->
    <xsl:template match="/">
        <html><body>
                <style>
                body 
                { 
                height: auto;  
                background-color: #360; 
                font-family: Verdana, sans-serif; 
                font-size: 11px
                }
                a
                { 
                color: #000000; 
                text-decoration: none 
                }
                a:link, a:visited  
                { 
                color: #ffffff; 
                text-decoration: underline 
                }
                a:hover 
                { 
                text-decoration: underline; 
                color: #cccccc
                }
                
                </style>
                <h2>Select a Project</h2>
                <table border="0">
                    <tr bgcolor="#eeeeee">
                        <th>Name</th>
                        <th>Creator(s)</th>
                        <th>Associated Parties</th>
                    </tr>
                    <xsl:for-each select="projects/project">
                    <xsl:sort select="title"/>
                    <tr><td valign="top">
                            <xsl:element name="a">
                                <xsl:attribute name="href"><xsl:value-of select="@id"/>
                                </xsl:attribute><xsl:value-of select="title"/></xsl:element>
                        </td>
                        <td valign="top">
                            <xsl:for-each select="creator">
                                <xsl:value-of select="individualName"/> &#160; <br/>
                            </xsl:for-each>
                        </td>
                        <td valign="top">
                            <xsl:for-each select="associatedParty">
                                <xsl:value-of select="individualName/surName"/>,
                                <xsl:value-of select="individualName/givenName"/> - 
                                <xsl:value-of select="role"/>
                                &#160; <br/>
                            </xsl:for-each>
                            &#160;
                        </td>
                    </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>