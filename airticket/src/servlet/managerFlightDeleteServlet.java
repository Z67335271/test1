package servlet;

import util.DBUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "managerFlightDeleteServlet")
public class managerFlightDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("gb2312");

        Connection con;
        Statement sql;
        int rs;
        try{
            con = DBUtils.getConnectDb();
            sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            String delete = request.getParameter("delete");
            System.out.println(delete);
            String condition = "delete from flight where flight_no='"+delete+"'";
            sql.executeUpdate(condition);
            condition = "delete from seat where flight_no='"+delete+"'";
            sql.executeUpdate(condition);
            condition = "delete from ticket_manage where flight_no='"+delete+"'";
            sql.executeUpdate(condition);
            request.setAttribute("jieguo","删除成功");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jieguo.jsp");
            dispatcher.forward(request, response);
        }catch (SQLException e){
            String err = String.valueOf(e);
            request.setAttribute("error",err);
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
