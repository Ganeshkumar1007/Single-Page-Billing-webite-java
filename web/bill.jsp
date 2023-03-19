

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="main.bill;" %>
<%@page import="java.util.*;" %>
<%! ArrayList<String> hai = new ArrayList();%>
<!DOCTYPE html>



<%

    bill obj =new bill();
    hai = obj.products();



%>
<html>
    <head>
        <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style.css">
    <script src='https://kit.fontawesome.com/a076d05399.js' ></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" >
<link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        <title>Billing Page</title>
    </head>
    <body>
        <h1 id="bill" style="text-align: center; color: orange"></h1> <hr>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6 col-lg-6 col-lg-12">
                    
                    <label style="color: green;font-size: 20px" class="label" for="cars">Customer Name:</label>
                         
                             <select id="cars">
                                 <option id ="customer" value="select">--select--</option>
                                 <%
                                  Connection con= null;
                                 try
                                 {
                                      Class.forName("org.apache.derby.jdbc.ClientDriver");
                                     con = DriverManager.getConnection("jdbc:derby://localhost:1527/Billing", "Ganesh", "Ganesh@123");
                                     PreparedStatement pst = con.prepareStatement("select customer_name from customers" );
                                      ResultSet rst = pst.executeQuery();
                                      while(rst.next())
                                        {%>
                                        <option id ="customers" value="<%=rst.getString(1)%>"><%=rst.getString(1)%></option>
                                        <%}
                                 }
                                 catch(Exception e)
                                 {
                                     System.out.print(e);
                                 }
                                       
                                    
                                    
                                 %>
                             </select>
                             <button class="btn btn-success btn-xs" id="sub">Submit</button>
                             <h4 id='invalid' style='color:orange; margin-left: 5px'></h4>
                        
                </div>
                             
                <div class="col-md-6 col-lg-6 col-lg-12">
                    <h4 id="d" style="text-align: right">Date : </h4>
                </div>
                             
                             
            </div>
                             
                    
                            
                            
        </div>
                             
                             <div class="container-fluid">
                                  <div  class="row">
                                      <div class="col-12" style="margin-left:10px;"><button class="btn btn-primary"  id="add">Add New Customers</button></div><hr id="hr1">
                                      
                                      
                                 <div id="addcustomer" class="col-md-12" style="margin-top: 10px;visibility: hidden">
                                     <div class="form-group">
                                        <label for="name">Customer Name:</label>
                                        <input type="text" class="form-control" id="customer_name" placeholder="Enter Name">
                                      </div>
                                      <div class="form-group">
                                        <label for="phone">Mobile: </label>
                                        <input type="tel" class="form-control" id="customer_mobile"  placeholder="Enter Mobile Number">
                                      </div>
                                     
                                     <button type="submit" class="btn btn-success " id="subadd">Submit</button><hr>
                                      
                                     
                                 </div>
                                     
                                      <div class="  col-md-12" id = "tab" style="visibility: visible; margin-top: -15%">
                                           <h2 id="cname" style="visibility: visible; margin-top: 3px"></h2>
                                          <div class="text-center">
                                              <button id = "additem" style="padding: 10px;" class="btn btn-warning" disabled>Add Item</button>
                                          </div>
                                           <div>
                                         <table class="table table-striped table-responsive" id ="maintable" style="margin-top:  10px" >
                                             <thead style="color:white;background-color: black;" id="t">
                                                 <tr>
                                                     <th style="text-align:center">S.No</th>
                                                     <th style="text-align:center">Product Name</th>
                                                     <th style="text-align:center">Product Price</th>
                                                     <th style="text-align:center">Quantity</th>
                                                     <th style="text-align:center">Tax</th>
                                                     <th style="text-align:center">Product Total Price</th>
                                                     <th style="text-align:center">Actions</th>
                                                     
                                                     
                                                 </tr>
                                             </thead>
                                             <tbody id="tb">
                                                 
                                             </tbody>
                                         </table>
                                               <h4 id="sh" style="text-align: right;margin-right: 10px;visibility: hidden">Total : <input id ="s" value="0"  disabled></h4>
                                               <h1 style='text-align: center'><button id='total' disabled class='btn btn-primary'>Total</button></h1>
                                               <h2 style='text-align: center;' ><button  style="visibility: hidden"  id='b' class='btn btn-success'>Place Order</button></h2>
                                        </div>
                                     </div>
                                      
                                 
                             </div>
                                 
                             </div>
                             
                             
                             
                                     
                                 
        
    </body>
    
