<!DOCTYPE html>
<%@page contentType="text/html;charset=gb2312" %>
<%@page import="pojo.client" %>

<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/login.css">
    <script src="layui/layui.all.js"></script>
    <script src="layui/layui.js"></script>
    <script src="js/jquery-1.8.2.min.js"></script>

    <title>登陆</title>
</head>
<body>
<div id="login">
    <h2>用户登录</h2>
    <hr>
    <% client cl = (client)request.getAttribute("user"); %>
    <form action="login" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名：</label>
            <div class="layui-input-inline">
                <input type="text" name="userid" required  lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码框：</label>
            <div class="layui-input-inline">
                <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <% if(cl!=null){ %>
        <p><%=cl.getMessage() %></p>
        <% } %>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn">登陆</button>
<%--                <input type="submit" class="layui-btn" value="登陆">--%>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>

            </div>
        </div>

    </form>
    <button class="layui-btn" id="other"><a href="regist.jsp">注册</a></button>
</div>
</body>
</html>
