<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020-6-12
  Time: 20:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=gb2312" %>
<jsp:useBean id="ticketbean" class="pojo.ticket" scope="request" />
<html>
<head>
    <meta charset="utf-8">
    <title>��Ʊ����</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link  rel="stylesheet" href="css/person.css">
    <script src="layui/layui.js"></script>
    <script src="layui/layui.all.js"></script>
    <script src="./js/jquery-2.1.1.js"></script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div>
        <div class="layui-header">
            <ul class="layui-nav " lay-filter="">
                <li class="layui-nav-item "><a href="index.jsp">���ඩƱ��վ</a></li>
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
                    <a href="javascript:">
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
    </div>
</div>
<div id="body">

    <%--    <% String[]columnName =ticketbean.getColumnName();%>--%>
    <% String [][] record = ticketbean.getTableRecord();%>
    <% if(record.length == 0){ %>
    <p style="padding: 100px;margin: 100px;font-size: 50px;position: relative;left: 150px;"> �տ���Ҳ</p>
    <% }else{ %>
    <table class="layui-table">
        <thead>
        <tr>
            <%--    <% for (String s:columnName){%>--%>
            <%--    <th><%= s %></th>--%>
            <%--    <% } %>--%>
            <th>Ʊ��</th>
            <th>�û���</th>
            <th>�����</th>
            <th>��λ</th>
            <th>�۸�</th>
            <th>����</th>
            <th>��ʼʱ��</th>
            <th>����ʱ��</th>
            <th>������</th>
            <th>Ŀ�ĵ�</th>
            <th>����</th>
        </tr>
        </thead>
        <tbody>

        <tr>
                <% for (String[] strings : record) { %>
        <tr>
            <% for (String string : strings) { %>
            <td>
                <%=string %>
            </td>
            <% } %>
            <td>
                <form action="delete" method="post">
                    <input type="hidden" name="delete" value="<%=strings[0] %>">
                    <button class="layui-btn">ɾ��</button>
                </form>
            </td>
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