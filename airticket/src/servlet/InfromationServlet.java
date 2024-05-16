package servlet;
//import jdk.jfr.Frequency;
import pojo.client;
import pojo.error;
import util.DBUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.*;

@WebServlet(name = "infromationServlet")
public class InfromationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=gb2312");
        client cl = null;
        error er = null;
        try {
            cl = new client();
            request.setAttribute("user", cl);
        } catch (Exception exp) {
            cl = new client();
            request.setAttribute("user", cl);
        }
        try {

            Connection con;
//            Statement sql;
//            ResultSet rs;
            try {
                con = DBUtils.getConnectDb();

                //更新上传的信息
                HttpSession session = request.getSession();
                String str1 = (String) session.getAttribute("userid");
                String str2 = request.getParameter("newpwd").trim();
                String str4 = request.getParameter("newname").trim();

                String str3 = new String(str4.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
                System.out.println(str1+" "+str2+" "+str3);
                String cond = "UPDATE client SET name=?,password=? where id=?";
                PreparedStatement sql2 = con.prepareStatement(cond);
                sql2.setString(1,str3);
                sql2.setString(2,str2);
                sql2.setString(3,str1);
                sql2.executeUpdate();
                session.setAttribute("userpwd",str2);
                session.setAttribute("username",str3);
                String iden = (String) session.getAttribute("useriden");
                if(iden.equals("manager")){
                    RequestDispatcher dispatcher = request.getRequestDispatcher("manager_information.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
                if(iden.equals("visitor")){
                    RequestDispatcher dispatcher = request.getRequestDispatcher("client_information.jsp");
                    dispatcher.forward(request, response);
                }
            } catch (SQLException e) {
                String err = String.valueOf(e);
                request.setAttribute("error", err);
                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
            }

        } catch (Exception exp) {
            String err = String.valueOf(exp);
            request.setAttribute("error", err);
            RequestDispatcher dispatcher = request.getRequestDispatcher("client_information.jsp");
            dispatcher.forward(request, response);
        }
    }
        protected void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            HttpSession session = request.getSession();
            String name = (String) session.getAttribute("username");
            String password = (String) session.getAttribute("userpwd");
            String id = (String) session.getAttribute("userid");

            request.setAttribute("username",name);
            request.setAttribute("userpwd",password);
            request.setAttribute("userid",id);
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);

        }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String str2 = request.getParameter("newpwd");
        String str3 = request.getParameter("newname");
        if( str2==null && str3==null){
            this.doGet(request, response);
        }else {
            this.doPost(request, response);
        }

    }

}
