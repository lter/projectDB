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
  <xsl:output method="xml" indent="yes"></xsl:output>
  <xsl:output doctype-public="-//OASIS//DTD DocBook XML V4.1.2//EN"
    doctype-system="http://www.oasis-open.org/docbook/xml/4.0/docbookx.dtd"></xsl:output>

  <xsl:template match="/">
    <book>
      <bookinfo>
        <title>Ecological Metadata Language (EML) Specification</title>
      </bookinfo>
      <chapter id="preface">
        <title>Preface</title>
        <section id="introduction">
          <title>Introduction</title>
          <para> intro for the project module </para>
        </section>
        <section id="features">
          <title>Features</title>
          <para> some feature text here </para>
        </section>
      </chapter>
      <chapter id="moduleOverview">
        <title>Overview of EML modules and their use</title>
        <section>
          <title>Module Overview Foreword</title>
          <para> The following section briefly describes each EML module and how they are logically
            designed in order to document ecological resources. Some of the modules are dependent on
            others, while others may be used as stand-alone descriptions. This section describes the
            modules using a &quot;top down&quot; approach, starting from the top-level eml
            wrapper module, followed by modules of increasing detail. However, there are modules
            that may be used at many levels, such as eml-access. These modules are described when it
            is appropriate. </para>
        </section>
        <section>
          <title> Root-level structure </title>
          <!-- Get the eml module description from the xsd file -->
          <xsl:apply-templates select="document('eml.xsd')//doc:moduleDescription/*" mode="copy"></xsl:apply-templates>
          <!-- Get the eml-resource module description from the xsd file -->
          <xsl:apply-templates select="document('eml-resource.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
        </section>
        <section>
          <title> Top-level resources </title>
          <para> The following four modules are used to describe separate resources: datasets,
            literature, software, and protocols. However, note that the dataset module makes use of
            the other top-level modules by importing them at different levels. For instance, a
            dataset may have been produced using a particular protocol, and that protocol may come
            from a protocol document in a library of protocols. Likewise, citations are used
            throughout the top-level resource modules by importing the literature module. </para>
          <!-- Get the eml-dataset module description from the xsd file -->
          <xsl:apply-templates select="document('eml-dataset.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-literature module description from the xsd file -->
          <xsl:apply-templates select="document('eml-literature.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-software module description from the xsd file -->
          <xsl:apply-templates select="document('eml-software.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-protocol module description from the xsd file -->
          <xsl:apply-templates select="document('eml-protocol.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
        </section>
        <section>
          <title> Supporting Modules - Adding detail to top-level resources </title>
          <para> The following six modules are used to qualify the resources being described in more
            detail. They are used to describe access control rules, distribution of the metadata and
            data themselves, parties associated with the resource, the geographic, temporal, and
            taxonomic extents of the resource, the overall research context of the resource, and
            detailed methodology used for creating the resource. Some of these modules are imported
            directly into the top-level resource modules, often in many locations in order to limit
            the scope of the description. For instance, the eml-coverage module may be used for a
            particular column of a dataset, rather than the entire dataset as a whole. </para>
          <!-- Get the eml-access module description from the xsd file -->
          <xsl:apply-templates select="document('eml-access.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-physical module description from the xsd file -->
          <xsl:apply-templates select="document('eml-physical.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-party module description from the xsd file -->
          <xsl:apply-templates select="document('eml-party.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-coverage module description from the xsd file -->
          <xsl:apply-templates select="document('eml-coverage.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-project module description from the xsd file -->
          <xsl:apply-templates select="document('eml-project.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-methods module description from the xsd file -->
          <xsl:apply-templates select="document('eml-methods.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
        </section>
        <section>
          <title> Data organization - Modules describing dataset structures </title>
          <para> The following three modules are used to document the logical layout of a dataset.
            Many datasets are comprised of multiple entities (e.g. a series of tabular data files,
            or a set of GIS features, or a number of tables in a relational database). Each entity
            within a dataset may contain one or more attributes (e.g. multiple columns in a
            datafile, multiple attributes of a GIS feature, or multiple columns of a database
            table). Lastly, there may be both simple or complex relationships among the entities
            within a dataset. The relationships, or the constraints that are to be enforced in the
            dataset, are described using the eml-constraint module. All entities share a common set
            of information (described using eml-entity), but some discipline specific entities have
            characteristics that are unique to that entity type. Therefore, the eml-entity module is
            extended for each of these types (dataTable, spatialRaster, spatialVector, etc...) which
            are described in the next section. </para>
          <!-- Get the eml-entity module description from the xsd file -->
          <xsl:apply-templates select="document('eml-entity.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-attribute module description from the xsd file -->
          <xsl:apply-templates select="document('eml-attribute.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-constraint module description from the xsd file -->
          <xsl:apply-templates select="document('eml-constraint.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!--section>
          <title>
            The stmml module - Definitions for creating a unit
            dictionary in EML
          </title>
          <para>
          <emphasis>This section is not yet complete.</emphasis>
          </para>
        </section-->
        </section>
        <section>
          <title> Entity types - Detailed information for discipline specific entities </title>
          <para> The following six modules are used to describe a number of common types of entities
            found in datasets. Each entity type uses the eml-entity module elements as it's base set
            of elements, but then extends the base with entity-specific elements. Note that the
            eml-spatialReference module is not an entity type, but is rather a common set of
            elements used to describe spatial reference systems in both eml-spatialRaster and
            eml-spatialVector. It is described here in relation to those two modules. </para>
          <!-- Get the eml-dataTable module description from the xsd file -->
          <xsl:apply-templates select="document('eml-dataTable.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-spatialRaster module description from the xsd file -->
          <xsl:apply-templates select="document('eml-spatialRaster.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-spatialVector module description from the xsd file -->
          <xsl:apply-templates select="document('eml-spatialVector.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-spatialReference module description from the xsd file -->
          <xsl:apply-templates
            select="document('eml-spatialReference.xsd')//doc:moduleDescription/*" mode="copy"></xsl:apply-templates>
          <!-- Get the eml-storedProcedure module description from the xsd file -->
          <xsl:apply-templates select="document('eml-storedProcedure.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <!-- Get the eml-view module description from the xsd file -->
          <xsl:apply-templates select="document('eml-view.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
        </section>
        <section>
          <title> Utility modules - Metadata documentation enhancements </title>
          <para> The following modules are used to highlight the information being documented in
            each of the above modules where prose may be needed to convey the critical metadata. The
            eml-text module provides a number of text-based constructs to enhance a document
            (including sections, paragraphs, lists, subscript, superscript, emphasis, etc.) </para>
          <xsl:apply-templates select="document('eml-text.xsd')//doc:moduleDescription/*"
            mode="copy"></xsl:apply-templates>
          <section>
            <title>Dependency Chart</title>
            <para> The multiple modules in EML all depend on each other in complex ways. To easily
              see these dependencies see the <ulink url="eml-dependencies.html">EML Dependency
                Chart.</ulink>
            </para>
          </section>
        </section>
      </chapter>

      <chapter id="technicalArch">




        <section>

          <title>ID and Scope Examples</title>
          <section>
            <title>Example Documents</title>
            <example>
              <title>Invalid EML due to duplicate identifiers</title>

              <section>
                <para>This instance document is invalid because both creator elements have the same
                  id. No two elements can have the same string as an id.</para>
              </section>
            </example>
            <example>
              <title>Invalid EML due to a non-existent reference</title>

              <section>
                <para>This instance document is invalid because the contact element references an id
                  that does not exist. Any referenced id must exist.</para>
              </section>
            </example>
            <example>
              <title>Invalid EML due to a conflicting id attribute and a &lt;references&gt;
                element</title>


            </example>
            <example>
              <title>A valid EML document</title>


            </example>
          </section>
        </section>

      </chapter>

      <chapter id="moduleDescriptions">
        <title>Module Descriptions (Normative)</title>
        <xsl:for-each select="//doc:module">
          <xsl:variable name="moduleNameVar">
            <!-- save the name of the module we are in in this loop-->
            <xsl:value-of select="document(.)//doc:moduleName"></xsl:value-of>.xsd </xsl:variable>
          <xsl:variable name="importedByList">
            <!--this is the variable that will be sent to the template-->
            <xsl:for-each select="/xs:schema/xs:annotation/xs:appinfo/doc:moduleDocs/doc:module">
              <xsl:variable name="currentModuleName">
                <!--save the name of the module that we are in this loop-->
                <xsl:value-of select="."></xsl:value-of>
              </xsl:variable>
              <xsl:for-each select="document(.)//xs:import">
                <!-- go through each import statement and see if the current module is there -->
                <xsl:if test="normalize-space($moduleNameVar)=normalize-space(./@schemaLocation)">
                  <!-- if it is put it in the variable -->
                  <xsl:value-of
                    select="substring($currentModuleName, 0,
                                  string-length($currentModuleName) - 3)"></xsl:value-of>
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:variable>
          <xsl:apply-templates select="document(.)//doc:moduleDocs">
            <!--send the importedBy variable to this stylesheet-->
            <xsl:with-param name="importedBy" select="$importedByList"></xsl:with-param>
          </xsl:apply-templates>
        </xsl:for-each>
      </chapter>

      <index id="index">
        <title>Index</title>
        <indexdiv>
          <title>A</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:sort select="@name" data-type="text"></xsl:sort>
              <xsl:if test="starts-with(@name, 'a')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>B</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'b')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>C</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'c')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>D</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'd')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>E</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'e')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>F</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'f')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>G</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'g')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>H</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'h')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>I</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'i')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>J</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'j')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>k</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'k')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>L</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'l')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>M</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'm')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>

        </indexdiv>
        <indexdiv>
          <title>N</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'n')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>O</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'o')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>P</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'p')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>Q</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'q')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'r')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>S</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 's')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>T</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 't')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>U</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'u')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>V</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'v')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>W</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'w')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>X</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'x')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>Y</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'y')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </indexdiv>
        <indexdiv>
          <title>Z</title>
          <xsl:for-each select="//doc:module">
            <xsl:for-each select="document(.)//xs:element">
              <xsl:if test="starts-with(./@name, 'z')">
                <xsl:apply-templates select="." mode="indexentry"></xsl:apply-templates>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
          <indexentry>
            <primaryie></primaryie>
          </indexentry>
        </indexdiv>
      </index>
    </book>
  </xsl:template>

  <xsl:template match="*|@*|text()" mode="copy">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|text()" mode="copy"></xsl:apply-templates>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="doc:moduleDocs">
    <xsl:param name="importedBy"></xsl:param>
    <section>
      <xsl:attribute name="id">
        <xsl:value-of select="./doc:moduleName"></xsl:value-of>
      </xsl:attribute>
      <title>
        <xsl:value-of select="./doc:moduleName"></xsl:value-of>
      </title>
      <para>Normative technical docs for <ulink>
          <xsl:attribute name="url">./<xsl:value-of select="./doc:moduleName"></xsl:value-of>.html</xsl:attribute>
          <xsl:value-of select="./doc:moduleName"></xsl:value-of>
        </ulink>
      </para>

    </section>
  </xsl:template>

  <xsl:template match="xs:element" mode="indexentry">
    <indexentry>
      <primaryie>
        <ulink>
          <xsl:attribute name="url">./<xsl:value-of select="//doc:moduleName"
              ></xsl:value-of>.html#<xsl:value-of select="@name"></xsl:value-of></xsl:attribute>
          <xsl:value-of select="@name"></xsl:value-of>
        </ulink>-<xsl:value-of select="//doc:moduleName"></xsl:value-of>
      </primaryie>
    </indexentry>
  </xsl:template>
</xsl:stylesheet>
