
-- =========================================================================
-- Step 3A: Physical Data Model (PDM) - Table Creation
-- =========================================================================

DROP TABLE IF EXISTS Be_compatible;
DROP TABLE IF EXISTS Contain;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Order_;
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Brand;
DROP TABLE IF EXISTS Employee;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    password VARCHAR(255) NOT NULL,
    registration_date DATE NOT NULL
);

CREATE TABLE Address (
    address_id INT PRIMARY KEY,
    street VARCHAR(150) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Brand (
    band_id INT PRIMARY KEY,
    brand_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    employee_role VARCHAR(30) NOT NULL
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_sku VARCHAR(30) NOT NULL UNIQUE,
    product_name VARCHAR(100) NOT NULL,
    product_desc VARCHAR(500),
    product_price DECIMAL(15,2) NOT NULL,
    product_stock INT NOT NULL,
    product_size VARCHAR(20),
    employee_id INT NOT NULL,
    band_id INT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (band_id) REFERENCES Brand(band_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Order_ (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    total_amount INT NOT NULL,
    address_id INT NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (address_id) REFERENCES Address(address_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Contain (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    purchased_quantity INT NOT NULL,
    locked_unit_price DECIMAL(15,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Order_(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Be_compatible (
    product_id INT NOT NULL,
    product_id_1 INT NOT NULL,
    PRIMARY KEY (product_id, product_id_1),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (product_id_1) REFERENCES Product(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
