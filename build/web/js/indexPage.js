/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


            function idValidation()
            {
                var A_id = document.forms["Auditor_Login"]["A_id"].value;
                if (A_id.length>10 || A_id.length<10)
                {
                    alert("The Employee ID length is inappropiate");
                }
                if( /[^a-zA-Z0-9\-\/]/.test( A_id ) ) 
                {
                    alert('Special Characters and White Spaces are not Allowed');
                }
            }
            
            function passValidation()
            {
                var A_pass = document.forms["Auditor_Login"]["password"].value;
                if( /[^a-zA-Z0-9\-\/]/.test( A_pass ) ) 
                {
                    alert('Input is not alphanumeric');
                }
            }