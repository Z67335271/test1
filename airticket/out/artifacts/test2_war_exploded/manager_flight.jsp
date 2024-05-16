<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020-6-13
  Time: 21:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="flightbean" class="pojo.flight" scope="request"  />
<html>
<head>
    <meta charset="utf-8">
    <title>航班管理</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/manage.css">
    <link  rel="stylesheet" href="css/person.css">
    <script src="layui/layui.js"></script>
    <script src="layui/layui.all.js"></script>
    <script src="js/jquery-2.1.1.js"></script>
</head>
<body>
<div>
    <ul class="layui-nav " lay-filter="">
        <li class="layui-nav-item "><a href="index.jsp">航班订票网站</a></li>
        <li class="layui-nav-item "><a href="manager_information.jsp">个人信息</a></li>
        <li class="layui-nav-item "><a href="manage_user">用户管理</a></li>
        <li class="layui-nav-item "><a href="ticket">订票管理</a></li>
        <li class="layui-nav-item "><a href="manage_flight">航班管理</a></li>
        <li class="layui-nav-item" ><a href="flightAdd.jsp">增加航班</a></li>
    </ul>
    <ul class="layui-nav layui-layout-right">
        <% if(session.getAttribute("userid")==null){ %>
        <li class="layui-nav-item">
            <a href="login">登陆注册</a>
        </li>
        <% }else{  %>
        <% if(session.getAttribute("useriden").equals("manager")){ %>
        <li class="layui-nav-item">
            <a href="javascript:;">
                <%=session.getAttribute("username") %>
            </a>
            <dl class="layui-nav-child">
                <dd><a href="manager_information.jsp">个人中心</a></dd>
                <dd><a href="loginout">退出登陆</a></dd>
            </dl>
        </li>
        <% }else{ %>
        <li class="layui-nav-item">
            <a href="javascript:;">
                <%=session.getAttribute("username") %>
            </a>
            <dl class="layui-nav-child">
                <dd><a href="client_information.jsp">个人中心</a></dd>
                <dd><a href="loginout">退出登陆</a></dd>
            </dl>
        </li>
        <% } %>
        <%} %>
    </ul>

</div>

<div id="body">

    <%--    <% String[]columnName =ticketbean.getColumnName();%>--%>
    <% String [][] record = flightbean.getRecord();%>
    <% if(record.length == 0){ %>
    <p style="padding: 100px;margin: 100px;font-size: 50px;position: relative;left: 150px;"> 空空如也</p>
    <% }else{ %>
    <table class="layui-table">
        <thead>
        <tr>
            <%--    <% for (String s:columnName){%>--%>
            <%--    <th><%= s %></th>--%>
            <%--    <% } %>--%>

            <th>航班号</th>
                <th>日期</th>
                <th>开始时间</th>
                <th>出发地</th>
                <th>目的地</th>
            <th>价格</th>
            <th>结束时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>

        <tr>
                <% for (String[] strings : record) { %>
        <tr>
            <% for (String string : strings) { %>
            <td>
                <%=string %>
            </td>
            <% } %>
            <td>
                <form action="manage_flight_modify" method="get">
                    <input type="hidden" name="flightno" value="<%=strings[0] %>">
                    <button class="layui-btn">修改</button>
                </form>
                <form action="flight_delete" method="post">
                    <input type="hidden" name="delete" value="<%=strings[0] %>">
                    <button class="layui-btn">删除</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>
</div>

</body>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;
        element.init()
    });
</script>
</html>
