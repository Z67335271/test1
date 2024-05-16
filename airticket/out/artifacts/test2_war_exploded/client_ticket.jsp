<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020-6-12
  Time: 20:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=gb2312" %>
<jsp:useBean id="ticketbean" class="pojo.ticket" scope="request" />
<html>
<head>
    <meta charset="utf-8">
    <title>订票管理</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link  rel="stylesheet" href="css/person.css">
    <script src="layui/layui.js"></script>
    <script src="layui/layui.all.js"></script>
    <script src="./js/jquery-2.1.1.js"></script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div>
        <div class="layui-header">
            <ul class="layui-nav layui-bg-green" lay-filter="">
                <li class="layui-nav-item "><a href="index.jsp">航班订票网站</a></li>
                <li class="layui-nav-item "><a href="client_information.jsp">个人信息</a></li>
                <li class="layui-nav-item "><a href="ticket">订票管理</a></li>
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
    </div>
</div>
<div id="body">

<%--    <% String[]columnName =ticketbean.getColumnName();%>--%>
    <% String [][] record = ticketbean.getTableRecord();%>
    <% if(record.length == 0){ %>
        <p style="padding: 100px;margin: 100px;font-size: 50px;position: relative;left: 150px;"> 空空如也</p>
    <% }else{ %>
    <table class="layui-table">
        <thead>
        <tr>
<%--    <% for (String s:columnName){%>--%>
<%--    <th><%= s %></th>--%>
<%--    <% } %>--%>
            <th>票号</th>
            <th>用户名</th>
            <th>航班号</th>
            <th>座位</th>
            <th>价格</th>
            <th>日期</th>
            <th>开始时间</th>
            <th>结束时间</th>
            <th>出发地</th>
            <th>目的地</th>
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
                <form action="delete" method="post">
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