CREATE TABLE supplier
(
 supplier_id serial PRIMARY KEY NOT NULL,
 brand text NOT NULL unique,
 address text NOT NULL,
 phone_number varchar(20) NOT NULL,
 email text NOT NULL unique,
 first_Name text NOT NULL,
 last_Name text NOT NULL,
 surname text NOT NULL,
 bank_Name text NOT NULL,
 bank_Number varchar(50) NOT NULL,
 first_Name_Recipient text NOT NULL,
 last_Name_Recipient text NOT NULL,
 surname_Recipient text NOT NULL
);
CREATE TABLE product 
(
 product_id serial PRIMARY KEY NOT NULL,
 product_Name text NOT NULL,
 category text NOT NULL,
 article varchar(50) NOT NULL unique,
 description text,
 cost_Price money NOT NULL check (cost_Price > 0),
 rec_Price money NOT NULL check (rec_Price >= cost_Price),
 best_Before_Date interval NOT NULL,
 storage_Conditions text NOT NULL
);
CREATE TABLE supply 
(
 supply_id serial PRIMARY KEY NOT NULL,
 supplier_id int REFERENCES supplier (supplier_id) NOT NULL,
 product_id int REFERENCES product (product_id) NOT NULL,
 delivery_Date date NOT NULL check (delivery_Date <= current_date),
 quantity int NOT NULL check (quantity > 0),
 unit_Price money NOT NULL (unit_Price > 0),
 total_Amount money NOT NULL (total_Amount > 0),
 invoice_Number varchar(20) NOT NULL,
 contract_Number varchar(20) NOT NULL,
 status text NOT NULL
);
CREATE TABLE characteristic
(
 characteristic_id serial PRIMARY KEY NOT NULL,
 characteristic_Name text NOT NULL,
 unit text NOT NULL
);
CREATE TABLE characteristic_product 
(
 product_id int REFERENCES product (product_id) NOT NULL,
 characteristic_id int REFERENCES characteristic (characteristic_id) NOT NULL,
 importance text NOT NULL check (importance in ('high', 'medium', 'low'))
);

