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


# TODO add foreign key for seller
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
    id          varchar(255) NOT NULL PRIMARY KEY,
    color       varchar(255) NOT NULL,
    size        varchar(255) NOT NULL,
    count       integer      NOT NULL,
    clothing_id varchar(255) NOT NULL,
    FOREIGN KEY (clothing_id) REFERENCES clothing (id)
);

CREATE TABLE comments
(
    id          varchar(255) NOT NULL,
    score       integer      NOT NULL,
    text        TEXT DEFAULT NULL,
    clothing_id varchar(255) NOT NULL,
    user_email  varchar(255) NOT NULL,
    PRIMARY KEY (id, user_email),
    FOREIGN KEY (user_email) REFERENCES user (email),
    FOREIGN KEY (clothing_id) REFERENCES clothing (id)
);



CREATE TABLE in_cart
(
    user_email varchar(255) NOT NULL,
    variety_id varchar(255) NOT NULL,
    count      integer      NOT NULL,
    PRIMARY KEY (user_email, variety_id),
    FOREIGN KEY (user_email) REFERENCES user (email)
);


INSERT INTO clothing
VALUES ('shk1001', 'shalvar_kordi', 'todo_add_seller', 'shalvar_rahat', 1000);

INSERT INTO variety
VALUES ('sub_cloth_id', 'brown', 'XL', 1000000, 'shk1001');

INSERT INTO user
VALUES ('mmd', 'mmd@mmd.mmd', 'mmd_abad', NULL, '123456789012', 'mmd');

INSERT INTO in_cart
VALUES ('mmd@mmd.mmd', 'sub_cloth_id', 100);

INSERT INTO comments
VALUES ('first_comment_id', 5, 'toosh gom mishe adadm', 'shk1001', 'mmd@mmd.mmd');
