-- =========================================================================
-- Step 4: Data Insertion
-- Adapted to the specific datatypes and FK relationships of the Looping LDM
-- =========================================================================

-- INSERT BRANDS (using band_id as per LDM)
INSERT INTO Brand (band_id, brand_name) VALUES
(1, 'Rip Curl'),
(2, 'Quiksilver'),
(3, 'Billabong'),
(4, 'FCS'),
(5, 'JS Industries');

-- INSERT CATEGORIES
INSERT INTO Category (category_id, category_name) VALUES
(1, 'Surfboards'),
(2, 'Wetsuits'),
(3, 'Fins'),
(4, 'Accessories');

-- INSERT EMPLOYEES
INSERT INTO Employee (employee_id, employee_name, employee_role) VALUES
(1, 'John Slater', 'Manager'),
(2, 'Alice Gilmore', 'Product Specialist'),
(3, 'Bob Machado', 'Warehouse Prep');

-- INSERT CUSTOMERS
INSERT INTO Customer (customer_id, last_name, first_name, email, phone_number, password, registration_date) VALUES
(1, 'Dupont', 'Jean', 'jean.dupont@email.com', '0601020304', 'hashedpass123', '2023-11-15'),
(2, 'Martin', 'Sophie', 'sophie.m@email.com', '0611223344', 'hashedpass456', '2024-01-10'),
(3, 'Lefebvre', 'Marc', 'marc.lef@email.com', '0699887766', 'hashedpass789', '2024-02-05'),
(4, 'Bernard', 'Lucie', 'lucie.b@email.com', '0644556677', 'hashedpass321', '2024-02-20'),
(5, 'Moreau', 'Thomas', 'tom.moreau@email.com', '0622334455', 'hashedpass654', '2024-03-01');

-- INSERT ADDRESSES
INSERT INTO Address (address_id, street, zip_code, city, country, customer_id) VALUES
(1, '10 Avenue de la Plage', '64200', 'Biarritz', 'France', 1),
(2, '5 Rue des Mouettes', '33120', 'Arcachon', 'France', 1),
(3, '15 Boulevard de l''Océan', '40150', 'Hossegor', 'France', 2),
(4, '8 Rue du Spot', '64500', 'Saint-Jean-de-Luz', 'France', 3),
(5, '22 Chemin des Dunes', '33680', 'Lacanau', 'France', 4),
(6, '3 Place de la Glisse', '64200', 'Biarritz', 'France', 5);

-- INSERT PRODUCTS (includes employee_id and band_id as per LDM)
INSERT INTO Product (product_id, product_sku, product_name, product_desc, product_price, product_stock, product_size, employee_id, band_id, category_id) VALUES
(1, 'JS-MONSTA-01', 'Monsta Box Surfboard', 'High performance shortboard', 650.00, 5, '5''10', 2, 5, 1),
(2, 'RC-WET-01', 'Flashbomb Wetsuit 4/3', 'Winter wetsuit, quick dry', 350.00, 12, 'M', 2, 1, 2),
(3, 'RC-WET-02', 'Dawn Patrol 3/2', 'Spring wetsuit', 220.00, 20, 'L', 3, 1, 2),
(4, 'FCS-FIN-01', 'FCS II Performer', 'Thruster fin set', 110.00, 30, 'Medium', 3, 4, 3),
(5, 'FCS-LEASH-01', 'FCS Essential Leash', '6ft regular leash', 35.00, 50, '6ft', 2, 4, 4),
(6, 'QK-BOARDSHORT', 'Highline Boardshorts', 'Stretch boardshorts', 65.00, 40, '32', 3, 2, 4),
(7, 'BB-PAD-01', 'Heritage Traction Pad', '3-piece tail pad', 45.00, 25, 'One Size', 3, 3, 4);

-- INSERT COMPATIBILITIES (Reflexive link Be_compatible uses product_id and product_id_1)
INSERT INTO Be_compatible (product_id, product_id_1) VALUES
(1, 4), -- Monsta Box compatible with FCS II Fins
(1, 5), -- Monsta Box compatible with FCS Leash
(1, 7); -- Monsta Box compatible with Traction Pad

-- INSERT ORDERS (total_amount is an INT as per LDM)
INSERT INTO Order_ (order_id, order_date, order_status, total_amount, address_id, customer_id) VALUES
(1, '2024-03-05', 'Delivered', 795, 1, 1),
(2, '2024-03-08', 'Shipped', 220, 3, 2),
(3, '2024-03-10', 'Processing', 110, 4, 3),
(4, '2024-03-12', 'Pending', 35, 2, 1),
(5, '2024-03-15', 'Delivered', 415, 5, 4);

-- INSERT ORDER LINES (CONTAIN)
INSERT INTO Contain (order_id, product_id, purchased_quantity, locked_unit_price) VALUES
(1, 1, 1, 650.00),
(1, 4, 1, 110.00),
(1, 5, 1, 35.00),
(2, 3, 1, 220.00),
(3, 4, 1, 110.00),
(4, 5, 1, 35.00),
(5, 2, 1, 350.00),
(5, 6, 1, 65.00);
