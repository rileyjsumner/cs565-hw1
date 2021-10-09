drop table if exists Item;
drop table if exists Bid;
drop table if exists User;

create table Item(
    ItemId INTEGER PRIMARY KEY, 
    user_id CHAR(50),
    Name CHAR(50) NOT NULL, 
    Category CHAR(50), 
    Currently DECIMAL(15, 2), 
    FirstBid DECIMAL(15, 2), 
    NumberOfBids INTEGER, 
    Location CHAR(150), 
    Country CHAR(50), 
    Started DateTime, 
    Ends DateTime, 
    Description CHAR(500),
    FOREIGN KEY (user_id) REFERENCES User
);
create table Bid(
    item_id INTEGER, 
    user_id CHAR(50),
    Time DateTime NOT NULL, 
    Amount DECIMAL(15, 2) NOT NULL, 
    PRIMARY KEY(user_id, item_id, Time, Amount),
    FOREIGN KEY (user_id) REFERENCES User,
    FOREIGN KEY (item_id) REFERENCES Item
);
create table User(
    UserId CHAR(50) PRIMARY KEY, 
    Rating INTEGER, 
    Location CHAR(150), 
    Country CHAR(50)
);
