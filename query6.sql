WITH Sellers AS(
    SELECT user_id, Rating FROM Item_Table
    JOIN User_Table ON Item_Table.user_id = User_Table.UserId
)
SELECT COUNT(*) FROM Sellers WHERE Sellers.Rating > 1000