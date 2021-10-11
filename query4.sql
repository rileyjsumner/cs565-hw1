SELECT ItemId FROM Item_Table
    WHERE Currently = (SELECT MAX(Currently) FROM Item);