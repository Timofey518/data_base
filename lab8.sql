-- Очистка всех таблиц
DROP TABLE IF EXISTS product_characteristic;
DROP TABLE IF EXISTS supply_product;
DROP TABLE IF EXISTS characteristic;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS product_category;
DROP TABLE IF EXISTS supply;
DROP TABLE IF EXISTS supply_status;
DROP TABLE IF EXISTS supplier_bank_details;
DROP TABLE IF EXISTS supplier_contacts;
DROP TABLE IF EXISTS supplier;

/*==============================================================*/
/* Table: supplier                                              */
/*==============================================================*/
CREATE TABLE supplier (
   supplier_id          SERIAL               NOT NULL,
   brand                TEXT                 NULL,
   address              TEXT                 NULL,
   phone_number         VARCHAR(20)          NULL,
   email                TEXT                 NULL,
   CONSTRAINT PK_SUPPLIER PRIMARY KEY (supplier_id)
);

/*==============================================================*/
/* Table: supplier_contacts                                     */
/*==============================================================*/
CREATE TABLE supplier_contacts (
   contact_id           SERIAL               NOT NULL,
   supplier_id          INT4                 NULL,
   first_Name           TEXT                 NULL,
   last_Name            TEXT                 NULL,
   surname              TEXT                 NULL,
   CONSTRAINT PK_SUPPLIER_CONTACTS PRIMARY KEY (contact_id)
);

/*==============================================================*/
/* Table: supplier_bank_details                                 */
/*==============================================================*/
CREATE TABLE supplier_bank_details (
   bank_detail_id       SERIAL               NOT NULL,
   supplier_id          INT4                 NULL,
   bank_Name            TEXT                 NULL,
   bank_Number          VARCHAR(50)          NULL,
   CONSTRAINT PK_SUPPLIER_BANK_DETAILS PRIMARY KEY (bank_detail_id)
);

/*==============================================================*/
/* Table: supply_status                                         */
/*==============================================================*/
CREATE TABLE supply_status (
   status_id            SERIAL               NOT NULL,
   status_Name          TEXT                 NULL,
   description          TEXT                 NULL,
   CONSTRAINT PK_SUPPLY_STATUS PRIMARY KEY (status_id)
);

/*==============================================================*/
/* Table: product_category                                      */
/*==============================================================*/
CREATE TABLE product_category (
   category_id          SERIAL               NOT NULL,
   category_Name        TEXT                 NULL,
   description          TEXT                 NULL,
   CONSTRAINT PK_PRODUCT_CATEGORY PRIMARY KEY (category_id)
);

/*==============================================================*/
/* Table: characteristic                                        */
/*==============================================================*/
CREATE TABLE characteristic (
   characteristic_id    SERIAL               NOT NULL,
   characteristic_Name  TEXT                 NULL,
   unit                 TEXT                 NULL,
   CONSTRAINT PK_CHARACTERISTIC PRIMARY KEY (characteristic_id)
);

/*==============================================================*/
/* Table: product                                               */
/*==============================================================*/
CREATE TABLE product (
   product_id           SERIAL               NOT NULL,
   category_id          INT4                 NULL,
   product_Name         TEXT                 NULL,
   article              VARCHAR(50)          NULL,
   description          TEXT                 NULL,
   cost_Price           MONEY                NULL,
   rec_Price            MONEY                NULL,
   best_before_days     INT4                 NULL,
   storage_Conditions   TEXT                 NULL,
   CONSTRAINT PK_PRODUCT PRIMARY KEY (product_id)
);

/*==============================================================*/
/* Table: supply                                                */
/*==============================================================*/
CREATE TABLE supply (
   supply_id            SERIAL               NOT NULL,
   supplier_id          INT4                 NULL,
   status_id            INT4                 NULL,
   delivery_Date        DATE                 NULL,
   invoice_Number       VARCHAR(20)          NULL,
   contract_Number      VARCHAR(20)          NULL,
   CONSTRAINT PK_SUPPLY PRIMARY KEY (supply_id)
);

/*==============================================================*/
/* Table: supply_product                                        */
/*==============================================================*/
CREATE TABLE supply_product (
   supply_product_id    SERIAL               NOT NULL,
   supply_id            INT4                 NULL,
   product_id           INT4                 NULL,
   quantity             INT4                 NULL,
   unit_Price           MONEY                NULL,
   CONSTRAINT PK_SUPPLY_PRODUCT PRIMARY KEY (supply_product_id)
);

