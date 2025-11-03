CREATE TABLE supplier 
(
 supplier_id serial PRIMARY KEY NOT NULL,
 brand text NOT NULL,
 address text NOT NULL,
 phone_number varchar(20) NOT NULL,
 email text NOT NULL,
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
 article varchar(50) NOT NULL,
 description text,
 cost_Price decimal(10, 2) NOT NULL,
 rec_Price decimal(10, 2) NOT NULL,
 best_Before_Date interval NOT NULL,
 storage_Conditions text NOT NULL
);
CREATE TABLE supply 
(
 supply_id serial PRIMARY KEY NOT NULL,
 fk_supplier_id int REFERENCES supplier (supplier_id) NOT NULL,
 fk_product_id int REFERENCES product (product_id) NOT NULL,
 delivery_Date date NOT NULL,
 quantity int NOT NULL,
 unit_Price decimal(10, 2) NOT NULL,
 total_Amount decimal(10, 2) NOT NULL,
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
 fk_product_id int REFERENCES product (product_id) NOT NULL,
 fk_characteristic_id int REFERENCES characteristic (characteristic_id) NOT NULL,
    importance text NOT NULL
);