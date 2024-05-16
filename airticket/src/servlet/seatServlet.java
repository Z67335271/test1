package servlet;

import pojo.seat;
import util.DBUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.*;


@MultipartConfig
@WebServlet(name = "seatServlet")
public class seatServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("gb2312");
        seat seatbean = new seat();
        Connection con;
        Statement sql;
        ResultSet rs;
        try {
            con = DBUtils.getConnectDb();
            sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            String date = request.getParameter("time").trim();
            String price = request.getParameter("price").trim();
            String end_place1 = request.getParameter("end_place").trim();
            String start_place1 = request.getParameter("start_place").trim();
            String start_place = new String(start_place1.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
            String end_place = new String(end_place1.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
            String start_time = request.getParameter("start_time").trim();
            String end_time = request.getParameter("end_time").trim();
            String seat1_1 = request.getParameter("seat1").trim();
            String seat2_2 = request.getParameter("seat2").trim();
            String flightno = request.getParameter("flightno").trim();

            HttpSession session = request.getSession();
            String name = (String) session.getAttribute("userid");

            String seat1 = new String(seat1_1.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
            String seat2 = new String(seat2_2.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
            String seat = seat1 + seat2;
            rs = sql.executeQuery("select status,ticket_no from seat where flight_no='" + flightno + "' and seat='" + seat + "'");
            rs.next();
            String status = rs.getString("status");
            String ticketno = rs.getString("ticket_no");
            System.out.println(status);
            System.out.println(status.equals("1"));
            if (status.equals("1")) {
                String jieguo = "该座位已经被占用了.";
                request.setAttribute("jieguo", "该座位已经被占用了");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/jieguo.jsp");
                dispatcher.forward(request, response);
                return;

            } else {
                sql.executeUpdate("update seat set status='1' where seat='" + seat + "'");
            }
            rs = sql.executeQuery("select * from ticket_manage");
            rs.moveToInsertRow();
            rs.updateString(1, ticketno);
            rs.updateString(2, name);
            rs.updateString(3, flightno);
            rs.updateString(4, seat);
            rs.updateString(5, price);
            rs.updateString(6, date);
            rs.updateString(7, start_time);
            rs.updateString(8, end_time);
            rs.updateString(9, start_place);
            rs.updateString(10, end_place);
            rs.insertRow();

            request.setAttribute("jieguo", "订票成功");
            System.out.println(request.getAttribute("jieguo"));
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jieguo.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            String err = String.valueOf(e);
            request.setAttribute("error", err);
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        seat seatbean = new seat();
        try {
            seatbean = (seat) request.getAttribute("seatbean");
            if (seatbean == null) {
                seatbean = new seat();
                request.setAttribute("seatbean", seatbean);
            }
        } catch (Exception exp) {
            seatbean = new seat();
            request.setAttribute("seatbean", seatbean);
        }
        Connection con;
        Statement sql;
        ResultSet rs;
        try {
            con = DBUtils.getConnectDb();
            sql = con.createStatement();
            String flightno = request.getParameter("flightno");
            System.out.println(flightno);
            try {
                rs = sql.executeQuery("select * from flight where flight_no='" + flightno + "'");
                rs.next();
                String starttime = rs.getString("start_time");
                String starttime1 = starttime.substring(0, 5);
                String endtime = rs.getString("end_time");
                String endtime1 = endtime.substring(0, 5);
                String start_place = rs.getString("start");
                String end_place = rs.getString("end");
                String date = rs.getString("date");
                String price = rs.getString("price");
                System.out.println(date + "  " + price + "  " + start_place + "  " + end_place + "   " + starttime1 + "   " + endtime1);

                seatbean.setDate(date);
                seatbean.setEnd(end_place);
                seatbean.setFlightno(flightno);
                seatbean.setPrice(price);
                seatbean.setStart(start_place);
                seatbean.setStarttime(starttime1);
                seatbean.setEndtime(endtime1);
                System.out.println(seatbean.getDate() + "  " + seatbean.getEnd() + "  " + seatbean.getEndtime() + "  " +
                        seatbean.getFlightno() + "   " + seatbean.getStarttime() + "   " + seatbean.getStart()+"  "+seatbean.getPrice());

                RequestDispatcher dispatcher = request.getRequestDispatcher("seat.jsp");
                dispatcher.forward(request, response);
            } catch (SQLException e) {
                String err = String.valueOf(e);
                request.setAttribute("error", err);
                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
            }


        } catch (SQLException e) {
            String err = String.valueOf(e);
            request.setAttribute("error", err);
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }

    }

    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String seat1_1 = request.getParameter("seat1");
        String seat2_2 = request.getParameter("seat2");
        String flightno = request.getParameter("flightno");
        System.out.println(flightno);
        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("username");
        if (user == null || user.equals("")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
            return;
        }
        if (seat1_1 != null && seat2_2 != null) {
            System.out.println("post");
            this.doPost(request, response);
        }else{
                System.out.println("get");
                this.doGet(request, response);
        }
    }
}