/*==============================================================*/
/* Table: product_characteristic                                */
/*==============================================================*/
CREATE TABLE product_characteristic (
   product_id           INT4                 NULL,
   characteristic_id    INT4                 NULL,
   importance           TEXT                 NULL
);

-- Добавление внешних ключей
ALTER TABLE supplier_contacts
   ADD CONSTRAINT FK_SUPPLIER_CONTACTS_REF_SUPPLIER FOREIGN KEY (supplier_id)
      REFERENCES supplier (supplier_id);

ALTER TABLE supplier_bank_details
   ADD CONSTRAINT FK_SUPPLIER_BANK_REF_SUPPLIER FOREIGN KEY (supplier_id)
      REFERENCES supplier (supplier_id);

ALTER TABLE supply
   ADD CONSTRAINT FK_SUPPLY_REF_SUPPLIER FOREIGN KEY (supplier_id)
      REFERENCES supplier (supplier_id);

ALTER TABLE supply
   ADD CONSTRAINT FK_SUPPLY_REF_STATUS FOREIGN KEY (status_id)
      REFERENCES supply_status (status_id);

ALTER TABLE product
   ADD CONSTRAINT FK_PRODUCT_REF_CATEGORY FOREIGN KEY (category_id)
      REFERENCES product_category (category_id);

ALTER TABLE supply_product
   ADD CONSTRAINT FK_SUPPLY_PRODUCT_REF_SUPPLY FOREIGN KEY (supply_id)
      REFERENCES supply (supply_id);

ALTER TABLE supply_product
   ADD CONSTRAINT FK_SUPPLY_PRODUCT_REF_PRODUCT FOREIGN KEY (product_id)
      REFERENCES product (product_id);

ALTER TABLE product_characteristic
   ADD CONSTRAINT FK_PROD_CHAR_REF_PRODUCT FOREIGN KEY (product_id)
      REFERENCES product (product_id);

ALTER TABLE product_characteristic
   ADD CONSTRAINT FK_PROD_CHAR_REF_CHARACTERISTIC FOREIGN KEY (characteristic_id)
      REFERENCES characteristic (characteristic_id);

INSERT INTO supply_status (status_id, status_Name, description) VALUES
(1, 'Ожидается', 'Поставка ожидает подтверждения'),
(2, 'Подтверждена', 'Поставка подтверждена поставщиком'),
(3, 'В пути', 'Товар в процессе доставки'),
(4, 'Доставлена', 'Товар получен на склад'),
(5, 'Отменена', 'Поставка отменена'),
(6, 'Частично доставлена', 'Доставлена часть товара'),
(7, 'Возврат', 'Товар возвращен поставщику'),
(8, 'Проверка качества', 'Товар на проверке качества'),
(9, 'Готов к отгрузке', 'Товар готов к отправке'),
(10, 'Задержана', 'Поставка задержана'),
(11, 'В обработке', 'Заказ в процессе обработки'),
(12, 'Упаковка', 'Товар упаковывается'),
(13, 'На таможне', 'Товар на таможенном оформлении'),
(14, 'Резерв', 'Товар зарезервирован'),
(15, 'Архив', 'Завершенная поставка');

-- Заполнение таблицы product_category
INSERT INTO product_category (category_id, category_Name, description) VALUES
(1, 'Электроника', 'Техника и электронные устройства'),
(2, 'Бытовая техника', 'Крупная и мелкая бытовая техника'),
(3, 'Мебель', 'Мебель для дома и офиса'),
(4, 'Одежда', 'Одежда и аксессуары'),
(5, 'Обувь', 'Обувь всех видов'),
(6, 'Канцелярия', 'Канцелярские товары'),
(7, 'Спорттовары', 'Спортивный инвентарь'),
(8, 'Автозапчасти', 'Запчасти для автомобилей'),
(9, 'Строительные материалы', 'Материалы для строительства'),
(10, 'Хозтовары', 'Хозяйственные товары'),
(11, 'Косметика', 'Косметика и парфюмерия'),
(12, 'Игрушки', 'Детские игрушки'),
(13, 'Книги', 'Книжная продукция'),
(14, 'Ювелирные изделия', 'Украшения и бижутерия'),
(15, 'Продукты питания', 'Пищевая продукция');
=
INSERT INTO characteristic (characteristic_id, characteristic_Name, unit) VALUES
(1, 'Вес', 'кг'),
(2, 'Объем', 'л'),
(3, 'Срок годности', 'дни'),
(4, 'Белки', 'г/100г'),
(5, 'Жиры', 'г/100г'),
(6, 'Углеводы', 'г/100г'),
(7, 'Калорийность', 'ккал'),
(8, 'Витамин C', 'мг'),
(9, 'Кальций', 'мг'),
(10, 'Железо', 'мг'),
(11, 'Размер упаковки', 'см'),
(12, 'Температура хранения', '°C'),
(13, 'Влажность', '%'),
(14, 'Кислотность', 'pH'),
(15, 'Плотность', 'г/мл'),
(16, 'Мощность', 'Вт'),
(17, 'Емкость аккумулятора', 'мАч'),
(18, 'Разрешение экрана', 'пиксели'),
(19, 'Объем памяти', 'ГБ'),
(20, 'Прочность', 'МПа');