<script>
        $(document).ready(function(){
            
            var n="";
            
            var today = new Date();
            var date =today.getDate()+'-'+(today.getMonth()+1)+'-'+ today.getFullYear();
            
            $("#d").append(date);
            //console.log(time);
            var i =1;
         
     
   $.ajax({url:"billing",success:function(result){
           $("#bill").text("BILL NO. : "+result);
   
       
   }});
   
   
   
    
   
       $("#sub").on("click",function(){
            
       var n = $("#cars").val();
       console.log(n);
       if(n=="select")
       {
           $("#invalid").text("Invalid!!! Select Customer");
           $("#additem").attr("disabled","true");
           $("#invalid").show();
        }
       else
       {
           $("#invalid").hide();
         $("#cname").text("Customer Name : " + n);
       document.getElementById("additem").removeAttribute("disabled");  
       
       
       
        }
        
       
   });
    console.log(n);
   
   $("#additem").on("click",function(){
       $("#additem").attr("disabled","true");
       document.getElementById("total").disabled = false;
       var n = $("#cars").val();
       var sno=$("#maintable tbody").children().length + 1;
               $("#maintable tbody").append("<tr>\n\
                                        <td class='sno'>"+sno+"</td>\n\
                                        <td><input list='browsers' name='products' id='browser'>\n\
                                                   <datalist id='browsers'>\n\
                                                   <%
                                                        for(String y : hai)
                                                        {%>\n\
                                                                    <option id ='value"+i+"'value='<%=y%>'>\n\
                                                        <%}
                                                   %>\n\
                                                                       </datalist>\n\
                                                    <button class='btn btn-success btn-sm one'  id='one'value='hai' type='submit'>Submit</button></td>\n\
                                        <td><input name='pname"+i+"' class='two' id='two'  disabled></td>\n\
                                        <td><input name='quan"+i+"' class='three' id='three'></td>\n\
                                        <td><input name='tax"+i+"' class='four'id='four'disabled></td>\n\
                                        <td><input name='total"+i+"' class='five' id='five'disabled></td>\n\\n\
                                        <td><button style='margin-left:5px' class='btn btn-primary clr' id='clear'>Clear</button><button style='margin-left:5px;margin-top :3px' class='btn btn-danger del' id='delete'>Delete</button></td>\n\
                                        \n\
                                     </tr>"
                                                               );
                                                       
            $("tbody").on("click",".one",function(e){
                
                    
//                 var v=(this.target).prev().prev().val();
//                 console.log(v);
                 
                  
         
                  var v=(e.target.previousElementSibling.previousElementSibling);
                  console.log(v);
                  console.log(e.target.value);
                  v=v.value;
                  console.log(v);
                  
                  if(v!=null)
                  {
                      document.getElementById("additem").removeAttribute("disabled");  
                        var k = (e.target);
                  console.log(k);
                  var a = $(this).val();
                  console.log(a);
                  $.ajax({url:"product",data:{product:v},success:function(result){
                
                     let text = result;

                    const arr = text.split(" ");  
                    let price =parseInt(arr[0]);
                    let tax = parseInt(arr[1]);
                    
//                    var k = $(this).closest("td").next("td").val(price);
                    
                    n =e.target.parentElement;
                    x=n.nextElementSibling.children[0];
                    x.value=price;
                    d = n.nextElementSibling.nextElementSibling;
                                                      //Tax
                    
                    
                    
                    var k = x.value;
                    console.log(k);
//                    a = n.nextElementSibling.nextElementSibling.children[0];
//                    console.log(a);

                    $("tbody").on("keyup",".three",function(e){
                        var b = e.target.value;
                        var c = k * b;
                        console.log(c);
                        var f = b*tax;
                        console.log(f);
                        e = d.nextElementSibling.children[0]; 
                        var g = d.nextElementSibling.nextElementSibling.children[0];
                        e.value=f;
                        var total = f + (b * k );
                        g.value = total
                        console.log(e);
                        
                        
                    })
                    
                    

                    
                    
                    
                    
      }}) 
                    }
                    else
                    {
                        $("#additem").attr("disabled","true");
                    }   
                  
        });
//       var getvalue = document.getElementsByName('products'+i+'')[0];
//       getvalue.addEventListener('input',function(){
//            
//           $.ajax({url:"product",data:{product:this.value},success:function(result){
//                  
//                   let text = result;
//      
//                    const arr = text.split(" ");  
//                    let price =parseInt(arr[0]);
//                    let tax = parseInt(arr[1]);
//                    //document.getElementById(1).value="price";
//                   // var x=document.getElementById(i);
//                    $('#p' + i+'').val("hai");
//                    var n = $("#"+i).val();
//                    alert(n);
//                    alert(price);
//                    alert(tax);
//                   
//                   
//           }})
//       })
//       
       
       
        
       
       
       
    i=i+1;
   });
   
   
   
   $("tbody").on("click",".clr",function(e){
                
                    
                var a = e.target.parentElement.parentElement.children[1].children[0];
                a.value="";
                var b = e.target.parentElement.parentElement.children[2].children[0];
                b.value="";
                var c = e.target.parentElement.parentElement.children[3].children[0];
                c.value="";
                var d = e.target.parentElement.parentElement.children[4].children[0];
                d.value="";
                var f = e.target.parentElement.parentElement.children[5].children[0];
                f.value="";
                console.log(a);
                
                
                  
        });
        
        $("tbody").on("click",".del",function(e){
                
               
              var i = e.target.parentElement.parentElement.rowIndex;
              document.getElementById("maintable").deleteRow(i);
              var l = e.target.parentElement.parentElement.children[0];
                console.log(l);
              var len=$("#maintable tbody").children().length;
//              for(var j =1;j<=len;j++)
//              {
//                  var l = e.target.parentElement.parentElement.nextElementSibling.children[0];
//                  console.log(l);
//               }
              console.log(len);
                
                  
        });
       
       
   
   $("#add").on("click",function(){
        
       $("#addcustomer").css("visibility","visible");
       //$("#addcustomer").css({"margin-top":"-13%"});
       
       $("#tab").css({"margin-top":"-1%"});
       $("#hr1").hide();
       
   });
   
   
   
   
   $("#subadd").on("click",function(){
        $.ajax({url:"addcustomer",data:{name:$("#customer_name").val(),mobile:$("#customer_mobile").val()},success:function(result){
           
           if(result==1)
           {
                alert("Customer successfully added\n Kindly refresh the page for the  updated result");
            }
            else
            {
                alert("Customer already exists");
            }
       
   }});
   })
   
   
    $("#total").on("click",function(){
                $("#sh").css("visibility", "visible");
                var sum =0;
                $("#b").css("visibility", "visible");
                var table = document.getElementById("maintable");
                
                var n=table.rows.length ;
                console.log(n);
                for(var i =1;i<n;i++)
                {
                    sum =sum + parseFloat (table.rows[i].cells[5].children[0].value);
                     
                }
                console.log(sum);
                $("#s").val(sum);
               
                
              
                
                  
        });
        
        $("#b").on("click",function(){
            console.log(n);
//            var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
            $.ajax({url:"placeorder",data:{da :date,tot:$("#s").val(),cus:$("#cars").val()},success:function(result){
                    var table=document.getElementById("maintable");
                    
                     for(var i =table.rows.length-1;i>=1;i--)
                    {
                        table.deleteRow(i);

                    }
                    var sum=0; 
                    alert("Order placed Successfully");
                    var n=table.rows.length ;
                   
                    for(var i =1;i<n;i++)
                    {
                        sum =sum + parseFloat (table.rows[i].cells[5].children[0].value);

                    }
                    console.log(sum);
                    $("#s").val(sum);
                    $("#bill").text("BILL NO. : "+result);
                    
            }})
        })
            
  });
       
   
   
       
     
        

  

</script>
</html>
