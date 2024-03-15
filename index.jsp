<%@page language="java" session="false" import="java.util.*, java.sql.*" %>

<html>
    <head><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="styles.css"></head>
    <form action="my_quiz.jsp">

        <div class="outer">
        <h1 ID="quizheading" class="display-1 ">NerdBrainer</h1>
        <div class="menu">
        <select class="form-select" name=subject aria-label="Default select example">
            <option value="c">C-Programming</option>
            <option value="java">Java-Programming</option>
            <option value="oop">Object Oriented Programming</option>
            <option value="general_programming">General Programming</option>
          </select>
        <select class="form-select" name=level aria-label="Default select example">
            <option value="1">Easy</option>
            <option value="2">Medium</option>
            <option value="3">Hard</option>
          </select>
        <select class="form-select" name="qs_cnt" aria-label="Default select example">
            <option value="5">5</option>
            <option value="10">10</option>
            <option value="15">15</option>
          </select>
    </div>
        <div class="nav">
    <button type="submit">Start</button>
</div>
    </div>
    </form>
</html>