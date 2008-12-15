function addNameToList(id_input,id_list) {
// inserts a new author entry into the specified list alphabetically
// (note: depends on functions in 'list_utils.js')

	//get element handles
	var elSource = document.getElementById(id_input);
	var elTarget = document.getElementById(id_list);
	
	//get info from elements
	var strName = elSource.value;
	var len = elTarget.length;
	
	if (strName.length > 0) {
	
		// replace comma delimiter with semi-colons
		var strValue = strName.replace(/, /g,',');
		strValue = strValue.replace(/,/g,';');
		
		// get alphabetical insert position of new name
		var pos = getSortedListInsertPosition(id_list,strName);
		
		// insert or append name to list
		if (pos < len) {
			insertOptionBefore(id_list,pos,strValue,strName);
		}
		else {
			appendOptionLast(id_list,strValue,strName);
		}
		
		//clear name after adding
		elSource.value = '';
	
	}
	
}

function appendNameToList(id_input,id_list) {
// appends a name entry to the specified list
// (note: depends on functions in 'list_utils.js')

	//get element handles
	var elSource = document.getElementById(id_input);
	var elTarget = document.getElementById(id_list);
	
	//get info from elements
	var strName = elSource.value;
	var len = elTarget.length;
	
	if (strName.length > 0) {
	
		// replace comma delimiter with semi-colons
		var strValue = strName.replace(/, /g,',');
		strValue = strValue.replace(/,/g,';');
		
		appendOptionLast(id_list,strValue,strName);
		
		//clear name after adding
		elSource.value = '';
	
	}
	
}

function switchRefType(id_list) {
// retrieves list of field names for selected reftype and calls function to toggle form field labels, visibility

	var elRefType = document.getElementById(id_list);
	var sel = elRefType.selectedIndex;
	var RefType = elRefType.options[sel].value;

     //note: static xml files generated from dynamic GCE web application are used here
     //to work around Ajax cross-site scripting security restrictions
	var url = 'webformfields_by_reftype_' + RefType.replace(' ','_') + '.xml';
	
	var err;
	try {
         ajaxRead(toggleFormFields,url,'xml');
	}
	catch (err) {
		alert('Sorry - an error occurred updating the form fields for the selected reference type');
	}
}

function toggleFormFields(obj) {
// toggles form row visibility and labels using info in a xml file

	var err
	
	try {

		// get root element node
		var root = obj.getElementsByTagName('Root')[0];
		
		// look up RefType
		var node = root.getElementsByTagName('RefType')[0];
		var RefType = node.firstChild.nodeValue;

		// loop through text fields nodes getting field names, labels, display options
		var textfields = root.getElementsByTagName('TextFields')[0];
		var fields = textfields.getElementsByTagName('Field');
		var numFields = fields.length;

		// init loop vars
		var label;
		var display;
		var elRow;
		var label_id;
		
		for (var i=0; i<numFields; i++){
			
			//get next node
			node = fields[i];
			
			// look up FieldName, Label, Display
			el = node.getElementsByTagName('FieldName')[0];
			rowId = el.firstChild.nodeValue;
			
			el = node.getElementsByTagName('Label')[0];
			label = el.firstChild.nodeValue;
			el = node.getElementsByTagName('Display')[0];
			display = el.firstChild.nodeValue;

			//update field label
			label_id = rowId + '_Label';
			label = label + ':';
			document.getElementById(label_id).innerHTML = label;

			//set row visibility
			elRow = document.getElementById(rowId);
			if (display == '1') {
				try {
					elRow.style.display = 'table-row';  //others
				}
				catch(err) {
					elRow.style.setAttribute('display','block');  //IE
				}
			}
			else {
				try {
					elRow.style.display = 'none';  //others
				}
				catch(err) {
					elRow.style.setAttribute('display','none');  //IE
				}
			}
			
		}
		
		// set editor list visibility based on ref type 
		// (visible if book type or conference paper)
		var elEditors = document.getElementById('Editors');
		
		if (RefType.match(/(Book|Conference Paper)/)) {
			try {
				elEditors.style.display = 'table-row';  //others
			}
			catch(err) {
				elEditors.style.setAttribute('display','block');  //IE
			}
		}
		else {
			try {
				elEditors.style.display = 'none';  //others
			}
			catch(err) {
				elEditors.style.setAttribute('display','none');  //IE
			}
		}
		
		// reset TypeOfWork list
		var elTypeOfWork = document.getElementById('TypeOfWork');
		
		// remove all but first option from list
		for (i = elTypeOfWork.length - 1; i>0; i--) {
			elTypeOfWork.remove(i); 
		}
		
		var typelist = root.getElementsByTagName('TypeOfWorkList')[0];
		var types = typelist.getElementsByTagName('Type');
		var numTypes = types.length;
		var type;
		var elOptNew;
		var ex;
		
		for (i = 0; i < numTypes; i++) {

			node = types[i];
			type = node.firstChild.nodeValue;
			
			elOptNew = document.createElement('option');
			elOptNew.text = type;
			elOptNew.value = type;
			
			//add element to end of list
			try {
				elTypeOfWork.add(elOptNew, null); // standards compliant; doesn't work in IE
			}
			catch(ex) {
				elTypeOfWork.add(elOptNew); // IE only
			}
			
			if (numTypes == 1) {
				elTypeOfWork.options[elTypeOfWork.length - 1].selected = true;
			}
		}
								  
	}
	catch (err) {
		alert('Sorry - an error occurred updating the form fields for the selected reference type');
	}
}
