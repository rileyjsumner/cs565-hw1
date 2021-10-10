DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS Bid;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Category;

CREATE TABLE Item(
    ItemId INTEGER PRIMARY KEY, 
    Name CHAR(50), 
    Currently DECIMAL(15, 2), 
    FirstBid DECIMAL(15, 2), 
    NumberOfBids INTEGER, 
    Location CHAR(150), 
    Country CHAR(50), 
    Started DateTime, 
    Ends DateTime, 
    user_id CHAR(50),
    Description CHAR(500)
);
CREATE TABLE Bid(
item_id INTEGER, 
    user_id CHAR(50),
    Time DateTime, 
    Amount DECIMAL(15, 2), 
    PRIMARY KEY(user_id, item_id, Time, Amount)
);
CREATE TABLE User(
    UserId CHAR(50) PRIMARY KEY, 
    Rating INTEGER, 
    Location CHAR(150), 
    Country CHAR(50)
);
CREATE TABLE Category(
    item_id INTEGER,
    Category_Name CHAR(50)
);
