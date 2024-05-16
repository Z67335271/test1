package servlet;

import pojo.client;
import pojo.error;
import util.DBUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

public class registServlet extends HttpServlet {
    @Override
    public void init(ServletConfig servletConfig) throws ServletException {

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException,IOException{
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=gb2312");
        client cl = null;
        error er = null;
        try{
            cl=(client)request.getAttribute("user");
            if(cl ==  null){
                cl = new client();
                request.setAttribute("user",cl);
            }
        }catch (Exception exp){
            cl = new client();
            request.setAttribute("user",cl);
        }
        Connection con;
        Statement sql;
        ResultSet rs;
        PreparedStatement sql2;
        try{
//            连接
            con = DBUtils.getConnectDb();
            sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
//            插入用户数据
            String userid = request.getParameter("userid").trim();
            String password = request.getParameter("password").trim();
            String name = "null";
            String iden = "visitor";
//            boolean isLD = true;
//            for(int i=0;i<userid.length();i++){
//                char c=userid.charAt(i);
//                if ((c <= 'z' && c >= 'a') || (c <= 'Z' && c >= 'A') || (c <= '9' && c >= '0')) {
//                    isLD = false;
//                    break;
//                }
//            }
//            for(int i=0;i<password.length();i++){
//                char c=password.charAt(i);
//                if ((c <= 'z' && c >= 'a') || (c <= 'Z' && c >= 'A') || (c <= '9' && c >= '0')) {
//                    isLD = false;
//                    break;
//                }
//            }
            System.out.println(userid);
            try {
                rs = sql.executeQuery("select id from client where id='" + userid + "'");
                String userid2 = rs.getString("id");
                System.out.println(userid2);
                System.out.println(userid + "--" + userid2);
                if (userid.equals(userid2)) {
                    System.out.println("same user");
                    cl.setMessage("已经有存在的用户名");
                    request.setAttribute("user", cl);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("regist.jsp");
                    dispatcher.forward(request, response);
                }
            }catch (SQLException ignored){}
            System.out.println(userid+"   "+password);
            if(password.length()>0 && userid.length()>0){
                String condition = "insert into client values(?,?,?,?) ";
                sql2 = con.prepareStatement(condition);
                sql2.setString(1,userid);
                sql2.setString(2,password);
                sql2.setString(3,name);
                sql2.setString(4,iden);
                sql2.executeUpdate();
                System.out.println("regist success");
                response.sendRedirect("login.jsp");
            }else{
                String jieguo ="用户名或密码错误";
                request.setAttribute("jieguo",jieguo);
                RequestDispatcher dispatcher = request.getRequestDispatcher("jieguo.jsp");
                dispatcher.forward(request, response);
            }



        }catch (SQLException e){
            String err = String.valueOf(e);
            request.setAttribute("error",err);
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }

    }
    @Override
    public ServletConfig getServletConfig() {
        return null;
    }

    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userid = request.getParameter("userid");
        String password = request.getParameter("password");
        if(userid==null && password ==null){
            response.sendRedirect("regist.jsp");
        }else{
            this.doPost(request,response);
        }
    }

    @Override
    public String getServletInfo() {
        return null;
    }

    @Override
    public void destroy() {

    }
}
