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

@WebServlet("/register")
public class Register extends HttpServlet {

    public Register() {}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");

        System.out.println(userName + ' ' + password);
        try {
            Connection con = DatabaseConnection.getConnection();

            PreparedStatement checkUser = con.prepareStatement("SELECT username FROM user WHERE username = ?;");
            checkUser.setString(1, userName);

            ResultSet userNames = checkUser.executeQuery();

            if ( userNames.next() ) {
                request.setAttribute("error", "Username already exists");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                PreparedStatement ps = con.prepareStatement("INSERT INTO user(username, password) VALUES (?, ?);");
                ps.setString(1, userName);
                ps.setString(2, password);

                ps.executeUpdate();

                request.setAttribute("error", "Registered! You may login");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
