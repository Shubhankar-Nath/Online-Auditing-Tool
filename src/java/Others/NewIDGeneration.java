/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Others;

/**
 *
 * @author Shubhankar Nath
 */
public class NewIDGeneration 
{
    public static String Generate(String lastID)
    {
        String nextC_id = new String();        
        System.out.println(lastID);
        int buffer = Integer.valueOf(lastID.substring(4, 10));
        System.out.println(buffer);
        buffer = buffer + 1;
        nextC_id = Integer.toString(buffer);
        int ln = nextC_id.length();
        for (int i = ln; i<6; i++)
        {
            nextC_id = 0 + nextC_id;
        }
        return lastID.substring(0, 4) + nextC_id;
    }
    
}
