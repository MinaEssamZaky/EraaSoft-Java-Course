package item.controller;

import item.model.Item;
import item.services.ItemService;
import item.services.impl.ItemServiceImpl;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/ItemController")
public class ItemController extends HttpServlet {

    @Resource(name = "jdbc/connection")
    private DataSource dataSource;

    private ItemService service() {
        return new ItemServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "edit":
                    edit(req, resp);
                    break;
                case "delete":
                    delete(req, resp);
                    break;
                default:
                    list(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "add";

        try {
            switch (action) {
                case "update":
                    update(req, resp);
                    break;
                default:
                    add(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        List<Item> items = service().getAllItems();
        req.setAttribute("items", items);
        req.getRequestDispatcher("/item/show-items.jsp").forward(req, resp);
    }

    private void edit(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {

        int id = Integer.parseInt(req.getParameter("id"));
        Item item = service().getItem((long) id);

        req.setAttribute("item", item);
        req.getRequestDispatcher("/item/update-item.jsp").forward(req, resp);
    }

    private void add(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {

        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        int totalNumber = Integer.parseInt(req.getParameter("totalNumber"));

        service().createItem(name, price, totalNumber);

        resp.sendRedirect(req.getContextPath()
                + "/ItemController?action=list");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {

        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        int totalNumber = Integer.parseInt(req.getParameter("totalNumber"));

        service().updateItem(id, name, price, totalNumber);

        resp.sendRedirect(req.getContextPath()
                + "/ItemController?action=list&msg=updated");
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        boolean success = service().deleteItem((long) id);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (success) {
            resp.getWriter().write("{\"status\":\"ok\",\"message\":\"Item deleted\"}");
        } else {
            resp.getWriter().write("{\"status\":\"error\",\"message\":\"Delete failed\"}");
        }
    }
}
