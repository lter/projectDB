<?xml version="1.0" encoding="utf-8"?>

<p:config 
  xmlns:p="http://www.orbeon.com/oxf/pipeline"
  xmlns:oxf="http://www.orbeon.com/oxf/processors">

    <p:param type="input" name="instance"/>
    <p:param type="output" name="data"/>

    <p:processor name="oxf:xslt">
      <p:input name="data" href="#instance"/>
      <p:input name="config">
        <text xsl:version="2.0">
          <xsl:variable name="text" as="xs:string" select="replace(/*, 'strong', 'emphasis')"/>
        </text>
      </p:input>
      <p:output name="data" id="paratoeml"/>
    </p:processor>

</p:config>


