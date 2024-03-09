
-- use ZooDB;
-- DROP schema ZooDB;

-- 1 
-- Retrieve All Animals in a Specific Habitat:
SELECT * 
FROM Animals 
WHERE Habitats_HabitatID = 1;


-- 2
-- List All Staff Along with Their Roles:
SELECT FirstName, LastName, Role 
FROM ZooStaff 
ORDER BY Role;


-- 3
-- Find All Health Checks Conducted by a Specific Veterinarian:
SELECT h.* FROM HealthChecks h
JOIN ZooStaff z ON h.ZooStaff_StaffID = z.StaffID
WHERE z.FirstName = 'John' AND z.LastName = 'Doe';


-- 4
-- Get the Total Revenue from Ticket Sales in a Specific Month:
SELECT SUM(TotalAmount) AS MonthlyRevenue 
FROM Visitors 
WHERE MONTH(VisitDate) = 7 AND YEAR(VisitDate) = 2023;


-- 5
-- List All Animals That Have Had a Health Check:
SELECT a.Name, a.Species, h.DateOfCheck, h.Results 
FROM Animals a 
JOIN HealthChecks h ON a.AnimalID = h.Animals_AnimalID;


-- 6
-- Find the Total Number of Visitors for Each Day of a Specific Month:
SELECT VisitDate, COUNT(DISTINCT VisitorID) AS NumberOfVisitors 
FROM Visitors 
WHERE MONTH(VisitDate) = 7 AND YEAR(VisitDate) = 2023 
GROUP BY VisitDate;


-- 7
-- Retrieve the Most Recent Maintenance Activities for Each Habitat:
SELECT m.Habitats_HabitatID, m.Date, m.Description
FROM Maintenance m
WHERE m.Date = (SELECT MAX(Date) FROM Maintenance WHERE Habitats_HabitatID = m.Habitats_HabitatID);


-- 8
-- List All Events Organized by a Specific Staff Member:
SELECT e.* FROM ZooEvents e
JOIN ZooStaff z ON e.ZooStaff_StaffID = z.StaffID
WHERE z.FirstName = 'Alice' AND z.LastName = 'Smith';


-- 9
-- Calculate the Total Donations Raised from Each Event:
SELECT e.EventID, e.Name, SUM(d.Amount) AS TotalDonations 
FROM ZooEvents e 
JOIN Donations d ON e.EventID = d.ZooEvents_EventID 
GROUP BY e.EventID, e.Name;


-- 10
-- List All Animals Handled by a Specific Staff Member for Feeding:
SELECT a.Name, a.Species 
FROM Animals a 
JOIN AnimalDiet d ON a.AnimalDiet_DietID = d.DietID 
JOIN ZooStaff z ON d.ZooStaff_StaffID = z.StaffID 
WHERE z.FirstName = 'Alice' AND z.LastName = 'Smith';



-- PROCEDOORS
-- 1.Update Animal Information with Health Check Results *******************************
DELIMITER //
-- Update Health Check Results for an Animal
CREATE PROCEDURE UpdateHealthCheckResults(
    IN p_healthCheckID INT,
    IN p_healthCheckDate DATE,
    IN p_healthCheckResults VARCHAR(255),
    IN p_recommendations VARCHAR(255),
    IN p_staffID INT
)
BEGIN
    -- Update the existing health check record
    UPDATE HealthChecks
    SET DateOfCheck = p_healthCheckDate,
        Results = p_healthCheckResults,
        Recommendations = p_recommendations,
        ZooStaff_StaffID = p_staffID
    WHERE CheckID = p_healthCheckID;
    
    COMMIT;
END;
//
DELIMITER ;

-- DROP PROCEDURE UpdateHealthCheckResults;

CALL UpdateHealthCheckResults(2,'2023-09-10','Healthy','No special recommendations',3);



-- 2.Update Zoo Event Details
DELIMITER //
CREATE PROCEDURE UpdateZooEventDetails(
    IN event_ID INT,
    IN eventDate DATE,
    IN eventDescription varchar(255),
	IN newTicketPrice DECIMAL(10, 2),
    IN staffID INT
)
BEGIN
    -- Update zoo event details
    UPDATE ZooEvents
    SET ZooStaff_StaffID = staffID, Date = eventDate, Description = eventDescription, TicketPricing = newTicketPrice
    WHERE EventID = event_ID;
    
    COMMIT;
