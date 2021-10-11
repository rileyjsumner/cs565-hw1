WITH Expensive_Items AS (
    SELECT item_id, Category_Name FROM Bid
    WHERE Bid.Amount > 100
    JOIN Category ON Bid.item_id = Category.item_id
    GROUP BY Category_Name
)
SELECT COUNT(*) FROM Expensive_Items