// call id check function, run ajaxInit after 'announcements' div rendered in DOM

// set up handler to assign flag after page fully loaded based on window.onload event
var pageLoaded = 0;
window.onload = function() {pageLoaded = 1;}

function loaded(id,fcn) {
// define function to determine if element with specified id exists in the DOM
	if (document.getElementById && document.getElementById(id) != null) fcn();  //id exists so call specified function
	else if (!pageLoaded) setTimeout('loaded(\''+id+'\','+fcn+')',20);  //call loaded again after 0.02s delay unless page fully loaded
}

loaded('disclaimer',ajaxInit);

function ajaxInit() {
// page initialization function
	var response = ajaxRead(insertNavBar,'/exist/rest/db/projects/util/web/js/gce/leftnav_insert.txt','text');
	
	init();  //call other page init functions in other page scripts
}

function insertNavBar(str) {
// insert navbar from library into leftnav div
	document.getElementById('leftnavbar').innerHTML = str;
}