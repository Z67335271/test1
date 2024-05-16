package servlet;

import util.DBUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.*;

@WebServlet(name = "ModifyFlightServlet")
public class ModifyFlightServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection con;
            Statement sql;
            ResultSet rs;
            try {
                con = DBUtils.getConnectDb();
                sql = con.createStatement();

                String date = request.getParameter("date");
                String time1 = request.getParameter("time1");
                String time2 = request.getParameter("time2");
                String flightno = request.getParameter("flightno");
                String startplace1 = request.getParameter("start_place").trim();
                String endplace1 = request.getParameter("end_place").trim();
                String startplace = new String(startplace1.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
                String endplace = new String(endplace1.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
                String price = request.getParameter("price");
                System.out.println(startplace1+endplace1);
                System.out.println(startplace+endplace);
                String cond = "update flight set date=?,start_time=?,end_time=?,start=?,end=?,price=?  where flight_no=?";
                PreparedStatement sql2 = con.prepareStatement(cond);
                sql2.setString(1,date);
                sql2.setString(2,time1);
                sql2.setString(3,time2);
                sql2.setString(4,startplace);
                sql2.setString(5,endplace);
                sql2.setString(6,price);
                sql2.setString(7, flightno);
                sql2.executeUpdate();

                request.setAttribute("jieguo", "修改成功");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/jieguo.jsp");
                dispatcher.forward(request, response);
            } catch (SQLException ex) {
                String err = String.valueOf(ex);
                request.setAttribute("error", err);
                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            String err = String.valueOf(e);
            request.setAttribute("error", err);
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            
            Connection con;
            Statement sql;
            ResultSet rs;
            try {
                con = DBUtils.getConnectDb();
                sql = con.createStatement();
                String flightno = request.getParameter("flightno");
                System.out.println(flightno);
                rs = sql.executeQuery("select * from flight where flight_no='"+flightno+"'");
                System.out.println(1);
                rs.next();
                String date = rs.getString("date");
                String start_time = rs.getString("start_time");
                String end_time = rs.getString("end_time");
                String start = rs.getString("start");
                String end = rs.getString("end");
                String price = rs.getString("price");
                request.setAttribute("flightno", flightno);
                request.setAttribute("date", date);
                request.setAttribute("start_time", start_time);
                request.setAttribute("start", start);
                request.setAttribute("end", end);
                request.setAttribute("price",price);
                request.setAttribute("end_time",end_time);
                System.out.println(2);
                con.close();
                rs.close();
                RequestDispatcher dispatcher = request.getRequestDispatcher("flightmodify.jsp");
                dispatcher.forward(request, response);
            } catch (SQLException ex) {
                String err = String.valueOf(ex);
                request.setAttribute("error", err);
                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            String err = String.valueOf(e);
            request.setAttribute("error", err);
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }

    }


    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String date = request.getParameter("date");
        String time1 = request.getParameter("time1");
        String time2 = request.getParameter("time2");
        String flightno = request.getParameter("flightno");


        String price = request.getParameter("price");
        System.out.println(time1+time2+flightno+date+price);
        if (date != null && time1 != null && time2 != null && flightno != null && price != null) {
            System.out.println("post");
            doPost(request, response);
        }
        else {
         System.out.println("get");
            doGet(request, response);
        }
    }
}
