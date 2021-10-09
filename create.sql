drop table if exists Items;
drop table if exists Bids;
drop table if exists Users;
drop table if exists ItemBids;
drop table if exists Bidders;
drop table if exists Sellers;

create table Items(
    ItemId INTEGER PRIMARY KEY, 
    Name CHAR(50) NOT NULL, 
    Category CHAR(50), 
    Currently DECIMAL(15, 2), 
    FirstBid DECIMAL(15, 2), 
    NumberOfBids INTEGER, 
    Location CHAR(150), 
    Country CHAR(50), 
    Started DateTime, 
    Ends DateTime, 
    Description CHAR(500)
);
create table Bids(
    Time DateTime NOT NULL, 
    Amount DECIMAL(15, 2) NOT NULL, 
    PRIMARY KEY(Time, Amount)
);
create table Users(
    UserId CHAR(50) PRIMARY KEY, 
    Rating INTEGER, 
    Location CHAR(150), 
    Country CHAR(50)
);
create table ItemBids(
    Time DateTime, 
    Amount DECIMAL(15, 2), 
    item_id INTEGER, 
    PRIMARY KEY(Time, Amount, item_id), 
    FOREIGN KEY (Time, Amount) REFERENCES Bid,
    FOREIGN KEY (item_id) REFERENCES Item
);
create table Bidders(
    Time DateTime, 
    Amount DECIMAL(15, 2), 
    user_id CHAR(50), 
    PRIMARY KEY(Time, Amount, user_id), 
    FOREIGN KEY (Time, Amount) REFERENCES Bid,
    FOREIGN KEY (user_id) REFERENCES User
);
create table Sellers(
    user_id CHAR(50), 
    item_id INTEGER,
    PRIMARY KEY(user_id, item_id), 
    FOREIGN KEY (user_id) REFERENCES User,
    FOREIGN KEY (item_id) REFERENCES Item
);