package com.example.megacitycab.controller;

import com.example.megacitycab.dao.PaymentDAO;
import com.example.megacitycab.model.Booking;
import com.example.megacitycab.model.Payment;
import com.example.megacitycab.service.PaymentService;
import com.example.megacitycab.util.PDFGenerator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/make-payment")
public class MakePaymentServlet extends HttpServlet {
    private PaymentService paymentService;

    @Override
    public void init() throws ServletException {
        PaymentDAO paymentDAO = new PaymentDAO();
        paymentService = new PaymentService(paymentDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if ("downloadReceipt".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));

                // Fetch booking details
                Booking booking = paymentService.getCompletedBookingDetails(bookingId);
                if (booking == null) {
                    response.sendRedirect("make-payment?error=Booking not found.");
                    return;
                }

                // Generate PDF
                byte[] pdfBytes = PDFGenerator.generateReceipt(booking);

                // Set response headers for PDF download
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=receipt_" + bookingId + ".pdf");
                response.setContentLength(pdfBytes.length);

                // Write PDF to response output stream
                response.getOutputStream().write(pdfBytes);
                response.getOutputStream().flush();
                return;
            }

            // Existing logic for fetching pending/completed payments
            int customerId = (int) request.getSession().getAttribute("customerId");

            List<Payment> pendingPayments = paymentService.getPendingPayments(customerId);
            request.setAttribute("pendingPayments", pendingPayments);

            List<Payment> paymentHistory = paymentService.getAllPaymentHistory(customerId);
            request.setAttribute("paymentHistory", paymentHistory);

            List<Payment> completedPayments = paymentService.getCompletedPayments(customerId);
            request.setAttribute("completedPayments", completedPayments);

            request.getRequestDispatcher("make-payment.jsp").forward(request, response);
        } catch (SQLException | IOException e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp?message=An error occurred.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            if ("processPayment".equals(action)) {
                String cardDetails = request.getParameter("cardDetails");

                // Validate card details
                if (cardDetails == null || cardDetails.isEmpty()) {
                    response.sendRedirect("make-payment?error=Card details are required.");
                    return;
                }

                // Process payment
                paymentService.processPayment(bookingId, cardDetails);
                response.sendRedirect("make-payment?message=Payment processed successfully.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("make-payment?error=Database error occurred.");
        } catch (IllegalArgumentException e) {
            response.sendRedirect("make-payment?error=" + e.getMessage());
        }
    }
}