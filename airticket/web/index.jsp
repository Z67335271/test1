<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020-6-10
  Time: 22:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=gb2312" language="java" pageEncoding="utf-8" %>
<html>
<head>
  <meta charset="utf-8">
  <title>飞机订票网站</title>
  <link rel="stylesheet" href="layui/css/layui.css">
  <link rel="stylesheet" href="css/main.css">
  <script src="layui/layui.js" ></script>
  <script src="layui/layui.all.js" ></script>
  <script src="./js/jquery-2.1.1.js"></script>
</head>
<body>

<div class="layui-layout layui-layout-admin">
  <div>
    <div class="layui-header">
      <ul class="layui-nav layui-bg-blue" lay-filter="">
        <li class="layui-nav-item "><a href="index.jsp">飞机订票网站</a></li>

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

  <div id="ch">
    <form class="layui-form" action="choose" method="post" accept-charset="UTF-8" >
      <!-- 出发地址 -->
      <div class="layui-form-item" id="start">

        <div class="layui-input-block">
          <input type="text" name="start" required  lay-verify="required" placeholder="请输入起始地点" autocomplete="off" class="layui-input">
        </div>
      </div>
      <i class="layui-icon layui-icon-right" id="icon"></i>
      <!-- 终点 -->
      <div class="layui-form-item" id="end">

        <div class="layui-input-block">
          <input type="text" name="end" required  lay-verify="required" placeholder="请输入目的地" autocomplete="off" class="layui-input">
        </div>
      </div>
      <div class="layui-form-item">

        <div class="layui-input-block">
          <input type="text" id="test1" required lay-verify="required" placeholder="请输入日期" name="time">
        </div>
      </div>
      <!-- 按钮 -->
      <div class="layui-form-item" id="sub">
        <div class="layui-input-block">
          <button class="layui-btn" >立即提交</button>
          <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
      </div>

    </form>
  </div>
</div>
</body>
<script>
  //JavaScript代码区域
  layui.use('element', function(){
    var element = layui.element;
    element.init()
  });

  layui.use('laydate', function(){
    var laydate = layui.laydate;
    //执行一个laydate实例
    laydate.render({
      elem:'#test1',
      type:'date'

    });
  });
</script>
</html>

