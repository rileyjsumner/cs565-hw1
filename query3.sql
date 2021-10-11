WITH By_Category AS (
    SELECT Category_Name FROM Category_Table
    GROUP BY Category_Name
    HAVING COUNT(*) = 4
)
SELECT COUNT(*) FROM By_Category;