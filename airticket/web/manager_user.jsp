<%@ page import="java.util.Arrays" %><%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020-6-13
  Time: 21:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=gb2312"  %>
<%--<jsp:useBean id="manclientbean" class="pojo.client" scope="request"  />--%>
<html>
<head>
    <meta charset="utf-8">
    <title>�û�����</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/manage.css">
    <link  rel="stylesheet" href="css/person.css">
    <script src="layui/layui.js"></script>
    <script src="layui/layui.all.js"></script>
    <script src="js/jquery-2.1.1.js"></script>
</head>
<body>
<div>
    <ul class="layui-nav " lay-filter="">
        <li class="layui-nav-item "><a href="index.jsp">�ɻ���Ʊ��վ</a></li>
        <li class="layui-nav-item "><a href="manager_information.jsp">������Ϣ</a></li>
        <li class="layui-nav-item "><a href="manage_user">�û�����</a></li>
        <li class="layui-nav-item "><a href="ticket">��Ʊ����</a></li>
        <li class="layui-nav-item "><a href="manage_flight">�������</a></li>
        <li class="layui-nav-item" ><a href="flightAdd.jsp">���Ӻ���</a></li>
    </ul>
    <ul class="layui-nav layui-layout-right">
        <% if(session.getAttribute("userid")==null){ %>
        <li class="layui-nav-item">
            <a href="login">��½ע��</a>
        </li>
        <% }else{  %>
        <% if(session.getAttribute("useriden").equals("manager")){ %>
        <li class="layui-nav-item">
            <a href="javascript:;">
                <%=session.getAttribute("username") %>
            </a>
            <dl class="layui-nav-child">
                <dd><a href="manager_information.jsp">��������</a></dd>
                <dd><a href="loginout">�˳���½</a></dd>
            </dl>
        </li>
        <% }else{ %>
        <li class="layui-nav-item">
            <a href="javascript:;">
                <%=session.getAttribute("username") %>
            </a>
            <dl class="layui-nav-child">
                <dd><a href="client_information.jsp">��������</a></dd>
                <dd><a href="loginout">�˳���½</a></dd>
            </dl>
        </li>
        <% } %>
        <%} %>
    </ul>

</div>

<div id="body">

    <%--    <% String[]columnName =ticketbean.getColumnName();%>--%>
    <% String [][] record = (String[][]) request.getAttribute("manclientbean");%>
<%--        <% record = (String[][]) request.getAttribute("manclientbean"); %>--%>
        <%System.out.println(Arrays.deepToString(record)); %>
    <% if(record.length == 0){ %>
    <p style="padding: 100px;margin: 100px;font-size: 50px;position: relative;left: 150px;"> �տ���Ҳ</p>
    <% }else{ %>
    <table class="layui-table">
        <thead>
        <tr>
            <th>�˺�</th>
                <th>����</th>
                <th>�û���</th>
                <th>�û����</th>
        </tr>
        </thead>
        <tbody>

                <% for (String[] strings : record) { %>
        <tr>
            <% for (String string : strings) { %>
            <td>
                <%=string %>
            </td>
            <% } %>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>
</div>
</body>
<script>
    //JavaScript��������
    layui.use('element', function(){
        var element = layui.element;
        element.init()
    });
</script>
</html>
