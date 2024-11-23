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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/userLibrary")
public class UserLibrary extends HttpServlet {

    public UserLibrary() {}

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userID = 1;

        try {
            Connection con = DatabaseConnection.getConnection();

            PreparedStatement getUserLibrary = con.prepareStatement("SELECT b.id, b.genre, b.name FROM book b, borrow bor WHERE bor.bookID = b.id AND bor.userID = ?;");
            getUserLibrary.setInt(1, userID);

            ResultSet bookSet = getUserLibrary.executeQuery();
            List<BookRequest> books = new ArrayList<>();

            while (bookSet.next()) {
                int bookID = bookSet.getInt("id");
                String name = bookSet.getString("name");
                String genre = bookSet.getString("genre");
                final int status = 1;

                books.add(new BookRequest(bookID, name, genre, status));

            }

            req.setAttribute("books", books);
            req.getRequestDispatcher("UserLibrary.jsp").forward(req, resp);


        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
