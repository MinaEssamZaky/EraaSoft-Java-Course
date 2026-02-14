package item.model;

public class Item {

    private Long id;
    private String name;
    private double price;
    private int totalNumber; 
    private String desc; 
    private String issueDate;
    private String expiryDate;
    private boolean hasDetails;

    public Item() {}

    public Item(String name, double price, int totalNumber) {
        this.name = name;
        this.price = price;
        this.totalNumber = totalNumber;
    }

    public Item(Long id, String name, double price, int totalNumber) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.totalNumber = totalNumber;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int gettotalNumber() { return totalNumber; }
    public void settotalNumber(int totalNumber) { this.totalNumber = totalNumber; }

    public String getDesc() { return desc; }
    public void setDesc(String desc) { this.desc = desc; }

    public String getIssueDate() { return issueDate; }
    public void setIssueDate(String issueDate) { this.issueDate = issueDate; }

    public String getExpiryDate() { return expiryDate; }
    public void setExpiryDate(String expiryDate) { this.expiryDate = expiryDate; }

    public boolean isHasDetails() { return hasDetails; }
    public void setHasDetails(boolean hasDetails) { this.hasDetails = hasDetails; }
}
