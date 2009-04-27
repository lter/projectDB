<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" media-type="text/xml"/>    
    
     <xsl:template name="main">
         <xsl:param name="css"/>
         <xsl:param name="navLabel"/>
         <html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <link rel="icon" type="image/x-icon" href="http://gce-lter.marsci.uga.edu/favicon.ico"/>
                <link rel="shortcut icon" type="image/x-icon" href="http://gce-lter.marsci.uga.edu/favicon.ico"/>
                <link rel="stylesheet" media="all" type="text/css" href="http://gce-lter.marsci.uga.edu/public/css/gce_main.css"/>
                <link rel="stylesheet" media="all" type="text/css" href="http://gce-lter.marsci.uga.edu/public/css/gce_topnav.css"/>
                <link rel="stylesheet" media="all" type="text/css" href="http://gce-lter.marsci.uga.edu/public/css/menu_buttons.css"/>
                <xsl:element name="link">
                    <xsl:attribute name="rel">stylesheet</xsl:attribute>
                    <xsl:attribute name="type">text/css</xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="$css"/>
                    </xsl:attribute>
                </xsl:element>
                <script type="text/javascript" src="/exist/rest/db/projects/util/web/js/gce/ajaxUtils.js"/>
                <script type="text/javascript" src="/exist/rest/db/projects/util/web/js/gce/ajaxLoadLeftNav.js"/>
                <title>Georgia Coastal Ecosystems LTER</title>
            </head>
            <body><div id="top-border">&#160;</div>
                <table id="pageframe">
                    <tr><td colspan="2" id="heading">
                            <div id="banner-image">
                                <a href="http://gce-lter.marsci.uga.edu/" title="Georgia Coastal Ecosystems LTER">
                                    <img src="http://gce-lter.marsci.uga.edu/public/images/main_logo_vert1.jpg" alt="Georgia Coastal Ecosystems LTER" width="800" height="95" border="0"/>
                                </a>
                            </div>
                            <div id="top-navbar">
                                <a href="http://gce-lter.marsci.uga.edu/">Home</a> &gt; <a href="http://gce-lter.marsci.uga.edu/public/research/research.htm">Research</a> &gt; 
                                <a href="http://amble.lternet.edu:8080/exist/rest/db/projects/util/xquery/getProjectsQueryForm.xql?siteId=gce&amp;xslUrl=http://amble.lternet.edu:8080/exist/rest/db/projects/util/xslt/gceQueryForm.xsl">Research Project Search</a>
                                <xsl:if test="string-length($navLabel)&gt;0"><xsl:text> &gt; </xsl:text><span class="current-page"><xsl:value-of select="$navLabel"/></span></xsl:if>
                            </div>
                        </td>
                    </tr>
                    <tr><td id="leftnavbar">
                            <noscript><p class="note">(JavaScript required<br/>for navigation menus)</p>
                            </noscript>
                        </td>
                        <td id="content">
                            <xsl:call-template name="projects_query"/>
                        </td>
                    </tr>
                    <tr><td id="footer-left">
                            <em>18-Feb-2008</em>
                        </td>
                        <td id="footer-right">
                            <div class="browser">(<a href="http://www.mozilla.com/">FireFox</a> 2+, <a href="http://www.microsoft.com/windows/products/winfamily/ie/">Internet Explorer</a> 6+ or <a href="http://www.apple.com/safari/download/">Safari</a> 2+ recommended for viewing this page)</div>
                            <a href="mailto:gcelter@uga.edu">Contact Us</a>
                        </td>
                    </tr>
                </table>
                <div id="disclaimer">
                    <div class="left-image">
                        <a href="http://www.lternet.edu/" title="LTER Network" target="_blank">
                            <img src="http://gce-lter.marsci.uga.edu/public/images/lterlogo_small.gif" alt="LTER" width="51" height="60" border="0"/>
                        </a>
                    </div>
                    <div class="right-image">
                        <a href="http://www.nsf.gov/" title="NSF" target="_blank">
                            <img src="http://gce-lter.marsci.uga.edu/public/images/nsfe2.gif" alt="NSF" width="64" height="65" border="0"/>
                        </a>
                    </div>
                    <p>This material is based upon work supported by the <a href="http://www.nsf.gov/" target="_blank">National Science
                            Foundation</a> under grant numbers <a href="http://www.nsf.gov/awardsearch/showAward.do?AwardNumber=9982133" target="_blank">OCE-9982133</a> and <a href="http://www.nsf.gov/awardsearch/showAward.do?AwardNumber=0620959" target="_blank">OCE-0620959</a>. Any opinions, findings, conclusions, or recommendations expressed in the
                        material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation.</p>
                    <div class="clear-float"/>
                </div>
            </body>
        </html>
      </xsl:template>
  
</xsl:stylesheet>