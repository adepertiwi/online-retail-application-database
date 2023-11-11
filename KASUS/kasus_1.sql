-- Kasus 1: 1 pelanggan membeli 3 barang yang berbeda
INSERT INTO Orders (customer_id, order_date, order_status)
VALUES
  (1, '2023-02-10', 'Menunggu Pembayaran'); 

INSERT INTO OrderDetails (order_id, product_id, quantity)
VALUES
  (LAST_INSERT_ID(), 1, 1), 
  (LAST_INSERT_ID(), 3, 2), 
  (LAST_INSERT_ID(), 5, 1); 