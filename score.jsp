<%@page language="java" session="false" %>
<html>
        <head>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="styles.css">
    </head> 
    <body>
<%
    Cookie c[]=request.getCookies();
    int score=Integer.parseInt(c[3].getValue());
    int total_qs=Integer.parseInt(c[2].getValue());

    %>
        <div class="all-score">
        <h1 class="display-1">Woo-Ho!!!!</h1>
            <br>
            <div class="score">You scored <br><span id="score"><%=score%>/<%=total_qs%></span></div>
        </div>
        
    
      

</body>
</html>