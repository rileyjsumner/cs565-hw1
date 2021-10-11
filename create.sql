DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS Bid;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Category;

CREATE TABLE Item_Table(
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
CREATE TABLE Bid_Table(
item_id INTEGER, 
    user_id CHAR(50),
    Time DateTime, 
    Amount DECIMAL(15, 2)
);
CREATE TABLE User_Table(
    UserId CHAR(50), 
    Rating INTEGER, 
    Location CHAR(150), 
    Country CHAR(50)
);
CREATE TABLE Category_Table(
    Category_Name CHAR(50),
    item_id INTEGER
);
