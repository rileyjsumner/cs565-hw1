SELECT ItemId FROM Items
    WHERE Currently = (SELECT MAX(Currently) FROM Items);