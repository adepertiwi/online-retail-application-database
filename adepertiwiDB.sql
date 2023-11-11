SHOW DATABASES;

-- Membuat Database
CREATE DATABASE tiwiDatabase;

-- Menggunakan Database
USE tiwiDatabase;

-- Membuat Table
CREATE TABLE Categories (
  category_id INT PRIMARY KEY AUTO_INCREMENT,
  category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Products (
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(100) NOT NULL,
  product_price DECIMAL(10, 2) NOT NULL,
  category_id INT,
  FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_name VARCHAR(100) NOT NULL,
  customer_email VARCHAR(50) NOT NULL,
  customer_address VARCHAR(100) NOT NULL,
  creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  order_date DATE NOT NULL,
  order_status VARCHAR(50),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderDetails (
  orderdetail_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,
  product_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

SHOW TABLES;

-- Menambakan Data kedalam Tabel
DESC Categories;

INSERT INTO Categories (category_name)
VALUES
  ('Majalah'), ('Novel'), ('Komik'), ('Kamus'), ('Manga'),
  ('Biografi'), ('Atlas'), ('Karya Ilmiah'), ('Dongeng'), ('Antologi'),
  ('Ensiklopedi');

SELECT * FROM Categories;

DESC Products;

INSERT INTO Products (product_name, product_price, category_id)
VALUES
  ('National Geographic', 20000.00, 1),
  ('To Kill a Mockingbird', 25000.00, 2),
  ('Batman: The Killing Joke', 30000.00, 3),
  ('Oxford English Dictionary', 35000.00, 4),
  ('One Piece', 40000.00, 5),
  ('Steve Jobs', 45000.00, 6),
  ('National Geographic Atlas of the World',  50000.00, 7),
  ('A Brief History of Time',  55000.00, 8),
  ('Grimms Fairy Tales',  60000.00, 9),
  ('The Norton Anthology of English Literature',  65000.00, 10),
  ('Encyclopedia Britannica',  70000.00, 11);

SELECT * FROM Products;

DESC Customers;

INSERT INTO Customers (customer_name, customer_email, customer_address)
VALUES
  ('Shinta', 'shinta@gmail.com', 'Denpasar, Bali'),
  ('Dian', 'dian@gmail.com', 'Surabaya, Jawa Timur'),
  ('Kesawa', 'kesawa@gmail.com', 'Singaraja, Bali'),
  ('Dewa', 'dewa@gmail.com', 'Bandung, Jawa Barat'),
  ('Dyah', 'dyah@gmail.com', 'Balikpapan, Kalimantan Timur'),
  ('Ameera', 'ameera@gmail.com', 'Binjai, Sumatera Utara'),
  ('Grace', 'grace@gmail.com', 'Pekanbaru, Riau'),
  ('Naren', 'naren@gmail.com', 'Ambon, Maluku'),
  ('Adit', 'adit@gmail.com', 'Mataram, Nusa Tenggara Barat'),
  ('Aulia', 'aulia@gmail.com', 'Kupang, Nusa Tenggara Timur'),
  ('Krisna', 'krisna@gmail.com', 'Jayapura, Papua');
  
SELECT * FROM Customers;

DESC Orders;

INSERT INTO Orders (customer_id, order_date, order_status) 
VALUES
  (1, '2023-02-10', 'Menunggu Pembayaran'),
  (2, '2023-03-11', 'Dalam Pengiriman'),
  (3, '2023-04-12', 'Selesai'),
  (4, '2023-05-13', 'Menunggu Pembayaran'),
  (5, '2023-06-14', 'Dalam Pengiriman'),
  (6, '2023-07-15', 'Selesai'),
  (7, '2023-08-16', 'Menunggu Pembayaran'),
  (8, '2023-09-17', 'Dalam Pengiriman'),
  (9, '2023-10-18', 'Menunggu Pembayaran'),
  (10, '2023-11-19', 'Selesai'),
  (11, '2023-12-20', 'Dalam Pengiriman');

SELECT * FROM Orders;

-- Update Data
UPDATE Customers
SET customer_address = 'Jakarta, Indonesia'
WHERE customer_id = '1';

UPDATE Products
SET product_price = 90000.00
WHERE product_id = '1';

-- Delete Data
SELECT * FROM Customers;
DELETE FROM Customers WHERE customer_id = '11';

-- Delete Table
DROP TABLE Orders;
DROP TABLE Customers;
DROP TABLE Products;
DROP TABLE Categories;
DROP TABLE OrderDetails;

-- Delete Database
DROP DATABASE tiwiDatabase;

-- Kasus 1: 1 pelanggan membeli 3 barang yang berbeda
INSERT INTO Orders (customer_id, order_date, order_status)
VALUES
  (1, '2023-02-10', 'Menunggu Pembayaran'); 

INSERT INTO OrderDetails (order_id, product_id, quantity)
VALUES
  (LAST_INSERT_ID(), 1, 1), 
  (LAST_INSERT_ID(), 3, 2), 
  (LAST_INSERT_ID(), 5, 1); 

-- Kasus 2: Melihat 3 produk yang paling sering dibeli oleh pelanggan
SELECT Products.product_name, COUNT(OrderDetails.product_id) AS total_pembelian
FROM OrderDetails
JOIN Products ON OrderDetails.product_id = Products.product_id
GROUP BY OrderDetails.product_id
ORDER BY total_pembelian DESC
LIMIT 3;

-- Kasus 3: Melihat Kategori barang yang paling banyak barangnya
SELECT Categories.category_name, COUNT(Products.product_id) AS total_barang
FROM Categories
JOIN Products ON Categories.category_id = Products.category_id
GROUP BY Categories.category_id
ORDER BY total_barang DESC
LIMIT 1;

-- Kasus 4: Nominal rata-rata transaksi yang dilakukan oleh pelanggan dalam 1 bulan terakhir
SELECT AVG(product_price * quantity) AS rata_rata_transaksi
FROM OrderDetails
JOIN Products ON OrderDetails.product_id = Products.product_id
WHERE OrderDetails.order_id IN (
    SELECT order_id
    FROM Orders
    WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 1 DAY)
);
