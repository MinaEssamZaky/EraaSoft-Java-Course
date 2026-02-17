package itemDetails.services.impl;

import itemDetails.model.ItemDetails;
import itemDetails.services.ItemDetailsService;

import javax.sql.DataSource;
import java.sql.*;
import java.time.LocalDate;

public class ItemDetailsServiceImpl implements ItemDetailsService {

    private final DataSource dataSource;

    public ItemDetailsServiceImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public boolean hasDetails(Long itemId) {
        String sql = "SELECT COUNT(*) FROM ITEM_DETAILS WHERE item_id = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, itemId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public ItemDetails getDetailsByItemId(Long itemId) {
        String sql = "SELECT id, item_id, description, issue_date, expiry_date FROM ITEM_DETAILS WHERE item_id = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, itemId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ItemDetails d = new ItemDetails();
                    d.setId(rs.getLong("id"));
                    d.setItemId(rs.getLong("item_id"));
                    d.setDescription(rs.getString("description"));
                    Date issue = rs.getDate("issue_date");
                    Date expiry = rs.getDate("expiry_date");
                    d.setIssueDate(issue != null ? issue.toLocalDate() : null);
                    d.setExpiryDate(expiry != null ? expiry.toLocalDate() : null);
                    return d;
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public boolean addDetails(Long itemId, String description, String issueStr, String expiryStr) {
        String sql = "INSERT INTO ITEM_DETAILS(item_id, description, issue_date, expiry_date) VALUES (?, ?, ?, ?)";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, itemId);
            ps.setString(2, description);
            ps.setDate(3, toSqlDate(issueStr));
            ps.setDate(4, toSqlDate(expiryStr));
            return ps.executeUpdate() == 1;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean updateDetails(Long itemId, String description, String issueStr, String expiryStr) {
        String sql = "UPDATE ITEM_DETAILS SET description = ?, issue_date = ?, expiry_date = ? WHERE item_id = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, description);
            ps.setDate(2, toSqlDate(issueStr));
            ps.setDate(3, toSqlDate(expiryStr));
            ps.setLong(4, itemId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean deleteDetails(Long itemId) {
        String sql = "DELETE FROM ITEM_DETAILS WHERE item_id = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, itemId);
            return ps.executeUpdate() >= 1;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    private Date toSqlDate(String isoDate) {
        if (isoDate == null || isoDate.trim().isEmpty()) return null;
        try {
            LocalDate ld = LocalDate.parse(isoDate); // expects yyyy-MM-dd (HTML date inputs)
            return Date.valueOf(ld);
        } catch (Exception e) {
            return null;
        }
    }
}