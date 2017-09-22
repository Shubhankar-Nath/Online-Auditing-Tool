/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Others;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
/**
 *
 * @author Shubhankar Nath
 */
public class Export 
{
    public static String writeXls (String campaign_id)
    {
        System.out.println("Function Invoked");
        try
        {
            String property = System.getProperty("user.name");
            System.out.println("User name:"+property);
            String filename = "C:/Users/"+property+"/Desktop/DataOf"+campaign_id+".xls";

            Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Audit?useSSL=false","root","1234");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from Qs"+campaign_id);
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet=workbook.createSheet("Audit Report");

            HSSFRow rowhead = sheet.createRow((short) 0);//Creating Header
            rowhead.createCell((short) 0).setCellValue("Sl.no");
            rowhead.createCell((short) 1).setCellValue("ID");
            rowhead.createCell((short) 2).setCellValue("Question");
            rowhead.createCell((short) 3).setCellValue("Document Recomended");
            rowhead.createCell((short) 4).setCellValue("Client Result");
            rowhead.createCell((short) 5).setCellValue("Auditor Comment");
            rowhead.createCell((short) 6).setCellValue("Audit Status");
            rowhead.createCell((short) 7).setCellValue("Standard STD");
            rowhead.createCell((short) 8).setCellValue("Standard PCIDSS");
            rowhead.createCell((short) 9).setCellValue("Standard SAP");

            int i = 1;
            while (rs.next())
            {
                HSSFRow row = sheet.createRow((short) i);//Creating new row
                row.createCell((short) 0).setCellValue(i);
                row.createCell((short) 1).setCellValue(rs.getString(1));
                row.createCell((short) 2).setCellValue(rs.getString(2));
                row.createCell((short) 3).setCellValue(rs.getString(3));
                row.createCell((short) 4).setCellValue(rs.getString(4));
                row.createCell((short) 5).setCellValue(rs.getString(5));
                row.createCell((short) 6).setCellValue(rs.getString(6));
                row.createCell((short) 7).setCellValue(rs.getString(7));
                row.createCell((short) 8).setCellValue(rs.getString(8));
                row.createCell((short) 9).setCellValue(rs.getString(9));
                i++;
            }
            FileOutputStream fileOut =  new FileOutputStream(filename);
            workbook.write(fileOut);
            fileOut.close();
            System.out.println("Your excel file has been generated!");
            conn.close();
        }
        catch(IOException | ClassNotFoundException | SQLException e)
        {
            System.out.println("Cannot export file");
            System.err.println(e.getClass().getName()+":"+e.getMessage());
            System.exit(0);
        } 
        return "Data Exported";
    }
//    public static void main(String[]args)
//    {
//        writeXls("00000001");
//    }
}
