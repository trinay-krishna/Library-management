package com.lib;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/hi")
public class HelloServlet extends HttpServlet {

    public HelloServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().println("hello.jsp");

        request.setAttribute("name", "Mario");

        try {
            Connection con = DatabaseConnection.getConnection();

        } catch (Exception e) {
            e.printStackTrace();
        }

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("hello.jsp");
        requestDispatcher.forward(request, response);

    }
}
