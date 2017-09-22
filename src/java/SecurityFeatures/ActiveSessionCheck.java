/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SecurityFeatures;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Shubhankar Nath
 */
public class ActiveSessionCheck
{
    public static String UserCheck( String info)
    {
        String auditor = null;
        try
        {
            Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
            Connection conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
            PreparedStatement pst = (PreparedStatement) conn.prepareStatement("Select * from Auditor_Details where A_SessionInfo=? ");
            pst.setString(1, info);
            ResultSet rs = pst.executeQuery();
            if (rs.next())//Means user Exists
            {
                auditor = rs.getString("A_FName");
                System.out.println("Session Authenticated");               
            }                      
        }

        catch(ClassNotFoundException | SQLException e)
        {
            System.out.println(e.getClass().getName()+":"+e.getMessage());
            System.exit(0);
        }
        return auditor;
    }
    
}
