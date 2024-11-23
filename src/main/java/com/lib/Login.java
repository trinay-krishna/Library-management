package com.lib;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet("/login")
public class Login extends HttpServlet {

    public Login() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

    protected void doPost( HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        final String userName = request.getParameter("userName");
        final String inputPassword = request.getParameter("password");

        try {
            Connection con = DatabaseConnection.getConnection();

            PreparedStatement ps = con.prepareStatement("SELECT password, role FROM user WHERE username = ?");
            ps.setString(1, userName);

            ResultSet rs = ps.executeQuery();
            if ( rs.next() ) {
                String password = rs.getString("password");
                String role = rs.getString("role");
                if ( password.equals(inputPassword) ) {
                    if ( role.equals("user") )
                        response.sendRedirect("/WTLibb/userHome");
                    else
                        response.sendRedirect("/WTLibb/adminHome");
                } else {
                    request.setAttribute("error", "Incorrect Details");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Register first!");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }



    }

}
