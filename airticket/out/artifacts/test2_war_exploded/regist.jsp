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
    <title>ע��</title>
</head>
<body>
<div id="login">
    <h2>�û�ע��</h2>
    <hr>
    <% client cl = (client)request.getAttribute("user"); %>
    <form action="regist" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">�û�����</label>
            <div class="layui-input-inline">
                <input type="text" name="userid" required  lay-verify="required" placeholder="�������û���" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">�����</label>
            <div class="layui-input-inline">
                <input type="password" name="password" required lay-verify="required" placeholder="����������" autocomplete="off" class="layui-input">
            </div>
        </div>
        <% if(cl !=null){ %>
            <p><%=cl.getMessage() %></p>
        <% } %>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn">ȷ��ע��</button>
                <button type="reset" class="layui-btn layui-btn-primary">����</button>

            </div>
        </div>

    </form>
    <button class="layui-btn" id="other"><a href="login.jsp">���ص�¼</a></button>


</div>
</body>
</html>
