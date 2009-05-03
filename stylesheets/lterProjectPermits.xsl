<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:lter="eml://ecoinformatics.org/lter-project-2.1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0         Transitional//EN" indent="yes" media-type="text/xml"/>
    <xsl:namespace-alias stylesheet-prefix="lter" result-prefix="xsl"/>
    
    <!-- call main template to generate page layout and scaffolding, which calls topnav and body templates at appropriate points in doc -->
    <xsl:template match="lter:researchProject">
        <html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <link rel="stylesheet" media="all" type="text/css" href="http://amble.lternet.edu:8080/exist/rest/db/projects/util/web/css/lterProjectDescription.css"/>
            <title>Permits for LTER Research Projects</title>
            </head>
            <body><xsl:call-template name="permits"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="permits">
        <xsl:for-each select="permissions">
            <h3>Permit for <xsl:value-of select="@date"/><br/>
                Grantor: <xsl:value-of select="@grantor"/>
            </h3>
            <div class="report-section">
                <xsl:for-each select="description">
                    <h4 class="reports">
                        <xsl:value-of select="."/>
                    </h4>
                    </xsl:for-each>
                <xsl:for-each select="temporalCoverage">
                    <h4>Time Period</h4>
                    <p class="studyarea">
                        <xsl:call-template name="tempCover"/>
                    </p>
                </xsl:for-each>
                <xsl:for-each select="permissionCategory">
                    <xsl:for-each select="categoryTitle">
                        <h4><xsl:value-of select="."/>
                        </h4>
                    </xsl:for-each>
                <xsl:for-each select="categoryValue">
                    <p><xsl:apply-templates/>
                    </p>
                    </xsl:for-each>
                </xsl:for-each>                
            </div>
            <xsl:if test="associatedMaterial != ''">
                <xsl:for-each select="associatedMaterial">
                    <xsl:call-template name="material">
                        <xsl:with-param name="category">
                            <xsl:value-of select="@category"/>
                            </xsl:with-param>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:if>
        </xsl:for-each>
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
    
    <!-- temporal coverage template -->
    <xsl:template name="tempCover">
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
        <xsl:if test="string(ongoing)"> ongoing (started <xsl:value-of select="ongoing/beginDate/calendarDate"/>) </xsl:if>
    </xsl:template>
    
    <!-- associated material template -->
    <xsl:template name="material">
        <xsl:param name="category"/>
        <xsl:choose><xsl:when test="$category = 'data'">
                <p class="material">Dataset:&#160;
                    <xsl:choose><xsl:when test="distribution/online != ''">
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
                <xsl:choose><xsl:when test="distribution/online != ''">
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                    <xsl:value-of select="distribution/online/url"/>
                                </xsl:attribute>
                            <xsl:attribute name="title">Link to publication</xsl:attribute>
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
                <xsl:choose><xsl:when test="distribution/online != ''">
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
            <xsl:when test="$category = 'permit'">
                <p class="material">
                    <xsl:choose><xsl:when test="distribution/online != ''">
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="distribution/online/url"/>
                                </xsl:attribute>
                                <xsl:attribute name="title">Link to permit</xsl:attribute>
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
            <xsl:otherwise><p class="material">Resource:&#160;
                    <xsl:choose><xsl:when test="distribution/online != ''">
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="distribution/online/url"/>
                                </xsl:attribute>
                                <xsl:attribute name="title">Link to resource</xsl:attribute>
                                <xsl:attribute name="target">_blankt</xsl:attribute>
                                <xsl:choose><xsl:when test="distribution/online/onlineDescription != ''">
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