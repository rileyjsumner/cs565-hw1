WITH Sellers AS(
    SELECT user_id FROM Item
    JOIN User ON Sellers.user_id = User.UserId
)
SELECT COUNT(*) FROM Sellers WHERE Rating > 1000