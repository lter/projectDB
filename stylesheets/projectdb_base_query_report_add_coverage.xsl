<!-- Sample xsl to output projects -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <body>
                <h2>LTER Projects</h2>
                <table border="1">
                    <tr bgcolor="#eeeeee">
                        <th>Name</th>
                        <th>Creator(s)</th>
                        <th>Associated Parties</th>
                        <th>Keywords</th>
                    </tr>
                    <xsl:for-each select="projects/project">
                    <!-- <xsl:sort select="title"/>-->
                    <tr>
                        <td valign="top">
                            <xsl:value-of select="title"/>
                        </td>
                        <td valign="top">
                            <xsl:for-each select="creator">
                                <xsl:value-of select="individualName"/> &#160; <br></br>
                            </xsl:for-each>
                        </td>
                        <td valign="top">
                            <xsl:for-each select="associatedParty">
                                <xsl:value-of select="individualName/surName"/>,
                                <xsl:value-of select="individualName/givenName"/> - 
                                <xsl:value-of select="role"/>
                                &#160; <br></br>
                            </xsl:for-each>
                            &#160;
                        </td>
                        <td valign="top">
                            <xsl:for-each select="keywordSet/keyword">
                                <xsl:value-of select="."/>,
                                &#160; <br></br>
                            </xsl:for-each>
                            &#160;
                        </td>
                        <td> 
                            <xsl:for-each select="temporalCoverage">
                                <xsl:value-of select="."/>, hello
                                &#160; <br></br>
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