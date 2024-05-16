package observed;

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

@WebServlet(name = "timeChangeServlet")
public class BookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Connection con;
        Statement sql;
        ResultSet rs;
        try{
            con = DBUtils.getConnectDb();
            sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            HttpSession session = request.getSession();
            String name = (String) session.getAttribute("userid");
            System.out.println(name);
            String seat1_1 = request.getParameter("seat_1");
            String seat2_2 = request.getParameter("seat_2");
            String seat1 = new String(seat1_1.getBytes(StandardCharsets.ISO_8859_1),StandardCharsets.UTF_8);
            String seat2 = new String(seat2_2.getBytes(StandardCharsets.ISO_8859_1),StandardCharsets.UTF_8);
            String seat = seat1+seat2;
            System.out.println(seat);
            String date = (String) session.getAttribute("date");
            System.out.println(date);
            String end_place = (String) session.getAttribute("end");
            System.out.println(end_place);
            String start_place = (String) session.getAttribute("start");
            System.out.println(start_place);
            String start_time = (String) session.getAttribute("start_time");
            System.out.println(start_time);
            String end_time = (String) session.getAttribute("end_time");
            System.out.println(end_time);
//            String date = request.getParameter("date");
//            String end_place = request.getParameter("end_place");
//            String start_place = request.getParameter("start_place");
//            String start_time = request.getParameter("start_time");
//            String end_time = request.getParameter("end_time");
            String flightno = (String) session.getAttribute("flightno");
            System.out.println(flightno);
            rs = sql.executeQuery("select * from flight where start_time='"+start_time+"' and end_time='"+end_time
                    +"' and start='"+start_place+"' and end='"+end_place+"'");
            System.out.println(12);
            rs.next();
            String price = rs.getString("price");
            System.out.println(price);
            rs = sql.executeQuery("select * from seat where flight_no='"+flightno+"' and seat='"+seat+"'");
            rs.next();
            String status = rs.getString("status");
            String ticketno =rs.getString("ticket_no");
            System.out.println(status);
            if(status.equals("1")){
                String jieguo = "该座位已经被占用了.";
                request.setAttribute("jieguo",jieguo);
                RequestDispatcher dispatcher = request.getRequestDispatcher("jieguo.jsp");
                dispatcher.forward(request, response);
            }else {
                sql.executeUpdate("update seat set status='1' where seat='" + seat + "'");
            }
            rs = sql.executeQuery("select * from ticket_manage");
            rs.moveToInsertRow();
            rs.updateString(1,ticketno);
            rs.updateString(2,name);
            rs.updateString(3,flightno);
            rs.updateString(4,seat);
            rs.updateString(5,price);
            rs.updateString(6,date);
            rs.updateString(7,start_time);
            rs.updateString(8,end_time);
            rs.updateString(9,start_place);
            rs.updateString(10,end_place);
            rs.insertRow();

            String jieguo = "订票成功";
            request.setAttribute("jieguo",jieguo);
            RequestDispatcher dispatcher = request.getRequestDispatcher("jieguo.jsp");
            dispatcher.forward(request, response);

        }catch (SQLException e){
            String err = String.valueOf(e);
            request.setAttribute("error",err);
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("seat.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String seat1_1 = request.getParameter("seat_1");
        String seat2_2 = request.getParameter("seat_2");
        HttpSession session = request.getSession();
//        String user = (String) session.getAttribute("username");
//        if(user == null ||user.equals("")) {
//            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
//            dispatcher.forward(request, response);
//            return;
//        }
        if(seat1_1==null && seat2_2==null) {
            System.out.println("get");
            this.doGet(request, response);
        }
        else {
            System.out.println("post");
            this.doPost(request, response);
        }
    }
}
