<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lter="eml://ecoinformatics.org/lter-project-2.1.0" version="1.0">
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" media-type="text/xml"/>
    <xsl:namespace-alias stylesheet-prefix="lter" result-prefix="xsl"/>
    
     <xsl:template match="/">

        <xsl:for-each select="lter:researchProject">
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                    <link rel="stylesheet" media="all" type="text/css" href="http://amble.lternet.edu:8080/exist/rest/db/projects/util/web/css/lterProjectDescription.css"/>
                    <script type="text/javascript" language="javascript" src="http://amble.lternet.edu:8080/exist/rest/db/projects/util/web/js/lterProjectDescription.js">
                         <xsl:comment>prevent self-closing script tag</xsl:comment>
                     </script>
                    <title>LTER Research Project Description</title>
                </head>
                <body>
                    <div id="lter_project">
                        <h2>
                            <xsl:value-of select="title"/>
                        </h2>
                        <noscript>
                            <p style="text-align: center; margin: 0 auto 1em auto">
                                <em>(Note: Javascript must be enabled to view contents by section)</em>
                            </p>
                        </noscript>
                        <table>
                            <tr>
                                <th id="project_summary_tab" class="currentTab" style="width:16.6%">
                                    <a href="javascript:showSection('project_summary')">Summary</a>
                                </th>
                                <th id="project_personnel_tab" class="defaultTab" style="width:16.6%">
                                    <a href="javascript:showSection('project_personnel')">Personnel</a>
                                </th>
                                <th id="project_studyArea_tab" class="defaultTab" style="width:16.6%">
                                    <a href="javascript:showSection('project_studyArea')">Study Area</a>
                                </th>
                                <th id="project_reports_tab" class="defaultTab" style="width:16.6%">
                                    <a href="javascript:showSection('project_reports')">Reports</a>
                                </th>
                                <th id="project_material_tab" class="defaultTab" style="width:16.6%">
                                    <a href="javascript:showSection('project_material')">Ancillary</a>
                                </th>
                                <th id="project_showall_tab" class="defaultTab" style="width:17%">
                                    <a href="javascript:showAll()">Show All</a>
                                </th>
                            </tr>
                            <tr id="project_summary" style="display:table-row">
                                <td colspan="6">
                                    <xsl:call-template name="summary"/>
                                </td>
                            </tr>
                            <tr id="project_personnel">
                                <td colspan="6">
                                    <xsl:call-template name="personnel"/>
                                </td>
                            </tr>
                            <tr id="project_studyArea">
                                <td colspan="6">
                                    <xsl:choose>
                                        <xsl:when test="./studyAreaDescription != '' or ./coverage/geographicCoverage != ''">
                                            <xsl:call-template name="studyArea"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <h3>Study Area</h3>                                            
                                            <p class="no-info">
                                                <em>No information available</em>
                                            </p>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                            </tr>
                            <tr id="project_reports">
                                <td colspan="6">
                                    <xsl:choose>
                                        <xsl:when test="reporting != ''">
                                            <xsl:call-template name="reports"/>                                            
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <h3>Reports</h3>
                                            <p class="no-info">
                                                <em>No information available</em>
                                            </p>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                            </tr>
                            <tr id="project_material">
                                <td colspan="6">
                                    <xsl:choose>
                                        <xsl:when test="associatedMaterial or additionalInfo != ''">
                                            <xsl:if test="additionalInfo != ''">
                                                <h3>Additional Information</h3>
                                                <xsl:for-each select="additionalInfo">
                                                    <xsl:apply-templates/>                                                    
                                                </xsl:for-each>
                                            </xsl:if>
                                            <xsl:if test="associatedMaterial != ''">
                                                <h3>Associated Material</h3>
                                                <xsl:for-each select="associatedMaterial">
                                                    <xsl:call-template name="material">
                                                        <xsl:with-param name="category" select="@category"/>
                                                    </xsl:call-template>
                                                </xsl:for-each>
                                            </xsl:if>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <h3>Additional Information</h3>
                                            <p class="no-info">
                                                <em>No information available</em>
                                            </p>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" class="last">
                                    &#160;
                                </td>
                            </tr>
                        </table>
                    </div>
                </body>
            </html>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="summary">
        <br/>
        <h3 class="inline">Title:</h3>
        <p class="inline">
            <xsl:value-of select="title"/>
        </p>
        <h3>Abstract:</h3>
        <xsl:for-each select="abstract">
            <xsl:call-template name="text"/>
        </xsl:for-each>
        <br/>
        <xsl:if test="keywordSet">
            <h3 class="inline">Keywords:</h3>
            <p class="inline">
                <xsl:for-each select="keywordSet/keyword">
                    <xsl:value-of select="."/>
                    <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
            </p>
            <br/>
            <br/>
        </xsl:if>
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
        <br/>
        <xsl:if test="coverage/temporalCoverage">
            <br/>
            <h3 class="inline">Time Period:</h3>
            <p class="inline">
                <xsl:for-each select="coverage/temporalCoverage">
                    <xsl:call-template name="tempCover"/>
                </xsl:for-each>
            </p>
        </xsl:if>
        <xsl:if test="funding">
            <h3>Funding:</h3>
            <xsl:for-each select="funding">
                <xsl:apply-templates/>
            </xsl:for-each>
        </xsl:if>
        <xsl:if test="designDescription">
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
                    <em>role:</em>&#160; <xsl:value-of select="role"/>                   
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
                <h4>Type Descriptors</h4>
                <xsl:for-each select="descriptor">
                    <p class="studyarea">
                        <xsl:value-of select="@name"/>: 
                        <xsl:for-each select="descriptorValue">
                            <xsl:value-of select="."/>
                            <xsl:if test="position() != last()">, </xsl:if>
                        </xsl:for-each>
                    </p>
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
            <xsl:if test="associatedMaterial != ''">
                <h4>Associated Material</h4>
                <xsl:for-each select="associatedMaterial">
                    <xsl:call-template name="material">
                        <xsl:with-param name="category" select="@category"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:if>
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
                <xsl:for-each select="associationMaterial">
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
            <xsl:value-of select="normalize-space(individualName)"/>
            <br/>
        </xsl:if>
        <xsl:if test="positionName != ''">
            <xsl:value-of select="positionName"/>
        </xsl:if>
        <xsl:if test="organizationName !=''">
            <xsl:value-of select="organizationName"/>
        </xsl:if>
        <br/>
        <xsl:if test="address !=''">
            <xsl:for-each select="address/deliveryPoint">
                <xsl:value-of select="."/>
                <br/>
            </xsl:for-each>
            <xsl:for-each select="address/city">
                <xsl:value-of select="."/>,
            </xsl:for-each>
            <xsl:for-each select="address/administrativeArea">
                <xsl:value-of select="."/>&#160;
            </xsl:for-each>
            <xsl:for-each select="address/postalCode">
                <xsl:value-of select="."/>
                <br/>
            </xsl:for-each>
            <xsl:for-each select="electronicMailAddress">
                <em>email:</em>
                <xsl:element name="a">
                    <xsl:attribute name="href">mailto:<xsl:value-of select="."/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
            <br/>
        </xsl:if>
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
    
    <!-- Geographic coverage template -->
    <xsl:template name="geoCover">
        <xsl:if test="geographicDescription[. !='']">
            <p class="studyarea">
                <xsl:text>Description: </xsl:text>
                <xsl:value-of select="geographicDescription"/>
            </p> 
        </xsl:if>
        <xsl:if test="boundingCoordinates[. !='']">
            <p class="studyarea">
                <xsl:text>Bounding Coordinates:</xsl:text>
            <br/>
            <span style="padding-left: 14px">
                <xsl:text>Longitude: </xsl:text>
                <xsl:value-of select="boundingCoordinates/westBoundingCoordinate"/>
                <xsl:text>°</xsl:text>
                <xsl:text>&#160;to&#160;</xsl:text>
                <xsl:value-of select="boundingCoordinates/eastBoundingCoordinate"/>
                <xsl:text>°</xsl:text>
            </span>
            <br/>
            <span style="padding-left: 14px">
                <xsl:text>Latitude: </xsl:text>
                <xsl:value-of select="boundingCoordinates/southBoundingCoordinate"/>
                <xsl:text>°</xsl:text>
                <xsl:text>&#160;to&#160;</xsl:text>
                <xsl:value-of select="boundingCoordinates/northBoundingCoordinate"/>
                <xsl:text>°</xsl:text>
            </span>
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
        <xsl:if test="string(ongoing)"> ongoing (started <xsl:value-of select="ongoing/beginDate/calendarDate"/>) </xsl:if>
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