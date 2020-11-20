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

CREATE TABLE clothing
(
    id       varchar(255) NOT NULL PRIMARY KEY,
    name     varchar(255) NOT NULL,
    seller   varchar(255) NOT NULL,
    category varchar(255) NOT NULL,
    price    integer      NOT NULL
);

CREATE TABLE variety
(
    id          varchar(255) NOT NULL,
    color       varchar(255) NOT NULL,
    size        varchar(255) NOT NULL,
    count       integer      NOT NULL,
    clothing_id varchar(255) NOT NULL,
    PRIMARY KEY (id, clothing_id),
    FOREIGN KEY (clothing_id) REFERENCES clothing (id)
);

CREATE TABLE comments
(
    id          varchar(255) NOT NULL,
    score       integer      NOT NULL,
    text        TEXT DEFAULT NULL,
    clothing_id varchar(255) NOT NULL,
    user_id  varchar(255) NOT NULL,
    PRIMARY KEY (id, user_id),
    FOREIGN KEY (user_id) REFERENCES user (email),
    FOREIGN KEY (clothing_id) REFERENCES clothing (id)
);

CREATE TABLE in_cart
(
    user_id varchar(255) NOT NULL,
    variety_id varchar(255) NOT NULL,
    count      integer      NOT NULL,
    PRIMARY KEY (user_id, variety_id),
    FOREIGN KEY (user_id) REFERENCES user (email)
);

CREATE TABLE driver
(
    name      varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    plate     varchar(8)   NOT NULL,
    phone_no  varchar(12)  NOT NULL,
    id        varchar(10)  NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE schedule
(
    id            varchar(255) NOT NULL,
    delivery_date date,
    capacity      int,
    driver_id     varchar(10)  NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (driver_id) REFERENCES driver (id)
);

CREATE TABLE product_order
(
    id              bigint       NOT NULL,
    order_date      date         NOT NULL,
    delivery_method int          NOT NULL,
    state           int          NOT NULL,
    schedule_id     varchar(255) NOT NULL,
    user_id         varchar(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (schedule_id) REFERENCES schedule (id),
    FOREIGN KEY (user_id) REFERENCES user (email)
);

CREATE TABLE product_order_variety
(
    order_id    bigint NOT NULL,
    variety_id  varchar(255),
    clothing_id varchar(255),
    FOREIGN KEY (order_id) REFERENCES product_order (id),
    FOREIGN KEY (variety_id, clothing_id) REFERENCES variety (id, clothing_id)
);


INSERT INTO user
VALUES ('mmd', 'mmd@mmd.mmd', 'mmd_abad', NULL, '123456789012', 'mmd');

INSERT INTO clothing
VALUES ('shk1001', 'shalvar_kordi', 'todo_add_seller', 'shalvar_rahat', 1000);

INSERT INTO variety
VALUES ('sub_cloth_id', 'brown', 'XL', 1000000, 'shk1001');

INSERT INTO in_cart
VALUES ('mmd@mmd.mmd', 'sub_cloth_id', 100);

INSERT INTO comments
VALUES ('first_comment_id', 5, 'toosh gom mishe adadm', 'shk1001', 'mmd@mmd.mmd');

INSERT INTO driver
VALUES ('hasan', 'kachal', '82b34522', '9123456789', '0123456789');

INSERT INTO schedule
VALUES ('tx123', '2020-11-20', 5, '0123456789');

INSERT INTO product_order
VALUES (385928, '2020-11-15', '2', '1', 'tx123', 'mmd@mmd.mmd');

INSERT INTO product_order_variety
VALUES (385928, 'sub_cloth_id', 'shk1001');
