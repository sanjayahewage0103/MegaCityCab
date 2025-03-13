package com.example.megacitycab.controller;

import com.example.megacitycab.dao.PaymentDAO;
import com.example.megacitycab.model.Payment;
import com.example.megacitycab.service.PaymentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminManagePaymentsServlet extends HttpServlet {
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

            // Handle viewing detailed payment information
            if ("viewDetails".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                Payment paymentDetails = paymentService.getPaymentDetails(bookingId);
                request.setAttribute("paymentDetails", paymentDetails);
                request.getRequestDispatcher("/admin-payment-details.jsp").forward(request, response);
                return;
            }

            // Handle pending payments request
            if ("pendingPayments".equals(action)) {
                double totalPendingIncome = paymentService.getTotalPendingIncome();
                List<Payment> pendingPayments = paymentService.getPendingPayments();

                request.setAttribute("totalPendingIncome", totalPendingIncome);
                request.setAttribute("pendingPayments", pendingPayments);

                request.getRequestDispatcher("/admin-pending-payments.jsp").forward(request, response);
                return;
            }

            // Handle completed payments request
            if ("completedPayments".equals(action)) {
                double totalCompletedIncome = paymentService.getTotalCompletedIncome();
                List<Payment> completedPayments = paymentService.getCompletedPayments();

                request.setAttribute("totalCompletedIncome", totalCompletedIncome);
                request.setAttribute("completedPayments", completedPayments);

                request.getRequestDispatcher("/admin-completed-payments.jsp").forward(request, response);
                return;
            }

            // Default case: Fetch all payments for admin view
            List<Payment> allPayments = paymentService.getAllPayments();
            request.setAttribute("allPayments", allPayments);

            List<Payment> pendingPayments = paymentService.getPendingPayments();
            request.setAttribute("pendingPayments", pendingPayments);

            List<Payment> completedPayments = paymentService.getCompletedPayments();
            request.setAttribute("completedPayments", completedPayments);

            double totalIncome = paymentService.getTotalIncome();
            double totalPendingIncome = paymentService.getTotalPendingIncome();
            double totalCompletedIncome = paymentService.getTotalCompletedIncome();

            request.setAttribute("totalIncome", totalIncome);
            request.setAttribute("totalPendingIncome", totalPendingIncome);
            request.setAttribute("totalCompletedIncome", totalCompletedIncome);

            request.getRequestDispatcher("/admin-manage-payments.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp?message=Database error occurred.");
        }
    }
}