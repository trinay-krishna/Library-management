package com.lib;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/adminHome")
public class AdminDashboard extends HttpServlet {

    public AdminDashboard() {}

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            Connection con = DatabaseConnection.getConnection();
            Statement st = con.createStatement();
            ResultSet books = st.executeQuery("SELECT * FROM book;");

            List<Book> bookObjects = new ArrayList<>();

            while(books.next()) {
                int id = books.getInt("id");
                String name = books.getString("name");
                String genre = books.getString("genre");
                int available_quantity = books.getInt("available_quantity");

                bookObjects.add(new Book(id, name, genre, available_quantity));

            }

            req.setAttribute("books", bookObjects);
            req.getRequestDispatcher("AdminDashboard.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
