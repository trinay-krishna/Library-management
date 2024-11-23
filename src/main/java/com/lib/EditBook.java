package com.lib;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/editBook")
public class EditBook extends HttpServlet {

    public EditBook() {}

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int bookID = Integer.parseInt(req.getParameter("id"));

        try {
            Connection con = DatabaseConnection.getConnection();

            String newName = req.getParameter("bookName");
            String newGenre = req.getParameter("genre");
            int newAvailableQuantity = Integer.parseInt(req.getParameter("available_quantity"));


            PreparedStatement updateBook = con.prepareStatement("UPDATE book SET name=?, genre=?, available_quantity = ? WHERE id = ?;");
            updateBook.setString(1, newName);
            updateBook.setString(2, newGenre);
            updateBook.setInt(3, newAvailableQuantity);
            updateBook.setInt(4, bookID);

            updateBook.executeUpdate();

            resp.sendRedirect("/WTLibb/adminHome");


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
