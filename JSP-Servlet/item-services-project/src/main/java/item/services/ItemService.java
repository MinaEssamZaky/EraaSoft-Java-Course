// ItemService.java
package item.services;

import java.util.List;
import item.model.Item;

public interface ItemService {
    List<Item> getAllItems();
    List<Item> getAllItemsWithDetails();
    Item getItem(Long id);
    Item getItemWithDetails(Long id);
    Item getItemByName(String name);
    void createItem(String name, double price, int total);
    boolean updateItem(Long id, String name, double price, int total);
    boolean updateItemWithDetails(Long id, String name, double price, int total, 
    String desc, String issueDate, String expiryDate);
    boolean deleteItem(Long id);
    boolean isItemExists(String name);
}