INSERT INTO supplier (supplier_id, brand, address, phone_number, email) VALUES
(1, 'TechElectro', 'г. Москва, ул. Техническая, 15', '+7-495-111-2233', 'techelectro@mail.ru'),
(2, 'HomeComfort', 'г. Санкт-Петербург, ул. Комфортная, 22', '+7-812-222-3344', 'homecomfort@mail.ru'),
(3, 'FashionStyle', 'г. Екатеринбург, ул. Модная, 8', '+7-343-333-4455', 'fashionstyle@mail.ru'),
(4, 'AutoPartsPro', 'г. Казань, ул. Автомобильная, 33', '+7-843-444-5566', 'autopartspro@mail.ru'),
(5, 'SportMaster', 'г. Новосибирск, ул. Спортивная, 44', '+7-383-555-6677', 'sportmaster@mail.ru'),
(6, 'BuildMaterial', 'г. Ростов-на-Дону, ул. Строительная, 55', '+7-863-666-7788', 'buildmaterial@mail.ru'),
(7, 'OfficeWorld', 'г. Уфа, ул. Офисная, 66', '+7-347-777-8899', 'officeworld@mail.ru'),
(8, 'BeautyLux', 'г. Красноярск, ул. Косметическая, 77', '+7-391-888-9900', 'beautylux@mail.ru'),
(9, 'ToyLand', 'г. Воронеж, ул. Игрушечная, 88', '+7-473-999-0011', 'toyland@mail.ru'),
(10, 'BookHouse', 'г. Волгоград, ул. Книжная, 99', '+7-844-000-1122', 'bookhouse@mail.ru'),
(11, 'JewelryArt', 'г. Пермь, ул. Ювелирная, 11', '+7-342-111-2233', 'jewelryart@mail.ru'),
(12, 'FoodMarket', 'г. Краснодар, ул. Продуктовая, 12', '+7-861-222-3344', 'foodmarket@mail.ru'),
(13, 'HouseHold', 'г. Самара, ул. Хозяйственная, 13', '+7-846-333-4455', 'household@mail.ru'),
(14, 'SmartGadgets', 'г. Омск, ул. Гаджетная, 14', '+7-381-444-5566', 'smartgadgets@mail.ru'),
(15, 'EcoProducts', 'г. Тюмень, ул. Экологическая, 15', '+7-345-555-6677', 'ecoproducts@mail.ru');

INSERT INTO supplier_contacts (contact_id, supplier_id, first_Name, last_Name, surname) VALUES
(1, 1, 'Алексей', 'Иванов', 'Петрович'),
(2, 1, 'Мария', 'Смирнова', 'Алексеевна'),
(3, 2, 'Дмитрий', 'Кузнецов', 'Сергеевич'),
(4, 3, 'Ольга', 'Попова', 'Дмитриевна'),
(5, 4, 'Сергей', 'Васильев', 'Игоревич'),
(6, 5, 'Елена', 'Петрова', 'Николаевна'),
(7, 6, 'Андрей', 'Соколов', 'Викторович'),
(8, 7, 'Наталья', 'Михайлова', 'Олеговна'),
(9, 8, 'Павел', 'Федоров', 'Анатольевич'),
(10, 9, 'Ирина', 'Морозова', 'Владимировна'),
(11, 10, 'Михаил', 'Волков', 'Николаевич'),
(12, 11, 'Татьяна', 'Алексеева', 'Игоревна'),
(13, 12, 'Виктор', 'Лебедев', 'Дмитриевич'),
(14, 13, 'Юлия', 'Семенова', 'Васильевна'),
(15, 14, 'Артем', 'Павлов', 'Олегович');

