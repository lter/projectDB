//Javascript functions called by lterQueryForm.xsl for client-side form validation
//
//validation based on code samples from Stephen Chapman (http://javascript.about.com/library/blvalid02.htm)
//
//author: Wade Sheldon <wsheldon@lternet.edu>
//version 1.0, 07-May-2009

//init arrays of allowed characters by type
var numb = '0123456789';
var lwr = 'abcdefghijklmnopqrstuvwxyz';
var upr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var sym = ' ';
var floatnum = '0123456789.-';

var global_valfield;	// retain valfield for timer thread

function init() {
    // page load init function - call startup events here
}

function setFocusDelayed()
{
  global_valfield.focus();
}

function setfocus(valfield)
{
  // save valfield in global variable so value retained when routine exits
  global_valfield = valfield;
  setTimeout('setFocusDelayed()', 100 );
}

//general validation function
function isValid(parm, val) {
    if (parm == "") return true;
    for (i = 0; i < parm.length; i++) {
        if (val.indexOf(parm.charAt(i), 0) == - 1) return false;
    }
    return true;
}

//test for numeric only
function isNumber(parm) {
    return isValid(parm, numb);
}

//test for lowercase alphabetic only
function isAlphaLower(parm) {
    return isValid(parm, lwr);
}

//test for upper case alphabetic only
function isAlphaUpper(parm) {
    return isValid(parm, upr);
}

//test for any case alphabetic
function isAlpha(parm) {
    return isValid(parm, lwr + upr);
}

//test for alphanumeric
function isAlphaNum(parm) {
    return isValid(parm, lwr + upr + numb);
}

//test for alphnumeric or allowed symbol
function isAlphaNumSymbol(parm){
    return isValid(parm,lwr + upr + numb + sym);
}

//test for floating-point numbers
function isFloatNumber(parm){
    return isValid(parm,floatnum);
}

//test for latitude
function isLatLon(parm,minval,maxval) {
    if (!isFloatNumber(parm)) {
        return false;
    }
    else {
        var num = parseFloat(parm);
        if (num < minval | num > maxval) {
            return false;
        }
        else {
            return true;
        }
    }
}

//generic event handler for validation
function validate(id,rule){
    var obj = document.getElementById(id);
    var parm = obj.value;
    var errmsg = '';
    
    switch (rule)
    {
    case 'alpha': { if (!isAlpha(parm)) errmsg = 'Please only enter alphabetic characters in this field'; break; }
    case 'alphalower': { if (!isAlphaLower(parm)) errmsg = 'Please only enter lower-case alphabetic characters in this field'; break; }
    case 'alphaupper': { if (!isAlphaUpper(parm)) errmsg = 'Please only enter upper-case alphabetic characters in this field'; break; }
    case 'alphanum': { if (!isAlphaNum(parm)) errmsg = 'Please only enter alpanumeric characters in this field'; break; }
    case 'alphanumsym': { if (!isAlphaNumSymbol(parm)) errmsg = 'Please only enter alphanumeric characters or spaces in this field'; break; }
    case 'num': { if (!isNumber(parm)) errmsg = 'Please only enter numbers in this field'; break; }
    case 'floatnum': { if (!isFloatNumber(parm)) errmsg = 'Please only enter floating-point numbers in this field'; break; }
    case 'latitude': { if (!isLatLon(parm,-90,90)) errmsg = 'Please only enter floating-point numbers between -90 and 90 in this field'; break; }
    case 'longitude': { if (!isLatLon(parm,-180,180)) errmsg = 'Please only enter floating-point numbers between -180 and 180 in this field'; break; }
    }

    if (errmsg.length > 0) {
        obj.value = '';
        alert(errmsg);
        setfocus(obj);
    }
    
}

