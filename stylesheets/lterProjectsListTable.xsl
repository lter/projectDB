<!-- Sample xsl to output projects -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!-- call main template to generate page layout and scaffolding, which calls topnav and body templates at appropriate points in doc -->
    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <style type="text/css">
                    body {
                        height: auto;
                        background-color: transparent;
                        font-family: Verdana, Arial, sans-serif;
                        font-size: 11px; 
                    }
                    #lter_projects {
                        width: 90%;
                        margin: 0 auto 2em auto;
                        padding: 20px;
                        background-color: #FFF;
                    }
                    #lter_projects h2 {
                        margin: 0 auto 0.5em auto;
                        font-size: 16px ;
                        text-align: center;
                    }
                    #lter_projects td a, #lter_projects td a:link, #lter_projects td a:visited {
                        color: Black;
                        text-decoration: none;
                    }
                    #lter_projects th a, #lter_projects th a:link, #lter_projects th a:visited {
                        color: Black;
                        text-decoration: underline;
                    }
                    #lter_projects td a:hover, #lter_projects th a:hover {
                        text-decoration: underline;
                        color: Maroon;
                    }
                    #lter_projects table {
                        width: 96%;
                        margin: .5em auto 2em auto;
                        padding: 0;
                        border-collapse:collapse;
                    }
                    #lter_projects th {
                        padding: 3px 8px 3px 8px;
                        border-bottom: 1px solid Black;
                        background-color: #F3F3FF;
                        text-align: center;
                        border-top: 1px solid Black;
                        border-bottom: 1px solid Black;
                    }
                    #lter_projects td {
                        vertical-align: top;
                        padding: 5px 8px 3px 8px;
                        border-bottom: 1px solid Black;
                    }
                    #lter_projects td.personnel {
                        white-space:nowrap;
                    }</style>
                <title>LTER Research Projects</title>
            </head>
            <body>
                <xsl:call-template name="projects_query"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="projects_query">
        <div id="lter_projects">
            <h2>LTER Research Projects</h2>
            <xsl:choose>
                <xsl:when test="projects/project/*">
                    <table>
                        <tr>
                            <th>
                                <xsl:call-template name="build_xquery">
                                    <xsl:with-param name="label">Site</xsl:with-param>
                                    <xsl:with-param name="sortBy">id</xsl:with-param>
                                </xsl:call-template>
                            </th>
                            <th>
                                <xsl:call-template name="build_xquery">
                                    <xsl:with-param name="label">Project Name</xsl:with-param>
                                    <xsl:with-param name="sortBy">title</xsl:with-param>
                                </xsl:call-template>
                            </th>
                            <th>
                                <xsl:call-template name="build_xquery">
                                    <xsl:with-param name="label">Investigator</xsl:with-param>
                                    <xsl:with-param name="sortBy">surName</xsl:with-param>
                                </xsl:call-template>
                            </th>
                            <th>Personnel</th>
                        </tr>
                        <xsl:for-each select="projects/project">
                            <!-- <xsl:sort select="title"/>-->
                            <tr>
                                <td>
                                    <xsl:value-of select="translate(substring(@id,10,3),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
                                </td>
                                <td>
                                    <xsl:element name="a">
                                        <xsl:attribute name="href">
                                            /exist/rest/db/projects/util/xquery/getProjectById.xql?id=<xsl:value-of select="@id"/>&amp;_xsl=http://amble.lternet.edu:8080/exist/rest/db/projects/util/xslt/capProjectHTML.xsl 
                                        </xsl:attribute>
                                        <xsl:value-of select="title"/>
                                    </xsl:element>
                                </td>
                                <td class="personnel">
                                    <xsl:for-each select="creator">
                                        <xsl:value-of select="individualName/surName"/>, <xsl:value-of select="individualName/givenName"/>
                                        <br/>
                                    </xsl:for-each>&#160; </td>
                                <td class="personnel">
                                    <xsl:for-each select="associatedParty">
                                        <xsl:value-of select="individualName/surName"/>, <xsl:value-of select="individualName/givenName"/> - <xsl:value-of select="role"/>
                                        <xsl:if test="position() != last()">
                                            <br/>
                                        </xsl:if>
                                    </xsl:for-each> &#160; </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <p style="text-align:center; margin-top:3em; margin-bottom: 20em">Sorry ... no projects were found.
                        Please <a href="javascript:history.back(1)">return to the search form</a> and select broader
                        criteria</p>
                </xsl:otherwise>
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
                <xsl:text>_xsl=/db/projects/util/xslt/lterProjectsListTable.xsl</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:text>Sort projects by </xsl:text>
                <xsl:value-of select="$label"/>
            </xsl:attribute>
            <xsl:value-of select="$label"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