INSERT INTO supplier_bank_details (bank_detail_id, supplier_id, bank_Name, bank_Number) VALUES
(1, 1, 'Сбербанк', '40702810100000012345'),
(2, 2, 'ВТБ', '40702810200000023456'),
(3, 3, 'Альфа-Банк', '40702810300000034567'),
(4, 4, 'Газпромбанк', '40702810400000045678'),
(5, 5, 'Открытие', '40702810500000056789'),
(6, 6, 'Райффайзенбанк', '40702810600000067890'),
(7, 7, 'Тинькофф', '40702810700000078901'),
(8, 8, 'Промсвязьбанк', '40702810800000089012'),
(9, 9, 'Россельхозбанк', '40702810900000090123'),
(10, 10, 'Совкомбанк', '40702811000000001234'),
(11, 11, 'ЮниКредит Банк', '40702811100000012345'),
(12, 12, 'Росбанк', '40702811200000023456'),
(13, 13, 'МКБ', '40702811300000034567'),
(14, 14, 'Ак Барс', '40702811400000045678'),
(15, 15, 'Банк Уралсиб', '40702811500000056789');

INSERT INTO product (product_id, category_id, product_Name, article, description, cost_Price, rec_Price, best_before_days, storage_Conditions) VALUES
(1, 1, 'Смартфон Samsung Galaxy', 'PHN001', 'Флагманский смартфон 128ГБ', 45000.00, 65000.00, NULL, 'Комнатная температура'),
(2, 1, 'Ноутбук ASUS ROG', 'LTP001', 'Игровой ноутбук 16ГБ RAM', 75000.00, 105000.00, NULL, 'Сухое помещение'),
(3, 1, 'Наушники Sony WH-1000XM4', 'AUD001', 'Беспроводные наушники с шумоподавлением', 15000.00, 22000.00, NULL, 'Защита от влаги'),

(4, 2, 'Холодильник LG', 'FRG001', 'Двухкамерный холодильник с No Frost', 35000.00, 52000.00, NULL, 'Защита от прямых солнечных лучей'),
(5, 2, 'Стиральная машина Bosch', 'WMH001', 'Стиральная машина с сушкой', 28000.00, 42000.00, NULL, 'Сухое помещение'),

(6, 3, 'Офисное кресло Ergohuman', 'CHR001', 'Эргономичное офисное кресло', 12000.00, 19000.00, NULL, 'Сухое помещение'),
(7, 3, 'Диван угловой', 'SOF001', 'Угловой диван с механизмом трансформации', 25000.00, 38000.00, NULL, 'Защита от влаги'),

(8, 4, 'Куртка зимняя Canada Goose', 'JKT001', 'Пуховая куртка для холодной погоды', 35000.00, 55000.00, NULL, 'Чехол для хранения'),
(9, 4, 'Джинсы Levi''s 501', 'JNS001', 'Классические джинсы прямого кроя', 4000.00, 7000.00, NULL, 'Защита от моли'),

(10, 5, 'Кроссовки Nike Air Max', 'SHO001', 'Беговые кроссовки с воздушной подушкой', 6000.00, 9500.00, NULL, 'Сухое место'),

(11, 15, 'Лосось слабосоленый', 'FISH001', 'Филе лосося холодного копчения', 1200.00, 1900.00, 30, '+2°C +6°C'),
(12, 15, 'Сыр Пармезан', 'CHS001', 'Выдержанный итальянский сыр 24 месяца', 1800.00, 2800.00, 365, '+4°C +8°C'),
(13, 15, 'Икра красная', 'CAV001', 'Икра лососевая зернистая', 2800.00, 4200.00, 180, '+2°C +6°C'),
(14, 15, 'Кофе зерновой Lavazza', 'COF001', 'Кофе в зернах 100% арабика', 800.00, 1300.00, 365, 'Сухое место'),
(15, 15, 'Шоколад Lindt Excellence', 'CHC001', 'Швейцарский темный шоколад 85%', 300.00, 550.00, 365, '+18°C +22°C');

