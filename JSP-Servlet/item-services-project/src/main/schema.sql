-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS ITEM_DETAILS;
DROP TABLE IF EXISTS ITEMS;
DROP TABLE IF EXISTS USERS;

-- Create USERS table
CREATE TABLE USERS (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userName VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(20)
);

-- Create ITEMS table
CREATE TABLE ITEMS (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    totalNumber INT NOT NULL
);

-- Create ITEM_DETAILS table with One-to-One relationship
CREATE TABLE ITEM_DETAILS (
    id INT PRIMARY KEY,
    description VARCHAR(500),
    issue_date DATE,
    expiry_date DATE,
    CONSTRAINT fk_item FOREIGN KEY (id) REFERENCES ITEMS(id) ON DELETE CASCADE,
    CONSTRAINT unique_item_detail UNIQUE (id)
);

-- Insert sample data
INSERT INTO USERS (userName, email, password, phone) VALUES 
('admin', 'admin@example.com', 'admin123', '1234567890');

INSERT INTO ITEMS (name, price, totalNumber) VALUES 
('Laptop', 999.99, 10),
('Mouse', 29.99, 50),
('Keyboard', 89.99, 30);

INSERT INTO ITEM_DETAILS (id, description, issue_date, expiry_date) VALUES 
(1, 'High performance laptop with 16GB RAM', '2024-01-01', '2025-01-01'),
(2, 'Wireless optical mouse', '2024-01-15', '2025-01-15');