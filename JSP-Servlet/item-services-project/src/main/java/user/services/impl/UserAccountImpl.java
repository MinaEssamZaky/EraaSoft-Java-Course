package user.services.impl;

import user.model.User;
import user.services.UserAccount;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserAccountImpl implements UserAccount {

    private final DataSource ds;

    public UserAccountImpl(DataSource ds) {
        this.ds = ds;
    }

    // ================= SIGN UP =================
    @Override
    public User signUp(User user) {

        if (isEmailExists(user.getEmail())) {
            return null; // email already exists
        }

        String sql = "INSERT INTO USERS (name, email, password, phone) VALUES (?, ?, ?, ?)";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getUserName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); // لاحقًا اعمل hashing
            ps.setString(4, user.getPhone());

            int rows = ps.executeUpdate();
            if (rows == 0) return null;

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    user.setId(rs.getLong(1));
                    return user;
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    // ================= SIGN IN =================
    @Override
    public User signIn(String email, String password) {

        String sql = "SELECT id, name, email, phone FROM USERS WHERE email = ? AND password = ?";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getLong("id"));
                    u.setUserName(rs.getString("name"));
                    u.setEmail(rs.getString("email"));
                    u.setPhone(rs.getString("phone"));
                    return u;
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    // ================= GET ALL USERS =================
    @Override
    public List<User> getAllUsers() {

        List<User> list = new ArrayList<>();
        String sql = "SELECT id, name, email, phone FROM USERS";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getLong("id"));
                u.setUserName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                list.add(u);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    // ================= UPDATE USER =================
    @Override
    public boolean updateUser(Long id, User user) {

        String sql = "UPDATE USERS SET name = ?, email = ?, phone = ? WHERE id = ?";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, user.getUserName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setLong(4, id);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // ================= DELETE USER =================
    @Override
    public boolean deleteUser(Long id) {

        String sql = "DELETE FROM USERS WHERE id = ?";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setLong(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // ================= CHECK EMAIL =================
    @Override
    public boolean isEmailExists(String email) {

        String sql = "SELECT id FROM USERS WHERE email = ?";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
