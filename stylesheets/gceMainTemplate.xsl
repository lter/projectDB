<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" media-type="text/xml"/>    
    
     <xsl:template name="main">
         <xsl:param name="css"/>
         <xsl:param name="javascript"/>
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
                <xsl:if test="$javascript != ''">
                    <xsl:element name="script">
                        <xsl:attribute name="type">text/javascript</xsl:attribute>
                        <xsl:attribute name="src">
                            <xsl:value-of select="$javascript"/>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:if>
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
                                <a href="http://amble.lternet.edu:8080/exist/rest/db/projects/util/xquery/getProjects.xql?siteId=gce&amp;_xsl=http://amble.lternet.edu:8080/exist/rest/db/projects/util/xslt/gceProjectsListText.xsl">Projects</a> &gt;
                                <a href="http://amble.lternet.edu:8080/exist/rest/db/projects/util/xquery/getProjectsQueryForm.xql?siteId=gce&amp;xslUrl=http://amble.lternet.edu:8080/exist/rest/db/projects/util/xslt/gceQueryForm.xsl">Search Project</a>
                                <xsl:if test="string-length($navLabel)&gt;0">
                                    <xsl:text> &gt; </xsl:text>
                                    <span class="current-page">
                                        <xsl:value-of select="$navLabel"/>
                                    </span>
                                </xsl:if>
                            </div>
                        </td>
                    </tr>
                    <tr><td id="leftnavbar">
<div class="menu">
<ul><li><a href="/">Home</a>
                                    </li>
<li><a href="http://gce-lter.marsci.uga.edu/public/app/news.asp">GCE News »<!--[if IE 7]><!--></a><!--<![endif]-->
<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul><li><a href="http://gce-lter.marsci.uga.edu/public/app/news.asp">News &amp; Events</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/calendar.asp">GCE Calendar »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="http://gce-lter.marsci.uga.edu/public/app/calendar.asp">Calendar</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/app/calendar_browse.asp">Search Events</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/announcements.asp">Announcements</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/conditions.asp">Site Conditions</a>
                                            </li>
	<li><a href="http://www.lternet.edu/news/">LTER Network</a>
                                            </li>
	</ul>
<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
<li><a href="http://gce-lter.marsci.uga.edu/public/app/biblio_query.asp">Bibliography »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul><li><a href="http://gce-lter.marsci.uga.edu/public/app/biblio_query.asp">Search/Custom</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/biblio_results.asp?Library=GCE&amp;Reprints=yes&amp;URLs=yes">GCE Publications</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/biblio_results.asp?Library=UGAMI&amp;Reprints=yes&amp;URLs=yes">UGAMI Publications</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/biblio_results.asp?Library=GARLMER&amp;Reprints=yes&amp;URLs=yes">LMER Publications</a>
                                            </li>
	<li><a href="http://search.lternet.edu/biblio/">LTER Network</a>
                                            </li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
<li><a href="http://gce-lter.marsci.uga.edu/public/data/data.htm">Data Products »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul><li><a href="http://gce-lter.marsci.uga.edu/public/data/data.htm">GCE Data</a> </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/data_catalog.asp">Data Catalog</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/portal/monitoring.htm">Data Portal</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=gisvectordata">GIS Vector Data</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=gisrasterdata">GIS Raster Data</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/realtime_data.asp">Near-real-time</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/im/data_submission.htm">Data Submission »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="http://gce-lter.marsci.uga.edu/public/im/data_submission.htm">Submission Info</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/app/resource_details.asp?id=101">Submission Form</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="http://metacat.lternet.edu/knb/">LTER Network »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="http://metacat.lternet.edu/knb/">LTER Data Catalog</a>
                                                    </li>
		<li><a href="http://www.fsl.orst.edu/climhy/">LTER Climate Data</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
<li><a href="http://gce-lter.marsci.uga.edu/public/app/personnel.asp">Personnel »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul><li><a href="http://gce-lter.marsci.uga.edu/public/app/personnel.asp?display=all">GCE Personnel</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/personnel.asp?display=committees">GCE Committees</a>
                                            </li>
	<li><a href="http://search.lternet.edu/dir.php">LTER Network</a>
                                            </li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
<li><a href="http://gce-lter.marsci.uga.edu/public/research/research.htm">Research »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul><li><a href="http://gce-lter.marsci.uga.edu/public/research/research.htm">GCE Research</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/all_species_lists.asp">Species Lists</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/research/mon/monitoring.htm">Projects »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="http://gce-lter.marsci.uga.edu/public/research/mon/monitoring.htm">All Projects</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/research/mon/climate.htm">Climate Monitoring</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/research/mon/sounds_creeks.htm">Salinity Monitoring</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/research/mon/marsh_set.htm">Sediment Dynamics</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/site/monitoring_map.htm">Monitoring Map</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="http://www.lternet.edu/coreareas/coreintro.html">LTER Network »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="http://www.lternet.edu/coreareas/coreintro.html">LTER Core Areas</a>
                                                    </li>
		<li><a href="http://www.lternet.edu/technology/ltergis/">Remote Sensing</a>
                                                    </li>
		<li><a href="http://www.lternet.edu/microbial_ecology/">Microbial Ecology</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
<li><a href="http://gce-lter.marsci.uga.edu/public/site/site_info.htm">Study Site »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul><li><a href="http://gce-lter.marsci.uga.edu/public/site/site_info.htm">GCE Study Site</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/site/studyarea.htm">Study Area Map</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/site/logistics.htm">Visiting Sapelo</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/site/tides.htm">Tide Tables</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/studysites.asp">Sampling Sites »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="http://gce-lter.marsci.uga.edu/public/app/studysites.asp">Sampling Sites</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/app/transects.asp">Survey Transects</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/app/geo_query.asp">Location Database</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/site/monitoring_map.htm">Monitoring Map</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="http://www.lternet.edu/sites/">LTER Network »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="http://www.lternet.edu/sites/">Site Profiles</a>
                                                    </li>
		<li><a href="http://www.lternet.edu/sites/site_coordinates.php">Site Coordinates</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
<li><a href="http://gce-lter.marsci.uga.edu/public/gis/Introduction.htm">GIS Resources »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul><li><a href="http://gce-lter.marsci.uga.edu/public/gis/Introduction.htm">Overview</a> </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/gis/Data_Resources.html">GIS Data Types</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/gis/KML.html">KML Information</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/gis/Links.html">GIS Links</a>
                                            </li>
    <li><a href="http://www.lternet.edu/technology/ltergis/">LTER Network</a>
                                            </li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
<li><a href="http://gce-lter.marsci.uga.edu/public/app/resource_search.asp?type=documents">Documents »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul><li><a href="http://gce-lter.marsci.uga.edu/public/app/resource_search.asp?type=document">Search/Browse All</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=document&amp;category=reports">Reports</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=document&amp;category=proposals">Proposals</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=document&amp;category=publications">Publications</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=document&amp;category=presentations">Presentations</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=document&amp;category=informatics">Informatics</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=document&amp;category=governance">Governance</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=document&amp;category=procedures">Procedures</a>
                                            </li>
	<li><a href="http://intranet.lternet.edu/modules.php?op=modload&amp;name=UpDownload&amp;file=index">LTER Network</a>
                                            </li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
<li><a href="http://gce-lter.marsci.uga.edu/public/app/resource_search.asp?type=imagery">Maps &amp; Imagery »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul><li><a href="http://gce-lter.marsci.uga.edu/public/app/resource_search.asp?type=image">Search/Browse All</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=image&amp;category=sitemaps">Site Maps</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=image&amp;category=sitephotos">Site Photos</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=image&amp;category=speciesphotos">Organism Photos</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=image&amp;category=logos">Logos</a>
                                            </li>
	<li><a href="http://savanna.lternet.edu/gallery/">LTER Network</a>
                                            </li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
<li><a href="http://gce-lter.marsci.uga.edu/public/outreach.htm">Outreach &amp; Ed »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul><li><a href="http://gce-lter.marsci.uga.edu/public/outreach.htm">GCE Outreach »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="http://gce-lter.marsci.uga.edu/public/outreach.htm">Overview</a>
                                                    </li>
		<li><a href="http://www.gcrc.uga.edu">GCRC Web Site</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/education/education.htm">GCE Education »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="http://gce-lter.marsci.uga.edu/public/education/education.htm">Education News</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/education/uga_classes.htm">UGA Classes</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/app/biblio_results.asp?Library=GCE&amp;KeyWord=education&amp;KeyWordMatch=exact&amp;URLs=yes">Publications</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="http://www.lternet.edu/education/">LTER Network »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="http://www.lternet.edu/education/">Opportunities</a>
                                                    </li>
		<li><a href="http://schoolyard.lternet.edu/">Schoolyard LTER</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
<li><a href="http://gce-lter.marsci.uga.edu/public/im/gce_is.htm">Informatics »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul><li><a href="http://gce-lter.marsci.uga.edu/public/im/gce_is.htm">IM Overview</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resource_details.asp?id=101">Data Submission</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/data/eml_metadata.htm">EML Metadata</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/app/resources.asp?type=document&amp;category=informatics&amp;theme=Database%20schemas">Databases</a>
                                            </li>
	<li><a href="http://gce-lter.marsci.uga.edu/public/im/tools/it_development.htm">Software »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="http://gce-lter.marsci.uga.edu/public/im/tools/it_development.htm">IT Development</a> </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/im/tools/data_toolbox.htm">GCE Data Toolbox</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/im/tools/usgs_harvester.htm">Data Harvesting</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="http://www.lternet.edu/informatics/">LTER Network »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="http://www.lternet.edu/informatics/">LTER Informatics</a> </li>
		<li><a href="http://www.ecoinformatics.org/">Ecoinformatics</a>
                                                    </li>
		<li><a href="http://www.lternet.edu/databits/">DataBits Newsletter</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
