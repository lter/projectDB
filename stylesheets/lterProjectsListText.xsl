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
                        font-size: 11px ;
                    }
                    #lter_projects {
                        width: 90%;
                        background-color: White;
                        margin: 0 auto 1em auto;
                        padding: 8px 20px 2em 20px;
                    }
                    #lter_projects div.lter_project {
                        width: 100%;
                        margin: 1.5em 10px 1em 10px;
                        padding: 6px;
                        border-top: 1px solid Black; 
                    }
                    #lter_projects h2 {
                        margin: 0 auto 0.5em auto;
                        font-size: 16px; 
                        text-align: center;
                    }
                    #lter_projects h3 {
                        font-size: 12px;
                        color: Black; 
                    }
                    #lter_projects a, #lter_projects a:link, #lter_projects a:visited {
                        color: Black;
                        text-decoration: underline; 
                    }
                    #lter_projects a:hover {
                        text-decoration: underline;
                        color: Maroon; 
                    }
                    #lter_projects p {
                        text-indent: -36px;
                        margin: 1em 10px .5em 64px;
                        padding: 0; 
                    }
                    #lter_projects em {
                        font-weight: bold;
                        font-style: italic;
                        color: Black; 
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
            <h2>Research Projects</h2>
            <xsl:choose>
                <xsl:when test="projects/project/*">
                    <div style="text-align: right; font-style: italic; color: #360; margin-top: -2.5em">
                        (sorty by: <xsl:call-template name="build_xquery">
                            <xsl:with-param name="label">Site</xsl:with-param>
                            <xsl:with-param name="sortBy">id</xsl:with-param>
                        </xsl:call-template>,
                        <xsl:call-template name="build_xquery">
                            <xsl:with-param name="label">Title</xsl:with-param>
                            <xsl:with-param name="sortBy">title</xsl:with-param>
                        </xsl:call-template>,
                        <xsl:call-template name="build_xquery">
                            <xsl:with-param name="label">Investigator</xsl:with-param>
                            <xsl:with-param name="sortBy">surName</xsl:with-param>
                        </xsl:call-template>)
                    </div>
                    <xsl:for-each select="projects/project">
                        <div class="lter_project">
                            <h3>
                                <xsl:element name="a">
                                    <xsl:attribute name="href">/exist/rest/db/projects/util/xquery/getProjectById.xql?_xsl=/db/projects/util/xslt/lterProjectDescription.xsl&amp;id=<xsl:value-of select="@id"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="title"/>
                                </xsl:element>
                            </h3>
                            <p>
                                <em>LTER Site:</em>&#160;
                                <xsl:value-of select="translate(substring(@id,10,3),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
                            </p>
                            <p class="project_investigator">
                                <em>Investigator:</em>&#160;
                                <xsl:for-each select="creator">
                                    <xsl:value-of select="normalize-space(individualName/givenName)"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="individualName/surName"/>
                                    <xsl:if test="position() != last()">, </xsl:if>
                                </xsl:for-each>
                            </p>
                            <p class="project_personnel">
                                <em>All Personnel:</em>&#160;
                                <xsl:for-each select="associatedParty">
                                    <xsl:value-of select="normalize-space(individualName/givenName)"/>
                                    <xsl:text>&#160;</xsl:text>
                                    <xsl:value-of select="individualName/surName"/> (<xsl:value-of select="role"/>)<xsl:if test="position() != last()">, </xsl:if>
                                </xsl:for-each>
                            </p>
                            <p class="project_keywords">
                                <em>Keywords:</em>&#160;
                                <xsl:for-each select="keywordSet/keyword">
                                    <xsl:value-of select="."/>
                                    <xsl:if test="position() != last()">, </xsl:if>
                                </xsl:for-each>
                            </p>
                            <p class="project_dates">
                                <em>Time Period</em>&#160;
                                <xsl:for-each select="coverage/temporalCoverage">
                                    <xsl:if test="string(rangeOfDates)">                                
                                        <xsl:choose>
                                            <xsl:when test="string(rangeOfDates/endDate)">
                                                <xsl:value-of select="rangeOfDates/beginDate/calendarDate"/> to <xsl:value-of select="rangeOfDates/endDate/calendarDate"/>
                                            </xsl:when>
                                            <xsl:otherwise>ongoing (started <xsl:value-of select="rangeOfDates/beginDate/calendarDate"/>)</xsl:otherwise>
                                        </xsl:choose>                                    
                                    </xsl:if>
                                    <xsl:if test="string(singleDateTime)">
                                        <xsl:value-of select="singleDateTime/calendarDate"/>
                                    </xsl:if>
                                    <xsl:if test="string(ongoing)">
                                        ongoing (started <xsl:value-of select="ongoing/beginDate/calendarDate"/>)
                                    </xsl:if>
                                </xsl:for-each>
                            </p>
                        </div>    
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <p style="text-align:center; margin-top:3em; margin-bottom: 20em">Sorry ... no projects were found. Please 
                        <a href="javascript:history.back(1)" style="text-decoration: underline">return to the search form</a> and select broader
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
                <xsl:text>_xsl=/db/projects/util/xslt/lterProjectsListText.xsl</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:text>Sort projects by </xsl:text>
                <xsl:value-of select="$label"/>
            </xsl:attribute>
            <xsl:value-of select="$label"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>