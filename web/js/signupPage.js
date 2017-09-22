/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function matchPassword()
{
    var password = document.forms["Auditor_SignUp"]["password"].value;
    var re_password = document.forms["Auditor_SignUp"]["re_password"].value;
    if(password!==re_password)
    {
        confirm("Type password again");
        document.getElementById("Auditor_SignUp").reset();
    }
}

function Checkboxcheck()
{
    var x = document.getElementById("myCheck");
    if (x!==1)
    {
        alert("You must agree to the terms");
    }
}