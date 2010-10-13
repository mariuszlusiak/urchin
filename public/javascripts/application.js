// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
/**
 * DHTML textbox character counter script. Courtesy of SmartWebby.com (http://www.smartwebby.com/dhtml/)
 */

asciiLimit=160;
unicodeLimit=70;

function is_ascii(taObj){
    value = taObj.value
    length = value.length

    for(i=0;i<=length;i++){
        if (value.charCodeAt(i) > 127) return false
    }
    return true;
}

var bName = navigator.appName;
function taLimit(taObj) {
    is_ascii(taObj) ? limit = asciiLimit : limit = unicodeLimit
    if (taObj.value.length==limit) return false;
    return true;
}

function taCount(taObj,Cnt) {
    objCnt=createObject(Cnt);
    objVal=taObj.value;
    is_ascii(taObj) ? limit = asciiLimit : limit = unicodeLimit
    if (objVal.length>limit) objVal=objVal.substring(0,limit);
    if (objCnt) {
        if(bName == "Netscape"){
            objCnt.textContent=limit-objVal.length;
        }
        else{
            objCnt.innerText=limit-objVal.length;
        }
    }
    ta =  document.getElementById("message_text")
    if (limit-objVal.length <= 0){
        ta.style.backgroundColor = '#FF4F4F' // Red
    }else{
        ta.style.backgroundColor = '#FFFFFF' // White
    }
    return true;
}

function createObject(objId) {
    if (document.getElementById) return document.getElementById(objId);
    else if (document.layers) return eval("document." + objId);
    else if (document.all) return eval("document.all." + objId);
    else return eval("document." + objId);
}