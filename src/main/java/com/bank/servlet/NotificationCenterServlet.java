package com.bank.servlet;

import com.bank.dao.NotificationDAO;
import com.bank.model.Notification;
import com.bank.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/notifications")
public class NotificationCenterServlet extends HttpServlet {
    private final NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Pick up flash messages set by doPost before redirect
            HttpSession session = request.getSession(false);
            if (session != null) {
                String flashSuccess = (String) session.getAttribute("flash_success");
                String flashError   = (String) session.getAttribute("flash_error");
                if (flashSuccess != null) {
                    request.setAttribute("success", flashSuccess);
                    session.removeAttribute("flash_success");
                }
                if (flashError != null) {
                    request.setAttribute("error", flashError);
                    session.removeAttribute("flash_error");
                }
            }

            String search = request.getParameter("search");
            String filter = request.getParameter("filter");

            if (search != null && search.trim().isEmpty()) search = null;
            if (filter != null && filter.trim().isEmpty()) filter = null;

            List<Notification> notifications;
            if (search != null || (filter != null && !filter.equalsIgnoreCase("all"))) {
                notifications = notificationDAO.searchNotifications(
                    search != null ? search.trim() : "",
                    filter != null ? filter : "all"
                );
            } else {
                notifications = notificationDAO.getAllNotifications();
            }

            // Counts always reflect full DB state regardless of current search/filter
            int total  = notificationDAO.getAllNotifications().size();
            int unread = notificationDAO.getUnreadNotifications().size();

            request.setAttribute("notifications", notifications);
            request.setAttribute("searchQuery",  search  != null ? search  : "");
            request.setAttribute("activeFilter", filter  != null ? filter  : "all");
            request.setAttribute("totalCount",   total);
            request.setAttribute("unreadCount",  unread);
            request.setAttribute("readCount",    total - unread);

            request.getRequestDispatcher("/jsp/notifications.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading notifications: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");
        String filter = request.getParameter("filter");

        // Build redirect URL preserving search/filter state
        String ctx = request.getContextPath();
        StringBuilder redirect = new StringBuilder(ctx + "/admin/notifications?");
        if (!ValidationUtil.isNullOrEmpty(search)) redirect.append("search=").append(java.net.URLEncoder.encode(search.trim(), "UTF-8")).append("&");
        if (!ValidationUtil.isNullOrEmpty(filter) && !filter.equalsIgnoreCase("all")) redirect.append("filter=").append(java.net.URLEncoder.encode(filter.trim(), "UTF-8")).append("&");

        HttpSession session = request.getSession(true);

        if ("mark_read".equals(action)) {
            String idStr = request.getParameter("id");
            if (!ValidationUtil.isNullOrEmpty(idStr)) {
                try {
                    notificationDAO.markAsRead(Integer.parseInt(idStr));
                } catch (NumberFormatException ignored) {}
            }

        } else if ("mark_all_read".equals(action)) {
            notificationDAO.markAllAsRead();
            session.setAttribute("flash_success", "All notifications marked as read.");

        } else if ("clear_all".equals(action)) {
            notificationDAO.deleteAllNotifications();
            session.setAttribute("flash_success", "All notifications have been cleared.");
        }

        // PRG — redirect after every POST to prevent form re-submission on refresh
        response.sendRedirect(redirect.toString());
    }
}
