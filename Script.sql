create database tujijenge_db;

create schema tujijenge;
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;
SELECT postgis_extensions_upgrade(); 
SELECT PostGIS_full_version();

--SELECT * FROM pg_available_extensions WHERE name = 'postgis';

--select rolcreatedb from pg_roles where rolname='postgres.creibsbzmowhdoweorps';
--
--grant all privileges on database tujijenge_db to 'postgres.creibsbzmowhdoweorps';

--\c tujijenge_db;
create table tujijenge.user(
user_id VARCHAR(15) primary key,
user_type VARCHAR(20) NOT NULL CHECK (user_type IN ('MamaMboga', 'GAIN', 'Taimba')),
username VARCHAR(50) UNIQUE NOT NULL,
phone_number VARCHAR(20) UNIQUE,
email VARCHAR(255) UNIQUE,
password_hash VARCHAR(255) NOT NULL,
location GEOGRAPHY(point,4326),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
check(
(user_type='MamaMboga'and phone_number is not null and email is NULL) or
(user_type in ('GAIN','Taimba') and email is not null and phone_number is null)
)
);

CREATE TABLE tujijenge.user_account(
    account_id VARCHAR(15) PRIMARY KEY,
    user_id VARCHAR(15) REFERENCES tujijenge.user(user_id) ON DELETE CASCADE,
    profile_image VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    deactivation_date TIMESTAMP,
    certified BOOLEAN DEFAULT FALSE,
    reactivation_window INTERVAL DEFAULT INTERVAL '7 days',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table tujijenge.notifications(
notification_id VARCHAR(15) primary key,
user_id VARCHAR(15) not null REFERENCES tujijenge.user(user_id),
message text not null,
notification_type VARCHAR(30) NOT NULL CHECK (notification_type IN ('Order', 'Training', 'Stock', 'Payment', 'Community')),
is_read BOOLEAN default false,
sent_at TIMESTAMP default CURRENT_TIMESTAMP
);

create table tujijenge.notification_status(
notification_status_id VARCHAR(15) primary key,
notification_id VARCHAR(15)  not null REFERENCES tujijenge.notifications(notification_id),
is_read BOOLEAN default FALSE
);

CREATE TABLE tujijenge.product (
    product_id VARCHAR(15) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    unit VARCHAR(20) NOT NULL CHECK (unit IN ('kg', 'piece', 'bunch')),
    category VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tujijenge.product_details (
    product_details_id VARCHAR(15) PRIMARY KEY,
    product_id VARCHAR(15) REFERENCES tujijenge.product(product_id) ON DELETE CASCADE,
    description TEXT,
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    image_url VARCHAR(255),
    is_in_stock BOOLEAN DEFAULT TRUE,
    amount DECIMAL(5,2),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


