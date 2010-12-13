<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template name="main">
    <xsl:param name="css"/>
	<xsl:param name="javascript"/>
	<xsl:param name="navLabel"/>
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
            <link rel="icon" type="image/x-icon" href="http://gce-lter.marsci.uga.edu/favicon.ico" />
            <link rel="shortcut icon" type="image/x-icon" href="http://gce-lter.marsci.uga.edu/favicon.ico" />
            <link rel="stylesheet" media="all" type="text/css" href="http://gce-lter.marsci.uga.edu/public/css/gce_main.css" />
            <link rel="stylesheet" media="all" type="text/css" href="http://gce-lter.marsci.uga.edu/public/css/gce_topnav.css" />
            <link rel="stylesheet" media="all" type="text/css" href="http://gce-lter.marsci.uga.edu/public/css/menu_buttons.css" />
            <xsl:element name="link">
            <xsl:attribute name="rel">stylesheet</xsl:attribute>
            <xsl:attribute name="type">text/css</xsl:attribute>
            <xsl:attribute name="href">
                <xsl:value-of select="$css"/>
            </xsl:attribute>
            </xsl:element>
            <script type="text/javascript" src="http://gce-lter.marsci.uga.edu/public/js/ajaxUtils.js"></script>
            <script type="text/javascript" src="http://gce-lter.marsci.uga.edu/public/js/ajaxLoadLeftNav.js"></script>
            <script type="text/javascript" src="http://gce-lter.marsci.uga.edu/public/js/gceProjectDescription.js"></script>
            <title>Georgia Coastal Ecosystems LTER</title>
        </head>
        <body>
            <div id="top-border">&#160;</div>
            <table id="pageframe">
                <tr>
                    <td colspan="2" id="heading">
                        <div id="banner-image"><a href="http://gce-lter.marsci.uga.edu/" title="Georgia Coastal Ecosystems LTER">
                            <img src="http://gce-lter.marsci.uga.edu/public/images/main_logo_vert1.jpg" alt="Georgia Coastal Ecosystems LTER" width="800" height="95" border="0" /></a>
                        </div>
                        <div id="top-navbar">
		<a href="http://gce-lter.marsci.uga.edu/">Home</a> &gt;
		<a href="http://gce-lter.marsci.uga.edu/public/research/research.htm">Research</a> &gt;
		<a href="http://gce-lter.marsci.uga.edu/public/research/projects.asp">Projects</a>
		<xsl:if test="string-length($navLabel)&gt;0">
			<xsl:text> &gt; </xsl:text>
			<span class="current-subpage">
				<xsl:value-of select="$navLabel"/>
			</span>
		</xsl:if>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td id="leftnavbar">
                        <div class="menu">
		<ul>
		<li><a href="http://gce-lter.marsci.uga.edu/">Home</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/app/news.asp">GCE News &#187;</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/research/research.htm">Research &#187;</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/site/site_info.htm">Study Site &#187;</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/site/logistics.htm">Field Planning &#187;</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/app/biblio_query.asp">Bibliography &#187;</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/data/data.htm">Data Products &#187;</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/gis/Introduction.htm">GIS Resources &#187;</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/app/resource_search.asp?type=imagery">Maps &amp; Imagery &#187;</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/app/resource_search.asp?type=documents">Documents &#187;</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/education/outreach.htm">Outreach &amp; Ed &#187;</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/im/gce_is.htm">Informatics &#187;</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/app/personnel.asp">Personnel &#187;</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/affiliates.htm">Affiliates &#187;</a></li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/private.htm">Private Site &#187;</a></li>
		</ul>
	           </div>
                        <div id="google-search-left">
                            <form action="http://gce-lter.marsci.uga.edu/public/search.htm" id="searchbox_014432048925071680651:vwuni1yg6dk">
                              <input type="hidden" name="cx" value="014432048925071680651:vwuni1yg6dk" />
                              <input type="hidden" name="cof" value="FORID:11" />
                              <input type="text" name="q" size="18" />
                              <input type="submit" name="sa" value="Search" />
                            </form>
                        </div>
                    </td>
                    <td id="content">
                        <xsl:if test="/error/errorMessage != ''">
                            <h1>Invalid Project</h1>
                            <p style="text-align:center;padding:1em 72px;"><xsl:value-of select="/error/errorMessage"/></p>
                        </xsl:if>
                        <xsl:call-template name="projects_query"></xsl:call-template>
                    </td>
                </tr>
                <tr>
                    <td id="footer-left"><em>18-Feb-2008</em></td>
                    <td id="footer-right">
                       <div class="browser">(<a href="http://www.mozilla.com/">FireFox</a> 2+,
                          <a href="http://www.microsoft.com/windows/products/winfamily/ie/">Internet Explorer</a> 6+ or
                          <a href="http://www.apple.com/safari/download/">Safari</a> 2+ recommended for viewing this page)</div>
                       <a href="mailto:gcelter@uga.edu">Contact Us</a>
                    </td>
                </tr>
            </table>
            <div id="disclaimer">
                <div class="left-image"><a href="http://www.lternet.edu/" title="LTER Network" target="_blank">
                    <img src="http://gce-lter.marsci.uga.edu/public/images/lterlogo_small.gif" alt="LTER" width="51" height="60" border="0" /></a>
                </div>
                <div class="right-image"><a href="http://www.nsf.gov/" title="NSF" target="_blank">
                    <img src="http://gce-lter.marsci.uga.edu/public/images/nsfe2.gif" alt="NSF" width="64" height="65" border="0" /></a>
                </div>
                <p>This material is based upon work supported by the <a href="http://www.nsf.gov/" target="_blank">National Science Foundation</a> under
                    grant numbers <a href="http://www.nsf.gov/awardsearch/showAward.do?AwardNumber=9982133" target="_blank">OCE-9982133</a> and
                    <a href="http://www.nsf.gov/awardsearch/showAward.do?AwardNumber=0620959" target="_blank">OCE-0620959</a>.
                    Any opinions, findings, conclusions, or recommendations expressed in the material are those of the author(s) and do not necessarily reflect the
                    views of the National Science Foundation.</p>
                <div class="clear-float"></div>
            </div>
        </body>
    </html>
</xsl:template>
</xsl:stylesheet>
