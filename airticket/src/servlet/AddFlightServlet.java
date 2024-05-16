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

@WebServlet(name = "AddFlightServlet")
public class AddFlightServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{

            Connection con;
            Statement sql;
            ResultSet rs;
            try{

                con = DBUtils.getConnectDb();
                sql = con.createStatement();

                String date = request.getParameter("date");
                String time1 = request.getParameter("time1");
                String time2 = request.getParameter("time2");
                String flightno = request.getParameter("flightno");
                String startplace1 = request.getParameter("start_place");
                String endplace1 = request.getParameter("end_place");
                String startplace = new String(startplace1.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
                String endplace = new String(endplace1.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

                String price = request.getParameter("price");

                try{
                    rs = sql.executeQuery("select flight_no from flight where flight_no='"+flightno+"'");
                    String flightno2 = rs.getString("flightno");
                    if(flightno.equals(flightno2)) {
                        request.setAttribute("jieguo", "存在相同的航空号");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/jieguo.jsp");
                        dispatcher.forward(request, response);
                        return;
                    }
                }catch (SQLException ignored){}

                for(int i = 1; i<=3; i++){
                    for(int i2 = 1; i2<=5; i2++){
                        String str = flightno+"-0"+i;
                        str = str.concat(String.valueOf(i2));
                        int i3 = 64+i2;
                        String  str2 = i+"排"+(char)Integer.parseInt(String.valueOf(i3)) +"座";
                        String condition ="insert into seat values(?,?,?,?) ";
                        PreparedStatement pr = con.prepareStatement(condition);
                        pr.setString(1,flightno);
                        pr.setString(2,str2);
                        pr.setString(3,"0");
                        pr.setString(4,str);
                    pr.executeUpdate();
                    }

                }


                String cond = "insert into flight values(?,?,?,?,?,?,?) ";
                PreparedStatement sql2 = con.prepareStatement(cond);
                sql2.setString(1,flightno);
                sql2.setString(2,date);
                sql2.setString(3,time1);
                sql2.setString(4,startplace);
                sql2.setString(5,endplace);
                sql2.setString(6,price);
                sql2.setString(7,time2);

                sql2.executeUpdate();

                request.setAttribute("jieguo","增加成功");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/jieguo.jsp");
                dispatcher.forward(request, response);
            }catch (SQLException ex){
                String err = String.valueOf(ex);
                request.setAttribute("error",err);
                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
            }

        }catch (Exception e){
            String err = String.valueOf(e);
            request.setAttribute("error",err);
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String date = request.getParameter("date");
        String time1 = request.getParameter("time1");
        String time2 = request.getParameter("time2");
        String flightno = request.getParameter("flightno");
        String startplace1 = request.getParameter("start_place");
        String endplace1 = request.getParameter("end_place");
        String startplace = new String(startplace1.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        String endplace = new String(endplace1.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

        String price = request.getParameter("price");
       if(date != null && time1 != null && time2 != null && flightno != null && price != null)
            doPost(request, response);
    }
}
