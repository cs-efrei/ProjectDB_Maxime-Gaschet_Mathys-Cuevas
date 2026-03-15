
-- =========================================================================
-- Step 3B: Validation Constraints
-- Ensuring data integrity and applying business rules
-- =========================================================================

-- 1. Ensure email has a valid basic format (contains @ and .)
ALTER TABLE Customer
ADD CONSTRAINT chk_customer_email
CHECK (email LIKE '%_@__%.__%');

-- 2. Ensure product price is strictly positive
ALTER TABLE Product
ADD CONSTRAINT chk_product_price
CHECK (product_price > 0);

-- 3. Ensure stock cannot be negative
ALTER TABLE Product
ADD CONSTRAINT chk_product_stock
CHECK (product_stock >= 0);

-- 4. Order statuses must belong to a specific predefined list
ALTER TABLE Order_
ADD CONSTRAINT chk_order_status
CHECK (order_status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'));

-- 5. An order line must have at least 1 item purchased
ALTER TABLE Contain
ADD CONSTRAINT chk_purchased_quantity
CHECK (purchased_quantity >= 1);

-- 6. The locked unit price at the time of purchase cannot be negative
ALTER TABLE Contain
ADD CONSTRAINT chk_locked_price
CHECK (locked_unit_price >= 0);
