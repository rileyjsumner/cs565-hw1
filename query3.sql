WITH By_Category AS (
    SELECT Category_Name FROM Category
    GROUP BY Category_Name
    HAVING COUNT(*) = 4
)
SELECT COUNT(*) FROM By_Category;