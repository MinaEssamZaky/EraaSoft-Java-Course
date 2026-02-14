package item.services;

import java.util.List;
import item.model.Item;

public interface ItemService {

    List<Item> getAllItems();

    Item getItem(Long id);

    void createItem(String name, double price, int total);

    void updateItem(int id, String name, double price, int total);

    boolean deleteItem(Long id);

    boolean isItemExists(String name);
}

