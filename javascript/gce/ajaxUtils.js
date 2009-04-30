//General utility functions for Ajax routines
//
//Wade Sheldon (email: sheldon@uga.edu)
//Georgia Coastal Ecosystems LTER (www: http://gce-lter.marsci.uga.edu)
//
//last modified: 06-Feb-2009

function ajaxRead(fcn,url,datatype) {
// retrieves and parses an xml or text document and calls the indicated function
//   fcn = Javascript function to call (string)
//   url = url for http get request (string)
//   datatype = data type to return (string: "xml" or "text")

	// instantiate xml http request object trying various browser variations
	var xmlObj = null;	
	var e;
	try	{
		// Firefox, Opera 8.0+, Safari, IE 7+
		xmlObj = new XMLHttpRequest();
	}
	catch (e) {
		// Internet Explorer 6+
		try {
		  xmlObj = new ActiveXObject("Msxml2.XMLHTTP.3.0");
		}
		catch (e) {
			// Internet Explorer 5+
			try {
				xmlObj = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch (e) {
				return false;
			}
		}
	}
  
  	// set handler for XMLHttpRequest object state change, calling user-specified function 
	// when request complete, passing returned XML/text as single argument
	xmlObj.onreadystatechange = function() {
		if(xmlObj.readyState == 4) {
			try {
				if(datatype == "xml") {
					fcn(xmlObj.responseXML);
				}
				else {
					fcn(xmlObj.responseText);
				}
			}
			catch (e) {
				return false;
			}
		}
	}
	
	// open url using HTTP GET method
	xmlObj.open ("GET", url, true);
	xmlObj.send ("");

}
