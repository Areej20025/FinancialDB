-- Create function to calculate current age based on birth year
CREATE FUNCTION dbo.GetUserAge (@BirthYear INT)
RETURNS INT
AS
BEGIN
    RETURN (YEAR(GETDATE()) - @BirthYear); -- Calculate age
END;

-- Example usage: Get current age based on birth year
SELECT ID, dbo.GetUserAge(birth_year) AS current_age
FROM Table_Users;

--get the current age of users
SELECT ID,current_age
FROM Table_Users;



