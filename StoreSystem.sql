DROP DATABASE IF EXISTS db_HW2_2;
create database db_HW2_2;

use db_HW2_2;

CREATE TABLE `user`
(
    `Email`     varchar(128) primary key not null,
    `FirstName` varchar(32)              not null,
    `LastName`  varchar(32)              not null,
    `City`      varchar(32)              not null,
    `Address`   varchar(256)             not null,
    `Telephone` varchar(10),
    `Password`  varchar(128)             not null
) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;

CREATE TABLE `driver`
(
    `NationalId`  char(10) primary key not null,
    `FirstName`   varchar(32)          not null,
    `LastName`    varchar(32)          not null,
    `Telephone`   varchar(10),
    `PlateNumber` varchar(8)           not null
) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;

CREATE TABLE `item`
(
    `Id`     varchar(10) primary key             not null,
    `Name`   varchar(128)                        not null,
    `Seller` varchar(128)                        not null,
    `Type`   ENUM ('Children' , 'Men' , 'Women') not null,
    `Price`  Int
) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;


CREATE TABLE `variety_item`
(
    `Id`       varchar(10) not null,
    `Color`    VARCHAR(10) not null,
    `Size`     int         not null,
    `Quantity` int         not null,
    CHECK ( Quantity >= 0 ),
    primary key (Id, Color, Size),
    FOREIGN KEY (Id) references item (id) on delete cascade on update cascade

) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;


CREATE TABLE `transport`
(
    `Id`            varchar(10) primary key not null,
    `TransportDate` DATE                    not null,
    `Capacity`      INT                     not null,
    `DriverID`      char(10)                not null,
    FOREIGN KEY (DriverID) REFERENCES driver (NationalId) ON UPDATE CASCADE ON DELETE CASCADE

) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;


