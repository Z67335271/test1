package servlet;
import pojo.flight;
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
import java.util.Arrays;


@WebServlet(name = "chooseServlet")
public class chooseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        flight flightbean = new flight();
        try{
            flightbean = (flight) request.getAttribute("flightbean");
            if(flightbean == null){
                flightbean = new flight();
                request.setAttribute("flightbean",flightbean);
            }
        }catch (Exception exp){
            flightbean = new flight();
            request.setAttribute("flightbean",flightbean);
        }
        String start1 = request.getParameter("start");
        String end1 = request.getParameter("end");
        String time1 = request.getParameter("time");
        String day =time1.substring(8);
        String month = time1.substring(5,7);
        String year = time1.substring(0,4);
        int day1 = Integer.parseInt(day);
        int month1 =Integer.parseInt(month);
        int year1 = Integer.parseInt(year);
        int previous_day = day1 - 1;
        int previous_mouth =month1;
        int previous_year = year1;
        int next_day =  day1 + 1;
        int next_mouth = month1;
        int next_year = year1;
        if(previous_day==0) {
             previous_mouth = previous_mouth -1;
            if(previous_mouth ==0){
                    previous_year = previous_year -1;
            }
            previous_day = monthtodate(previous_mouth,previous_year);
        }
        String previous_month_str;
        if(previous_mouth<10){
             previous_month_str = "0"+String.valueOf(previous_mouth);
        }
        else{
             previous_month_str =String.valueOf(previous_mouth);
        }

        String previous_date = String.valueOf(previous_year)+"-"+previous_month_str+"-"+String.valueOf(previous_day);
        if(next_day==32){
            next_mouth = next_mouth +1;
            if(next_mouth == 13){
                next_year = next_year +1;
            }
        }
        String next_month_str;
        if(next_mouth<10){
            next_month_str = "0"+String.valueOf(next_mouth);
        }else{
            next_month_str = String.valueOf(next_mouth);
        }
        String next_date = String.valueOf(next_year) + "-"+next_month_str+"-"+String.valueOf(next_day);
        flightbean.setPrevious(previous_date);
        flightbean.setNext(next_date);


        String start = new String(start1.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        String end = new String(end1.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        String time = new String(time1.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

        flightbean.setDate(time);
        flightbean.setEnd(end);
        flightbean.setStart(start);
        HttpSession session = request.getSession();
        Connection con;
        Statement sql;
        ResultSet rs;
        try{
            con = DBUtils.getConnectDb();
            sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
            rs =sql.executeQuery("select * from flight where start='"+start+"' and end='"+end+"' and date='"+time+"'");
            try {
                ResultSetMetaData metaData = rs.getMetaData();
            }catch (SQLException e){
                RequestDispatcher dispatcher = request.getRequestDispatcher("choose.jsp");
                dispatcher.forward(request, response);
            }
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            rs.last();
            int rowNumber = rs.getRow();
            String [][]Record = flightbean.getRecord();
            Record = new String[rowNumber][columnCount];
            rs.beforeFirst();
            int i=0;
            while(rs.next()){
                for(int k=0;k<columnCount;k++){
                    Record[i][k] = rs.getString(k+1);
                }
                i++;
            }
            for(int i2=0;i2<i;i2++){
                String date1 = Record[i2][2].substring(0,5);
                String date2 = Record[i2][6].substring(0,5);
                Record[i2][2] = date1;
                Record[i2][6] = date2;
            }
            flightbean.setRecord(Record);
            System.out.println(Arrays.deepToString(flightbean.getRecord()));
            RequestDispatcher dispatcher = request.getRequestDispatcher("choose.jsp");
            dispatcher.forward(request, response);
        }catch(SQLException e){
            String err = String.valueOf(e);
            request.setAttribute("error",err);
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=gb2312");
        String start = request.getParameter("start");
        String end = request.getParameter("end");
        String time = request.getParameter("time");


    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String start = request.getParameter("start");
        String end = request.getParameter("end");
        String time = request.getParameter("time");
        String start1 = new String(start.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        String end1 = new String(end.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        String time1 = new String(time.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        System.out.println(start1+"->"+end1+"->"+time1);

        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("username");
        if(user == null ||user.equals("")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
            return;
        }
        doPost(request, response);
    }

    public int monthtodate(int month, int year){
        switch (month) {
            case 1:
            case 10:
            case 5:
            case 8:
            case 12:
            case 7:
            case 3:
                return 31;
            case 2:{
                if((year%4 ==0 && year%100 !=0 )|| year%400==0){
                    return 29;
                }else{
                    return 28;
                }
            }
            case 4:
            case 11:
            case 9:
            case 6:
                return 30;
        }
        return month;
    }
}


