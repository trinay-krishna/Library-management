package com.lib;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/createBook")
public class BookCreate extends HttpServlet {

    public BookCreate() {}

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("bookName");
        String genre = req.getParameter("genre");
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        try {
            Connection con = DatabaseConnection.getConnection();
            PreparedStatement createBook = con.prepareStatement("INSERT INTO book(name, genre, available_quantity) VALUES(?, ?, ?);");
            createBook.setString(1, name);
            createBook.setString(2, genre);
            createBook.setInt(3, quantity);

            createBook.executeUpdate();

            resp.sendRedirect("/WTLibb/adminHome");
        } catch (Exception e) {
            e.printStackTrace();
        }



    }
}