CREATE TABLE `saleOrder`
(
    `Id`          varchar(10) primary key                       not null,
    `OrderDate`   DATE                                          not null,
    `Type`        ENUM ('Normal' , 'Special' )                  NOT NULL DEFAULT 'Normal',
    `Staus`       ENUM ('Pending' , 'Registered' , 'Completed') NOT NULL DEFAULT 'Pending',
    `UserEmail`   varchar(128)                                  not null,
    `TransportID` varchar(10)                                   not null,
    FOREIGN KEY (UserEmail) references user (Email) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (TransportID) references transport (Id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;

CREATE TABLE `comment`
(
    `Id`        varchar(10)   NOT NULL,
    `ItemId`    varchar(10)   NOT NULL,
    `UserEmail` varchar(128)  not null,
    `Score`     int           not null,
    `Text`      varchar(1024) not null,
    CHECK ( Score >= 1 and Score <= 5 ),
    PRIMARY KEY (Id, ItemId, UserEmail),
    FOREIGN KEY (UserEmail) REFERENCES user (Email) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ItemId) REFERENCES item (ID) ON DELETE CASCADE ON UPDATE CASCADE

) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;


CREATE TABLE `basket`
(
    `UserEmail` varchar(128) primary key not null,
    FOREIGN KEY (UserEmail) REFERENCES user (Email) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;


CREATE TABLE `basket_variety`
(
    `BasketEmail` varchar(128) not null,
    `VarietyId`   varchar(10)  not null,
    `Color`       VARCHAR(10)  not null,
    `Size`        int          not null,
    `Quantity`    int          not null,
    PRIMARY KEY (VarietyId, Color, Size, BasketEmail),
    FOREIGN KEY (BasketEmail) REFERENCES basket (UserEmail) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (VarietyId, Color, Size) references variety_item (Id, Color, Size) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;

CREATE TABLE `order_variety`
(
    `OrderId`   varchar(10) not null,
    `VarietyId` varchar(10) not null,
    `Color`     VARCHAR(10) not null,
    `Size`      int         not null,
    `Quantity`  int         not null,
    PRIMARY KEY (OrderId, VarietyId, Color, Size),
    FOREIGN KEY (OrderId) references saleOrder (Id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (VarietyId, Color, Size) references variety_item (Id, Color, Size) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;

INSERT INTO `user`
VALUES ('gggg@gmail.com', 'c', 'l', 'yazd', 'iran,yazd,2', '1234568', 'bb'),
       ('efg@gmail.com', 'd', 'm', 'yazd', 'iran,yazd,3', '1234569', 'cc'),
       ('hij@gmail.com', 'e', 'n', 'yazd', 'iran,yazd,4', '1234560', 'dd'),
       ('klm@gmail.com', 'f', 'o', 'yazd', 'iran,yazd,5', '1234561', 'ee'),
       ('nop@gmail.com', 'g', 'p', 'yazd', 'iran,yazd,6', '1234562', 'ff'),
       ('qrs@gmail.com', 'h', 'q', 'yazd', 'iran,yazd,7', '1234563', 'gg'),
       ('tuv@gmail.com', 'i', 'r', 'yazd', 'iran,yazd,8', '1234564', 'hh'),
       ('xyz@gmail.com', 'j', 's', 'yazd', 'iran,yazd,9', '1234565', 'ii'),
       ('hhh@gmail.com', 'k', 't', 'yazd', 'iran,yazd,0', '1234566', 'jj'),
       ('abcd@gmail.com', 'h', 'k', 'yazd', 'iran,yazd,1', '1234567', 'll');

INSERT INTO `driver`
VALUES ('1111111111', 'asghar1', 'asghari1', 2461564, 111111),
       ('2222222222', 'asghar2', 'asghari2', 2461565, 222222),
       ('3333333333', 'asghar3', 'asghari3', 2461566, 333333),
       ('4444444444', 'asghar4', 'asghari4', 2461567, 444444),
       ('5555555555', 'asghar5', 'asghari5', 2461568, 555555);

INSERT INTO `item`
VALUES ('111', 'aaa', 'aa', 'Men', 11),
       ('222', 'bbb', 'gg', 'Women', 234),
       ('333', 'ddd', 'dd', 'Women', 56),
       ('444', 'yyy', 'tt', 'Women', 77),
       ('555', 'jjj', 'uu', 'Children', 12),
       ('666', 'nnn', 'ww', 'Children', 11),
       ('777', 'rrr', 'ww', 'Children', 67),
       ('888', 'eee', 'hh', 'Children', 8973),
       ('999', 'qqq', 'yy', 'Men', 5);

INSERT INTO `variety_item`
VALUES ('111', 'white', 1, 10),
       ('111', 'black', 1, 10),
       ('222', 'yellow', 1, 10),
       ('222', 'orange', 1, 10),
       ('111', 'pink', 1, 10),
       ('333', 'white', 1, 10),
       ('333', 'red', 1, 10),
       ('555', 'blue', 1, 10),
       ('444', 'purple', 1, 10),
       ('666', 'brown', 1, 10),
       ('888', 'black', 1, 10),
       ('999', 'white', 1, 0),
       ('888', 'white', 1, 0),
       ('666', 'white', 1, 10),
       ('888', 'gray', 1, 0),
       ('999', 'green', 1, 10),
       ('777', 'green', 1, 10);

INSERT INTO `transport`
VALUES ('1a1a', '1399-08-20', 3, '1111111111'),
       ('2a1a', '1399-08-30', 3, '1111111111'),
       ('3a3a', '1399-08-15', 3, '1111111111'),
       ('4a1a', '1399-09-20', 3, '2222222222'),
       ('5a1a', '1399-09-10', 3, '2222222222'),
       ('6a1a', '1399-10-10', 3, '3333333333'),
       ('7a1a', '1399-11-30', 3, '4444444444'),
       ('8a1a', '1399-12-17', 3, '5555555555'),
       ('9a1a', '1399-07-20', 3, '5555555555');

INSERT INTO `saleOrder`
VALUES ('10', '1399-07-17', 'Normal', 'Pending', 'hhh@gmail.com', '9a1a'),
       ('20', '1399-08-15', 'Normal', 'Pending', 'hhh@gmail.com', '2a1a'),
       ('30', '1399-08-10', 'Special', 'Pending', 'abcd@gmail.com', '3a3a'),
       ('40', '1399-09-16', 'Normal', 'Pending', 'xyz@gmail.com', '4a1a'),
       ('50', '1399-09-03', 'Normal', 'Pending', 'xyz@gmail.com', '5a1a'),
       ('60', '1399-08-27', 'Normal', 'Registered', 'abcd@gmail.com', '2a1a'),
       ('70', '1399-08-14', 'Special', 'Registered', 'abcd@gmail.com', '3a3a'),
       ('80', '1399-09-09', 'Special', 'Registered', 'qrs@gmail.com', '5a1a'),
       ('90', '1399-10-07', 'Normal', 'Registered', 'qrs@gmail.com', '6a1a'),
       ('100', '1399-08-19', 'Special', 'Pending', 'klm@gmail.com', '1a1a'),
       ('110', '1399-12-13', 'Normal', 'Completed', 'klm@gmail.com', '8a1a'),
       ('120', '1399-08-19', 'Special', 'Completed', 'abcd@gmail.com', '1a1a'),
       ('130', '1399-10-06', 'Normal', 'Completed', 'klm@gmail.com', '6a1a');

INSERT INTO `comment`
VALUES ('c11', '111', 'nop@gmail.com', 1, 'ddfgsd'),
       ('c12', '222', 'nop@gmail.com', 2, 'asdfasf'),
       ('c13', '222', 'nop@gmail.com', 3, 'asdfasd'),
       ('c14', '222', 'nop@gmail.com', 3, 'gdffhdf'),
       ('c15', '222', 'nop@gmail.com', 3, 'dfgsd'),
       ('c16', '333', 'nop@gmail.com', 3, 'fdfsg'),
       ('c17', '333', 'nop@gmail.com', 3, 'dfdsfh'),
       ('c18', '444', 'nop@gmail.com', 4, 'sdfgsdfg'),
       ('c19', '555', 'nop@gmail.com', 4, 'sdfgsdfg'),
       ('c10', '444', 'nop@gmail.com', 5, 'sdfgsdfg'),
       ('c111', '555', 'nop@gmail.com', 5, 'hykjuyk'),
       ('c112', '666', 'nop@gmail.com', 5, 'lio;;889'),
       ('c113', '777', 'nop@gmail.com', 5, 'terthr'),
       ('c114', '333', 'nop@gmail.com', 5, 'thwtrth'),
       ('c115', '666', 'nop@gmail.com', 2, 'wthghngh');

INSERT INTO `basket`
VALUES ('abcd@gmail.com'),
       ('gggg@gmail.com'),
       ('efg@gmail.com'),
       ('hij@gmail.com'),
       ('klm@gmail.com'),
       ('nop@gmail.com'),
       ('qrs@gmail.com'),
       ('tuv@gmail.com'),
       ('xyz@gmail.com'),
       ('hhh@gmail.com');

INSERT INTO `order_variety`
VALUES ('10', '111', 'white', 1, 2),
       ('10', '111', 'black', 1, 1),
       ('10', '777', 'green', 1, 4),
       ('20', '222', 'yellow', 1, 8),
       ('20', '111', 'white', 1, 1),
       ('30', '777', 'green', 1, 2),
       ('30', '999', 'green', 1, 2),
       ('30', '111', 'white', 1, 2),
       ('40', '777', 'green', 1, 2),
       ('50', '999', 'green', 1, 2),
       ('60', '888', 'black', 1, 3),
       ('70', '888', 'black', 1, 2),
       ('80', '111', 'pink', 1, 7),
       ('90', '888', 'black', 1, 2),
       ('100', '444', 'purple', 1, 2),
       ('110', '444', 'purple', 1, 2),
       ('120', '444', 'purple', 1, 1),
       ('130', '444', 'purple', 1, 2),
       ('130', '222', 'orange', 1, 1),
       ('130', '222', 'yellow', 1, 2);

SELECT UserEmail, SUM(Price)
FROM item
         JOIN variety_item vi on item.Id = vi.Id
         JOIN order_variety ov on vi.Id = ov.VarietyId and vi.Color = ov.Color and vi.Size = ov.Size
         JOIN saleOrder sO on sO.Id = ov.OrderId
WHERE Staus = 'Completed'
GROUP BY UserEmail;

SELECT *
FROM item
         JOIN comment c on item.Id = c.ItemId
ORDER BY Score DESC
LIMIT 5;

SELECT DISTINCT FirstName, LastName
FROM driver
         JOIN transport t on driver.NationalId = t.DriverID
         JOIN saleOrder sO on t.Id = sO.TransportID
WHERE Capacity > 0;

SELECT Id, Size, Color
FROM variety_item
WHERE Quantity = 0;

SELECT *
FROM user
         JOIN saleOrder sO on user.Email = sO.UserEmail
WHERE OrderDate > '1399-08-20'
  AND Staus = 'Registered';

SELECT *
FROM driver
         JOIN transport t on driver.NationalId = t.DriverID
         JOIN saleOrder sO on t.Id = sO.TransportID
WHERE UserEmail = 'abcd@gmail.com'
  AND TransportDate = '1399-08-20';