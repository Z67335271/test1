<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020-6-13
  Time: 21:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link  rel="stylesheet" href="css/person.css">
    <script src="layui/layui.js"></script>
    <script src="layui/layui.all.js"></script>
    <script src="js/jquery-2.1.1.js"></script>
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
    <div id="form_input">
        <p>您可以在以下输入框修改自己的信息</p>
        <hr>
        <form class="layui-form" action="information" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">账号</label>
                <div class="layui-input-inline">
                    <input type="text" name="userid" value="<%=session.getAttribute("userid") %>"   placeholder="请输入账号" autocomplete="off" disabled="true" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">密码框</label>
                <div class="layui-input-inline">
                    <input type="password" name="newpwd" value="<%=session.getAttribute("userpwd")%>"  placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
                <i class="layui-icon layui-icon-tips" onclick="view(this)"></i>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">名字</label>
                <div class="layui-input-inline">
                    <input type="text" name="newname"  value="<%=session.getAttribute("username")%>" placeholder="请输入名字" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
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
    layui.use('element', function(){
        var element = layui.element;
        element.init()
    });

    function view(e){
        $("input[name$=newpwd]").attr("type","text")
        $(e).attr("onclick","unview(this)")
        $(e).css("color","blue");
    }

    function unview(e){
        $("input[name$=newpwd]").attr("type","password")
        $(e).attr("onclick","view(this)")
        $(e).css("color","black");
    }


</script>
</html>
