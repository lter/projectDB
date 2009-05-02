function showSection(strId) {
    // toggle table row displays and table heading classes for tabbed display
    
    var allIds = new Array('project_summary', 'project_personnel', 'project_permits', 'project_reports', 'project_material');
    
    for (i = 0; i < allIds.length; i++) {
    
        var el = document.getElementById(allIds[i]);
        try {
            el.style.display = 'none';
        }
        catch(err) {
            el.style.setAttribute('display','block');  //IE
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
    
    var el_current = document.getElementById(strId);
    
    try {
        el_current.style.display = 'table-row';
     }
     catch(err) {
        el_current.style.setAttribute('display','block');  //IE
     }
    
    var tabId_current = strId + '_tab';
    var tab_current = document.getElementById(tabId_current);
    try {
        tab_current.className = 'currentTab';
    }
    catch(err) {
        tab_current.setAttribute('class','currentTab');  //IE
    }
}
