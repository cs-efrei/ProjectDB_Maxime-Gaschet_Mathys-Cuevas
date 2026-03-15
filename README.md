Database Mini-Project: Surf Shop 🏄‍♂️

Group Members: Maxime GASCHET & Mathys CUEVAS--YIM

1. Requirements Analysis (Step 1)

1.1. The Prompt Used (RICARDO Framework)

Here is the prompt we used to generate our database:

You work in the field of surf selling. Your surf shop is involved in the domain of selling every type of surf accessory. It is a surf shop such as all surf shops . Take inspiration from the following https://www.mundo-surf.com/fr/. Your surf shop wants to apply MERISE to design an information system. You are responsible for the analysis part, i.e., gathering the company's requirements. It has called on a computer engineering student to carry out this project, and you must provide him with the necessary information so that he can then apply the following steps of database design and development himself. First, establish the data business rules for your surf shop. in the form of a bulleted list. It must correspond to the information provided by someone who knows how the company works, but not how an information system is built. Next, based on these rules, provide a raw data dictionary with the following columns, grouped in a table: meaning of the data, type, size in number of characters or digits. There should be between 25 and 35 data items. It is used to provide additional information about each data item (size and type) but without any assumptions about how the data will be modeled later. Provide the business rules and the data dictionary.

1.2. Business Rules

A customer can create multiple delivery addresses, but a specific address belongs to only one customer.

A customer can place multiple orders over time (or none if they just created their account).

An order is placed by a single, unique customer.

An order is delivered to a single delivery address.

An order contains one or more products (which form the order lines).

A product can be bought in several different orders.

Each product belongs to a single main category (e.g., Surfboards, Wetsuits, Accessories).

A category can group multiple products.

Each product is manufactured by a single brand.

A brand offers one or more products in the shop.

Some products (like a surfboard) may require other products as compatible accessories (e.g., leash, boardbag, fins).

A shop employee (advisor/salesperson) can prepare multiple orders.

An order is prepared by a single employee.

<img width="635" height="857" alt="image" src="https://github.com/user-attachments/assets/3376a4f7-a394-4b74-a8e7-811f14e2bb54" />

2. Conceptual Data Model - MCD (Step 2)

Here is the Conceptual Data Model created on Looping, complying with the 3rd Normal Form (3NF).

Included Advanced Elements:

Weak Entity (Relative Identification): The ADDRESS entity is a weak entity relative to CUSTOMER.

Reflexive Relationship: The BE_COMPATIBLE association links products (accessories) to other products within the same table.

<img width="2713" height="1038" alt="image" src="https://github.com/user-attachments/assets/e5cac6ad-39c5-4c18-9123-2bf985674b52" />


3. Logical Data Model - LDM (Step 3)

Customer = (customer_id INT, last_name VARCHAR(50), first_name VARCHAR(50), email VARCHAR(100), phone_number VARCHAR(15), password VARCHAR(255), registration_date DATE);
Address = (address_id INT, street VARCHAR(150), zip_code VARCHAR(10), city VARCHAR(50), country VARCHAR(50), #customer_id);
Order_ = (order_id INT, order_date DATE, order_status VARCHAR(20), total_amount INT, #address_id, #customer_id);
Category = (category_id INT, category_name VARCHAR(50));
Brand = (band_id INT, brand_name VARCHAR(50));
Employee = (employee_id INT, employee_name VARCHAR(50), employee_role VARCHAR(30));
Product = (product_id INT, product_sku VARCHAR(30), product_name VARCHAR(100), product_desc VARCHAR(500), product_price DECIMAL(15,2), product_stock INT, product_size VARCHAR(20), #employee_id, #band_id, #category_id);
Contain = (#order_id, #product_id, purchased_quantity INT, locked_unit_price DECIMAL(15,2));
Be_compatible = (#product_id, #product_id_1);


4. Data Insertion Prompt (Step 4)

To automatically generate realistic mock data for our database, we used the prompt structure outlined in Lab 1. Here is the exact prompt submitted to the Generative AI:

Provide the insertion queries used to populate the database, whose relational model is as follows:
Customer = (customer_id INT, last_name VARCHAR(50), first_name VARCHAR(50), email VARCHAR(100), phone_number VARCHAR(15), password VARCHAR(255), registration_date DATE); Primary Key: customer_id
Address = (address_id INT, street VARCHAR(150), zip_code VARCHAR(10), city VARCHAR(50), country VARCHAR(50), #customer_id); Primary Key: address_id
Order_ = (order_id INT, order_date DATE, order_status VARCHAR(20), total_amount INT, #address_id, #customer_id); Primary Key: order_id
Category = (category_id INT, category_name VARCHAR(50)); Primary Key: category_id
Brand = (band_id INT, brand_name VARCHAR(50)); Primary Key: band_id
Employee = (employee_id INT, employee_name VARCHAR(50), employee_role VARCHAR(30)); Primary Key: employee_id
Product = (product_id INT, product_sku VARCHAR(30), product_name VARCHAR(100), product_desc VARCHAR(500), product_price DECIMAL(15,2), product_stock INT, product_size VARCHAR(20), #employee_id, #band_id, #category_id); Primary Key: product_id
Contain = (#order_id, #product_id, purchased_quantity INT, locked_unit_price DECIMAL(15,2)); Primary Keys: order_id, product_id
Be_compatible = (#product_id, #product_id_1); Primary Keys: product_id, product_id_1

Primary keys correspond to IDs, unless otherwise specified (when it is a composite attribute). Foreign keys are identified by # and have the same name as the primary keys to which they refer.

There must be: 5 rows for the Brand table, 4 rows for Category, 3 rows for Employee, 5 rows for Customer, 6 rows for Address, 7 rows for Product, 5 rows for Order_, 8 order lines in Contain, and 3 relationships in Be_compatible.

The shop sells surfboards, wetsuits, leashes, and fins. The data must be realistic, using real surf brand names (like Quiksilver, Rip Curl, FCS, JS Industries) and realistic product prices and descriptions.

Foreign keys must refer to existing primary keys: provide the lines starting with filling in the tables in which there are no foreign keys, then the tables in which the foreign keys refer to primary keys in tables that have already been filled in.

The data must comply with the following validation constraints:
ALTER TABLE Customer ADD CONSTRAINT chk_customer_email CHECK (email LIKE '%@%.%');
ALTER TABLE Product ADD CONSTRAINT chk_product_price CHECK (product_price > 0);
ALTER TABLE Product ADD CONSTRAINT chk_product_stock CHECK (product_stock >= 0);
ALTER TABLE Order ADD CONSTRAINT chk_order_status CHECK (order_status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'));
ALTER TABLE Contain ADD CONSTRAINT chk_purchased_quantity CHECK (purchased_quantity >= 1);
ALTER TABLE Contain ADD CONSTRAINT chk_locked_price CHECK (locked_unit_price >= 0);

Make sure that the customers' first and last names refer to various origins and are mixed.
Provide the set in the form of an SQL script ready to be executed.


5. Usage Scenario for Querying (Step 5)

Scenario Context: Marketing & Operations Analysis
The database is actively used by two main departments at the Surf Shop:

The Marketing Department: They need to extract customer data to target specific cities for localized ad campaigns, understand which product categories generate the most revenue, and identify products that are frequently bought together or never sold.

The Logistics & Operations Department: They use the database to manage employee workloads (seeing who prepares/manages the most products), track inventory values, monitor the statuses of recent high-value orders, and ensure stock is moving efficiently.

The queries formulated in 4_interrogation.sql are specifically designed to answer the day-to-day operational questions raised by these two departments.


