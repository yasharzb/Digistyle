DROP DATABASE IF EXISTS digi_style;
CREATE DATABASE digi_style;
USE digi_style;
CREATE TABLE user
(
    name     varchar(255) NOT NULL,
    email    varchar(255) NOT NULL,
    city     varchar(255) NOT NULL,
    address  text DEFAULT NULL,
    phone_no varchar(12)  NOT NULL,
    password varchar(255) NOT NULL,
    PRIMARY KEY (email)
);