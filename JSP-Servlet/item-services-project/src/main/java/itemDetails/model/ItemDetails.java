package itemDetails.model;

public class ItemDetails {
    private Long id; 
    private String description;
    private String issueDate;
    private String expiryDate;

    public ItemDetails() {}

    public ItemDetails(Long id, String description, String issueDate, String expiryDate) {
        this.id = id;
        this.description = description;
        this.issueDate = issueDate;
        this.expiryDate = expiryDate;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getIssueDate() { return issueDate; }
    public void setIssueDate(String issueDate) { this.issueDate = issueDate; }

    public String getExpiryDate() { return expiryDate; }
    public void setExpiryDate(String expiryDate) { this.expiryDate = expiryDate; }

	public void setItemId(long long1) {
		// TODO Auto-generated method stub
		
	}

	public void setIssueDate(Object issueDate2) {
		// TODO Auto-generated method stub
		
	}

	public void setExpiryDate(Object expiryDate2) {
		// TODO Auto-generated method stub
		
	}
}