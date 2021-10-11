WITH Sellers AS(
    SELECT user_id, Rating FROM Item
    JOIN User ON Item.user_id = User.UserId
)
SELECT COUNT(*) FROM Sellers WHERE Sellers.Rating > 1000