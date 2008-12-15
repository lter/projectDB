//Generalized select list manipulation functions
//
//Wade Sheldon (email: sheldon@uga.edu)
//Georgia Coastal Ecosystems LTER (www: http://gce-lter.marsci.uga.edu)
//
//modified from source code provided at http://www.mredkj.com/tutorials/tutorial005.html

function insertOptionBefore(id,intPos,strVal,strText)
{
	//inserts a new option before the selected option in a target select list
	//  id = id of the select list (string)
	//  inPos = position to insert the record (integer)
	//  strVal = option value (string)
	//  strText = option display text (string)
	
	//look up select list by id
	var elSel = document.getElementById(id);
		
	if (intPos < elSel.length) {
		
		//create new option element
		var elOptNew = document.createElement('option');
		elOptNew.text = strText;
		elOptNew.value = strVal;
		
		//get options of current selection
		var elOptOld = elSel.options[intPos];
		
		//insert new option
		try {
			elSel.add(elOptNew, elOptOld); // standards compliant; doesn't work in IE
		}
		catch(ex) {
			elSel.add(elOptNew, elSel.selectedIndex); // IE only
		}
		
		//set focus to inserted option
		elSel.options[intPos].selected = true;
		
	}
}

function selectAllNone(id,strOption)
{
	//selects all or none of the options in a specified list
	//  id = id of the select list (string)
	//  strOption = selection option (string; 'all' selects all, 'none' clears all selections)
	
	var elSel = document.getElementById(id);
	var i;
	
	if (strOption = 'none') {
		for (i = 0; i < elSel.length; i++) {
			elSel.options[i].selected = false;
		}
	}
	if (strOption = 'all') {
		for (i = 0; i < elSel.length; i++) {
			elSel.options[i].selected = true;
		}
	}
}

function selectAllNoneMultiple(ids,strOption)
{
	//calls the selectAllNone function for multiple lists sequentially
	//  ids = array of strings
	//  strOption = selection option (string; 'all' selects all, 'none' clears all selections)
	
	var i
	for (i = 0; i < ids.length; i++) {
		selectAllNone(ids[i],strOption);
	}
}

function appendOptionLast(id,strVal,strText)
{
	//appends a new option to the end of a select list
	//  id = id of the select list (string)
	//  strVal = option value (string)
	//  strText = option display text (string)

	//create new option element in DOM
	var elOptNew = document.createElement('option');
	elOptNew.text = strText;
	elOptNew.value = strVal;
	
	//look up select list by id
	var elSel = document.getElementById(id);

	//add element to end of list
	try {
		elSel.add(elOptNew, null); // standards compliant; doesn't work in IE
	}
	catch(ex) {
		elSel.add(elOptNew); // IE only
	}
	
	//set focus to added option
	elSel.options[elSel.length - 1].selected = true;
	
}

function removeOptionSelected(id)
{
	//remove selected option(s) from a select list
	//  id = id of the select list (string)
	
	//look up list by id
	var elSel = document.getElementById(id);
	
	//remove selected options
	var i;
	for (i = elSel.length - 1; i>=0; i--) {
		if (elSel.options[i].selected) {
			elSel.remove(i);
		}
	}
}

function removeOptionLast(id)
{
	//remove last option from list
	//  id = id of the select list (string)
	
	//look up list by id
	var elSel = document.getElementById(id);
	
	//remove last option
	if (elSel.length > 0)
	{
		elSel.remove(elSel.length - 1);
	}
}

function getSortedListInsertPosition(id,strNew)
{
	//return position index for inserting an option into an alphabetically-sorted list
	//  id = id of the select list (string)
	//  strNew = new string to use for list comparison against current list display text (string)
	
	//look up list by id
	var elSel = document.getElementById(id);
	
	//init runtime variables
	var strTest = strNew.toLowerCase();  //convert input text to lower case
	var pos = elSel.length;	 //init position with maximum length in case no options greater
	var strList;  //init variable for list text
	var i;  //init counter
	
	//loop through selection performing string comparisons
	for (i = 0; i < elSel.length; i++) {
		strList = elSel.options[i].text;
		if (strList.toLowerCase() > strTest)
		{
			pos = i;
			break;
		}
	}
	
	//return position
	return pos
	
}

function updateSingleListSelection(id,strMatch)
{
	//update the selected option of a single-select list based on matching options to a specified string
	//  id = id of the select list (string)
	//  strMatch = option to match (string)
	
	//look up list by id
	var elSel = document.getElementById(id);
	
	//init runtime variables
	var strTest = strMatch.toLowerCase();  //convert input text to lower case
	var pos = elSel.length;	 //init position with maximum length in case no options greater
	var strList;  //init variable for list text
	var i;  //init counter
	var pos;  //init output
	
	//loop through selection performing string comparisons
	for (i = 0; i < elSel.length; i++) {
		strList = elSel.options[i].value;
		if (strList.toLowerCase() == strTest) {
			elSel.options[i].selected = true;
		}
		else {
			elSel.options[i].selected = false;
			pos = i;
		}
	}
	
}

function transferOptionSingle(idFrom,idTo,insertOption)
{
	//move selected option in one list to another list
	//  idFrom = id of the source list (string)
	//  idTo = id of the target list (string)
	//  insertOption = option to insert transfered option in alphabetical order with existing list values (integer)
	//     0 = no (append to target)
	//     1 = yes (insert alphabetically)

	//look up lists by id
	var elSource = document.getElementById(idFrom);
	var elTarget = document.getElementById(idTo);
	
	//init runtime vars
	var idx = 0;
	var i = 0;
	var strText = '';
	var strVal = '';

	//check for active selection
	for (i = 0; i < elSource.length; i++) {
		
		if (elSource.options[i].selected) {
			
			//get value, text from source selection
			strText = elSource.options[i].text;
			strVal = elSource.options[i].value;
		
			//append or insert option into target list
			if (insertOption == 0) {
				//append option from source list to end of target list
				appendOptionLast(idTo,strVal,strText);
			}
	
			else {
				//get index for insertion
				idx = getSortedListInsertPosition(idTo,strText);
				if (idx < elTarget.length) {
					//set focus to specified position
					elTarget.options[idx].selected = true;					
					insertOptionBefore(idTo,idx,strVal,strText);
				}
				else {
					appendOptionLast(idTo,strVal,strText);
				}
			}
			
		}
		
	}
	
	//delete all selected options from source list
	removeOptionSelected(idFrom);
	
}

function moveOptionsUp(id) {
//move selected options up in the specified list
//  id = select list id (string)

	var selectList = document.getElementById(id);
	var selectOptions = selectList.getElementsByTagName('option');
	
	for (var i = 1; i < selectOptions.length; i++) {
 		var opt = selectOptions[i];
	 	if (opt.selected) {
			selectList.removeChild(opt);
			selectList.insertBefore(opt, selectOptions[i - 1]);
		}
    }
}

function moveOptionsDown(id) {
//move selected options down in the specified list
//  id = select list id (string)

	var selectList = document.getElementById(id);
	var selectOptions = selectList.getElementsByTagName('option');

	for (var i = selectOptions.length - 2; i >= 0; i--) {
 		var opt = selectOptions[i];
 		if (opt.selected) {
 			var nextOpt = selectOptions[i + 1];
 			opt = selectList.removeChild(opt);
 			nextOpt = selectList.replaceChild(opt, nextOpt);
 			selectList.insertBefore(nextOpt, opt);
 		}
	}
}