package itemDetails.controller;

import itemDetails.services.ItemDetailsService;
import itemDetails.services.impl.ItemDetailsServiceImpl;
import itemDetails.model.ItemDetails;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/ItemDetailsController")
public class ItemDetailsController extends HttpServlet {

    @Resource(name = "jdbc/connection")
    private DataSource dataSource;
    private ItemDetailsService detailsService;

    @Override
    public void init() throws ServletException {
        detailsService = new ItemDetailsServiceImpl(dataSource);
    }

    private boolean isItemActive(Long itemId) {
        String sql = "SELECT deleted FROM ITEMS WHERE id = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, itemId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int deleted = rs.getInt("deleted");
                    return deleted == 0;
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String itemIdStr = req.getParameter("itemId");

        if (itemIdStr == null) {
            resp.sendRedirect(req.getContextPath() + "/ItemController");
            return;
        }

        try {
            Long itemId = Long.parseLong(itemIdStr);

            if ("delete_details".equals(action)) {
                if (!isItemActive(itemId)) {
                    resp.sendRedirect(req.getContextPath() + "/ItemController?msg=" + URLEncoder.encode("Item not found or deleted", "UTF-8"));
                    return;
                }
                boolean deleted = detailsService.deleteDetails(itemId);
                String msg = deleted ? "Details deleted successfully" : "Delete failed";
                resp.sendRedirect(req.getContextPath() + "/ItemController?msg=" + URLEncoder.encode(msg, "UTF-8"));
                return;
            }

            // عرض نموذج الإضافة/التعديل
            ItemDetails details = detailsService.getDetailsByItemId(itemId);
            req.setAttribute("details", details);
            req.setAttribute("itemId", itemId);
            req.getRequestDispatcher("/item/add-details.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/ItemController?error=" + URLEncoder.encode("Invalid Item ID", "UTF-8"));
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            try {
                Long itemId = Long.parseLong(req.getParameter("itemId"));
                if (!isItemActive(itemId)) {
                    resp.sendRedirect(req.getContextPath() + "/ItemController?msg=" + URLEncoder.encode("Item not found or deleted", "UTF-8"));
                    return;
                }
                String desc = req.getParameter("description");
                String issue = req.getParameter("issueDate");
                String expiry = req.getParameter("expiryDate");

                boolean success;
                if (detailsService.hasDetails(itemId)) {
                    success = detailsService.updateDetails(itemId, desc, issue, expiry);
                } else {
                    success = detailsService.addDetails(itemId, desc, issue, expiry);
                }

                if (success) {
                    resp.sendRedirect(req.getContextPath() + "/ItemController?msg=" + URLEncoder.encode("Details saved successfully", "UTF-8"));
                } else {
                    // إعادة التوجيه مع رسالة خطأ
                    resp.sendRedirect(req.getContextPath() + "/ItemDetailsController?itemId=" + itemId + "&error=failed");
                }
            } catch (NumberFormatException e) {
                resp.sendRedirect(req.getContextPath() + "/ItemController?error=" + URLEncoder.encode("Invalid Item ID", "UTF-8"));
            }
        }
    }
}