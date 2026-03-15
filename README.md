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

👥 User & Staff Management
CUSTOMER (<u>customer_id</u> INT, last_name VARCHAR(50), first_name VARCHAR(50), email VARCHAR(100), phone_number VARCHAR(15), password VARCHAR(255), registration_date DATE)

EMPLOYEE (<u>employee_id</u> INT, employee_name VARCHAR(50), employee_role VARCHAR(30))

📍 Location & Logistics
ADDRESS (<u>address_id</u> INT, <u>customer_id#</u> INT, street VARCHAR(150), zip_code VARCHAR(10), city VARCHAR(50), country VARCHAR(50))

Note: Address is a weak entity dependent on Customer.

📦 Product Catalog
BRAND (<u>brand_id</u> INT, brand_name VARCHAR(50))

CATEGORY (<u>category_id</u> INT, category_name VARCHAR(50))

PRODUCT (<u>product_id</u> INT, product_sku VARCHAR(30), product_name VARCHAR(100), product_desc VARCHAR(500), product_price DECIMAL(15,2), product_stock INT, product_size VARCHAR(20), brand_id# INT, category_id# INT)

BE_COMPATIBLE (<u>main_product_id#</u> INT, <u>accessory_product_id#</u> INT)

Self-referencing relationship to manage product compatibility/accessories.

🛍️ Sales & Orders
ORDERS (<u>order_id</u> INT, order_date DATE, order_status VARCHAR(20), total_amount DECIMAL(15,2), customer_id# INT, address_id# INT, employee_id# INT)

CONTAIN (<u>order_id#</u> INT, <u>product_id#</u> INT, purchased_quantity INT, locked_unit_price DECIMAL(15,2))

The locked_unit_price ensures historical price accuracy regardless of future product price changes.

🔑 Notation Legend
<u>Underlined</u>: Primary Key (PK)

#: Foreign Key (FK)

VARCHAR(N): Variable character string with maximum length N

DECIMAL(P,S): Precise numerical value for financial data




