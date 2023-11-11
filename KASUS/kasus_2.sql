-- Kasus 2: Melihat 3 produk yang paling sering dibeli oleh pelanggan
SELECT Products.product_name, COUNT(OrderDetails.product_id) AS total_pembelian
FROM OrderDetails
JOIN Products ON OrderDetails.product_id = Products.product_id
GROUP BY OrderDetails.product_id
ORDER BY total_pembelian DESC
LIMIT 3;