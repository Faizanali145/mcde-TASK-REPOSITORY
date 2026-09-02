--Task 29:  Find all products whose list price is above the overall average list price.

SELECT 
    product_name,
    list_price
FROM production.products
WHERE list_price > (
    SELECT AVG(list_price)
    FROM production.products
);
--Task 30:  Find customers who have never placed an order.
SELECT 
    c.first_name + ' ' + c.last_name AS customer_name
FROM sales.customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM sales.orders AS o
    WHERE o.customer_id = c.customer_id
);
--Task 32:  Find staff members who work in the store that generated the most revenue.
SELECT 
    p.product_name,
    p.list_price,
    p.category_id
FROM production.products AS p
WHERE p.list_price = (
    SELECT MAX(p2.list_price)
    FROM production.products AS p2
    WHERE p2.category_id = p.category_id
);
--Task 34:  List products that have never been ordered by any customer.
SELECT 
    p.product_name
FROM production.products AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM sales.order_items AS oi
    WHERE oi.product_id = p.product_id
);
--Task 35:  Find the customer who has spent the most money overall

SELECT TOP 1
    c.first_name + ' ' + c.last_name AS customer_name,
    SUM(
        oi.quantity * oi.list_price * (1 - oi.discount)
    ) AS total_spent
FROM sales.customers AS c
INNER JOIN sales.orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC;