WITH Sellers AS(
    SELECT user_id FROM Item
    JOIN User_Table ON Item_Table.user_id = User_Table.UserId
)
SELECT COUNT(*) FROM Sellers