END;
//
DELIMITER ;

CALL UpdateZooEventDetails(1, '2023-09-15', 'Animal Show', 25.99, 2);



-- 3.Update Donor's Donation Amount
DELIMITER //
CREATE PROCEDURE UpdateDonationAmount(
	IN donorID INT,
    IN donorName VARCHAR(255),
    IN newAmount DECIMAL(10, 2)
)
BEGIN
    -- Update donation amount
    UPDATE Donations
    SET Amount = newAmount
    WHERE DonorName = donorName AND DonationID = donorID ;
    
    COMMIT;
END;
//
DELIMITER ;



-- 4.Update the details of a habitat 
DELIMITER //
CREATE PROCEDURE UpdateHabitatDetailsWithMaintenance(
    IN Habitat_ID INT,
    IN newHabitatType VARCHAR(255),
    IN newHabitatSize DECIMAL(10, 2),
    IN newMaximumCapacity INT,
    IN newMaintenanceDate DATE,
    IN newMaintenanceDescription VARCHAR(255),
    IN newMaintenanceStaffID INT
)
BEGIN
    -- Start a transaction
    START TRANSACTION;

    -- Update the habitat details
    UPDATE Habitats
    SET Type = newHabitatType,
        Size = newHabitatSize,
        MaximumCapacity = newMaximumCapacity
    WHERE Habitat_ID = HabitatID;

    -- Insert a new maintenance record
    INSERT INTO Maintenance (Date, Description, Habitats_HabitatID, ZooStaff_StaffID)
    VALUES (newMaintenanceDate, newMaintenanceDescription, habitat_ID, newMaintenanceStaffID);

    -- Commit the transaction
    COMMIT;
END;
//
DELIMITER ;


-- DROP PROCEDURE UpdateHabitatDetailsWithMaintenance;

call UpdateHabitatDetailsWithMaintenance(2,'Afeka cats Corner',25,200, '2023-05-10','cleaning' ,2 );



-- 5.get_animals_in_habitat
DELIMITER //
CREATE PROCEDURE get_animals_in_habitat(IN habitat_id INT)
BEGIN
    SELECT * 
    FROM Animals 
    WHERE Habitats_HabitatID = habitat_id;
END //
DELIMITER ;



-- 6. Procedure to fetch details of all animals transferred from a specific zoo
DELIMITER //
CREATE PROCEDURE get_animals_from_source_zoo(IN source VARCHAR(45))
BEGIN
    SELECT * 
    FROM AnimalTransfer
    WHERE SourceZoo = source;
END //
DELIMITER ;



-- 7. Procedure to fetch details of all staff who joined after a specific date
DELIMITER //
CREATE PROCEDURE get_staff_joined_after(IN join_date DATE)
BEGIN
    SELECT * 
    FROM ZooStaff
    WHERE DateOfJoining > join_date;
END //
DELIMITER ;



-- 8. Procedure to update the ticket price for a specific ticket type
DELIMITER //
CREATE PROCEDURE update_ticket_price(
IN ticket_id INT,
IN ticket_type VARCHAR(45),
IN new_price FLOAT
 )
BEGIN
    UPDATE TicketPricing
    SET Price = new_price
    WHERE Type = ticket_type AND TicketID = ticket_id;
END //
DELIMITER ;



-- 9.get_monthly_revenue
DELIMITER //
CREATE PROCEDURE get_monthly_revenue(IN month_num INT, IN year_num INT)
READS SQL DATA
DETERMINISTIC
BEGIN
    SELECT SUM(TotalAmount) AS MonthlyRevenue 
    FROM Visitors 
    WHERE MONTH(VisitDate) = month_num AND YEAR(VisitDate) = year_num;
END //
DELIMITER ;


CALL get_animals_in_habitat(3);
CALL get_animals_handled_by_staff('Emma', 'Watson');
CALL get_animals_from_source_zoo('ZooA');
CALL get_staff_joined_after('2023-01-01');
CALL update_ticket_price(2,'Child', 15);
CALL get_monthly_revenue(7, 2023);



