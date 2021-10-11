WITH Sellers AS(
    SELECT user_id FROM Item
    JOIN User ON Item.user_id = User.UserId
)
SELECT COUNT(*) FROM Sellers