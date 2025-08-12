-- Create an audit table to log changes
CREATE TABLE UserAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing ID for each record
    UserID INT,                             -- User ID (the ID of the user being modified)
    OldBirthYear INT,                       -- Old birth year before update
    NewBirthYear INT,                       -- New birth year after update
    OldAge INT,                             -- Old age before update
    NewAge INT,                             -- New age after update
    ChangeDate DATETIME DEFAULT GETDATE()   -- Date and time of change
);

-- Create trigger to update user's age after changing birth_year and log the changes
CREATE TRIGGER UpdateUserAge
ON Table_Users
AFTER UPDATE
AS
BEGIN
    IF UPDATE(birth_year) -- Check if birth_year was updated
    BEGIN
        DECLARE @UserID INT, @OldBirthYear INT, @NewBirthYear INT, @OldAge INT, @NewAge INT;

        -- Get the updated and old birth_year from inserted and deleted record
        SELECT @UserID = ID, @OldBirthYear = birth_year FROM deleted; -- Old value
        SELECT @NewBirthYear = birth_year FROM inserted;            -- New value

        -- Calculate the old and new age
        SET @OldAge = YEAR(GETDATE()) - @OldBirthYear;
        SET @NewAge = YEAR(GETDATE()) - @NewBirthYear;

        -- Update the user's age in the Table_Users
        UPDATE Table_Users
        SET current_age = @NewAge
        WHERE ID = @UserID;

        -- Log the change in the UserAuditLog table
        INSERT INTO UserAuditLog (UserID, OldBirthYear, NewBirthYear, OldAge, NewAge)
        VALUES (@UserID, @OldBirthYear, @NewBirthYear, @OldAge, @NewAge);
    END
END;

-- Example usage
SELECT current_age,birth_year 
FROM Table_Users
WHERE ID = 100; -- Display the current birth_year (Before update: 2000)

UPDATE Table_Users
SET birth_year = 2001
WHERE ID = 100; -- Trigger will update current_age and log changes

SELECT current_age,birth_year 
FROM Table_Users
WHERE ID = 100;  -- Display the updated birth_year (After update: 2001)

-- View the audit log to see the recorded changes
SELECT * FROM UserAuditLog;




