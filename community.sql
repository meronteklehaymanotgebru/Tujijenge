CREATE TABLE tujijenge.communities (
   community_id VARCHAR(15)  PRIMARY KEY,
   name VARCHAR(100) NOT NULL,
   description TEXT,
   location GEOGRAPHY(POINT, 4326) NOT NULL,
   created_by VARCHAR(15)  NOT NULL REFERENCES tujijenge.user(user_id),
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   UNIQUE (created_by)
);

insert into tujijenge.communities(community_id,name,description,location,created_by,created_at)
values
('C001','co')

CREATE TABLE tujijenge.community_members (
   membership_id VARCHAR(15)  PRIMARY KEY,
   user_id VARCHAR(15) NOT NULL REFERENCES tujijenge.user(user_id),
   community_id VARCHAR(15) NOT NULL REFERENCES tujijenge.communities(community_id),
   join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   left_date TIMESTAMP,
   UNIQUE (user_id, community_id)
);

CREATE TABLE tujijenge.stock (
   stock_id VARCHAR(15) PRIMARY KEY,
   user_id VARCHAR(15) NOT NULL REFERENCES tujijenge.user(user_id),
   product_id VARCHAR(15) NOT NULL REFERENCES tujijenge.product(product_id),
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   UNIQUE (user_id, product_id)
);

CREATE TABLE tujijenge.stock_updates (
   update_id VARCHAR(15) PRIMARY KEY,
   stock_id VARCHAR(15) NOT NULL REFERENCES tujijenge.stock(stock_id),
   quantity INTEGER NOT NULL CHECK (quantity >= 0),
   order_id VARCHAR(15) REFERENCES tujijenge.orders(order_id),
   last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tujijenge.inventory_reports (
   report_id VARCHAR(15) PRIMARY KEY,
   user_id VARCHAR(15) NOT NULL REFERENCES tujijenge.user(user_id),
   product_id VARCHAR(15) NOT NULL REFERENCES tujijenge.product(product_id),
   start_date DATE NOT NULL,
   end_date DATE NOT NULL,
   initial_stock INTEGER NOT NULL CHECK (initial_stock >= 0),
   final_stock INTEGER NOT NULL CHECK (final_stock >= 0),
   restocked_quantity INTEGER NOT NULL CHECK (restocked_quantity >= 0),
   sold_quantity INTEGER NOT NULL CHECK (sold_quantity >= 0),
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   UNIQUE (user_id, product_id, start_date)
);

