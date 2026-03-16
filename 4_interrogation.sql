-- =========================================================================
-- Step 5: Database Querying
-- Scenario: Marketing & Operations Data Extraction
-- =========================================================================

-- =========================================================================
-- CATEGORY 1: PROJECTIONS & SELECTIONS (Using LIKE, IN, BETWEEN, DISTINCT)
-- =========================================================================

-- 1. Marketing wants to find all customers registered in 2024 for an anniversary email.
SELECT last_name, first_name, email, registration_date
FROM Customer
WHERE registration_date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY registration_date DESC;

-- 2. Marketing wants to list all products containing 'wetsuit' in their description.
SELECT product_name, product_price, product_stock
FROM Product
WHERE product_desc LIKE '%wetsuit%'
ORDER BY product_price ASC;

-- 3. Operations wants to see which unique cities we are delivering to for logistics planning.
SELECT DISTINCT city 
FROM Address
ORDER BY city;

-- 4. Marketing is looking for mid-tier products priced between 50 and 200.
SELECT product_name, product_price
FROM Product
WHERE product_price BETWEEN 50 AND 200;

-- 5. Operations wants the contact info for specific management & sales staff.
SELECT employee_name, employee_role
FROM Employee
WHERE employee_role IN ('Manager', 'Product Specialist');


-- =========================================================================
-- CATEGORY 2: AGGREGATIONS (Using GROUP BY, HAVING, SUM, COUNT, AVG, MAX, MIN)
-- =========================================================================

-- 6. Marketing wants to calculate the total value of stock currently available per brand.
SELECT band_id, SUM(product_price * product_stock) AS total_inventory_value
FROM Product
GROUP BY band_id
ORDER BY total_inventory_value DESC;

-- 7. Operations wants to identify employees who manage/prepare more than 2 distinct products.
SELECT employee_id, COUNT(product_id) AS total_products_managed
FROM Product
GROUP BY employee_id
HAVING COUNT(product_id) > 2;

-- 8. Marketing wants to know the average product price for each product category.
SELECT category_id, AVG(product_price) AS average_price
FROM Product
GROUP BY category_id;

-- 9. Operations wants to see the minimum and maximum order amounts in the system.
SELECT MIN(total_amount) AS lowest_order, MAX(total_amount) AS highest_order
FROM Order_;

-- 10. Marketing wants to see which products have sold more than 1 unit total.
SELECT product_id, SUM(purchased_quantity) AS total_sold
FROM Contain
GROUP BY product_id
HAVING SUM(purchased_quantity) > 1;


-- =========================================================================
-- CATEGORY 3: JOINS (Inner, Outer, Multiple, Self/Reflexive)
-- =========================================================================

-- 11. INNER JOIN: Operations wants a list of products alongside the employee name who prepared/manages them.
SELECT p.product_name, p.product_sku, e.employee_name
FROM Product p
INNER JOIN Employee e ON p.employee_id = e.employee_id;

-- 12. LEFT OUTER JOIN: Marketing wants to find products that have NEVER been sold (no order lines).
SELECT p.product_name, p.product_sku
FROM Product p
LEFT JOIN Contain c ON p.product_id = c.product_id
WHERE c.order_id IS NULL;

-- 13. MULTIPLE JOIN: A detailed receipt view linking Orders, Customers, and Delivery City.
SELECT o.order_id, c.last_name, c.first_name, a.city, o.total_amount
FROM Order_ o
INNER JOIN Customer c ON o.customer_id = c.customer_id
INNER JOIN Address a ON o.address_id = a.address_id;

-- 14. MULTIPLE JOIN: See exactly which Brand and Category are selling in Order #1.
SELECT p.product_name, b.brand_name, cat.category_name, c.purchased_quantity
FROM Contain c
INNER JOIN Product p ON c.product_id = p.product_id
INNER JOIN Brand b ON p.band_id = b.band_id
INNER JOIN Category cat ON p.category_id = cat.category_id
WHERE c.order_id = 1;

-- 15. REFLEXIVE JOIN: Marketing wants to see Surfboards alongside their recommended accessories.
SELECT main.product_name AS Main_Product, acc.product_name AS Recommended_Accessory
FROM Be_compatible bc
INNER JOIN Product main ON bc.product_id = main.product_id
INNER JOIN Product acc ON bc.product_id_1 = acc.product_id;


-- =========================================================================
-- CATEGORY 4: NESTED QUERIES (IN, NOT IN, EXISTS, ANY, ALL)
-- =========================================================================

-- 16. NOT IN: Marketing wants to find Customers who have registered but never placed an order.
SELECT customer_id, first_name, last_name, email
FROM Customer
WHERE customer_id NOT IN (SELECT customer_id FROM Order_);

-- 17. ALL: Find the premium products that cost more than ALL wetsuits.
SELECT product_name, product_price
FROM Product
WHERE product_price > ALL (
    SELECT p.product_price 
    FROM Product p
    INNER JOIN Category c ON p.category_id = c.category_id
    WHERE c.category_name = 'Wetsuits'
);

-- 18. EXISTS: Find brands that currently have products out of stock (stock = 0).
SELECT brand_name 
FROM Brand b
WHERE EXISTS (
    SELECT 1 
    FROM Product p 
    WHERE p.band_id = b.band_id AND p.product_stock = 0
);

-- 19. IN: Marketing wants to target customers who bought a specific brand ('FCS').
SELECT DISTINCT c.first_name, c.last_name, c.email
FROM Customer c
WHERE c.customer_id IN (
    SELECT o.customer_id 
    FROM Order_ o
    INNER JOIN Contain ct ON o.order_id = ct.order_id
    INNER JOIN Product p ON ct.product_id = p.product_id
    INNER JOIN Brand b ON p.band_id = b.band_id
    WHERE b.brand_name = 'FCS'
);

-- 20. ANY: Find products that are cheaper than ANY surfboard (to recommend as add-ons).
SELECT product_name, product_price
FROM Product
WHERE category_id != 1 -- Not a surfboard itself
AND product_price < ANY (
    SELECT p.product_price 
    FROM Product p
    INNER JOIN Category c ON p.category_id = c.category_id
    WHERE c.category_name = 'Surfboards'
);