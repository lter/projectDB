#!/bin/bash

#get the basic info and build a docbook
xsltproc buildProjectDocBook.xsl eml-project.xsd > unsorted-docbook.xml

#sort it
xsltproc sortDocBook.xsl unsorted-docbook.xml > sorted-docbook.xml

# create the index.html
xsltproc style/docbook-xsl-1.50.0/html/docbook.xsl sorted-docbook.xml > docs/index.html

# create the individual schema files.
# only project.xsd should be different than 2.1
xsltproc eml-documentation.xsl eml-project.xsd > docs/eml-project.html
xsltproc eml-documentation.xsl eml-access.xsd > docs/eml-access.html
xsltproc eml-documentation.xsl eml-coverage.xsd > docs/eml-coverage.html
xsltproc eml-documentation.xsl eml-literature.xsd > docs/eml-literature.html
xsltproc eml-documentation.xsl eml-party.xsd > docs/eml-party.html
xsltproc eml-documentation.xsl eml-physical.xsd > docs/eml-physical.html
xsltproc eml-documentation.xsl eml-resource.xsd > docs/eml-resource.html
xsltproc eml-documentation.xsl eml-text.xsd > docs/eml-text.html

# copy the images so they are the latest
cp ~mob/EML_nextRelease/eml/docs/eml-2.1.0/eml-access.png docs/
cp ~mob/EML_nextRelease/eml/docs/eml-2.1.0/eml-coverage.png docs/
cp ~mob/EML_nextRelease/eml/docs/eml-2.1.0/eml-literature.png docs/
cp ~mob/EML_nextRelease/eml/docs/eml-2.1.0/eml-party.png docs/
cp ~mob/EML_nextRelease/eml/docs/eml-2.1.0/eml-physical.png docs/
cp ~mob/EML_nextRelease/eml/docs/eml-2.1.0/eml-resource.png docs/
cp ~mob/EML_nextRelease/eml/docs/eml-2.1.0/eml-text.png docs/

