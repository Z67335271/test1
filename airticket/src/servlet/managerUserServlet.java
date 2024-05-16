package servlet;

import util.DBUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;


@WebServlet(name = "manageUserServlet")
public class managerUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=gb2312");


        Connection con;
        Statement sql;
        ResultSet rs;
        try{
            con = DBUtils.getConnectDb();
            sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);

            rs = sql.executeQuery("select * from client ");
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            System.out.println(columnCount);

            rs.last();
            int rowNumber = rs.getRow();
            String [][] tableRecord= new String[rowNumber][columnCount];
            rs.beforeFirst();
            int i=0;
            while(rs.next()){
                for(int k=0;k<columnCount;k++) {
                    tableRecord[i][k] = rs.getString(k + 1);
                }
                i++;
            }

            request.setAttribute("manclientbean",tableRecord);
            request.getRequestDispatcher("manager_user.jsp").forward(request, response);

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
        HttpSession session = request.getSession();
        String user  = (String) session.getAttribute("username");
        if (user == null || user.equals("")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
            return;
        }
        doPost(request, response);
    }
}