-- FUNCTIONS
DELIMITER //
-- 1.Function to get count of events organized by a specific staff member
CREATE FUNCTION get_event_count_by_staff(first_name VARCHAR(45), last_name VARCHAR(45)) 
RETURNS INT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE event_count INT;

    SELECT COUNT(*) INTO event_count
    FROM ZooEvents e
    JOIN ZooStaff z ON e.ZooStaff_StaffID = z.StaffID
    WHERE z.FirstName = first_name AND z.LastName = last_name;

    RETURN event_count;
END //
DELIMITER ;


-- 2.Function to get count of health checks conducted by a specific veterinarian
DELIMITER //
CREATE FUNCTION get_health_check_count_by_vet(first_name VARCHAR(45), last_name VARCHAR(45)) 
RETURNS INT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE health_check_count INT;

    SELECT COUNT(*) INTO health_check_count
    FROM HealthChecks h
    JOIN ZooStaff z ON h.ZooStaff_StaffID = z.StaffID
    WHERE z.FirstName = first_name AND z.LastName = last_name;

    RETURN health_check_count;
END //
DELIMITER ;


-- 3. Function to get the total donations for a specific event
DELIMITER //
CREATE FUNCTION get_total_donations_for_event(event_id INT) 
RETURNS FLOAT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE total_donation FLOAT;

    SELECT SUM(Amount) INTO total_donation
    FROM Donations
    WHERE ZooEvents_EventID = event_id;

    RETURN total_donation;
END //
DELIMITER ;


-- 4. Function to get the average salary of all staff
DELIMITER //
CREATE FUNCTION get_average_salary() 
RETURNS FLOAT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE avg_salary FLOAT;

    SELECT AVG(Salary) INTO avg_salary
    FROM ZooStaff;

    RETURN avg_salary;
END //
DELIMITER ;


-- 5. Function to count the number of animals in a specific habitat
DELIMITER //
CREATE FUNCTION count_animals_in_habitat(habitat_id INT) 
RETURNS INT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE animal_count INT;

    SELECT COUNT(*) INTO animal_count
    FROM Animals
    WHERE Habitats_HabitatID = habitat_id;

    RETURN animal_count;
END //
DELIMITER ;


SELECT get_event_count_by_staff('Bob', 'Johnson');
SELECT get_health_check_count_by_vet('John', 'Doe');
SELECT get_average_salary();
SELECT count_animals_in_habitat(1);



-- TRIGGERS
DELIMITER //
-- 1. Trigger after an animal is added
CREATE TRIGGER after_animal_inserted
AFTER INSERT ON Animals
FOR EACH ROW
BEGIN
    UPDATE Habitats
    SET MaximumCapacity = MaximumCapacity - 1
    WHERE HabitatID = NEW.Habitats_HabitatID;
END //
DELIMITER ;

INSERT INTO `ZooDB`.`Animals` (`Name`, `Species`, `DateOfBirth`, `Gender`, `Habitats_HabitatID`, `AnimalDiet_DietID`) VALUES 
('Shmulik Hagever', 'Orginal Lion Wallahi', '2018-01-10', 'Male', 3, 1);


-- 2.Trigger to Calculate Total Amount in Visitors when Tickets are Sold 
-- && 10 Precent discount for each visitor buy ticket on August month
DELIMITER //
CREATE TRIGGER CalculateTotalAmountOnInsert
BEFORE INSERT ON Visitors
FOR EACH ROW
BEGIN
    DECLARE ticket_price DECIMAL(10, 2);
	DECLARE Total INT;

    -- Get the ticket price for the visitor's ticket type
    SELECT Price INTO ticket_price
    FROM TicketPricing
    WHERE TicketID = NEW.TicketPricing_TicketID;

    -- Calculate and update the TotalAmount for the visitor
     SET Total = NEW.NumberOfTickets * ticket_price;

    -- Update the Visitors table with the calculated TotalAmount
    IF Total > 0 
    THEN
		SET NEW.TotalAmount = Total;
    END IF;
    
    -- 10 Precent discount for each visitor buy ticket on August month
    IF MONTH(NEW.VisitDate) = 8 
    THEN
        SET NEW.TotalAmount = NEW.TotalAmount * 0.9;  -- Apply a 10% discount
    END IF;
    
