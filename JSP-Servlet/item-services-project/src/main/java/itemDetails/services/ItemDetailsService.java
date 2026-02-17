package itemDetails.services;

import item.model.Item;
import itemDetails.model.ItemDetails;

public interface ItemDetailsService {
    ItemDetails getDetailsByItemId(Long itemId);
    boolean addDetails(Long itemId, String description, String issueDate, String expiryDate);
    boolean updateDetails(Long itemId, String description, String issueDate, String expiryDate);
    boolean deleteDetails(Long itemId);
    boolean hasDetails(Long itemId);
}