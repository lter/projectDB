<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!-- call main template to generate page layout and scaffolding, which calls topnav and body templates at appropriate points in doc -->
    <xsl:template xmlns:lter="eml://ecoinformatics.org/lter-project-2.1.0" match="lter:researchProject">
        <html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <style type="text/css">
                    body {
                        height: auto;
                        background-color: #360;
                        font-family: Verdana, sans-serif;
                         font-size: 11px 
                    }
                    #lter_projects h2 {
                        text-align: center;
                        color: #360;
                         font-size: 14px 
                    }
                    #lter_projects a, #lter_projects a:link, #lter_projects a:visited {
                        color: #360;
                         text-decoration: none 
                    }
                    #lter_projects a:hover {
                        text-decoration: underline;
                         color: #660 
                    }
                    #lter_projects {
                        width: 80%;
                        background-color: #fff;
                        margin: 3em auto 1em 10%;
                        padding: 8px 20px 2em 20px;
                         border-bottom: 1px solid #000 
                    }
                    #lter_projects div.lter_project {
                        margin: 1em 10px 1em 10px;
                        padding: 6px;
                         border-top: 1px solid #000 
                    }
                    #lter_projects p {
                        margin: .5em 10px .2em 40px;
                         padding: 0 
                    }
                    #lter_projects em {
                        font-weight: bold;
                        font-style: italic;
                         color: #360 
                    }</style>
                <title>Reporting for LTER Research Projects</title>
            </head>
            <body><xsl:call-template name="project_reporting"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="project_reporting">
        <div id="lter_projects">
                 <h2>Reporting for LTER Research Project&#160;
                <xsl:value-of select="@id"/>
            </h2>
                <div class="lter_project">
                    <h3><xsl:element name="a">
                            <xsl:attribute name="href">/exist/rest/db/projects/util/xquery/getProjectById.xql?_xsl=/db/projects/util/xslt/capProjectHTML.xsl&amp;id=<xsl:value-of select="@id"/>
                            </xsl:attribute>
                            <xsl:value-of select="title"/>
                        </xsl:element>
                    </h3>
                    <br/>
                <br/>
                        <em>Investigator:</em>&#160; <xsl:for-each select="creator">
                            <xsl:value-of select="normalize-space(individualName)"/>
                            <xsl:if test="position() != last()">, </xsl:if>
                        </xsl:for-each>
                    
                        <xsl:for-each select="reporting">
                            <xsl:choose><xsl:when test="@date[. !='']">
                                    <br/>
                            <br/>
                                    <h2>Reporting Year: &#160;
                                        <xsl:value-of select="@date"/>
                                    </h2>
                            <br/>
                                </xsl:when>
                                <xsl:otherwise><br/>
                            <br/>
                                    <h2>Report</h2>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:for-each select="reportSection">
                                <xsl:if test="sectionTitle[. !='']">
                                    <br/>
                            <br/>
                            <br/>
                                    <em>Section: 
                                    <xsl:value-of select="sectionTitle"/>
                                    </em>
                                </xsl:if>
                                <br/>
                        <br/>
                        <br/>
                                <xsl:for-each select="sectionValue">
                                    <xsl:call-template name="textType"/>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                 </div>
        </div>
    </xsl:template>
    <!-- text type initial template, calling all the following templates for formatting -->
    <xsl:template name="textType">
        <xsl:variable select="generate-id()" name="texttypeid"/>
        <div name="{$texttypeid}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <!-- all other text type related templates -->
    <xsl:template match="section">
        <xsl:for-each select="title">
            <br/><em><xsl:value-of select="."/>
            </em>
        </xsl:for-each>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="para">
        <xsl:if test="itemizedlist or orderedlist">
            <xsl:apply-templates/>
        </xsl:if>
        <xsl:if test="literalLayout">
            <xsl:element name="p">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
        <xsl:if test="emphasis or subscript or superscript">
            <xsl:apply-templates/>
        </xsl:if>
        <xsl:for-each select="child::text()">
            <xsl:element name="p">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="emphasis">
        <xsl:element name="b">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="subscript">
        <xsl:element name="sub">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="superscript">
        <xsl:element name="sup">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="literalLayout">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="itemizedlist">
        <xsl:element name="ul">
            <xsl:apply-templates select="listitem"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="orderedlist">
        <xsl:element name="ol">
            <xsl:apply-templates select="listitem"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="listitem">
        <xsl:if test="para/literalLayout">
            <xsl:element name="li">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:if>
        <xsl:if test="not ( para/literalLayout)">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>
    

</xsl:stylesheet>