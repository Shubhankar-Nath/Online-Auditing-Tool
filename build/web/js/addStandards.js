/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//To display the section based on selection

function check1()
{
    var x=document.getElementById("Qb_ISO").checked;
    if (x===true)
    {
        document.getElementById("Sec").style.display="block";
        document.getElementById("Qb_StdISO").style.display="block";
    }
    else 
    {
        document.getElementById("Sec").style.display="none";
        document.getElementById("Qb_StdISO").style.display="none";
    }
}
function check2()
{
    var x=document.getElementById("Qb_PCIDSS").checked;
    if (x===true)
    {
        document.getElementById("Sec").style.display="block";
        document.getElementById("Qb_StdPCIDSS").style.display="block";
    }
    else
    {
        document.getElementById("Sec").style.display="none";
        document.getElementById("Qb_StdPCIDSS").style.display="none";
    }
}
function check3()
{
    var x=document.getElementById("Qb_SAP").checked;
    if (x===true)
    {
        document.getElementById("Sec").style.display="block";
        document.getElementById("Qb_StdSAP").style.display="block";
    }
    else
    {
        document.getElementById("Sec").style.display="none";
        document.getElementById("Qb_StdSAP").style.display="none";
    }
}