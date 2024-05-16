<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020-6-13
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="../layui/css/layui.css">
    <link rel="stylesheet" href="../css/pay.css">
    <script src="../layui/layui.js"></script>
    <script src="../layui/layui.all.js"></script>
    <script src="../js/jquery-2.1.1.js"></script>
</head>
<body>
<% Cookie[] cookies = request.getCookies(); %>
<div class="layui-layout layui-layout-admin">
    <div>
        <div class="layui-header">
            <ul class="layui-nav layui-bg-blue" lay-filter="">
                <li class="layui-nav-item "><a href="">航班订票网站</a></li>

            </ul>
            <ul class="layui-nav layui-layout-right">
                <% if(cookies[0].getValue() ==""){ %>
                <li class="layui-nav-item">
                    <a href="login">登陆注册</a>
                </li>
                <% }else{  %>
                <li class="layui-nav-item">
                    <a href="javascript:;">
                        <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                        贤心
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="${pageContext.request.contextPath}/client/information">个人中心</a></dd>
                        <dd><a href="loginout">退出登陆</a></dd>
                    </dl>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</div>

<div id="body">
    <!-- 提示文本 -->
    <div id="tip">
        <p>请您确认一下清单</p>
    </div>
    <!-- 记录 -->
    <div id="ticket">
        <div class="ticket_ding">

        </div>
        <div class="ticket_ding">

        </div>
        <div class="ticket_ding">

        </div>
        <div class="ticket_ding">

        </div>

    </div>
    <!-- 总共 -->
    <div id="sum">

    </div>
    <!-- 确认 -->
    <div class="btn">

        <button class="layui-btn"><a>提交订单</a></button>
        <button class="layui-btn"><a>返回</a></button>
    </div>
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

