<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lter="eml://ecoinformatics.org/lter-project-2.1.0" version="1.0">
    <xsl:output method="xml" omit-xml-declaration="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:namespace-alias stylesheet-prefix="lter" result-prefix="xsl"/>

    <!-- call main template to generate page layout and scaffolding, which calls topnav and body templates at appropriate points in doc -->
    <xsl:template match="/">
        <xsl:call-template name="main">
            <xsl:with-param name="css">/exist/rest/db/projects/util/web/css/gceProjectDescriptionPlain.css</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="main">
        <xsl:param name="css"/>
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
                <link rel="stylesheet" type="text/css" href="/exist/rest/db/projects/util/web/css/gce_main_plain.css"/>
                <xsl:element name="link">
                    <xsl:attribute name="rel">stylesheet</xsl:attribute>
                    <xsl:attribute name="type">text/css</xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="$css"/>
                    </xsl:attribute>
                </xsl:element>
                <title>Georgia Coastal Ecosystems LTER :: Research Project</title>
            </head>
            <body>
                <xsl:if test="/error/errorMessage != ''">
                    <h1>Invalid Project</h1>
                    <p style="text-align:center;padding:1em 72px;">
                        <xsl:value-of select="/error/errorMessage"/>
                    </p>
                </xsl:if>
                <xsl:call-template name="projects_query"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template name="projects_query">
        <xsl:for-each select="lter:researchProject">
            <div id="lter_project">
                <h2>
                    <xsl:value-of select="shortName"/>
                </h2>
                <xsl:call-template name="summary"/>
                <xsl:if test="associatedMaterial[@category!='data' and @category!='publication'] != ''">
                    <h3>Figures and Illustrations</h3>
                    <xsl:for-each select="associatedMaterial[@category!='data' and @category!='publication']">
                        <xsl:call-template name="material">
                            <xsl:with-param name="category" select="@category"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </xsl:if>
                <xsl:call-template name="personnel"/>
                <xsl:if test="./studyAreaDescription != '' or ./coverage/geographicCoverage != ''">
                    <xsl:call-template name="studyArea"/>
                </xsl:if>
                <xsl:if test="reporting != ''">
                    <xsl:call-template name="reports"/>
                </xsl:if>
                <xsl:if test="associatedMaterial[@category='publication'] != ''">
                    <h3>Publications</h3>
                    <xsl:for-each select="associatedMaterial[@category='publication']">
                        <xsl:call-template name="material">
                            <xsl:with-param name="category" select="@category"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="associatedMaterial[@category='data'] != ''">
                    <h3>Data Sets</h3>
                    <xsl:for-each select="associatedMaterial[@category='data']">
                        <xsl:call-template name="material">
                            <xsl:with-param name="category" select="@category"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="additionalInfo != ''">
                    <h3>Additional Information</h3>
                    <xsl:for-each select="additionalInfo">
                        <xsl:call-template name="text"/>
                    </xsl:for-each>
                </xsl:if>
            </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="summary">
        <br/>
        <h3 class="inline">Title:</h3>
        <p class="inline">
            <xsl:value-of select="title"/>
        </p>
        <div style="margin: 1.25em 0 1em 0">
            <h3 class="inline">Lead Investigator(s): </h3>
            <p class="inline">
                <xsl:for-each select="creator">
                    <xsl:choose>
                        <xsl:when test="references != ''">
                            <xsl:variable name="ref">
                                <xsl:value-of select="references"/>
                            </xsl:variable>
                            <xsl:for-each select="/lter:researchProject/associatedParty[@id = $ref]">
                                <xsl:value-of select="normalize-space(individualName)"/>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="normalize-space(individualName)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
            </p>
        </div>
        <h3>Description:</h3>
        <xsl:for-each select="abstract">
            <xsl:call-template name="text"/>
        </xsl:for-each>
        <xsl:if test="funding">
            <div style="margin:1em 0 1em 0">
                <div style="float:left; width: auto; margin-right: 8px">
                    <h3 class="inline">Funding:</h3>
                </div>
                <div style="float:none; margin-left: 36px">
                    <p>
                        <xsl:for-each select="funding/section/para">
                            <xsl:apply-templates/>
                        </xsl:for-each>
                    </p>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="keywordSet">
            <div style="margin:1em 0 1em 0">
                <div style="float:left; width:auto; margin-right: 8px">
                    <h3 class="inline">Keywords:</h3>
                </div>
                <div style="float:none; margin-left: 36px">
                    <p>
                        <xsl:for-each select="keywordSet/keyword">
                            <xsl:value-of select="."/>
                            <xsl:if test="position() != last()">, </xsl:if>
                        </xsl:for-each>
                    </p>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="coverage/temporalCoverage">
            <h3 class="inline">Time Period:</h3>
            <p class="inline">
                <xsl:for-each select="coverage/temporalCoverage">
                    <xsl:call-template name="tempCover"/>
                </xsl:for-each>
            </p>
        </xsl:if>
        <xsl:if test="designDescription">
            <br/>
            <h3>Study Design:</h3>
            <xsl:apply-templates select="designDescription"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="personnel">
        <h3>Lead Project Investigators</h3>
        <xsl:for-each select="creator">
            <p class="party">
                <xsl:choose>
                    <xsl:when test="references != ''">
                        <xsl:variable name="ref">
                            <xsl:value-of select="references"/>
                        </xsl:variable>
                        <xsl:for-each select="/lter:researchProject/associatedParty[@id = $ref]">
                            <xsl:call-template name="rp"/>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="rp"/>
                    </xsl:otherwise>
                </xsl:choose>
            </p>
        </xsl:for-each>
        <xsl:if test="associatedParty">
            <h3>All Associated Personnel</h3>
            <xsl:for-each select="associatedParty">
                <p class="party">
                    <xsl:call-template name="rp"/>
                    <em>role:</em>
                    <xsl:value-of select="role"/>
                </p>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    <xsl:template name="studyArea">
        <xsl:for-each select="coverage/geographicCoverage">
            <h3>Overall Geographic Coverage</h3>
            <xsl:call-template name="geoCover"/>
        </xsl:for-each>
        <xsl:for-each select="studyAreaDescription">
            <h3>Study Site Descriptions</h3>
            <xsl:if test="descriptor != ''">
                <h4>Environment Type Descriptors</h4>
                <xsl:for-each select="descriptor">
                    <p class="studyarea">
                        <xsl:value-of select="@name"/>: <xsl:for-each select="descriptorValue">
                            <xsl:value-of select="."/>
                            <xsl:if test="position() != last()">, </xsl:if>
                        </xsl:for-each>
                    </p>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="associatedMaterial != ''">
                <h4>Maps and Photos</h4>
                <xsl:for-each select="associatedMaterial">
                    <xsl:call-template name="material">
                        <xsl:with-param name="category" select="@category"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:if>
            <xsl:for-each select="coverage/geographicCoverage">
                <h4>Geographic Location</h4>
                <xsl:call-template name="geoCover"/>
            </xsl:for-each>
            <xsl:for-each select="coverage/temporalCoverage">
                <h4>Time Period</h4>
                <p class="studyarea">
                    <xsl:call-template name="tempCover"/>
                </p>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="reports">
        <xsl:for-each select="reporting">
            <h3>Report for <xsl:value-of select="@date"/>
            </h3>
            <div class="report-section">
                <xsl:for-each select="reportSection">
                    <h4 class="reports">
                        <xsl:value-of select="sectionTitle"/>
                    </h4>
                    <xsl:for-each select="sectionValue">
                        <xsl:apply-templates/>
                    </xsl:for-each>
                </xsl:for-each>
                <xsl:for-each select="associatedMaterial">
                    <xsl:call-template name="material">
                        <xsl:with-param name="category">
                            <xsl:value-of select="@category"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:for-each>
            </div>
        </xsl:for-each>
    </xsl:template>

    <!-- responsible party template -->
    <xsl:template name="rp">
        <xsl:if test="individualName[. !='']">
            <strong>
                <xsl:value-of select="normalize-space(individualName)"/>
            </strong>
        </xsl:if>
        <xsl:if test="positionName != ''">
            <xsl:value-of select="positionName"/>
        </xsl:if>
        <br/>
        <xsl:if test="organizationName !=''">
            <em>organization:</em>
            <xsl:text> </xsl:text>
            <xsl:value-of select="organizationName"/>
            <br/>
        </xsl:if>
        <xsl:if test="address !=''">
            <em>address:</em>
            <xsl:text> </xsl:text>
            <xsl:for-each select="address/deliveryPoint">
                <xsl:value-of select="."/>
                <xsl:text>, </xsl:text>
            </xsl:for-each>
            <xsl:for-each select="address/city">
                <xsl:value-of select="."/>
                <xsl:text>, </xsl:text>
            </xsl:for-each>
            <xsl:for-each select="address/administrativeArea">
                <xsl:value-of select="."/>
                <xsl:text> </xsl:text>
            </xsl:for-each>
            <xsl:for-each select="address/postalCode">
                <xsl:value-of select="."/>
                <br/>
            </xsl:for-each>
            <xsl:for-each select="electronicMailAddress">
                <em>email:</em>
                <xsl:text> </xsl:text>
                <xsl:element name="a">
                    <xsl:attribute name="href">mailto:<xsl:value-of select="."/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
                <br/>
            </xsl:for-each>
        </xsl:if>
        <xsl:for-each select="temporalCoverage">
            <em>participation:</em>
            <xsl:text> </xsl:text>
            <xsl:call-template name="tempCover"/>
            <br/>
        </xsl:for-each>
    </xsl:template>

    <!-- Templates for converting textType elements to HTML markup -->
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
            <xsl:apply-templates/>
        </xsl:if>
        <xsl:if test="not (para/literalLayout)">
            <xsl:element name="li">
                <xsl:value-of select="."/>
            </xsl:element>
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
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>

    <!-- Geographic coverage template -->
    <xsl:template name="geoCover">
        <xsl:if test="geographicDescription[. !='']">
            <p class="studyarea">
                <xsl:value-of select="geographicDescription"/>
            </p>
        </xsl:if>
        <xsl:if test="boundingCoordinates[. !='']">
            <p class="studyarea">
                <xsl:if test="boundingCoordinates/westBoundingCoordinate != boundingCoordinates/eastBoundingCoordinate">
                    <xsl:text>Polygon Bounding Box Coordinates:</xsl:text>
                    <br/>
                    <span style="padding-left: 14px">
                        <xsl:text>Longitude: </xsl:text>
                        <xsl:value-of select="boundingCoordinates/westBoundingCoordinate"/>
                        <xsl:text> </xsl:text>
                        <xsl:text> to </xsl:text>
                        <xsl:value-of select="boundingCoordinates/eastBoundingCoordinate"/>
                        <xsl:text> </xsl:text>
                    </span>
                </xsl:if>
                <xsl:if test="boundingCoordinates/westBoundingCoordinate = boundingCoordinates/eastBoundingCoordinate">
                    <xsl:text>Location Coordinates:</xsl:text>
                    <br/>
                    <span style="padding-left: 14px">
                        <xsl:text>Longitude: </xsl:text>
                        <xsl:value-of select="boundingCoordinates/westBoundingCoordinate"/>
                        <xsl:text> </xsl:text>
                    </span>
                </xsl:if>
                <br/>
                <xsl:if test="boundingCoordinates/southBoundingCoordinate !=                     boundingCoordinates/northBoundingCoordinate">
                    <span style="padding-left: 14px">
                        <xsl:text>Latitude: </xsl:text>
                        <xsl:value-of select="boundingCoordinates/southBoundingCoordinate"/>
                        <xsl:text> </xsl:text>
                        <xsl:text> to </xsl:text>
                        <xsl:value-of select="boundingCoordinates/northBoundingCoordinate"/>
                        <xsl:text> </xsl:text>
                    </span>
                </xsl:if>
                <xsl:if test="boundingCoordinates/southBoundingCoordinate = boundingCoordinates/northBoundingCoordinate">
                    <span style="padding-left: 14px">
                        <xsl:text>Latitude: </xsl:text>
                        <xsl:value-of select="boundingCoordinates/southBoundingCoordinate"/>
                        <xsl:text> </xsl:text>
                    </span>
                </xsl:if>
            </p>
        </xsl:if>
    </xsl:template>

    <!-- temporal coverage template -->
    <xsl:template name="tempCover">
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
        <xsl:if test="string(ongoing)"> ongoing (started <xsl:value-of select="ongoing/beginDate/calendarDate"/>)
        </xsl:if>
    </xsl:template>

    <!-- associated material template -->
    <xsl:template name="material">
        <xsl:param name="category"/>
        <xsl:choose>
            <xsl:when test="$category = 'data'">
                <p class="material">
                    <xsl:choose>
                        <xsl:when test="distribution/online != ''">
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="distribution/online/url"/>
                                </xsl:attribute>
                                <xsl:attribute name="title">Link to data set</xsl:attribute>
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
                <p class="material">
                    <xsl:choose>
                        <xsl:when test="distribution/online != ''">
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="distribution/online/url"/>
                                </xsl:attribute>
                                <xsl:attribute name="title">Link to data set</xsl:attribute>
                                <xsl:value-of select="distribution/online/onlineDescription"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="distribution/offline != ''">
                            <xsl:value-of select="distribution/offline/mediumName"/>
                        </xsl:when>
                    </xsl:choose>
                </p>
            </xsl:when>
            <xsl:when test="$category = 'image'">
                <xsl:choose>
                    <xsl:when test="distribution/online != ''">
                        <p class="material">
                            <xsl:value-of select="distribution/online/onlineDescription"/>
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
                <p class="material">Resource:  <xsl:choose>
                        <xsl:when test="distribution/online != ''">
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="distribution/online/url"/>
                                </xsl:attribute>
                                <xsl:attribute name="title">Link to resource</xsl:attribute>
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