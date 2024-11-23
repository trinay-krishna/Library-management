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

@WebServlet("/return")
public class Return extends HttpServlet {

    public Return() {}

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int bookID = Integer.parseInt(req.getParameter("id"));
        int userID = 1;

        try {
            Connection con = DatabaseConnection.getConnection();

            PreparedStatement ps = con.prepareStatement("SELECT * FROM book WHERE id=?;");
            ps.setInt(1, bookID);

            ResultSet book = ps.executeQuery();

            if ( !book.next() ) {
                req.setAttribute("error", "Invalid book id!");
                req.getRequestDispatcher("UserHome.jsp").forward(req, resp);
                return;
            }

            int availableQuantity = book.getInt("available_quantity");

            int newQuantity = availableQuantity + 1;

            PreparedStatement updateQuantity = con.prepareStatement("UPDATE book SET available_quantity = ? WHERE id = ?");
            updateQuantity.setInt(1, newQuantity);
            updateQuantity.setInt(2, bookID);

            updateQuantity.executeUpdate();

            PreparedStatement addTransaction = con.prepareStatement("INSERT INTO transactions(userID, bookID, action) VALUES(?, ?, 'RETURN');");
            addTransaction.setInt(1, userID);
            addTransaction.setInt(2, bookID);

            addTransaction.executeUpdate();

            PreparedStatement removeBorrow = con.prepareStatement("DELETE FROM borrow WHERE userID = ? AND bookID = ?;");
            removeBorrow.setInt(1, userID);
            removeBorrow.setInt(2, bookID);

            removeBorrow.executeUpdate();

            resp.sendRedirect("/WTLibb/userHome");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
