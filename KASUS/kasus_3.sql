-- Kasus 3: Melihat Kategori barang yang paling banyak barangnya
SELECT Categories.category_name, COUNT(Products.product_id) AS total_barang
FROM Categories
JOIN Products ON Categories.category_id = Products.category_id
GROUP BY Categories.category_id
ORDER BY total_barang DESC
LIMIT 1;