<li><a href="http://gce-lter.marsci.uga.edu/public/affiliates.htm">Affiliates »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul><li><a href="http://gce-lter.marsci.uga.edu/public/affiliates.htm">GCE Affiliates</a>
                                            </li>
	<li><a href="http://www.lternet.edu/">LTER Web Site</a>
                                            </li>
	<li><a href="http://www.uga.edu/ugami/">UGAMI Web Site</a>
                                            </li>
	<li><a href="http://www.sapelonerr.org/">SINERR Web Site</a>
                                            </li>
	<li><a href="http://www.gcrc.uga.edu/">GCRC Web Site</a>
                                            </li>
	<li><a href="http://simo.marsci.uga.edu/">SIMO Web Site</a>
                                            </li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
<li><a href="http://gce-lter.marsci.uga.edu/public/private.htm">Private Site »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
	<ul><li><a href="http://gce-lter.marsci.uga.edu/public/private.htm">Private Site Info</a>
                                            </li>
	<li><a href="https://gce-lter.marsci.uga.edu/private/app/project_data.asp">Provisional Data</a>
                                            </li>
	<li><a href="https://gce-lter.marsci.uga.edu/private/app/gce_archives.asp">Project Archives »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="https://gce-lter.marsci.uga.edu/private/app/gce_archives.asp">Archive Info</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/resource_search.asp">File Archive</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/cruise_files.asp">Cruise Logs</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/meetings.asp">Annual Meetings</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/gce_reprints.asp">Reprint Library</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="https://gce-lter.marsci.uga.edu/private/app/resource_search.asp">Governance »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="https://gce-lter.marsci.uga.edu/private/app/referenda.asp">GCE Referenda</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/app/resource_details.asp?id=94">GCE Bylaws</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/app/personnel.asp?display=committees">Exec Committee</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="https://gce-lter.marsci.uga.edu/private/app/upload_file.asp">Upload File(s) »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="https://gce-lter.marsci.uga.edu/private/app/upload_file.asp?category=data">Study Data</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/upload_gis.asp">GPS Data</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/upload_file.asp?category=reprints">Reprint File</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/upload_species_files.asp">Species List File</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/upload_file.asp">Other File(s)</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="https://gce-lter.marsci.uga.edu/private/app/add_resource.asp">Archive File »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="https://gce-lter.marsci.uga.edu/private/app/add_resource.asp?type=doc">Document</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/add_resource.asp?type=gisvectordata&amp;category=gisdata">GIS Vector Data</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/add_resource.asp?type=map&amp;category=sitemaps">Map Image</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/upload_species_files.asp">Organism Photo</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/add_resource.asp?type=photo&amp;category=sitephotos">Site Photo</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/add_resource.asp">Other File</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="https://gce-lter.marsci.uga.edu/private/app/bibliography.asp">Update Biblio »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="https://gce-lter.marsci.uga.edu/private/app/add_citation.asp">Add Citation</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/update_citation.asp">Update Citation</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/upload_file.asp?category=reprints">Upload Reprint</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="https://gce-lter.marsci.uga.edu/private/app/announcements.asp">Update News »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="https://gce-lter.marsci.uga.edu/private/app/announcements.asp">View News Items</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/add_announce.asp">Add News Item</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/announcements.asp">Update News Item</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="https://gce-lter.marsci.uga.edu/private/app/calendar.asp">Update Calendar »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="https://gce-lter.marsci.uga.edu/private/app/calendar.asp">View Calendar</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/calendar_add.asp">Add Event</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/calendar_browse.asp?Mode=edit">Update Event</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	<li><a href="https://gce-lter.marsci.uga.edu/private/app/accountinfo.asp">Update User Info »<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul><li><a href="https://gce-lter.marsci.uga.edu/private/app/password.asp">Change Password</a>
                                                    </li>
		<li><a href="http://gce-lter.marsci.uga.edu/public/request_login.htm">Email Password</a>
                                                    </li>
		<li><a href="https://gce-lter.marsci.uga.edu/private/app/update_bio.asp">Update Bio Page</a>
                                                    </li>
		</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</li>
	</ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
</li>
</ul>
</div>

<div id="google-search-left">
<form action="http://gce-lter.marsci.uga.edu/public/search.htm" id="searchbox_014432048925071680651:vwuni1yg6dk">
  <input type="hidden" name="cx" value="014432048925071680651:vwuni1yg6dk"/>
  <input type="hidden" name="cof" value="FORID:11"/>
  <input type="text" name="q" size="18"/>
  <input type="submit" name="sa" value="Search"/>
</form>
</div>
                        </td>
                        <td id="content">
                            <xsl:call-template name="projects_query"/>
                        </td>
                    </tr>
                    <tr><td id="footer-left">
                            <em>18-Feb-2008</em>
                        </td>
                        <td id="footer-right">                            
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