package com.lib;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/deleteBook")
public class DeleteBook extends HttpServlet {

    public DeleteBook() {}

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StringBuilder sb = new StringBuilder();
        String line = req.getReader().readLine();

        if ( line == null ) return;
        sb.append(line);

        int bookID = Integer.parseInt(sb.toString());

        try {
            Connection con = DatabaseConnection.getConnection();

            PreparedStatement deleteBook = con.prepareStatement("DELETE FROM book WHERE id=?;");
            deleteBook.setInt(1, bookID);

            deleteBook.executeUpdate();

            resp.sendRedirect("/WTLibb/adminHome");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
