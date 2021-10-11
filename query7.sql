WITH Expensive_Items AS (
    SELECT Bid_Table.item_id, Category_Table.Category_Name FROM Bid_Table
    JOIN Category_Table ON Bid_Table.item_id = Category_Table.item_id
    WHERE Bid_Table.Amount > 100
    GROUP BY Category_Name
)
SELECT COUNT(*) FROM Expensive_Items