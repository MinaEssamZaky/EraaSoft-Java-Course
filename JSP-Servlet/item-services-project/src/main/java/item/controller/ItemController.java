package item.controller;

import item.model.Item;
import item.services.ItemService;
import item.services.impl.ItemServiceImpl;
import itemDetails.services.ItemDetailsService;
import itemDetails.services.impl.ItemDetailsServiceImpl;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.BiFunction;

@WebServlet("/ItemController")
public class ItemController extends HttpServlet {

    @Resource(name = "jdbc/connection")
    private DataSource dataSource;
    
    private ItemService itemService;

    @Override
    public void init() throws ServletException {
        itemService = new ItemServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";
        
        Map<String, Runnable> actions = new HashMap<>();
        actions.put("edit", () -> safeExecute(req, resp, this::editItem));
        actions.put("delete", () -> safeExecute(req, resp, this::deleteItem));
        actions.put("list", () -> safeExecute(req, resp, this::listItems));
        
        actions.getOrDefault(action, () -> {
            try {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }).run();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "add";
        
        Map<String, Runnable> actions = new HashMap<>();
        actions.put("update", () -> safeExecute(req, resp, this::updateItem));
        actions.put("add", () -> safeExecute(req, resp, this::addItem));
        
        actions.getOrDefault(action, () -> {
            try {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }).run();
    }

    private void safeExecute(HttpServletRequest req, HttpServletResponse resp, 
                            BiFunction<HttpServletRequest, HttpServletResponse, String> action) {
        try {
            String result = action.apply(req, resp);
            if (result != null) {
                if (result.startsWith("redirect:")) {
                    String path = result.substring("redirect:".length());
                    if (path.startsWith(":")) path = path.substring(1);
                    resp.sendRedirect(req.getContextPath() + path);
                } else if (result.startsWith("forward:")) {
                    String path = result.substring("forward:".length());
                    if (path.startsWith(":")) path = path.substring(1);
                    req.getRequestDispatcher(path).forward(req, resp);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                sendJsonResponse(resp, "error", "An error occurred: " + e.getMessage());
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        }
    }

    private String listItems(HttpServletRequest req, HttpServletResponse resp) {
        try {
            List<Item> items = itemService.getAllItemsWithDetails();
            req.setAttribute("items", items);
            
            // الاحتفاظ برسالة النجاح إذا وجدت
            String msg = req.getParameter("msg");
            if (msg != null) {
                req.setAttribute("successMessage", msg);
            }
            
            req.getRequestDispatcher("/item/show-items.jsp").forward(req, resp);
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/item/show-items.jsp?error=" + encodeURI("Error loading items");
        }
    }

    private String editItem(HttpServletRequest req, HttpServletResponse resp) {
        try {
            Long id = parseId(req.getParameter("id"));
            if (id == null) {
                return "redirect:/ItemController?error=" + encodeURI("Invalid item ID");
            }
            
            // عند جلب عنصر فردي للاعرض/تعديل:
            Item item = itemService.getItemWithDetails(id); // <-- بدل getItem(id)
            req.setAttribute("item", item);
            return "forward:/item/update-item.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/ItemController?error=" + encodeURI("Error loading item: " + e.getMessage());
        }
    }

    private String addItem(HttpServletRequest req, HttpServletResponse resp) {
        Map<String, String> errors = validateItemInput(req);
        
        if (!errors.isEmpty()) {
            return "redirect:/item/add-item.jsp?error=" + encodeURI(errors.values().iterator().next());
        }

        String name = req.getParameter("name");
        
        try {
            if (itemService.isItemExists(name)) {
                return "redirect:/item/add-item.jsp?error=" + encodeURI("Item name already exists");
            }

            double price = Double.parseDouble(req.getParameter("price"));
            int totalNumber = Integer.parseInt(req.getParameter("totalNumber"));

            itemService.createItem(name, price, totalNumber);
            
            return "redirect:/ItemController?action=list&msg=" + encodeURI("Item added successfully");
            
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/item/add-item.jsp?error=" + encodeURI("Error adding item: " + e.getMessage());
        }
    }

    private String updateItem(HttpServletRequest req, HttpServletResponse resp) {
        try {
            Long id = parseId(req.getParameter("id"));
            if (id == null) {
                return "redirect:/ItemController?error=" + encodeURI("Invalid item ID");
            }
            
            Map<String, String> errors = validateItemInput(req);
            if (!errors.isEmpty()) {
                return "redirect:/item/update-item.jsp?id=" + id + "&error=" + encodeURI(errors.values().iterator().next());
            }

            String name = req.getParameter("name");
            double price = Double.parseDouble(req.getParameter("price"));
            int totalNumber = Integer.parseInt(req.getParameter("totalNumber"));

            Item existingItem = itemService.getItemByName(name);
            if (existingItem != null && !existingItem.getId().equals(id)) {
                return "redirect:/item/update-item.jsp?id=" + id + "&error=" + encodeURI("Item name already exists");
            }

            boolean success = itemService.updateItem(id, name, price, totalNumber);

            if (success) {
                return "redirect:/ItemController?action=list&msg=" + encodeURI("Item updated successfully");
            } else {
                return "redirect:/item/update-item.jsp?id=" + id + "&error=" + encodeURI("Failed to update item");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            String id = req.getParameter("id");
            return "redirect:/item/update-item.jsp?id=" + (id != null ? id : "") + "&error=" + encodeURI("Error: " + e.getMessage());
        }
    }

    private String deleteItem(HttpServletRequest req, HttpServletResponse resp) {
        try {
            Long id = parseId(req.getParameter("id"));
            if (id == null) {
                sendJsonResponse(resp, "error", "Invalid item ID");
                return null;
            }

            boolean deleted = itemService.deleteItem(id);

            if (deleted) {
            	return "redirect:/ItemController?action=list&msg=" 
            		       + encodeURI("Item deleted successfully");
            	} else {
                sendJsonResponse(resp, "error", "Failed to delete item");
            }

        } catch (Exception e) {
            e.printStackTrace();
            try {
                sendJsonResponse(resp, "error", "Error deleting item: " + e.getMessage());
            } catch (IOException ioe) {
                ioe.printStackTrace();
            }
        }
        return null;
    }

    private Map<String, String> validateItemInput(HttpServletRequest req) {
        Map<String, String> errors = new HashMap<>();
        
        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        String totalStr = req.getParameter("totalNumber");

        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "Name is required");
        } else if (name.trim().length() < 2) {
            errors.put("name", "Name must be at least 2 characters");
        } else if (name.trim().length() > 100) {
            errors.put("name", "Name must not exceed 100 characters");
        }

        try {
            double price = Double.parseDouble(priceStr);
            if (price < 0) {
                errors.put("price", "Price must be non-negative");
            } else if (price > 999999.99) {
                errors.put("price", "Price must not exceed 999,999.99");
            }
        } catch (NumberFormatException e) {
            errors.put("price", "Invalid price format");
        }

        try {
            int total = Integer.parseInt(totalStr);
            if (total < 0) {
                errors.put("totalNumber", "Quantity must be non-negative");
            } else if (total > 999999) {
                errors.put("totalNumber", "Quantity must not exceed 999,999");
            }
        } catch (NumberFormatException e) {
            errors.put("totalNumber", "Invalid quantity format");
        }

        return errors;
    }

    private Long parseId(String idStr) {
        try {
            return idStr != null ? Long.parseLong(idStr) : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private String encodeURI(String value) {
        try {
            return java.net.URLEncoder.encode(value, "UTF-8");
        } catch (Exception e) {
            return value;
        }
    }

    private void sendJsonResponse(HttpServletResponse resp, String status, String message) 
            throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(String.format(
            "{\"status\":\"%s\",\"message\":\"%s\"}", status, message));
    }
}