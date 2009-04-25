<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/">
        <xsl:element name="markers">
            <xsl:for-each select="projects/project/coverage/geographicCoverage/boundingCoordinates">
                <xsl:element name="marker">
                    <xsl:attribute name="lat">
                        <xsl:value-of select="northBoundingCoordinate"/>
                    </xsl:attribute>
                    <xsl:attribute name="long">
                        <xsl:value-of select="westBoundingCoordinate"/>
                    </xsl:attribute>
                    <xsl:attribute name="html">
                        <xsl:value-of select="ancestor::geographicCoverage/geographicDescription"/>
                    </xsl:attribute>
                    <xsl:attribute name="label">
                        <xsl:value-of select="ancestor::geographicCoverage/geographicDescription"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>