function showSection(strId) {
    // toggles table row display and table heading classes to manage tabbed display
    //
    //author: Wade Sheldon <wsheldon@lternet.edu>
    //version 1.0, 01-May-2009
        
    // init array of all section ids
    var allIds = new Array('project_summary', 'project_personnel', 'project_studyArea', 'project_reports', 'project_material');
    
    // loop through ids, toggling display off and setting corresponding tab to default style
    for (i = 0; i < allIds.length; i++) {
    
        var el = document.getElementById(allIds[i]);
        try {
            el.style.display = 'none';
        }
        catch(err) {
            el.style.setAttribute('display','block');  //IE syntax
        }
        
        var tabId = allIds[i] + '_tab'; 
        var tab = document.getElementById(tabId);
        try {
            tab.className = '';
         }
         catch(err) {
             tab.setAttribute('class','');  //IE
         }
        
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
