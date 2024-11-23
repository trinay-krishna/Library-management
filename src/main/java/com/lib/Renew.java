package com.lib;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet("/renew")
public class Renew extends HttpServlet {

    public Renew() {}

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

            PreparedStatement borrowEndDateQuery = con.prepareStatement("SELECT borrowEndDate FROM borrow WHERE bookID = ? AND userID = ?;");
            borrowEndDateQuery.setInt(1, bookID);
            borrowEndDateQuery.setInt(2, userID);

            ResultSet rs = borrowEndDateQuery.executeQuery();

            if ( rs.next() ) {
                Date borrowEndDate = rs.getDate("borrowEndDate");

                LocalDate localBorrowEndDate = borrowEndDate.toLocalDate();

                LocalDate currentDate = LocalDate.now();

                long daysBetween = ChronoUnit.DAYS.between(currentDate, localBorrowEndDate);

                if ( daysBetween > 3 ) {
                    req.setAttribute("error", "You can only renew a book at least 3 days before the return date.");
                    req.getRequestDispatcher("UserHome.jsp").forward(req, resp);
                    return;
                }


                LocalDate newLocalBorrowEndDate = localBorrowEndDate.plusDays(30);

                Date newBorrowEndDate = Date.valueOf(newLocalBorrowEndDate);

                PreparedStatement updateBorrowEndDate = con.prepareStatement("UPDATE borrow SET borrowEndDate = ? WHERE bookID = ? AND userID = ?;");
                updateBorrowEndDate.setDate(1, newBorrowEndDate);
                updateBorrowEndDate.setInt(2, bookID);
                updateBorrowEndDate.setInt(3, userID);

                updateBorrowEndDate.executeUpdate();

                PreparedStatement addTransaction = con.prepareStatement("INSERT INTO transactions(userID, bookID, action) VALUES(?, ?, 'RENEW');");
                addTransaction.setInt(1, userID);
                addTransaction.setInt(2, bookID);

                addTransaction.executeUpdate();

                resp.sendRedirect("/WTLibb/userHome");

            } else {
                req.setAttribute("error", "Error");
                req.getRequestDispatcher("UserHome.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
