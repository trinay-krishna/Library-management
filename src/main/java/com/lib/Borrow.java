package com.lib;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

@WebServlet("/borrow")
public class Borrow extends HttpServlet {

    public Borrow() {}

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
            } else {
                int quantity = book.getInt("available_quantity");

                if ( quantity == 0 ) {
                    req.setAttribute("error", "Book Unavailable!");
                    req.getRequestDispatcher("UserHome.jsp").forward(req, resp);
                    return;
                }

                int newQuantity = quantity - 1;
                PreparedStatement updateQuantity = con.prepareStatement("UPDATE book SET available_quantity = ? WHERE id = ?");
                updateQuantity.setInt(1, newQuantity);
                updateQuantity.setInt(2, bookID);

                updateQuantity.executeUpdate();

                PreparedStatement insertTransaction = con.prepareStatement("INSERT INTO transactions(userID, bookID, action) VALUES(?, ?, 'BORROW');");
                insertTransaction.setInt(1, userID);
                insertTransaction.setInt(2, bookID);

                insertTransaction.executeUpdate();

                PreparedStatement insertBorrow = con.prepareStatement("INSERT INTO borrow(userID, bookID, borrowEndDate) VALUES(?, ?, ?);");
                insertBorrow.setInt(1, userID);
                insertBorrow.setInt(2, bookID);

                LocalDate currentDate = LocalDate.now();
                LocalDate borrowEndDate = currentDate.plusDays(30);


                insertBorrow.setDate(3, Date.valueOf(borrowEndDate));

                insertBorrow.executeUpdate();

                resp.sendRedirect("/WTLibb/userHome");


            }


        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
