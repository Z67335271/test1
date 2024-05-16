<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020-6-27
  Time: 20:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>结果</title>
</head>
<body>
    <% String cl = (String) request.getAttribute("jieguo"); %>
    <p><%=cl %></p>
    <a href="javascript:history.go(-1);">返回</a>
    <br>
    <a href="index.jsp">返回首页</a>
</body>
</html>
