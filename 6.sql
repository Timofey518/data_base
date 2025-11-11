CREATE TABLE supplier (
    supplier_id serial PRIMARY KEY NOT NULL,
    brand text NOT NULL UNIQUE,
    address text NOT NULL,
    phone_number varchar(20) NOT NULL,
    email text NOT NULL UNIQUE
);
CREATE TABLE supplier_bank_details (
    bank_detail_id serial PRIMARY KEY NOT NULL,
    supplier_id int REFERENCES supplier(supplier_id) NOT NULL,
    bank_name text NOT NULL,
    bank_number varchar(50) NOT NULL,
    UNIQUE(supplier_id, bank_number)
);
CREATE TABLE supplier_contacts (
    contact_id serial PRIMARY KEY NOT NULL,
    supplier_id int REFERENCES supplier(supplier_id) NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    surname text NOT NULL,
    contact_type text NOT NULL CHECK (contact_type IN ('main', 'recipient')),
    UNIQUE(supplier_id, first_name, last_name, surname, contact_type)
);
CREATE TABLE product_category (
    category_id serial PRIMARY KEY NOT NULL,
    category_name text NOT NULL UNIQUE,
    description text
);
CREATE TABLE product (
    product_id serial PRIMARY KEY NOT NULL,
    product_name text NOT NULL,
    category_id int REFERENCES product_category(category_id) NOT NULL,
    article varchar(50) NOT NULL UNIQUE,
    description text,
    cost_price numeric(10,2) NOT NULL CHECK (cost_price > 0),
    rec_price numeric(10,2) NOT NULL CHECK (rec_price >= cost_price),
    best_before_days int NOT NULL CHECK (best_before_days > 0),
    storage_conditions text NOT NULL
);
CREATE TABLE characteristic (
    characteristic_id serial PRIMARY KEY NOT NULL,
    characteristic_name text NOT NULL,
    unit text NOT NULL,
    UNIQUE(characteristic_name, unit)
);
CREATE TABLE product_characteristic (
    product_id int REFERENCES product(product_id) NOT NULL,
    characteristic_id int REFERENCES characteristic(characteristic_id) NOT NULL,
    importance text NOT NULL CHECK (importance IN ('high', 'medium', 'low')),
    PRIMARY KEY (product_id, characteristic_id)
);
CREATE TABLE supply_status (
    status_id serial PRIMARY KEY NOT NULL,
    status_name text NOT NULL UNIQUE,
    description text
);
CREATE TABLE supply (
    supply_id serial PRIMARY KEY NOT NULL,
    supplier_id int REFERENCES supplier(supplier_id) NOT NULL,
    product_id int REFERENCES product(product_id) NOT NULL,
    delivery_date date NOT NULL CHECK (delivery_date <= CURRENT_DATE),
    quantity int NOT NULL CHECK (quantity > 0),
    unit_price numeric(10,2) NOT NULL CHECK (unit_price > 0),
    invoice_number varchar(20) NOT NULL UNIQUE,
    contract_number varchar(20) NOT NULL,
    status_id int REFERENCES supply_status(status_id) NOT NULL,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP
);