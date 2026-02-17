package user.controller;

import java.io.IOException;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;
import user.model.User;
import user.services.UserAccount;
import user.services.impl.UserAccountImpl;

@WebServlet("/user/UserController")
public class UserController extends HttpServlet {

    @Resource(name = "jdbc/connection")
    private DataSource dataSource;

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        processRequest(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        processRequest(req, res);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "SignIn"; 
        try {
            switch (action) {
                case "SignUp": signUp(req, res); break;
                case "SignIn": signIn(req, res); break;
                case "GetAll": getAll(req, res); break;
                case "Update": updateUser(req, res); break;
                case "Delete": deleteUser(req, res); break;
                case "Logout": logout(req, res); break;
                default: res.getWriter().append("Invalid Action");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void signUp(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        UserAccount service = new UserAccountImpl(dataSource);

        String userName = safeTrim(req.getParameter("userName"));
        String email = safeTrim(req.getParameter("email"));
        String password = safeTrim(req.getParameter("password"));
        String phone = safeTrim(req.getParameter("phone"));

        if (userName.isEmpty()) {
            req.setAttribute("error", "Username is required");
            retainInput(req, userName, email, phone);
            req.getRequestDispatcher("/user/signUp.jsp").forward(req, res);
            return;
        }

        

        if (password.length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters");
            retainInput(req, userName, email, phone);
            req.getRequestDispatcher("/user/signUp.jsp").forward(req, res);
            return;
        }

        if (phone.length() < 10) {
            req.setAttribute("error", "Phone number must be at least 10 digits");
            retainInput(req, userName, email, phone);
            req.getRequestDispatcher("/user/signUp.jsp").forward(req, res);
            return;
        }

        User user = new User();
        user.setUserName(userName);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);

        if (service.isEmailExists(email)) {
            req.setAttribute("error", "Email already registered");
            retainInput(req, userName, email, phone);
            req.getRequestDispatcher("/user/signUp.jsp").forward(req, res);
            return;
        }

        User saved = service.signUp(user);

        if (saved !=  null) {
            res.sendRedirect(req.getContextPath() + "/user/login.jsp?msg=SignUp+Success!+Please+login.");
        } else {
            req.setAttribute("error", "Registration failed. Please try again.");
            retainInput(req, userName, email, phone);
            req.getRequestDispatcher("/user/signUp.jsp").forward(req, res);
        }
    }

    private void retainInput(HttpServletRequest req, String userName, String email, String phone) {
        req.setAttribute("userName", userName);
        req.setAttribute("email", email);
        req.setAttribute("phone", phone);
    }

    
	private void signIn(HttpServletRequest req, HttpServletResponse res) throws IOException {
        UserAccount service = new UserAccountImpl(dataSource);

        String email = safeTrim(req.getParameter("email"));
        String password = safeTrim(req.getParameter("password"));

        if (email.isEmpty() || password.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/user/login.jsp?error=Invalid+email+or+password");
            return;
        }

        User user = service.signIn(email, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("currentUser", user);
            res.sendRedirect(req.getContextPath() + "/ItemController");
        } else {
            res.sendRedirect(req.getContextPath() + "/user/login.jsp?error=Invalid+email+or+password");
        }
    }

	private String safeTrim(String value) {
	    return value == null ? "" : value.trim();
	}


	private void getAll(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            res.sendRedirect(req.getContextPath() + "/user/login.jsp?error=Please+login");
            return;
        }

        UserAccount service = new UserAccountImpl(dataSource);
        List<User> users = service.getAllUsers();

        req.setAttribute("users", users);
        req.getRequestDispatcher("/user/list-users.jsp").forward(req, res);
    }

    private void updateUser(HttpServletRequest req, HttpServletResponse res) throws IOException {
        UserAccount service = new UserAccountImpl(dataSource);

        String idStr = req.getParameter("id");
        if (idStr == null) {
            res.sendRedirect(req.getContextPath() + "/user/UserController?action=GetAll&error=Invalid+id");
            return;
        }

        long id;
        try {
            id = Long.parseLong(idStr);
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/user/UserController?action=GetAll&error=Invalid+id");
            return;
        }

        String userName = safeTrim(req.getParameter("userName"));
        String email = safeTrim(req.getParameter("email"));
        String phone = safeTrim(req.getParameter("phone"));

        if (userName.isEmpty() || email.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/user/edit-user.jsp?id=" + id + "&error=Invalid+input");
            return;
        }

        User user = new User();
        user.setUserName(userName);
        user.setEmail(email);
        user.setPhone(phone);

        boolean updated = service.updateUser(id, user);

        if (updated) {
            res.sendRedirect(req.getContextPath() + "/user/UserController?action=GetAll&msg=User+updated+successfully");
        } else {
            res.sendRedirect(req.getContextPath() + "/user/edit-user.jsp?id=" + id + "&error=Failed+to+update+user");
        }
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse res) throws IOException {
        UserAccount service = new UserAccountImpl(dataSource);
        String idStr = req.getParameter("id");
        if (idStr == null) {
            res.sendRedirect(req.getContextPath() + "/user/UserController?action=GetAll&error=Invalid+id");
            return;
        }

        long id;
        try {
            id = Long.parseLong(idStr);
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/user/UserController?action=GetAll&error=Invalid+id");
            return;
        }

        boolean deleted = service.deleteUser(id);

        if (deleted) {
            res.sendRedirect(req.getContextPath() + "/user/UserController?action=GetAll&msg=User+deleted+successfully");
        } else {
            res.sendRedirect(req.getContextPath() + "/user/UserController?action=GetAll&error=Failed+to+delete+user");
        }
    }

    private void logout(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate(); 
        }
        
        
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                cookie.setMaxAge(0);
                cookie.setPath(req.getContextPath());
                res.addCookie(cookie);
            }
        }
        
        res.sendRedirect(req.getContextPath() + "/user/login.jsp?msg=Logged+out+successfully");
    }
}
