//= require_self
//= require jquery
//= require jquery_ujs
//= require_tree .



/**
 * DHTML textbox character counter script. Courtesy of SmartWebby.com (http://www.smartwebby.com/dhtml/)
 */

asciiLimit=320;
unicodeLimit=140;

function is_ascii(taObj){
    value = taObj.value
    length = value.length

    for(i=0;i<=length;i++){
        if (value.charCodeAt(i) > 127) return false
    }
    return true;
}

var bName = navigator.appName;
//function taLimit(taObj) {
//    is_ascii(taObj) ? limit = asciiLimit : limit = unicodeLimit
//    if (taObj.value.length==limit) return false;
//    return true;
//}

function taCount(taObj,Cnt) {
    objCnt=createObject(Cnt)  ;
    objVal=taObj.value ;

    is_ascii(taObj) ? limit = asciiLimit : limit = unicodeLimit
    ta =  document.getElementById('message_text')
    sm = document.getElementById('message_submit')
    if(objVal.length > limit){
        sm.disabled = true;
        objCnt.style.color = '#FF0000';
        ta.style.backgroundColor = '#FF4F4F'; // Red
    }else if(objVal.length > (limit/2)){
        sm.disabled = false;
        objCnt.style.color = '#008000';
        ta.style.backgroundColor = '#A7F2A7'; // White
    }else{
        sm.disabled = false;
        objCnt.style.color = '#000000';
        ta.style.backgroundColor = '#FFFFFF'; // White
    }
    
    //if (objVal.length>limit) objVal=objVal.substring(0,limit);
    if (objCnt) {
        if(bName == "Netscape"){
            objCnt.textContent=limit-objVal.length;
        }
        else{
            objCnt.innerText=limit-objVal.length;
        }
    }
    
    return true;
}

function createObject(objId) {
    if (document.getElementById) return document.getElementById(objId);
    else if (document.layers) return eval("document." + objId);
    else if (document.all) return eval("document.all." + objId);
    else return eval("document." + objId);
}