<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020-6-12
  Time: 20:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>订票记录</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
    <link rel="stylesheet" href="../css/manage.css">
    <script src="../layui/layui.js"></script>

    <script src="../layui/layui.all.js"></script>
    <script src="../js/jquery-2.1.1.js"></script>
</head>
<body>
<div>
    <ul class="layui-nav layui-bg-molv">
        <li class="layui-nav-item">
            <a href="">管理系统</a>
        </li>
        <li class="layui-nav-item"><a href="">订票记录</a></li>
        <li class="layui-nav-item"><a href="">用户记录</a></li>
    </ul>

</div>
<div id="body">
    <table class="layui-table">
        <colgroup>
            <col width="150">
            <col width="200">
            <col>
        </colgroup>
        <thead>
        <tr>
            <th>昵称</th>
            <th>加入时间</th>
            <th>签名</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>贤心</td>
            <td>2016-11-29</td>
            <td>人生就像是一场修行</td>
        </tr>
        <tr>
            <td>许闲心</td>
            <td>2016-11-28</td>
            <td>于千万人之中遇见你所遇见的人，于千万年之中，时间的无涯的荒野里…</td>
        </tr>
        </tbody>
    </table>
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
