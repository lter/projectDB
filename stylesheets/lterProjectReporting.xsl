<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lter="eml://ecoinformatics.org/lter-project-2.1.0" version="1.0">
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0         Transitional//EN" indent="yes" media-type="text/xml"/>
    <xsl:namespace-alias stylesheet-prefix="lter" result-prefix="xsl"/>
    
    <!-- call main template to generate page layout and scaffolding, which calls topnav and body templates at appropriate points in doc -->
    <xsl:template xmlns:lter="eml://ecoinformatics.org/lter-project-2.1.0" match="lter:researchProject">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <link rel="stylesheet" media="all" type="text/css" href="http://amble.lternet.edu:8080/exist/rest/db/projects/util/web/css/lterProjectDescription.css"/>
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
                            <xsl:attribute name="href">http://amble.lternet.edu:8080/exist/rest/db/projects/util/xquery/getProjectById.xql?_xsl=/db/projects/util/xslt/lterProjectDescription.xsl&amp;id=<xsl:value-of select="@id"/>
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
                                    <h3>Reporting Year: &#160;
                                        <xsl:value-of select="@date"/>
                                    </h3>
                            <br/>
                                </xsl:when>
                                <xsl:otherwise><br/>
                            <br/>
                                    <h3>Report</h3>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:for-each select="reportSection">
                                <xsl:if test="sectionTitle[. !='']">
                                    <div class="report-section">
                                        <h4 class="reports">Section: 
                                    <xsl:value-of select="sectionTitle"/>
                                        </h4>
                                    </div>
                                </xsl:if>
                                <xsl:for-each select="sectionValue">
                                    <xsl:apply-templates/>
                                </xsl:for-each>
                            </xsl:for-each>
                            <xsl:for-each select="associationMaterial">
                                <xsl:call-template name="material">
                                    <xsl:with-param name="category">
                                        <xsl:value-of select="@category"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:for-each>
                 </div>
        </div>
    </xsl:template>
    
    
    <!-- Templates for textType elements-->
    <xsl:template name="text">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="section">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="title">
        <xsl:element name="p">
            <xsl:attribute name="class">section-title</xsl:attribute>
            <xsl:value-of select="title"/>
            <xsl:apply-templates/>
        </xsl:element>        
    </xsl:template>
    
    <xsl:template match="para">
        <xsl:element name="p">
            <xsl:attribute name="class">section-para</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="emphasis">
        <xsl:element name="em">
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
    
    <xsl:template match="ulink">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="@url"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="citetitle"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <!-- associated material template -->
    <xsl:template name="material">
        <xsl:param name="category"/>
        <xsl:choose>
            <xsl:when test="$category = 'data'">
                <p class="material">Dataset:&#160;
                    <xsl:choose>
                        <xsl:when test="distribution/online != ''">
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="distribution/online/url"/>
                                </xsl:attribute>
                                <xsl:attribute name="title">Link to data set</xsl:attribute>
                                <xsl:attribute name="target">_blankt</xsl:attribute>
                                <xsl:value-of select="distribution/online/onlineDescription"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="distribution/offline != ''">
                            <xsl:value-of select="normalize-space(offline)"/>
                        </xsl:when>
                    </xsl:choose>                    
                </p>
            </xsl:when>
            <xsl:when test="$category = 'publication'">
                <p class="material">Publication:&#160;
                    <xsl:choose>
                        <xsl:when test="distribution/online != ''">
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="distribution/online/url"/>
                                </xsl:attribute>
                                <xsl:attribute name="title">Link to data set</xsl:attribute>
                                <xsl:attribute name="target">_blankt</xsl:attribute>
                                <xsl:value-of select="distribution/online/onlineDescription"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="distribution/offline != ''">
                            <xsl:value-of select="normalize-space(offline)"/>
                        </xsl:when>
                    </xsl:choose>                    
                </p>
            </xsl:when>
            <xsl:when test="$category = 'image'">
                <xsl:choose>
                    <xsl:when test="distribution/online != ''">
                        <p class="material">Image: <xsl:value-of select="distribution/online/onlineDescription"/>
                        </p>
                        <div class="image">
                            <xsl:element name="img">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="distribution/online/url"/>
                                </xsl:attribute>
                                <xsl:attribute name="alt">
                                    <xsl:value-of select="distribution/online/onlineDescription"/>
                                </xsl:attribute>
                                <xsl:attribute name="title">
                                    <xsl:value-of select="distribution/online/onlineDescription"/>
                                </xsl:attribute>
                            </xsl:element>
                        </div>
                    </xsl:when>
                    <xsl:when test="distribution/offline != ''">
                        <p class="material">Offline image: <xsl:value-of select="normalize-space(offline)"/>
                        </p>
                    </xsl:when>
                </xsl:choose>                    
            </xsl:when>
            <xsl:otherwise>
                <p class="material">Resource:&#160;
                    <xsl:choose>
                        <xsl:when test="distribution/online != ''">
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="distribution/online/url"/>
                                </xsl:attribute>
                                <xsl:attribute name="title">Link to resource</xsl:attribute>
                                <xsl:attribute name="target">_blankt</xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="distribution/online/onlineDescription != ''">
                                        <xsl:value-of select="distribution/online/onlineDescription"/>                                        
                                    </xsl:when>
                                    <xsl:otherwise>Web link to online resource</xsl:otherwise>
                                </xsl:choose>                                
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="distribution/offline != ''">
                            <xsl:value-of select="normalize-space(offline)"/>
                        </xsl:when>
                    </xsl:choose>                    
                </p>                
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
</xsl:stylesheet>