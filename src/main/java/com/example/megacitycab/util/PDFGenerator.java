package com.example.megacitycab.util;

import com.example.megacitycab.model.Booking;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

public class PDFGenerator {
    public static byte[] generateReceipt(Booking booking) throws IOException {
        // Create a ByteArrayOutputStream to hold the PDF content
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        try {
            PdfWriter writer = new PdfWriter(outputStream);

            PdfDocument pdfDoc = new PdfDocument(writer);

            Document document = new Document(pdfDoc);
            document.add(new Paragraph("Booking Receipt"));
            document.add(new Paragraph("Booking ID: " + booking.getBookingId()));
            document.add(new Paragraph("Customer Name: " + booking.getCustomerName()));
            document.add(new Paragraph("Contact: " + booking.getCustomerMobile()));
            document.add(new Paragraph("Date: " + booking.getDate()));
            document.add(new Paragraph("Time: " + booking.getTime()));
            document.add(new Paragraph("Pickup Location: " + booking.getPickupLocation()));
            document.add(new Paragraph("Drop Location: " + booking.getDropLocation()));
            document.add(new Paragraph("Total Distance: " + booking.getTotalDistance() + " km"));
            document.add(new Paragraph("Vehicle Type: " + booking.getVehicleType()));
            document.add(new Paragraph("Driver Name: " + booking.getDriverName()));
            document.add(new Paragraph("Vehicle Number: " + booking.getVehicleNumber()));
            document.add(new Paragraph("Vehicle Color: " + booking.getVehicleColor()));
            document.add(new Paragraph("Payment Method: " + booking.getPaymentMethod()));
            document.add(new Paragraph("Transaction ID: " + booking.getTransactionId()));
            document.add(new Paragraph("Final Amount: $" + booking.getFinalAmount()));

            document.close();
        } catch (Exception e) {
            throw new IOException("Error generating PDF receipt", e);
        }

        return outputStream.toByteArray();
    }
}