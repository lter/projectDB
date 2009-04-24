<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Copyright: 2003 Board of Reagents, Arizona State University
    
    This material is based upon work supported by the National Science Foundation 
    under Grant No. 9983132 and 0219310. Any opinions, findings and conclusions or recommendation 
    expressed in this material are those of the author(s) and do not necessarily 
    reflect the views of the National Science Foundation (NSF).  
                  
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.
 
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html"/>
	<!-- root element -->
	<xsl:template xmlns:lter="eml://ecoinformatics.org/lter-project-2.1.0" match="lter:researchProject">
		<xsl:for-each select=".">
			<xsl:element name="html">
				<xsl:element name="head">
					<xsl:element name="style"> .node { color : #225555; font-family : Verdana,
						Geneva, Arial, Helvetica, sans-serif; margin-left: 0.1cm } BODY {
						font-family : Verdana, Geneva, Arial, Helvetica, sans-serif; font-size :
						10pt; } .tagLabel { color : 225555; margin-right: 0.3cm; margin-left: 0.3cm
						} .tagValue { margin-right: 0.3cm; margin-left: 0.5cm; color : black } </xsl:element>
					<xsl:element name="link">
						<xsl:attribute name="REL">stylesheet</xsl:attribute>
						<xsl:attribute name="TYPE">text/css</xsl:attribute>
						<xsl:attribute name="HREF">/exist/rest/util/web/css/caplter.css</xsl:attribute>
					</xsl:element>
				</xsl:element>
				<xsl:element name="body">
					<xsl:call-template name="project"/>
				</xsl:element>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!-- main template for everything project -->
	<xsl:template name="project">
		<xsl:for-each select="title">
			<xsl:element name="span">
				<xsl:attribute name="class">level1m</xsl:attribute>
				<xsl:value-of select="."/>
				<xsl:element name="br"/>
			</xsl:element>
		</xsl:for-each>
		<span class="level3m">Identifier:</span>
		<xsl:element name="a">
			<xsl:attribute name="href">
				<xsl:for-each select="distribution/online/url">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</xsl:attribute>
			<xsl:value-of select="@id"/>
		</xsl:element>
		<br/>
		<xsl:if test="creator[. !='']">
			<br/>
			<span class="level3m">Principal Investigator(s):</span>
			<br/>
			<xsl:for-each select="creator">
				<xsl:if test="individualName[. !='']">
					<xsl:value-of select="individualName/givenName"/>
					<xsl:text>&#160;</xsl:text>
					<xsl:value-of select="individualName/surName"/>
					<br/>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="associatedParty[. !='']">
			<br/>
			<span class="level3m">Associated with the Project:</span>
			<br/>
			<xsl:for-each select="associatedParty">
				<xsl:if test="individualName[. !='']">
					<xsl:value-of select="individualName/givenName"/>
					<xsl:text>&#160;</xsl:text>
					<xsl:value-of select="individualName/surName"/>
					<xsl:text>,&#160;</xsl:text>
					<xsl:value-of select="role"/>
					<xsl:text>&#160;</xsl:text>
					<xsl:for-each select="temporalCoverage">
						<xsl:call-template name="tempCover"/>
					</xsl:for-each>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:for-each select="metadataProvider">
			<br/>
			<span class="level3m">Metadata Provider and Contact:</span>
			<br/>
			<xsl:call-template name="rp"/>
		</xsl:for-each>
		<xsl:for-each select="abstract">
			<br/>
			<span class="level3m">Abstract:</span>
			<xsl:call-template name="textType"/>
		</xsl:for-each>
		<br/>
		<br/>
		<xsl:if test="keywordSet[. !='']">
			<span class="level3m">Keywords:</span>
			<div><xsl:for-each select="keywordSet">
					<xsl:call-template name="keywordSet"/>
				</xsl:for-each>
			</div>
		</xsl:if>
		<xsl:for-each select="coverage/temporalCoverage">
			<br/>
			<span class="level3m">Temporal Coverage:</span>
			<br/>
			<xsl:for-each select=".">
				<xsl:call-template name="tempCover"/>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="coverage/geographicCoverage">
			<br/>
			<span class="level3m">Geographic Coverage:</span>
			<br/>
			<xsl:for-each select=".">
				<xsl:call-template name="geoCover"/>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:if test="associatedMaterial[. !='']">
			<br/>
            <br/>
			<span class="level2m">Associated Material:</span>
			<xsl:if test="associatedMaterial/@type = 'Dataset'">
				<br/>
				<br/>
				<span class="level3m">Datasets:</span>
				<br/>
				<br/>
				<xsl:for-each select="associatedMaterial/distribution/online/onlineDescription">
					<xsl:element name="a">
					<xsl:attribute name="href">
						<xsl:value-of select="./ancestor::online/url"/>
					</xsl:attribute>
						<xsl:value-of select="."/>
				</xsl:element>
					<br/>
                    <br/>
				</xsl:for-each>
			</xsl:if>
			<br/>
		</xsl:if>
		<xsl:if test="designDescription/description[. !='']">
			<xsl:for-each select="designDescription/description">
				<br/>
				<span class="level3m">Design:</span>
				<xsl:call-template name="textType"/>
			</xsl:for-each>
			<br/>
			<br/>
		</xsl:if>
		<xsl:if test="funding[. !='']">
			<xsl:for-each select="abstract">
				<br/>
				<span class="level3m">Funding:</span>
				<xsl:call-template name="textType"/>
			</xsl:for-each>
			<br/>
			<br/>
		</xsl:if>
	</xsl:template>
	<!-- Georgraphic coverage template -->
	<xsl:template name="geoCover">
		<xsl:if test="geographicDescription[. !='']">
			<xsl:text>Geographic Description:</xsl:text>
			<xsl:value-of select="geographicDescription"/>
			<br/>
		</xsl:if>
		<xsl:if test="boundingCoordinates[. !='']">
			<xsl:text>Bounding Coordinates:</xsl:text>
			<br/>
			<xsl:text>Longitude:</xsl:text>
			<xsl:value-of select="boundingCoordinates/westBoundingCoordinate"/>
			<xsl:text>&#160;</xsl:text>
			<xsl:text>to&#160;</xsl:text>
			<xsl:value-of select="boundingCoordinates/eastBoundingCoordinate"/>
			<br/>
			<xsl:text>Latitude:</xsl:text>
			<xsl:value-of select="boundingCoordinates/northBoundingCoordinate"/>
			<xsl:text>&#160;</xsl:text>
			<xsl:text>to&#160;</xsl:text>
			<xsl:value-of select="boundingCoordinates/southBoundingCoordinate"/>
			<br/>
		</xsl:if>
	</xsl:template>
	<!-- temporal coverage template -->
	<xsl:template name="tempCover">
		<xsl:if test="singleDateTime[. !='']">
			<xsl:value-of select="singleDateTime/calendarDate"/>
			<xsl:text>&#160;-&#160;current</xsl:text>
			<br/>
		</xsl:if>
		<xsl:if test="rangeOfDates[. !='']">
			<xsl:value-of select="rangeOfDates/beginDate/calendarDate"/>
			<xsl:text>&#160;</xsl:text>
			<xsl:text>-&#160;</xsl:text>
			<xsl:value-of select="rangeOfDates/endDate/calendarDate"/>
			<br/>
		</xsl:if>
	</xsl:template>
	<!-- responsible party template -->
	<xsl:template name="rp">
		<xsl:if test="individualName[. !='']">
			<xsl:value-of select="individualName/givenName"/>
			<xsl:text>&#160;</xsl:text>
			<xsl:value-of select="individualName/surName"/>
			<br/>
		</xsl:if>
		<xsl:if test="positionName != ''">
			<xsl:value-of select="positionName"/>
			<xsl:text>,&#160;</xsl:text>
		</xsl:if>
		<xsl:if test="organizationName !=''">
			<xsl:value-of select="organizationName"/>
			<xsl:text>,&#160;</xsl:text>
		</xsl:if>
		<br/>
		<xsl:if test="address !=''">
			<xsl:for-each select="address/deliveryPoint">
				<xsl:value-of select="."/>
				<xsl:text>,&#160;</xsl:text>
			</xsl:for-each>
			<xsl:for-each select="address/city">
				<xsl:value-of select="."/>
				<xsl:text>&#160;</xsl:text>
			</xsl:for-each>
			<xsl:for-each select="address/postalCode">
				<xsl:value-of select="."/>
			</xsl:for-each>
			<xsl:for-each select="electronicMailAddress">
				<br/>
				<xsl:text>&#160;</xsl:text>
				<xsl:element name="a">
					<xsl:attribute name="href">mailto:<xsl:value-of select="."/>
                    </xsl:attribute>
					<xsl:attribute name="class">bodylink</xsl:attribute>
					<xsl:value-of select="."/>
				</xsl:element>
			</xsl:for-each>
			<br/>
		</xsl:if>
	</xsl:template>
	<!-- keyword set template -->
	<xsl:template name="keywordSet">
		<xsl:for-each select="keyword">
			<xsl:value-of select="."/>
			<xsl:if test="position() != last()">
				<xsl:text>,&#160;</xsl:text>
			</xsl:if>
		</xsl:for-each>
		<br/>
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
		<xsl:if test="title">
			<xsl:variable name="hdr" select="./title"/>
			<xsl:element name="{$hdr}">
				<xsl:value-of select="para/literalLayout"/>
			</xsl:element>
		</xsl:if>
		<xsl:if test="not ( title)">
			<xsl:apply-templates/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="para">
		<xsl:if test="itemizedlist or orderedlist">
			<xsl:apply-templates/>
		</xsl:if>
		<xsl:if test="literalLayout or emphasis or subscript or superscript">
			<xsl:element name="p">
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:if>
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
	<xsl:template name="associatedMaterial"> </xsl:template>
</xsl:stylesheet>