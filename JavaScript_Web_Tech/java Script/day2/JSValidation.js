function nameValidation(uname){
var namePattern =/^[a-zA-Z]{3,10}$/;
var nameStatus = true;
if(!namePattern.test(uname)){
    nameStatus= false;
    //dispaly error message
    document.getElementById("nameError").innerHTML="Name should be 3 to 10 characters";
}
if(nameStatus==true){
    document.getElementById("nameError").style.visibility="hidden";
}else{
    document.getElementById("nameError").style.visibility="visible";
}
return nameStatus;
}


function ageValidation(age){
var agePattern =/^[0-9]{1,3}$/;
var ageStatus = true;
if(!agePattern.test(age)){
    ageStatus = false;
    //dipalay erro message
    document.getElementById("ageError").innerHTML="Age should be 1 to 3 digits";
}
if(ageStatus==true){
    //make the error  invisable
    document.getElementById("ageError").style.visibility="hidden";
}else{
    document.getElementById("ageError").style.visibility="visible";
}
return ageStatus
}

function passValidation(pass){
var p = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
var pstatus = true;
if(!p.test(pass)){
    pstatus = false;

    document.getElementById("passerror").innerHTML="password should be MN 6 characters";
}
if(pstatus==true){
    document.getElementById("passerror").style.visibility="hidden";
}else{
    document.getElementById("passerror").style.visibility="visible";
}
return pstatus;
}
function validationForm(){
    var uname = document.getElementById("name").value;
    var age = document.getElementById("age").value;
  var pass = document.getElementById("pass").value;
    return nameValidation(uname)&& ageValidation(age) && passValidation(pass) ;
}
