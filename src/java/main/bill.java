/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package main;

import java.sql.*;
import java.time.*;  
import java.time.format.DateTimeFormatter;  
import java.util.*;

/**
 *
 * @author Ganesh
 */

public class bill {
    public Connection  con  = null;
    public void connect()
    {
        try
        {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/Billing", "Ganesh", "Ganesh@123");
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
    }
    
    public int billid()
    {
      connect();
      int y=10;
      //Date k = java.time.LocalDate.now();
      try
      {
          PreparedStatement pst = con.prepareStatement("select count(*) from billing");
          ResultSet rst = pst.executeQuery();
          rst.next();
          y = rst.getInt(1)+1;
//          PreparedStatement pst1 = con.prepareStatement("insert into billid(bid, date_and_time) values(?,?)");
//          pst1.setInt(1, y);
//          pst1.setDate(2,k );
         
          
          
      }
      catch(Exception e)
      {
          System.out.println(e);
      }
      return y;
    }
    
//     public ArrayList<String> generatercustomers()
//     {
//         connect();
//         ArrayList<String> x = new ArrayList();
//         try
//         {
//             PreparedStatement pst = con.prepareStatement("select customer_name from customers" );
//            ResultSet rst = pst.executeQuery();
//            while(rst.next())
//            {
//                ArrayList<String> y = new ArrayList();
//                y.add(rst.getString(1));
//               
//                x.add(y);
//                
//            }
//      
//         }
//         catch(Exception e)
//         {
//             System.out.println(e);
//         }
//         
//         return x;
//     }
    
    
//     public String[] generatercustomers()
//     {
//         connect();
//         int y ;
//         
//         try
//         {
//             PreparedStatement pst1 = con.prepareStatement("select count(*) from customers" );
//             ResultSet rst1 = pst1.executeQuery();
//             rst1.next();
//             y = rst1.getInt(1);
//             String[] a = new String[y];
//             
//      
//         }
//         catch(Exception e)
//         {
//             System.out.println(e);
//         }
//         
//         return x;
//     }
    
    
    
    public int checkandaddcustomer(String name, String mobile)
    {
        connect();
        int y;
        int res=10;
        try
        {
            PreparedStatement pst = con.prepareStatement("select count(*) from customers where customer_name=? and customer_mobile=? ");
            pst.setString(1, name);
            pst.setString(2, mobile);
            ResultSet rst = pst.executeQuery();
            rst.next();
            y = rst.getInt(1);
            if(y==0)
            {
                 res=1;
                int k;
                PreparedStatement pst1 = con.prepareStatement("select count(*) from customers");
                ResultSet rst1 = pst1.executeQuery();
                rst1.next();
                k = rst1.getInt(1)+1;
                PreparedStatement pst2 = con.prepareStatement("insert into customers values (?,?,?)");
                pst2.setInt(1, k);
                pst2.setString(2, name);
                pst2.setString(3, mobile);
                pst2.executeUpdate();
               
                con.commit();
                con.close();
                
            }
            else
            {
                res=0;
            }
        }
        
        catch(Exception e)
        {
            System.out.println(e);
        }
        return res;
    }
    
    
    public int snumber(String cname)
    {
     connect();
     int y=0;
     try
     {
         int k=0;
         int a =0;
         PreparedStatement pst = con.prepareStatement("select cid from customers where customer_name= ?");
         pst.setString(1, cname);
         ResultSet rst = pst.executeQuery();
         rst.next();
         k = rst.getInt(1);
         System.out.println(k);
         PreparedStatement pst1 = con.prepareStatement("select count(*) from billid");
         ResultSet rst1 = pst1.executeQuery();
         rst1.next();
         y = rst1.getInt(1) + 1;
         System.out.println(a);
         PreparedStatement pst2 = con.prepareStatement("insert into billid (bid,cid) values (?,?)");
         pst2.setInt(1,y );
         pst2.setInt(2, k);
         pst2.executeUpdate();
         
         System.out.println(y);
         con.commit();
         con.close();
     }
     catch(Exception e)
     {
         System.out.println(e);
     }
        
        return y;
    }
    
    
    public ArrayList<String> products()
    {
     connect();
     ArrayList<String> x = new ArrayList();
     try
     {
         PreparedStatement pst = con.prepareStatement("select product_name from products");
         ResultSet rst= pst.executeQuery();
         while(rst.next())
         {
             x.add(rst.getString(1));
         }
     }
     catch(Exception e)
     {
         System.out.println(e);
     }
     
     
     return x;
    }
    public String price(String product)
    {
      connect();
      String y = "";
      
      try
      {
          int k;
          int a;
          PreparedStatement pst = con.prepareStatement("select product_price, tax from products where product_name=?");
          pst.setString(1, product);
          ResultSet rst = pst.executeQuery();
          rst.next();
          a = rst.getInt(1);
          k = rst.getInt(2);
          y = Integer.toString(a)+" "+Integer.toString(k);
          
          
      }
      catch(Exception e)
      {
          System.out.println(e);
      }
      
      return y;
    }
    
    public int cid(String customer)
    {
        connect();
        int y=0;
        try
        {
            PreparedStatement pst = con.prepareStatement("select cid from customers where customer_name= ?");
            pst.setString(1, customer);
            ResultSet rst = pst.executeQuery();
            rst.next();
            y = rst.getInt(1);
            System.out.println(y);
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
        
        return y;
    }
    
    
    public void insert(int cid, String date, int total)
    {
       connect();
        int y=0;
        try
        {
            PreparedStatement pst = con.prepareStatement("select count(*) from billing");
            ResultSet rst = pst.executeQuery();
            rst.next();
             y = rst.getInt(1) + 1;
            
            PreparedStatement pst1 = con.prepareStatement("insert into billing values (?,?,?,?)");
            pst1.setInt(1, y);
            pst1.setInt(2, cid);
            pst1.setInt(3, total);
            pst1.setString(4, date);
            
            pst1.executeUpdate();
            con.commit();
            con.close();
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
        
        ;
    }
    public static void main(String[] args) {
        
        bill obj = new bill();
        obj.connect();
        int y=obj.billid();
        
    }
    
}