END;
//
DELIMITER ;

INSERT INTO `ZooDB`.`Visitors` (`FirstName`, `LastName`, `VisitDate`, `NumberOfTickets`, `TotalAmount`, `TicketPricing_TicketID`) VALUES 
('omer', 'Watson', '2023-08-15', 4, 0 , 2);
-- Drop Trigger CalculateTotalAmountOnInsert;


-- 3. trigger check if there a zoo staff member that are working more than 3 years and update his salary 20 precent more
DELIMITER //
CREATE TRIGGER IncreaseSalaryAfter3Years
BEFORE INSERT ON ZooStaff
FOR EACH ROW
BEGIN
    DECLARE currentDate DATE;
    DECLARE joiningDate DATE;
    DECLARE yearsWorked INT;

    SET currentDate = CURDATE();
    SET joiningDate = NEW.DateOfJoining;
    SET yearsWorked = YEAR(currentDate) - YEAR(joiningDate);

    IF yearsWorked > 3 THEN
        SET NEW.Salary = NEW.Salary * 1.20; -- Increase salary by 20%
    END IF;
END;
//
DELIMITER ;

-- Drop Trigger IncreaseSalaryAfter3Years;

INSERT INTO `ZooDB`.`ZooStaff` (`FirstName`, `LastName`, `Role`, `ContactInfo`, `DateOfJoining`, `Salary`) VALUES 
('bombo', 'tin', 'Veterinarian', 'samira.martin@example.com', '2019-05-10', 50000);


-- 4.trigger make sure only admin staff members can manage or be responsible for zoo events
-- && zoo events can be scheduled for a future date only
DELIMITER //
CREATE TRIGGER CheckAdminForZooEvents
BEFORE INSERT ON ZooEvents
FOR EACH ROW
BEGIN

    DECLARE isAdmin INT;
    DECLARE currentDate DATE;
    
    -- Check if the inserting staff member is an admin
    SELECT COUNT(*) INTO isAdmin
    FROM ZooStaff
    WHERE StaffID = NEW.ZooStaff_StaffID AND Role = 'Admin';

    -- Get the current date
    SET currentDate = CURDATE();

    -- Check if the event date is at least one day in the future
    IF NEW.Date <= currentDate
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'events can only be scheduled for a future date.';
        
    ELSEIF isAdmin = 0 
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Only admin staff can manage zoo events.';
    END IF;
    
END;
//
DELIMITER ;

INSERT INTO `ZooDB`.`ZooEvents` (`Name`, `Date`, `Description`, `TicketPricing`, `ZooStaff_StaffID`) VALUES 
('coco', '2023-09-15', 'pop', 40, 3);


-- 5. ensure that only animals of the same species can be placed in the same habitat
DELIMITER //
CREATE TRIGGER EnforceSameSpeciesInHabitat
BEFORE INSERT ON Animals
FOR EACH ROW
BEGIN
    DECLARE habitat_species VARCHAR(255);
    DECLARE new_species VARCHAR(255);

    -- Get the species of animals already in the habitat
    SELECT GROUP_CONCAT(DISTINCT A.Species) INTO habitat_species
    FROM Animals A
    WHERE A.Habitats_HabitatID = NEW.Habitats_HabitatID;

    -- Get the species of the new animal
    SET new_species = NEW.Species;

    -- Check if there are any species already present in the same habitat
    IF habitat_species IS NOT NULL AND habitat_species != new_species THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Animals of different species cannot be placed in the same habitat.';
    END IF;
END;
//
DELIMITER ;

INSERT INTO `ZooDB`.`Animals` (`Name`, `Species`, `DateOfBirth`, `Gender`, `Habitats_HabitatID`, `AnimalDiet_DietID`) VALUES 
('zozo', 'Eagle', '2018-05-10', 'Male', 5, 1);

-- Drop Trigger EnforceSpeciesInHabitat;
