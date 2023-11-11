-- Kasus 4: Nominal rata-rata transaksi yang dilakukan oleh pelanggan dalam 1 bulan terakhir
SELECT AVG(product_price * quantity) AS rata_rata_transaksi
FROM OrderDetails
JOIN Products ON OrderDetails.product_id = Products.product_id
WHERE OrderDetails.order_id IN (
    SELECT order_id
    FROM Orders
    WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 1 DAY)
);