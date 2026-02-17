package item.services.impl;
import item.model.Item;
import item.services.ItemService;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import itemDetails.services.impl.ItemDetailsServiceImpl;
import itemDetails.services.ItemDetailsService;

public class ItemServiceImpl implements ItemService {

    private final DataSource ds;
    private final ItemDetailsService detailsService;

    public ItemServiceImpl(DataSource ds) {
        this.ds = ds;
        this.detailsService = new ItemDetailsServiceImpl(ds);
    }

    @Override
    public List<Item> getAllItems() {
        List<Item> list = new ArrayList<>();
        String sql = "SELECT * FROM ITEMS WHERE deleted = 0";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapItem(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all items", e);
        }
        return list;
    }

    @Override
    public List<Item> getAllItemsWithDetails() {
        List<Item> list = new ArrayList<>();
        String sql = "SELECT i.id, i.name, i.price, i.totalNumber, i.deleted, " +
                     "d.description, d.issue_date, d.expiry_date " +
                     "FROM ITEMS i LEFT JOIN ITEM_DETAILS d ON i.id = d.item_id " +
                     "WHERE i.deleted = 0 ORDER BY i.id";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Item item = mapItem(rs);
                // map details if present
                String desc = rs.getString("description");
                if (desc != null) {
                    item.setDesc(desc);
                    Date issue = rs.getDate("issue_date");
                    if (issue != null) item.setIssueDate(issue.toString());
                    Date expiry = rs.getDate("expiry_date");
                    if (expiry != null) item.setExpiryDate(expiry.toString());
                    item.setHasDetails(true);
                } else {
                    item.setHasDetails(false);
                }
                list.add(item);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching items with details", e);
        }
        return list;
    }

    @Override
    public Item getItem(Long id) {
        String sql = "SELECT * FROM ITEMS WHERE id = ? AND deleted = 0";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapItem(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching item by id: " + id, e);
        }
        return null;
    }

    @Override
    public Item getItemWithDetails(Long id) {
        String sql = "SELECT i.*, d.description, d.issue_date, d.expiry_date " +
                     "FROM ITEMS i LEFT JOIN ITEM_DETAILS d ON i.id = d.item_id " +
                     "WHERE i.id = ? AND i.deleted = 0";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapItemWithDetails(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching item with details by id: " + id, e);
        }
        return null;
    }

    @Override
    public Item getItemByName(String name) {
        String sql = "SELECT * FROM ITEMS WHERE name = ? AND deleted = 0";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapItem(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching item by name: " + name, e);
        }
        return null;
    }

    @Override
    public void createItem(String name, double price, int totalNumber) {
        String sql = "INSERT INTO ITEMS (name, price, totalNumber) VALUES (?, ?, ?)";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setInt(3, totalNumber);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Error creating item: " + name, e);
        }
    }

    @Override
    public boolean updateItem(Long id, String name, double price, int totalNumber) {
        // تعديل: التأكد أن العنصر غير محذوف
        String checkSql = "SELECT deleted FROM ITEMS WHERE id = ?";
        String updateSql = "UPDATE ITEMS SET name=?, price=?, totalNumber=? WHERE id=? AND deleted = 0";

        try (Connection c = ds.getConnection();
             PreparedStatement checkPs = c.prepareStatement(checkSql)) {
            
            checkPs.setLong(1, id);
            try (ResultSet rs = checkPs.executeQuery()) {
                if (rs.next() && rs.getInt("deleted") == 1) {
                    return false; // العنصر محذوف
                }
            }

            try (PreparedStatement ps = c.prepareStatement(updateSql)) {
                ps.setString(1, name);
                ps.setDouble(2, price);
                ps.setInt(3, totalNumber);
                ps.setLong(4, id);
                
                return ps.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error updating item with id: " + id, e);
        }
    }

    @Override
    public boolean updateItemWithDetails(Long id, String name, double price, int totalNumber,
                                         String desc, String issueDate, String expiryDate) {
        Connection conn = null;
        try {
            conn = ds.getConnection();
            conn.setAutoCommit(false);

            // التحقق أن العنصر غير محذوف
            String checkSql = "SELECT deleted FROM ITEMS WHERE id = ?";
            try (PreparedStatement checkPs = conn.prepareStatement(checkSql)) {
                checkPs.setLong(1, id);
                try (ResultSet rs = checkPs.executeQuery()) {
                    if (rs.next() && rs.getInt("deleted") == 1) {
                        conn.rollback();
                        return false;
                    }
                }
            }

            // Update item
            String itemSql = "UPDATE ITEMS SET name=?, price=?, totalNumber=? WHERE id=? AND deleted = 0";
            try (PreparedStatement ps = conn.prepareStatement(itemSql)) {
                ps.setString(1, name);
                ps.setDouble(2, price);
                ps.setInt(3, totalNumber);
                ps.setLong(4, id);
                ps.executeUpdate();
            }

            // Update or insert details
            if (detailsService.hasDetails(id)) {
                detailsService.updateDetails(id, desc, issueDate, expiryDate);
            } else if (desc != null && !desc.trim().isEmpty()) {
                detailsService.addDetails(id, desc, issueDate, expiryDate);
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw new RuntimeException("Error updating item with details for id: " + id, e);
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public boolean deleteItem(Long id) {
        String sql = "UPDATE ITEMS SET deleted = 1 WHERE id = ? AND deleted = 0";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, id);
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try {
                    detailsService.deleteDetails(id);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean isItemExists(String name) {
        String sql = "SELECT id FROM ITEMS WHERE name = ? AND deleted = 0";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error checking if item exists: " + name, e);
        }
    }

    private Item mapItem(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setId(rs.getLong("id"));
        item.setName(rs.getString("name"));
        item.setPrice(rs.getDouble("price"));
        item.setTotalNumber(rs.getInt("totalNumber"));
        return item;
    }

    private Item mapItemWithDetails(ResultSet rs) throws SQLException {
        Item item = mapItem(rs);
        item.setDesc(rs.getString("description"));
        
        Date issueDate = rs.getDate("issue_date");
        if (issueDate != null) {
            item.setIssueDate(issueDate.toString());
        }
        
        Date expiryDate = rs.getDate("expiry_date");
        if (expiryDate != null) {
            item.setExpiryDate(expiryDate.toString());
        }
        
        item.setHasDetails(rs.getString("description") != null);
        return item;
    }
}