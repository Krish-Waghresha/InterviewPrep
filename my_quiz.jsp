<%@page language="java" session="false" import="java.util.*, java.sql.*" %>

<%
try{
    Connection con;
    Statement stmt;
    ResultSet rs;
    RequestDispatcher rd;
    Random rand=new Random();
    Class.forName("org.postgresql.Driver");
    con=DriverManager.getConnection("jdbc:postgresql://localhost/postgres","postgres","sql123");
    stmt=con.createStatement();

    Cookie c[]=request.getCookies();
    int qs_id,qs_count,total_qs;
    String subject;
    qs_count=0;
    if(c==null)
    {
        subject=request.getParameter("subject");
        int level=Integer.parseInt(request.getParameter("level"));
        total_qs=Integer.parseInt(request.getParameter("qs_cnt"));
        
        do{
            int tempid=rand.nextInt(31);
            rs=stmt.executeQuery("select * from mcqs where mcq_id="+tempid+" and subject='"+subject+"' and difficulty_level<="+level+" and isasked=false");
            
        }while(!rs.isBeforeFirst());
        rs.next();
        qs_id=rs.getInt(1);
        qs_count++;        
        Cookie c1=new Cookie("subject",subject);
        Cookie c2=new Cookie("level",""+level);
        Cookie c3=new Cookie("total_qs",""+total_qs);
        Cookie c4=new Cookie("score",""+0);
        Cookie c5= new Cookie("qs_id",""+qs_id);
        Cookie c6= new Cookie("qs_count",""+qs_count);
    
        response.addCookie(c1);
        response.addCookie(c2);
        response.addCookie(c3);
        response.addCookie(c4);
        response.addCookie(c5);
        response.addCookie(c6);
        
        rs=stmt.executeQuery("select * from mcqs where mcq_id="+qs_id);
        rs.next();
    }
    else{

    
        subject=c[0].getValue();
        int level=Integer.parseInt(c[1].getValue());
        total_qs=Integer.parseInt(c[2].getValue());
        int score=Integer.parseInt(c[3].getValue());
        qs_id=Integer.parseInt(c[4].getValue());
        qs_count=Integer.parseInt(c[5].getValue());
        response.addCookie(c[0]);
        response.addCookie(c[1]);
        response.addCookie(c[2]);

        rs=stmt.executeQuery("select correct_option from mcqs where mcq_id="+qs_id+"and subject='"+subject+"'");
        rs.next();
        String ans=rs.getString("correct_option");
        String choice=request.getParameter("ans");
        
        
        if(ans.equalsIgnoreCase(choice)==true)
            score++;
        else
            score=score;

        c[3].setValue(""+score);
        response.addCookie(c[3]);
        

        stmt.executeUpdate("update mcqs set isasked=true where mcq_id="+qs_id+"and subject='"+subject+"'");
        
        if(qs_count==total_qs)
        {
            stmt.executeUpdate("update mcqs set isasked=false");
            rd=request.getRequestDispatcher("score.jsp");
            rd.forward(request,response);
        }
        
        do{
            int tempid=rand.nextInt(31);
            rs=stmt.executeQuery("select * from mcqs where mcq_id="+tempid+" and subject='"+subject+"' and difficulty_level<="+level+" and isasked=false");
            
        }while(!rs.isBeforeFirst());
        rs.next();
        qs_id=rs.getInt(1);
        qs_count++;
    
    c[4].setValue(""+qs_id);
    c[5].setValue(""+qs_count);

        response.addCookie(c[4]);
        response.addCookie(c[5]);

        rs=stmt.executeQuery("select * from mcqs where mcq_id="+qs_id);
        rs.next();

    }
    String type=null;

    switch(subject){
        case "c":type="C-Programming";
                 break;
        case "java":type="Java-Programming";
                 break;
        case "oop":type="Object Oriented Concepts";
                 break;
        case "general_programming":type="General Programming";
                 break;

    }
%>
    <html>
        <head>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="styles.css">
    </head> 
            <body>
                <form action="my_quiz.jsp">
                <div class="card" id="card">
                    <div class="header d-flex justify-content-between align-items-center">
                        <h3>
                            <small class="text-muted number" >Question Number <span style="font-size: 5rem; font-weight: bold;"><%= qs_count %></span> </small>
                        </h3>

                        <span class="mr-2 type">
                            Subject:<%=type%>
                        </span>
                    </div>

                    <div class="main">
                        <div class="question">
                            <h3>
                                <span class="question-text"><%= rs.getString(2)%></span>
                            </h3>
                        </div>
                        <div class="option">
                            <div class="form-check option">
                                <input class="form-check-input" type="radio" name="ans" value="A" id="flexRadioDefault1">
                                <label class="form-check-label" for="flexRadioDefault1">
                                    <%= rs.getString(3)%>
                                </label>
                            </div>
                            <div class="form-check option">
                                <input class="form-check-input" type="radio" name="ans" value="B" id="flexRadioDefault1">
                                <label class="form-check-label" for="flexRadioDefault1">
                                    <%= rs.getString(4)%>
                                </label>
                            </div>
                            <div class="form-check option">
                                <input class="form-check-input" type="radio" name="ans" value="C" id="flexRadioDefault1">
                                <label class="form-check-label" for="flexRadioDefault1">
                                    <%= rs.getString(5)%>
                                </label>
                            </div>
                            <div class="form-check option">
                                <input class="form-check-input" type="radio" name="ans"  value="D" id="flexRadioDefault1">
                                <label class="form-check-label" for="flexRadioDefault1">
                                    <%= rs.getString(6)%>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="nav d-flex justify-content-center">
                        <button type="reset" class="btn m-4 mt-0 mb-0 btn-primary">RESET</button>
                        <button class="btn btn-success m-4 mt-0 mb-0">NEXT</button>
                    </div>
                </div>
            </form>
            <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
            

</body>

    
    <%
    
}catch(Exception e)
{
    out.print("Error:"+e);
}
%>