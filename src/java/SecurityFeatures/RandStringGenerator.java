/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SecurityFeatures;

import java.util.Random;

/**
 *
 * @author Shubhankar Nath
 */
public class RandStringGenerator 
{
    public static String getRandString()
    {
        String RANDTCHARS = "PQRSTUVWXYZ12ABCDE890qwertyuiopljhFGHIJKLMxcvbnmNO34567gfdsaz";
        StringBuilder salt = new StringBuilder();
        Random rnd = new Random();
        while (salt.length() < 18) 
        { // length of the random string.
            int index = (int) (rnd.nextFloat() * RANDTCHARS.length());
            salt.append(RANDTCHARS.charAt(index));
        }        
        return salt.toString();
    }

}
