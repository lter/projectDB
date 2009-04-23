<?xml version="1.0"?>
<!--
       
       Copyright: 1997-2002 Regents of the University of California,
                            University of New Mexico, and
                            Arizona State University
        Sponsors: National Center for Ecological Analysis and Synthesis and
                  Partnership for Interdisciplinary Studies of Coastal Oceans,
                     University of California Santa Barbara
                  Long-Term Ecological Research Network Office,
                     University of New Mexico
                  Center for Environmental Studies, Arizona State University
   Other funding: National Science Foundation (see README for details)
                  The David and Lucile Packard Foundation
     For Details: http://knb.ecoinformatics.org/

        '$Author: obrien $'
          '$Date: 2008/08/27 21:30:04 $'
      '$Revision: 1.61 $'

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
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:doc="eml://ecoinformatics.org/documentation-2.1.0" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:output doctype-public="-//OASIS//DTD DocBook XML V4.1.2//EN"
    doctype-system="http://www.oasis-open.org/docbook/xml/4.0/docbookx.dtd"/>

  <xsl:template match="/">
    <book>
      <bookinfo>
        <title>About projectDB Schema</title>
      </bookinfo>
      <chapter id="introduction">
        <title>Introduction</title>
        <para>The schema for the projectDB is closely based on the EML project module. The EML
          development community is aware of this use, and we plan to recommend a set of changes to
          the EML schema in the course of this work.</para>
      </chapter>
      <!-- 
      features-->
      <chapter id="features">
        <title>Features and differences from EML 2</title>

        <para>The projectDB schema incorporates most of the important features of EML2. We have
          imported the EML2.1 series of schema docs, in anticipation of it's release early in 2009.
          Some changes have been made to the project schema for projectDB, and so it differs from
          EML 2's project module in these ways:</para>

        <section>
          <title>Root-level element is &lt;researchProject&gt;</title>
          <para>The root-level element is &lt;researchProject&gt; instead of
            &lt;eml&gt;. <itemizedlist>

              <listitem>Documents written against this schema may use any namespace prefix, but
                authors creating documents for LTER applications should use the prefix
                "lter".</listitem>
              <listitem>At some future time, the root level element may become &lt;eml:eml&gt;,
                and the researchProject elevated to it's first child. This structure 
                would be analogous to the dataset, citation, software, or protocol 
                modules in EML 2. </listitem>
            </itemizedlist>
          </para>
        </section>
        <section>
          <title>Import the resource group </title>
          <para> The project schema uses the resource group, as do other top-level EML elements.
          </para>
        </section>
        <section>
          <title> New nodes added </title>
          <para>Four new nodes were added to the eml-project schema to accommodate use cases. 
            All are optional and repeatable.
            <orderedlist>
              <listitem>&lt;reporting&gt;: to contain information about reporting needs.
                This node is generic, with elements for the name of a report section and a
                value (text), and attributes desribing the report's recipient and a date. </listitem>
              <listitem>&lt;permissions&gt;: to contain information about project management.
                Like reporting, this node is generic,  elements for a permissions category and a
                value (text), and attributes desribing the premission grantor and a date. </listitem>
              <listitem> &lt;associatedMaterial&gt;: to contain distribution info about an
                associated resource of the project, such as a dataset or publication 
              </listitem>
              <listitem> &lt;associatedProject&gt;: to contain the name and relationship of
                a project associated with the project being descibed. The relationship is limited to
                "parent", since this is the only information required to
                build geneological relationships. In the EML 2.1 project schema module, related 
                projects can be
                nested. This may be appropirate for a datset or citation, but for this use,
                a nested structure might result in complex branching documents in which
                relationships were difficult to follow. A structure more similar to "triples"
                results in simpler instance documents and is simpler to implement.
              </listitem>
            </orderedlist>
          </para>
        </section>





      </chapter>
      <chapter id="moduleOverview">
        <title>Module Overview </title>
        <section>
          <title>Introduction to projectDB modules and their use</title>
          <para> The following section briefly describes each EML module used by the projectDB.
          </para>
        </section>
        <section>
          <title> Root-level structure </title>
          <!-- Get the module descriptions from the project xsd file -->
          <xsl:apply-templates select="document('lter-project.xsd')//doc:moduleDescription/*"
            mode="copy"/>
          <!-- Get the eml module description from the xsd file
          <xsl:apply-templates select="document('eml.xsd')//doc:moduleDescription/*" mode="copy"></xsl:apply-templates>
 -->
        </section>

        <section>
          <title>Modules Used </title>
          <para> The following modules are used</para>
          <!-- Get the eml-resource module description from each  xsd file -->
          <xsl:apply-templates select="document('eml-resource.xsd')//doc:moduleDescription/*"
            mode="copy"/>
          <xsl:apply-templates select="document('eml-physical.xsd')//doc:moduleDescription/*"
            mode="copy"/>
          <xsl:apply-templates select="document('eml-party.xsd')//doc:moduleDescription/*"
            mode="copy"/>
          <xsl:apply-templates select="document('eml-coverage.xsd')//doc:moduleDescription/*"
            mode="copy"/>
          <xsl:apply-templates select="document('eml-literature.xsd')//doc:moduleDescription/*"
            mode="copy"/>
          <xsl:apply-templates select="document('eml-access.xsd')//doc:moduleDescription/*"
            mode="copy"/>

        </section>
      </chapter>



      <chapter id="moduleDescriptions">
        <title>Module Descriptions (Normative)</title>
        <xsl:for-each select="//doc:module">
          <xsl:variable name="moduleNameVar">
            <!-- save the name of the module we are in in this loop-->
            <xsl:value-of select="document(.)//doc:moduleName"/>.xsd </xsl:variable>
          <xsl:variable name="importedByList">
            <!--this is the variable that will be sent to the template-->
            <xsl:for-each select="/xs:schema/xs:annotation/xs:appinfo/doc:moduleDocs/doc:module">
              <xsl:variable name="currentModuleName">
                <!--save the name of the module that we are in this loop-->
                <xsl:value-of select="."/>
              </xsl:variable>
              <xsl:for-each select="document(.)//xs:import">
                <!-- go through each import statement and see if the current module is there -->
                <xsl:if test="normalize-space($moduleNameVar)=normalize-space(./@schemaLocation)">
                  <!-- if it is put it in the variable -->
                  <xsl:value-of
                    select="substring($currentModuleName, 0,
                                  string-length($currentModuleName) - 3)"/>
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:variable>
          <xsl:apply-templates select="document(.)//doc:moduleDocs">
            <!--send the importedBy variable to this stylesheet-->
            <xsl:with-param name="importedBy" select="$importedByList"/>
          </xsl:apply-templates>
        </xsl:for-each>
      </chapter>

      <index id="index">
        <title>Index</title>
        <indexdiv>
          <title>A</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:sort select="@name" data-type="text"/>
              <xsl:if test="starts-with(@name, 'a')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>B</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'b')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>C</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'c')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>D</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'd')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>E</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'e')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>F</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'f')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>G</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'g')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>H</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'h')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>I</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'i')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>J</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'j')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>k</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'k')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>L</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'l')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>M</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'm')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>

        </indexdiv>
        <indexdiv>
          <title>N</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'n')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>O</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'o')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>P</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'p')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>Q</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'q')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'r')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>S</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 's')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>T</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 't')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>U</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'u')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>V</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'v')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>W</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'w')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>X</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'x')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>Y</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'y')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>Z</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'z')">
                <xsl:apply-templates select="." mode="indexentry"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
          <indexentry>
            <primaryie/>
          </indexentry>
        </indexdiv>
      </index>
    </book>
  </xsl:template>

  <xsl:template match="*|@*|text()" mode="copy">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|text()" mode="copy"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="doc:moduleDocs">
    <xsl:param name="importedBy"/>
    <section>
      <xsl:attribute name="id">
        <xsl:value-of select="./doc:moduleName"/>
      </xsl:attribute>
      <title>
        <xsl:value-of select="./doc:moduleName"/>
      </title>
      <para>Normative technical docs for <ulink>
          <xsl:attribute name="url">./<xsl:value-of select="./doc:moduleName"/>.html</xsl:attribute>
          <xsl:value-of select="./doc:moduleName"/>
        </ulink>
      </para>

    </section>
  </xsl:template>

  <xsl:template match="xs:element" mode="indexentry">
    <indexentry>
      <primaryie>
        <ulink>
          <xsl:attribute name="url">./<xsl:value-of select="//doc:moduleName"/>.html#<xsl:value-of
              select="@name"/></xsl:attribute>
          <xsl:value-of select="@name"/>
        </ulink>-<xsl:value-of select="//doc:moduleName"/>
      </primaryie>
    </indexentry>
  </xsl:template>
</xsl:stylesheet>
