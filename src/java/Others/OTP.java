/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Others;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;

/**
 *
 * @author Shubhankar Nath
 */
public class OTP 
{
    public static String generateOTP(String campaign_id) throws ClassNotFoundException, SQLException
    {
        String pass ="==NONE==";
        String status = "Alive";
        try
        {
            pass = getRandPass();
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
            PreparedStatement pst =con.prepareStatement("insert into OTP_Details(campaign_id,pass,status) values(?,?,?)");
            pst.setString(1,campaign_id);
            pst.setString(2, pass);
            pst.setString(3, status);
            int r=pst.executeUpdate();
            if (r==1)
            {
                System.out.print("OTP Made");
            }
        }
        catch (ClassNotFoundException | SQLException e)
        {
            System.out.print(e);
            System.out.print("OTP could not be generated");
        }
        return pass;
    }
    public static String getRandPass()
    {
        char[] chars = "abcdefghijklABCDEFGHmnopqrsZYXWVUtuvwxyz012345LTS6789".toCharArray();
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i <6; i++)
        {
            char c = chars[random.nextInt(chars.length)];
            sb.append(c);
        }
        String pass = sb.toString();
        return pass;
    }
}
