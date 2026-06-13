package com.bank.servlet;

import com.bank.dao.NotificationDAO;
import com.bank.model.Notification;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/admin/notifications/api")
public class NotificationServlet extends HttpServlet {
    private final NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        List<Notification> notifications = notificationDAO.getUnreadNotifications();
        
        PrintWriter out = response.getWriter();
        StringBuilder json = new StringBuilder();
        json.append("[");
        
        SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy HH:mm");
        
        for (int i = 0; i < notifications.size(); i++) {
            Notification n = notifications.get(i);
            
            // type is included in JSON for frontend icon rendering
            json.append("{");
            json.append("\"id\":").append(n.getNotificationId()).append(",");
            json.append("\"type\":\"").append(escapeJson(n.getType())).append("\",");
            json.append("\"title\":\"").append(escapeJson(n.getTitle())).append("\",");
            json.append("\"msg\":\"").append(escapeJson(n.getMessage())).append("\",");
            json.append("\"time\":\"").append(sdf.format(n.getCreatedAt())).append("\",");
            json.append("\"read\":").append(n.isRead()).append(",");
            json.append("\"link\":\"#\"");
            json.append("}");
            
            if (i < notifications.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        out.print(json.toString());
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        if ("mark_read".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    boolean success = notificationDAO.markAsRead(id);
                    out.print("{\"success\": " + success + "}");
                    return;
                } catch (NumberFormatException e) {
                    out.print("{\"success\": false, \"error\": \"Invalid ID\"}");
                    return;
                }
            }
        } else if ("clear_all".equals(action)) {
            boolean success = notificationDAO.markAllAsRead();
            out.print("{\"success\": " + success + "}");
            return;
        }
        
        out.print("{\"success\": false, \"error\": \"Invalid action\"}");
    }
    
    private String escapeJson(String data) {
        if (data == null) return "";
        return data.replace("\"", "\\\"").replace("\n", "\\n");
    }
}
