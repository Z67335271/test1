<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020-6-13
  Time: 21:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="seatbean" class="pojo.seat" scope="request"/>
<html>
<head>
    <meta charset="utf-8">
    <title>选择座位</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/choose.css">
    <link rel="stylesheet" href="css/seat.css">
    <script src="layui/layui.js"></script>
    <script src="layui/layui.all.js"></script>
    <script src="./js/jquery-2.1.1.js"></script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div>
        <div class="layui-header">
            <ul class="layui-nav layui-bg-blue" lay-filter="">
                <li class="layui-nav-item "><a href="index.jsp">航班订票网站</a></li>
                <li class="layui-nav-item "><a href="client_ticket.jsp">订票管理</a></li>
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
    <div class="choose">
        <form action="seat" method="post">
            <h2>您选择了:</h2>
            <div class="layui-form-item">
                <label class="layui-form-label">航班号</label>
                <div class="layui-input-block">
                    <label>
                        <input type="text" name="flightno"  value="<%=seatbean.getFlightno() %>" readonly="readonly"  />
                    </label>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">起始地点</label>
                <div class="layui-input-block">
                    <label>
                        <input type="text" name="start_place"  value="<%=seatbean.getStart() %>"  readonly="readonly" />
                    </label>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">目的地</label>
                <div class="layui-input-block">
                    <label>
                        <input type="text" name="end_place"  value="<%=seatbean.getEnd() %>"   autocomplete="off" class="layui-input"  readonly="readonly"/>
                    </label>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" pane>航班日期</label>
                <div class="layui-input-block">
                    <label>
                        <input type="text"  name="time" value="<%=seatbean.getDate() %>"  autocomplete="off" class="layui-input" readonly="readonly" />
                    </label>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">价格：</label>
                <div class="layui-input-block">
                    <label>
                        <input type="text"  name="price" value="<%=seatbean.getPrice() %>"  readonly="readonly" />
                    </label>
                </div>
            </div>

            <div class="layui-form-item" style="position: relative;top:10px;">
                <label class="layui-form-label" pane>航班时间</label>
                <div class="layui-input-block">
                    <label>
                        <input type="text" name="start_time" value="<%=seatbean.getStarttime() %>" readonly="readonly" />
                    </label>
                    <i class="layui-icon layui-icon-next" style="position:relative; top: 10px;"></i>
                    <label>
                        <input type="text" name="end_time" value="<%=seatbean.getEndtime() %>" readonly="readonly"/>
                    </label>
                </div>
            </div>

            <div class="layui-form-item" style="position: relative;top:-10px;">
                <label class="layui-form-label" pane>座位</label>
                <div class="layui-input-block">
                    <input type="text" id="seat" name="seat1" class="seat a" readonly="readonly"  />
                  <input type="text" id="seat2" name="seat2" class="seat b"  readonly="readonly"/>
                </div>
            </div>
            <div class="layui-form-item">
            <div class="layui-input-inline">
                <button class="layui-btn"   lay-submit lay-filter="formDemo">确定</button>
            </div>
            </div>
        </form>
    </div>
</div>

<div id="main2">
    <h2>选择座位列:</h2>
    <div id="chooseSeat">
        <button class="seaT" onclick="append_a(this)" value="1排">1排</button>
        <button class="seaT" onclick="append_a(this)" value="2排">2排</button>
        <button class="seaT" onclick="append_a(this)" value="3排">3排</button>


    </div>
    <hr>
    <h2 class="Sea">选择座位号:</h2>
    <div id="chooseSeat2">
        <button class="Seat" onclick="append_b(this)" value="A座">A座</button>
        <button class="Seat" onclick="append_b(this)" value="B座" >B座</button>
        <button class="Seat" onclick="append_b(this)" value="C座">C座</button>
        <button class="Seat" onclick="append_b(this)" value="D座">D座</button>
        <button class="Seat" onclick="append_b(this)" value="E座">E座</button>
    </div>
</div>
</body>
<script>
    layui.use('element', function(){
        var element = layui.element;
        element.init()
    });
    function append_a(e){
        console.log($(e).attr("value"));
        $("#seat").val($(e).attr("value"))
    }
    function append_b(e){
        console.log($(e).attr("value"));
        $("#seat2").val($(e).attr("value"))
    }


</script>
</html>
