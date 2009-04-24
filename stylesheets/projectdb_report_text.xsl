<?xml version="1.0" encoding="UTF-8"?>
<!-- Sample xsl to output projects --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <!-- call main template to generate page layout and scaffolding, which calls topnav and body templates at appropriate points in doc -->
    <xsl:template match="/">
        <html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <style type="text/css">                   
                    body { height: auto;  background-color: #360; font-family: Verdana, sans-serif; font-size: 11px }
                    #lter_projects h2  { text-align: center; color: #360 }
                    #lter_projects a, #lter_projects a:link, #lter_projects a:visited  { color: #360; text-decoration: none }
                    #lter_projects a:hover { text-decoration: underline; color: #660 }
                    #lter_projects { width: 80%; background-color: #fff ;margin: 3em auto 1em auto; padding: 8px 20px 2em 20px; border-bottom: 1px solid #000 }
                    #lter_projects div.lter_project  { margin: 1em 10px 1em 10px; padding: 6px; border-top: 1px solid #000 }
                    #lter_projects p  {  text-indent: -36px; margin: 1em 10px .5em 64px; padding: 0 }
                    #lter_projects em  { font-weight: bold; font-style: italic; color: #360 }
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
            <xsl:for-each select="projects/project">
                <div class="lter_project">
                    <h3><xsl:element name="a">
                            <xsl:attribute name="href">/exist/rest/db/util/xquery/getProjectById.xql?_xsl=/db/util/xslt/capProjectHTML.xsl&amp;id=<xsl:value-of select="@id"/></xsl:attribute>
                            <xsl:value-of select="title"/>
                        </xsl:element>
                    </h3>
                    <p class="project_investigator">
                        <em>Investigator:</em>&#160;
                        <xsl:for-each select="creator">
                            <xsl:value-of select="normalize-space(individualName)"/>
                            <xsl:if test="position() != last()">, </xsl:if>
                        </xsl:for-each>
                    </p>
                    <p class="project_personnel">
                        <em>All Personnel:</em>&#160;
                        <xsl:for-each select="associatedParty">
                            <xsl:value-of select="normalize-space(individualName)"/> (<xsl:value-of select="role"/>)<xsl:if test="position() != last()">, </xsl:if>
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
                                <xsl:choose><xsl:when test="string(rangeOfDates/endDate)">
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
          </div>
    </xsl:template>
    
</xsl:stylesheet>