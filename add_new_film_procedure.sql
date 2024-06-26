-- add_new_film_procedure.sql

/*
This script creates a stored procedure named AddNewFilm to add a new film to the rental system.
The procedure accepts parameters for the film title, description, release year, language ID, rental duration, rental rate, length, replacement cost, rating, and special features.
The procedure inserts a new record into the film table with the provided values and sets the last_update column to the current date.
The procedure handles any potential errors and returns a success message upon successful insertion.
*/

CREATE PROCEDURE AddNewFilm
    @title VARCHAR(255),
    @description TEXT,
    @release_year VARCHAR(4),
    @language_id INT,
    @rental_duration TINYINT,
    @rental_rate DECIMAL(4,2),
    @length SMALLINT,
    @replacement_cost DECIMAL(5,2),
    @rating VARCHAR(10),
    @special_features VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO film (
            title,
            description,
            release_year,
            language_id,
            rental_duration,
            rental_rate,
            length,
            replacement_cost,
            rating,
            special_features,
            last_update
        ) VALUES (
            @title,
            @description,
            @release_year,
            @language_id,
            @rental_duration,
            @rental_rate,
            @length,
            @replacement_cost,
            @rating,
            @special_features,
            GETDATE()
        );

        PRINT 'New film added successfully.';
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO