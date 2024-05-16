<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020-6-13
  Time: 21:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link  rel="stylesheet" href="css/flightadd.css">
    <script src="layui/layui.js"></script>
    <script src="layui/layui.all.js"></script>
    <script src="js/jquery-2.1.1.js"></script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div>
        <div class="layui-header">
            <ul class="layui-nav " lay-filter="">
                <li class="layui-nav-item "><a href="index.jsp">航班订票网站</a></li>
                <li class="layui-nav-item "><a href="manager_information.jsp">个人信息</a></li>
                <li class="layui-nav-item "><a href="manage_user">用户管理</a></li>
                <li class="layui-nav-item "><a href="manage_ticket">订票管理</a></li>
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
    </div>
</div>
<div id="body">
    <div id="form_input">
        <p>请输入详细的航班信息</p>
        <hr>
        <form class="layui-form" action="manage_flight_add" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">航班号</label>
                <div class="layui-input-inline">
                    <input type="text" name="flightno"   autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">出发地</label>
                <div class="layui-input-inline">
                    <input type="text" name="start_place"   autocomplete="off" class="layui-input">
                </div>

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">目的地</label>
                <div class="layui-input-inline">
                    <input type="text" name="end_place" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">出发日期</label>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="date"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">出发时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="time1" id="time1" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">到达时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="time2" id="time2"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">价格</label>
                <div class="layui-input-inline">
                    <input type="text" name="price"  autocomplete="off" class="layui-input">
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
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        //执行一个laydate实例
        laydate.render({
            elem:'#date',
            type:'date'

        });
        laydate.render({
            elem:'#time1',
            type:'time'

        });
        laydate.render({
            elem:'#time2',
            type:'time'

        });
    });

</script>
</html>
