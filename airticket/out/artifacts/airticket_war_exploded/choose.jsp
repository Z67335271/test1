<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020-6-12
  Time: 20:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html;charset=utf-8"); %>
<jsp:useBean id="flightbean" class="pojo.flight" scope="request" />
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/choose.css">
    <script src="layui/layui.js"></script>
    <script src="layui/layui.all.js"></script>
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
<div id="left">
    <!-- 选择地点 -->
    <div class="chooseplace">
        <form action="choose" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">起始地点</label>
                <div class="layui-input-block">
                    <input type="text" name="start"  lay-verify="required"  autocomplete="off" value="<%=flightbean.getStart() %>" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">目的地</label>
                <div class="layui-input-block">
                    <label>
                        <input type="text" name="end"  lay-verify="required" autocomplete="off" value="<%=flightbean.getEnd() %>" class="layui-input">
                    </label>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" pane>航班日期</label>
                <div class="layui-input-block">
                    <input type="text" id="test1" name="time" value="<%=flightbean.getDate() %>">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-inline">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>


    </div>

</div>
<div id="main">
    <% String [][] record = flightbean.getRecord(); %>
    <!-- 分页 -->

    <div id="page">
        <form class="timechange" action="choose" method="post">
            <input type="hidden" value="<%=flightbean.getStart() %>" name="start">
            <input type="hidden" value="<%=flightbean.getEnd() %>" name="end">
            <input type="hidden" value="<%=flightbean.getPrevious() %>" name="time">
        <button id="previous_date"><a >上一天</a></button>
        </form>
        <p id="datetime"><%=flightbean.getDate() %></p>
        <form class="timechange" action="choose" method="post">
            <input type="hidden" value="<%=flightbean.getStart() %>" name="start">
            <input type="hidden" value="<%=flightbean.getEnd() %>" name="end">
            <input type="hidden" value="<%=flightbean.getNext() %>" name="time">
            <button id="next_date"><a >下一天</a></button>
        </form>
    </div>
    <% if(record.length ==0){%>
    <p style="padding: 100px;margin: 100px;font-size: 30px;position: relative;left: 50px;">空空如也，请输入合适的地点或时间</p>
    <% }else{ %>
    <!-- 选择时间 -->
    <div id="time">

    <% for(String[] strings : record) {%>
        <div class="chooseTime">
            <div class="place">
                <p class="start_place"><%=strings[3] %></p>
                <i class="layui-icon layui-icon-triangle-r"></i>
                <p class="end_place"><%=strings[4] %></p>
            </div>
            <div class="time">
                <p class="start_time"><%=strings[2] %></p>
                <i class="layui-icon layui-icon-triangle-r"></i>
                <p class="end_time"><%=strings[6] %></p>
            </div>
            <div class="price">
                <p class="price1">价格：<%=strings[5] %></p>
            </div>
            <div class="flightno">
                <h1><%=strings[0]%></h1>
            </div>
            <div class="sub">
                <form action="seat" method="get">
                    <input type="hidden" name="flightno" value="<%=strings[0] %>" />
                    <input type="submit" value="订票" class="layui-btn">
                </form>
            </div>
        </div>
    <%} %>
        <%} %>

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
            elem:'#test1'
        });
    });
</script>
</html>
