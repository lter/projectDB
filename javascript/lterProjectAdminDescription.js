//Javascript functions called by lterProjectDescription.xsl on page load and to handle tab selection events
//
//authors: Wade Sheldon <wsheldon@lternet.edu>, Corinna Gries <cgries@lternet.edu>
//version 1.1, 02-May-2009

window.onload = init;  // run init function after page load 

function init() {
    // initializes page by displaying summary tab
    showSection('project_summary');
}

function showAll() {
    // toggles display of all sections at once

    // init array of all section ids
    var allIds = new Array('project_summary', 'project_personnel', 'project_permits', 'project_reports', 'project_material');
    
    // loop through ids, toggling display on and setting corresponding tab to default style
    for (i = 0; i < allIds.length; i++) {

        // set all rows to display
        var el = document.getElementById(allIds[i]);
        try {
            el.style.display = 'table-row';
        }
        catch(err) {
            el.style.setAttribute('display','block');  //IE syntax
        }

        // set all tab classes to default
        var tabId = allIds[i] + '_tab'; 
        var tab = document.getElementById(tabId);
        try {
            tab.className = 'defaultTab';
         }
         catch(err) {
             tab.setAttribute('class','defaultTab');  //IE
         }
    }
        
    // toggle show all tab class to currentTab
    var tab_current = document.getElementById('project_showall_tab');
    try {
        tab_current.className = 'currentTab';
    }
    catch(err) {
        tab_current.setAttribute('class','currentTab');  //IE
    }
}

function showSection(strId) {
    // toggles table row display and table heading classes to manage tabbed display
        
    // init array of all section ids
    var allIds = new Array('project_summary', 'project_personnel', 'project_permits', 'project_reports', 'project_material');
    
    // loop through ids, toggling display off and setting corresponding tab to default style
    for (i = 0; i < allIds.length; i++) {
    
        var el = document.getElementById(allIds[i]);
        try {
            el.style.display = 'none';
        }
        catch(err) {
            el.style.setAttribute('display','none');  //IE syntax
        }
        
        var tabId = allIds[i] + '_tab'; 
        var tab = document.getElementById(tabId);
        try {
            tab.className = 'defaultTab';
         }
         catch(err) {
             tab.setAttribute('class','defaultTab');  //IE
         }
        
    }
    
    // toggle show all tab class to default
     var tab_all = document.getElementById('project_showall_tab');
        try {
            tab_all.className = 'defaultTab';
        }
        catch(err) {
            tab_all.setAttribute('class','defaultTab');  //IE
        }

    // get handle for new selection, toggle display option to show
    var el_current = document.getElementById(strId);
    
    try {
        el_current.style.display = 'table-row';
     }
     catch(err) {
        el_current.style.setAttribute('display','block');  //IE
     }
    
    // set corresponding tab to currentTab style
    var tabId_current = strId + '_tab';
    var tab_current = document.getElementById(tabId_current);
    try {
        tab_current.className = 'currentTab';
    }
    catch(err) {
        tab_current.setAttribute('class','currentTab');  //IE
    }
    
}
