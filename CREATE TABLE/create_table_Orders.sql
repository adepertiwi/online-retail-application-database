-- Membuat Table Orders
CREATE TABLE Orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  order_date DATE NOT NULL,
  order_status VARCHAR(50),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);