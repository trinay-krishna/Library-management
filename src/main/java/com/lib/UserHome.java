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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/userHome")
public class UserHome extends HttpServlet {

    public UserHome() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            int userID = 1;
            Connection con = DatabaseConnection.getConnection();

            String query = "SELECT b.id, b.name, b.genre, CASE WHEN bor.userID IS NOT NULL THEN 1 ELSE 0 END AS status FROM book AS b LEFT JOIN borrow bor ON b.id = bor.bookID WHERE bor.userID = ? OR bor.userID IS NULL;";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userID);

            ResultSet books = ps.executeQuery();

            List<BookRequest> bookRequests = new ArrayList<>();

            while( books.next() ) {
                int id = books.getInt("id");
                String name = books.getString("name");
                String genre = books.getString("genre");
                int status = books.getInt("status");

                bookRequests.add(new BookRequest(id, name, genre, status));

                System.out.println(id +  " " + name + " " + genre + " " + status);
            }
            request.setAttribute("books", bookRequests);

            request.getRequestDispatcher("UserHome.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}
