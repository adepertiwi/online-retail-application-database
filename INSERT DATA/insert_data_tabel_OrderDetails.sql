-- Menambakan Data kedalam Tabel OrderDetails
INSERT INTO OrderDetails (order_id, product_id, quantity)
VALUES
  (LAST_INSERT_ID(), 1, 1), 
  (LAST_INSERT_ID(), 3, 2), 
  (LAST_INSERT_ID(), 5, 1); 