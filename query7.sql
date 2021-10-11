WITH Expensive_Items AS (
    SELECT item_id, Category_Name FROM Bid_Table
    WHERE Bid.Amount > 100
    JOIN Category_Table ON Bid_Table.item_id = Category_Table.item_id
    GROUP BY Category_Name
)
SELECT COUNT(*) FROM Expensive_Items