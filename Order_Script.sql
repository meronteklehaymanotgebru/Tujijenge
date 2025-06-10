CREATE TABLE tujijenge.cart (
   cart_id VARCHAR(15) PRIMARY KEY,
   user_id VARCHAR(15) NOT NULL REFERENCES tujijenge.user(user_id),
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO tujijenge.cart (cart_id,user_id,created_at)
VALUES 
('C001','U007','2025-06-09 20:23:60.323'),
('C002','U002','2025-06-09 20:23:60.326'),
('C003','U005','2025-06-09 20:23:60.329'),
('C004','U003','2025-06-09 20:23:60.333'),
('C005','U001','2025-06-09 20:23:60.338');


CREATE TABLE tujijenge.cart_items (
   cart_item_id VARCHAR(15) PRIMARY KEY,
   cart_id VARCHAR(15) NOT NULL REFERENCES tujijenge.cart(cart_id) ON DELETE CASCADE,
   product_id VARCHAR(15) NOT NULL REFERENCES tujijenge.product(product_id),
   quantity INTEGER NOT NULL CHECK (quantity > 0),
   added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO tujijenge.cart_items  (cart_item_id,cart_id,product_id,quantity,added_at)
VALUES 
('CI001','C004','P003',10,'2025-06-09 20:23:60.323'),
('CI002','C002','P003',5,'2025-06-09 20:23:60.329'),
('CI003','C003','P001',12,'2025-06-09 20:23:60.353'),
('CI004','C003','P002',4,'2025-06-09 20:23:60.328'),
('CI005','C002','P003',6,'2025-06-09 20:23:60.326');

CREATE TABLE tujijenge.payments (
   payment_id VARCHAR(15) PRIMARY KEY,
   order_id VARCHAR(15) NOT NULL UNIQUE REFERENCES tujijenge.orders(order_id),
   amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
   transaction_id VARCHAR(100) NOT NULL UNIQUE,
   receiver_account VARCHAR(100) NOT NULL,
   payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   status VARCHAR(20) NOT NULL CHECK (status IN ('Pending', 'Completed', 'Failed')),
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tujijenge.orders (
   order_id VARCHAR(15)  PRIMARY KEY,
   user_id VARCHAR(15) REFERENCES tujijenge.user(user_id),
   community_id VARCHAR(15) REFERENCES tujijenge.communities(community_id),
   deadline_at TIMESTAMP DEFAULT (date_trunc('day', CURRENT_TIMESTAMP) + interval '22 hours'),
   order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 
   CHECK (
       (user_id IS NOT NULL AND community_id IS NULL) OR
       (user_id IS NULL AND community_id IS NOT NULL)
   )
);


CREATE TABLE tujijenge.order_items (
   item_id VARCHAR(15) PRIMARY KEY,
   order_id VARCHAR(15) NOT NULL REFERENCES tujijenge.orders(order_id),
   product_id VARCHAR(15) NOT NULL REFERENCES tujijenge.product(product_id),
   quantity INTEGER NOT NULL CHECK (quantity > 0),
   unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0)
);

create table tujijenge.order_status(
order_status_id VARCHAR(15) primary key,
order_id VARCHAR(15) references tujijenge.orders(order_id),
last_sync_at TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);