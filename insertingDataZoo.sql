-- Inserting data into Habitats

INSERT INTO `ZooDB`.`Habitats` (`Type`, `Size`, `Location`, `MaximumCapacity`) VALUES 
('Aquatic', 500, 'North Wing', 15),
('Desert', 300, 'West Wing', 10),
('Forest', 700, 'East Wing', 20),
('Jungle', 800, 'South Wing', 25),
('Mountain', 600, 'Central Wing', 12),
('Savannah', 1000, 'West Wing', 30);


-- Inserting data into ZooStaff
INSERT INTO `ZooDB`.`ZooStaff` (`FirstName`, `LastName`, `Role`, `ContactInfo`, `DateOfJoining`, `Salary`) VALUES 
('John', 'Doe', 'Veterinarian', 'john.doe@example.com', '2020-01-15', 75000),
('Alice', 'Smith', 'Caretaker', 'alice.smith@example.com', '2019-03-10', 50000),
('Bob', 'Johnson', 'Admin', 'bob.johnson@example.com', '2018-06-05', 65000),
('Eve', 'Martin', 'Veterinarian', 'eve.martin@example.com', '2017-05-10', 77000),
('Derek', 'Wilson', 'Caretaker', 'derek.wilson@example.com', '2016-08-12', 52000),
('Nina', 'Garcia', 'Admin', 'nina.garcia@example.com', '2019-10-04', 68000);


-- Inserting data into AnimalDiet
INSERT INTO `ZooDB`.`AnimalDiet` (`FoodType`, `Quantity`, `FeedingTime`, `ZooStaff_StaffID`) VALUES 
('Meat', 5, '10:00:00', 2),
('Fish', 3, '11:00:00', 2),
('Grass', 4, '09:00:00', 2),
('Meat', 6, '09:30:00', 4),
('Plankton', 30, '12:00:00', 4),
('Rats', 2, '14:00:00', 5);


-- Inserting data into Animals
-- Note: Inserting without AnimalTransfer foreign keys initially. We'll update them later.
INSERT INTO `ZooDB`.`Animals` (`Name`, `Species`, `DateOfBirth`, `Gender`, `Habitats_HabitatID`, `AnimalDiet_DietID`) VALUES 
('Leo', 'Lion', '2018-01-10', 'Male', 3, 1),
('Koko', 'Lion', '2018-09-10', 'Male', 3, 1),
('Aqua', 'Dolphin', '2014-08-15', 'Female', 1, 2),
('Bambi', 'Deer', '2012-08-20', 'Female', 2, 3),
('Rocky', 'Eagle', '2016-09-20', 'Male', 5, NULL),
('Simba', 'Lion', '2019-04-15', 'Male', 4, 3),
('Sarabi', 'Lion', '2017-06-25', 'Female', 6, 1),
('Lolo', 'Dolphin', '2017-03-15', 'Female', 1, 2),
('Bambi', 'Deer', '2015-08-20', 'Female', 2, 3),
('Koko', 'Lion', '2018-05-10', 'Male', 4, 1),
('Smath', 'Lion', '2019-04-15', 'Male',6, 3),
('Toto', 'Eagle', '2012-02-20', 'Male',5, 4);


-- Inserting data into HealthChecks
INSERT INTO `ZooDB`.`HealthChecks` (`DateOfCheck`, `Results`, `Recommendations`, `ZooStaff_StaffID`, `Animals_AnimalID`) VALUES 
('2023-05-15', 'Healthy', 'Regular diet', 1, 1),
('2023-06-10', 'Requires Attention', 'More exercise needed', 1, 2),
('2023-07-05', 'Healthy', 'No changes required', 1, 3);


-- Inserting data into TicketPricing
INSERT INTO `ZooDB`.`TicketPricing` (`Type`, `Price`) VALUES 
('Adult', 30),
('Child', 20),
('Senior', 25),
('Student', 20);


-- Inserting data into Visitors
INSERT INTO `ZooDB`.`Visitors` (`FirstName`, `LastName`, `VisitDate`, `NumberOfTickets`, `TotalAmount`, `TicketPricing_TicketID`) VALUES 
('Emma', 'Watson', '2023-07-15', 2, 60, 1),
('Chris', 'Evans', '2023-07-20', 3, 90, 2),
('Robert', 'Downey', '2023-08-10', 4, 100, 1),
('Scarlett', 'Johansson', '2023-08-12', 5, 125, 1);


-- Inserting data into ZooEvents
INSERT INTO `ZooDB`.`ZooEvents` (`Name`, `Date`, `Description`, `TicketPricing`, `ZooStaff_StaffID`) VALUES 
('Summer Fest', '2023-08-15', 'A fun summer event ', 30, 3),
('Winter Wonderland', '2023-12-20', 'Enjoy the zoo in a winter ', 30, 3),
('Spring Gala', '2023-04-15', 'A special event to welcome spring', 40, 6),
('Animal Birthday Party', '2023-05-05', 'Celebrate the birthdays of the animals', 25, 3);


-- Inserting data into Donations
INSERT INTO `ZooDB`.`Donations` (`DonorName`, `Amount`, `Date`, `ZooEvents_EventID`) VALUES 
('Tony Stark', 1000, '2023-08-15', 1),
('Natasha Romanoff', 500, '2023-12-20', 2),
('Bruce Banner', 750, '2023-04-15', 3),
('Steve Rogers', 1000, '2023-05-05', 4),
('Jojo', 750, '2023-04-15', 4),
('William ols', 50, '2023-04-15', 4),
('Bruce Banner', 750, '2023-04-15', 4),
('Laupotra', 2000, '2023-04-15', 3),
('Banner Luis', 10000, '2023-04-15', 2),
('Nono', 1400, '2023-08-15', 1);



-- Inserting data into Maintenance
INSERT INTO `ZooDB`.`Maintenance` (`Date`, `Description`, `Habitats_HabitatID`, `ZooStaff_StaffID`) VALUES 
('2023-06-15', 'Cleaned the water tank', 1, 2),
('2023-06-20', 'Replaced sand in the habitat', 2, 2),
('2023-06-25', 'Pruned trees', 3, 2),
('2023-04-25', 'General cleaning and repair', 4, 5),
('2023-05-02', 'Replacement of equipment', 5, 6),
('2023-05-10', 'Installation of new facilities', 3, 4);


-- Inserting data into Feedbacks
INSERT INTO `ZooDB`.`Feedbacks` (`Comments`, `Date`, `Visitors_VisitorID`) VALUES 
('Loved the dolphin show!', '2023-07-15', 1),
('The winter theme was amazing!', '2023-12-20', 2),
('Great initiative animal birthday party!', '2023-05-05', 3),
('The spring event was fantastic!', '2023-04-15', 4);



-- Inserting more data into AnimalTransfer
INSERT INTO `ZooDB`.`AnimalTransfer` (`SourceZoo`, `DestinationZoo`, `AnimalID`, `TransferDate`) VALUES 
('ZooA', 'ZooB', 4, '2022-05-15'),
('ZooC', 'ZooA', 5, '2022-06-10'),
('ZooB', 'ZooC', 6, '2022-07-05');
