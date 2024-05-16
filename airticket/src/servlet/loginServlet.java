package servlet;
import pojo.client;
import util.DBUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

public class loginServlet extends HttpServlet {
    @Override
    public void init(ServletConfig servletConfig) throws ServletException {
        super.init(servletConfig);
    }

    @Override
    public ServletConfig getServletConfig() {
        return null;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setHeader("Access-Control-Allow-Credentials","true");
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=gb2312");
        try {

            Connection con;
            Statement sql;
            ResultSet rs;
            try{
                con = DBUtils.getConnectDb();
                sql = con.createStatement();
                String str= request.getParameter("userid").trim();
                String str2 = request.getParameter("password").trim();
                if(str.length()>0 &&str2.length()>0){
                    rs = sql.executeQuery("select * from client where id='"+str+"' and password='"+str2+"'");
                    boolean m = rs.next();
                    String name = rs.getString("name");
                    String iden = rs.getString("iden");
                    if(m){
                        HttpSession session = request.getSession();
                        session.setAttribute("username",name);
                        session.setAttribute("userpwd",str2);
                        session.setAttribute("userid",str);
                        session.setAttribute("useriden",iden);
                        success(request,response,str,str2,name);
                        System.out.println(session.getAttribute("useriden"));
                        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
                        dispatcher.forward(request, response);
                    }
                }else{
                    String back = "用户名或密码出错";
                    fail(request, response,back);
                }

            }catch (SQLException e){
                String err = String.valueOf(e);
                request.setAttribute("error",err);
                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
            }
        }catch (Exception exp){
            String err = String.valueOf(exp);
            request.setAttribute("error",err);
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        response.sendRedirect("login.jsp");
    }

    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String str= request.getParameter("userid");
        String str2 = request.getParameter("password");
        System.out.println(str+"--"+str2);
        if(str==null || str2==null){
            this.doGet(request,response);
        }else {
            this.doPost(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return null;
    }

    @Override
    public void destroy() {

    }
    public void success(HttpServletRequest request,HttpServletResponse response,String userid,String password,String username){
        client clientbean = null;
        HttpSession session = request.getSession(true);
        session.setMaxInactiveInterval(30);
        try{
            clientbean = (client) session.getAttribute("clientbean");
            session.setAttribute("clientbean",clientbean);
            clientbean.setuserid(userid);
            clientbean.setuserpwd(password);
            clientbean.setusername(username);
        }catch (Exception e){
            clientbean = new client();
            session.setAttribute("clientbean",clientbean);
            clientbean.setMessage("登陆成功");
            clientbean.setuserid(userid);
            clientbean.setuserpwd(password);
            clientbean.setusername(username);
        }
    }


    public void fail(HttpServletRequest request,HttpServletResponse response,String back) throws ServletException, IOException {
        request.setAttribute("jieguo",back);
        RequestDispatcher dispatcher = request.getRequestDispatcher("jieguo.jsp");
        dispatcher.forward(request, response);
    }
}