INSERT INTO supply (supply_id, supplier_id, status_id, delivery_Date, invoice_Number, contract_Number) VALUES
(1, 1, 4, '2024-01-15', 'INV-2024-001', 'ДГ-2024-001'),
(2, 2, 3, '2024-01-18', 'INV-2024-002', 'ДГ-2024-002'),
(3, 3, 2, '2024-01-20', 'INV-2024-003', 'ДГ-2024-003'),
(4, 4, 4, '2024-01-22', 'INV-2024-004', 'ДГ-2024-004'),
(5, 5, 1, '2024-01-25', 'INV-2024-005', 'ДГ-2024-005'),
(6, 6, 4, '2024-01-28', 'INV-2024-006', 'ДГ-2024-006'),
(7, 7, 6, '2024-02-01', 'INV-2024-007', 'ДГ-2024-007'),
(8, 8, 4, '2024-02-05', 'INV-2024-008', 'ДГ-2024-008'),
(9, 9, 5, '2024-02-08', 'INV-2024-009', 'ДГ-2024-009'),
(10, 10, 4, '2024-02-12', 'INV-2024-010', 'ДГ-2024-010'),
(11, 11, 3, '2024-02-15', 'INV-2024-011', 'ДГ-2024-011'),
(12, 12, 4, '2024-02-18', 'INV-2024-012', 'ДГ-2024-012'),
(13, 13, 2, '2024-02-20', 'INV-2024-013', 'ДГ-2024-013'),
(14, 14, 4, '2024-02-22', 'INV-2024-014', 'ДГ-2024-014'),
(15, 15, 1, '2024-02-25', 'INV-2024-015', 'ДГ-2024-015');

INSERT INTO supply_product (supply_product_id, supply_id, product_id, quantity, unit_Price) VALUES
(1, 1, 1, 50, 45000.00),
(2, 1, 2, 20, 75000.00),
(3, 2, 3, 100, 15000.00),
(4, 3, 4, 15, 35000.00),
(5, 4, 5, 25, 28000.00),
(6, 5, 6, 40, 12000.00),
(7, 6, 7, 12, 25000.00),
(8, 7, 8, 30, 35000.00),
(9, 8, 9, 80, 4000.00),
(10, 9, 10, 60, 6000.00),
(11, 10, 11, 45, 1200.00),
(12, 11, 12, 35, 1800.00),
(13, 12, 13, 20, 2800.00),
(14, 13, 14, 150, 800.00),
(15, 14, 15, 200, 300.00);

INSERT INTO product_characteristic (product_id, characteristic_id, importance) VALUES
(1, 1, 'Средняя'),
(1, 17, 'Высокая'),
(1, 18, 'Критическая'),
(1, 19, 'Высокая'),

(2, 1, 'Высокая'),
(2, 16, 'Средняя'),
(2, 19, 'Критическая'),

(3, 1, 'Низкая'),
(3, 17, 'Высокая'),

(4, 1, 'Критическая'),
(4, 12, 'Высокая'),
(4, 16, 'Средняя'),

(11, 1, 'Средняя'),
(11, 3, 'Критическая'),
(11, 4, 'Высокая'),
(11, 5, 'Высокая'),

(12, 1, 'Средняя'),
(12, 3, 'Высокая'),
(12, 5, 'Высокая'),

(13, 1, 'Низкая'),
(13, 3, 'Критическая'),
(13, 12, 'Высокая'),

(14, 1, 'Низкая'),
(14, 3, 'Средняя'),
(14, 14, 'Высокая'),

(15, 1, 'Низкая'),
(15, 3, 'Средняя'),
(15, 7, 'Высокая');

select category_name, sum(rec_Price)
from product
inner join product_category on product.category_id = product_category.category_id
group by category_name
having sum(rec_Price) > 60000
order by sum(rec_Price) desc

select status_name, contract_number
from supply_status
inner join supply on supply_status.status_id = supply.status_id
limit 5

SELECT sp.supply_id, s.brand, sp.delivery_date, ss.status_name
FROM supply sp
INNER JOIN supplier s ON sp.supplier_id = s.supplier_id
INNER JOIN supply_status ss ON sp.status_id = ss.status_id
ORDER BY sp.delivery_date DESC
LIMIT 10;

SELECT pc.category_name, COUNT(p.product_id) as product_count
FROM product p
INNER JOIN product_category pc ON p.category_id = pc.category_id
GROUP BY pc.category_name
ORDER BY product_count DESC
LIMIT 10;