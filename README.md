# 🏄‍♂️ Database Mini-Project: Surf Shop

> **Group Members:** Maxime GASCHET & Mathys CUEVAS-YIM

---

## 📋 Table of Contents

1. [Requirements Analysis](#1-requirements-analysis-step-1)
2. [Conceptual Data Model (MCD)](#2-conceptual-data-model---mcd-step-2)
3. [Logical Data Model (LDM)](#3-logical-data-model---ldm-step-3)
4. [Data Insertion Prompt](#4-data-insertion-prompt-step-4)
5. [Usage Scenario for Querying](#5-usage-scenario-for-querying-step-5)

---

## 1. Requirements Analysis (Step 1)

### 1.1. The Prompt Used (RICARDO Framework)

Here is the prompt we used to generate our database:

> You work in the field of surf selling. Your surf shop is involved in the domain of selling every type of surf accessory. It is a surf shop such as all surf shops. Take inspiration from the following https://www.mundo-surf.com/fr/. Your surf shop wants to apply MERISE to design an information system. You are responsible for the analysis part, i.e., gathering the company's requirements. It has called on a computer engineering student to carry out this project, and you must provide him with the necessary information so that he can then apply the following steps of database design and development himself. First, establish the data business rules for your surf shop in the form of a bulleted list. It must correspond to the information provided by someone who knows how the company works, but not how an information system is built. Next, based on these rules, provide a raw data dictionary with the following columns, grouped in a table: meaning of the data, type, size in number of characters or digits. There should be between 25 and 35 data items. It is used to provide additional information about each data item (size and type) but without any assumptions about how the data will be modeled later. Provide the business rules and the data dictionary.

---

### 1.2. Business Rules

| # | Business Rule |
|---|---------------|
| 1 | A customer can create multiple delivery addresses, but a specific address belongs to only one customer. |
| 2 | A customer can place multiple orders over time (or none if they just created their account). |
| 3 | An order is placed by a single, unique customer. |
| 4 | An order is delivered to a single delivery address. |
| 5 | An order contains one or more products (which form the order lines). |
| 6 | A product can be bought in several different orders. |
| 7 | Each product belongs to a single main category (e.g., Surfboards, Wetsuits, Accessories). |
| 8 | A category can group multiple products. |
| 9 | Each product is manufactured by a single brand. |
| 10 | A brand offers one or more products in the shop. |
| 11 | Some products (like a surfboard) may require other products as compatible accessories (e.g., leash, boardbag, fins). |
| 12 | A shop employee (advisor/salesperson) can prepare multiple orders. |
| 13 | An order is prepared by a single employee. |

![Data Dictionary](https://github.com/user-attachments/assets/3376a4f7-a394-4b74-a8e7-811f14e2bb54)

---

## 2. Conceptual Data Model - MCD (Step 2)

Here is the Conceptual Data Model created on Looping, complying with the **3rd Normal Form (3NF)**.

### Included Advanced Elements

| Element | Description |
|---------|-------------|
| **Weak Entity** (Relative Identification) | The `ADDRESS` entity is a weak entity relative to `CUSTOMER`. |
| **Reflexive Relationship** | The `BE_COMPATIBLE` association links products (accessories) to other products within the same table. |

<img width="1283" height="663" alt="image" src="https://github.com/user-attachments/assets/7fee0f29-d145-4331-abc7-eb76cae03df1" />


---

## 3. Logical Data Model - LDM (Step 3)

```
Customer = (customer_id INT, last_name VARCHAR(50), first_name VARCHAR(50), email VARCHAR(100), phone_number VARCHAR(15), password VARCHAR(255), registration_date DATE);
Category = (category_id INT, category_name VARCHAR(50));
Brand = (band_id INT, brand_name VARCHAR(50));
Employee = (employee_id INT, employee_name VARCHAR(50), employee_role VARCHAR(30));
Location = (zip_code VARCHAR(10), city VARCHAR(50), country VARCHAR(50));
Address = (address_id INT, street VARCHAR(150), #zip_code, #customer_id);
Order_ = (order_id INT, order_date DATE, order_status VARCHAR(20), #address_id);
Product = (product_id INT, product_sku VARCHAR(30), product_name VARCHAR(100), product_desc VARCHAR(500), product_price DECIMAL(15,2), product_stock INT, product_size VARCHAR(20), #employee_id, #band_id, #category_id);
Contain = (#order_id, #product_id, purchased_quantity INT, locked_unit_price DECIMAL(15,2));
Be_compatible = (#product_id, #product_id_1);

```

---

## 4. Data Insertion Prompt (Step 4)

To automatically generate realistic mock data for our database, we used the prompt structure outlined in Lab 1. Here is the exact prompt submitted to the Generative AI:

> Provide the insertion queries used to populate the database, whose relational model is as follows:
>
> ```
> Customer = (customer_id INT, last_name VARCHAR(50), first_name VARCHAR(50), email VARCHAR(100), phone_number VARCHAR(15), password VARCHAR(255), registration_date DATE);
> Category = (category_id INT, category_name VARCHAR(50));
> Brand = (band_id INT, brand_name VARCHAR(50));
> Employee = (employee_id INT, employee_name VARCHAR(50), employee_role VARCHAR(30));
> Location = (zip_code VARCHAR(10), city VARCHAR(50), country VARCHAR(50));
> Address = (address_id INT, street VARCHAR(150), #zip_code, #customer_id);
> Order_ = (order_id INT, order_date DATE, order_status VARCHAR(20), #address_id);
> Product = (product_id INT, product_sku VARCHAR(30), product_name VARCHAR(100), product_desc VARCHAR(500), product_price DECIMAL(15,2), product_stock INT, product_size VARCHAR(20), #employee_id, #band_id, #category_id);
> Contain = (#order_id, #product_id, purchased_quantity INT, locked_unit_price DECIMAL(15,2));
> Be_compatible = (#product_id, #product_id_1);
> ```
>
> Primary keys correspond to IDs, unless otherwise specified (when it is a composite attribute). Foreign keys are identified by `#` and have the same name as the primary keys to which they refer.

### Data Volume Requirements

| Table | Rows |
|-------|------|
| Brand | 5 |
| Location | 5 |
| Category | 4 |
| Employee | 3 |
| Customer | 5 |
| Address | 6 |
| Product | 7 |
| Order_ | 5 |
| Contain (order lines) | 8 |
| Be_compatible | 3 |

### Additional Constraints

- The shop sells **surfboards, wetsuits, leashes, and fins**.
- Data must be realistic using **real surf brand names** (Quiksilver, Rip Curl, FCS, JS Industries) and realistic prices/descriptions.
- Foreign keys must refer to existing primary keys — populate tables with no foreign keys first, then those referencing already-filled tables.
- Customers' first and last names must reflect **various origins and be mixed**.
- The data must comply with the following validation constraints:

```sql
ALTER TABLE Customer  ADD CONSTRAINT chk_customer_email     CHECK (email LIKE '%@%.%');
ALTER TABLE Product   ADD CONSTRAINT chk_product_price      CHECK (product_price > 0);
ALTER TABLE Product   ADD CONSTRAINT chk_product_stock      CHECK (product_stock >= 0);
ALTER TABLE Order_    ADD CONSTRAINT chk_order_status       CHECK (order_status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'));
ALTER TABLE Contain   ADD CONSTRAINT chk_purchased_quantity CHECK (purchased_quantity >= 1);
ALTER TABLE Contain   ADD CONSTRAINT chk_locked_price       CHECK (locked_unit_price >= 0);
```

- Provide the full set as an **SQL script ready to be executed**.

---

## 5. Usage Scenario for Querying (Step 5)

### Scenario Context: Marketing & Operations Analysis

The database is actively used by two main departments at the Surf Shop:

#### 📣 Marketing Department
They need to:
- Extract customer data to target specific cities for **localized ad campaigns**
- Understand which product categories generate the **most revenue**
- Identify products that are **frequently bought together** or **never sold**

#### 🚚 Logistics & Operations Department
They use the database to:
- Manage **employee workloads** (seeing who prepares/manages the most products)
- Track **inventory values**
- Monitor the statuses of **recent high-value orders**
- Ensure **stock is moving efficiently**

> The queries formulated in `4_interrogation.sql` are specifically designed to answer the day-to-day operational questions raised by these two departments.
