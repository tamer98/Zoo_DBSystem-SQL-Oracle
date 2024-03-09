-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ZooDB
-- -----------------------------------------------------
-- DROP Schema `ZooDB`; -- drop the schema
-- -----------------------------------------------------
-- Schema ZooDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ZooDB` DEFAULT CHARACTER SET utf8 ;
USE `ZooDB`;

-- -----------------------------------------------------
-- Table `ZooDB`.`Habitats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZooDB`.`Habitats` (
  `HabitatID` INT NOT NULL AUTO_INCREMENT,
  `Type` VARCHAR(255) NULL,
  `Size` INT NULL,
  `Location` VARCHAR(255) NULL,
  `MaximumCapacity` INT NULL,
  PRIMARY KEY (`HabitatID`),
  UNIQUE INDEX `HabitatID_UNIQUE` (`HabitatID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ZooDB`.`AnimalTransfer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZooDB`.`AnimalTransfer` (
  `TransferID` INT NOT NULL AUTO_INCREMENT,
  `SourceZoo` VARCHAR(255) NULL,
  `DestinationZoo` VARCHAR(255) NULL,
  `AnimalID` INT NULL,
  `TransferDate` DATETIME NULL,
  PRIMARY KEY (`TransferID`),
  UNIQUE INDEX `TransferID_UNIQUE` (`TransferID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ZooDB`.`ZooStaff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZooDB`.`ZooStaff` (
  `StaffID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(255) NULL,
  `LastName` VARCHAR(255) NULL,
  `Role` VARCHAR(255) NULL,
  `ContactInfo` VARCHAR(255) NULL,
  `DateOfJoining` DATETIME NULL,
  `Salary` FLOAT NULL,
  PRIMARY KEY (`StaffID`),
  UNIQUE INDEX `StaffID_UNIQUE` (`StaffID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ZooDB`.`AnimalDiet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZooDB`.`AnimalDiet` (
  `DietID` INT NOT NULL AUTO_INCREMENT,
  `FoodType` VARCHAR(255) NULL,
  `Quantity` INT NULL,
  `FeedingTime` TIME NULL,
  `ZooStaff_StaffID` INT NOT NULL,
  PRIMARY KEY (`DietID`),
  INDEX `fk_AnimalDiet_ZooStaff1_idx` (`ZooStaff_StaffID` ASC) VISIBLE,
  UNIQUE INDEX `DietID_UNIQUE` (`DietID` ASC) VISIBLE,
  CONSTRAINT `fk_AnimalDiet_ZooStaff1`
    FOREIGN KEY (`ZooStaff_StaffID`)
    REFERENCES `ZooDB`.`ZooStaff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ZooDB`.`Animals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZooDB`.`Animals` (
  `AnimalID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NULL,
  `Species` VARCHAR(255) NULL,
  `DateOfBirth` DATETIME NULL,
  `Gender` VARCHAR(255) NULL,
  `Habitats_HabitatID` INT NOT NULL,
  `AnimalTransfer_TransferID` INT NULL,
  `AnimalDiet_DietID` INT NULL,
  PRIMARY KEY (`AnimalID`),
  INDEX `fk_Animals_Habitats1_idx` (`Habitats_HabitatID` ASC) VISIBLE,
  INDEX `fk_Animals_AnimalTransfer1_idx` (`AnimalTransfer_TransferID` ASC) VISIBLE,
  INDEX `fk_Animals_AnimalDiet1_idx` (`AnimalDiet_DietID` ASC) VISIBLE,
  UNIQUE INDEX `AnimalID_UNIQUE` (`AnimalID` ASC) VISIBLE,
  CONSTRAINT `fk_Animals_Habitats1`
    FOREIGN KEY (`Habitats_HabitatID`)
    REFERENCES `ZooDB`.`Habitats` (`HabitatID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Animals_AnimalTransfer1`
    FOREIGN KEY (`AnimalTransfer_TransferID`)
    REFERENCES `ZooDB`.`AnimalTransfer` (`TransferID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Animals_AnimalDiet1`
    FOREIGN KEY (`AnimalDiet_DietID`)
    REFERENCES `ZooDB`.`AnimalDiet` (`DietID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ZooDB`.`Maintenance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZooDB`.`Maintenance` (
  `MaintenanceID` INT NOT NULL AUTO_INCREMENT,
  `Date` DATETIME NULL,
  `Description` VARCHAR(255) NULL,
  `Habitats_HabitatID` INT NOT NULL,
  `ZooStaff_StaffID` INT NOT NULL,
  PRIMARY KEY (`MaintenanceID`),
  INDEX `fk_Maintenance_Habitats1_idx` (`Habitats_HabitatID` ASC) VISIBLE,
  INDEX `fk_Maintenance_ZooStaff1_idx` (`ZooStaff_StaffID` ASC) VISIBLE,
  UNIQUE INDEX `MaintenanceID_UNIQUE` (`MaintenanceID` ASC) VISIBLE,
  CONSTRAINT `fk_Maintenance_Habitats1`
    FOREIGN KEY (`Habitats_HabitatID`)
    REFERENCES `ZooDB`.`Habitats` (`HabitatID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Maintenance_ZooStaff1`
    FOREIGN KEY (`ZooStaff_StaffID`)
    REFERENCES `ZooDB`.`ZooStaff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ZooDB`.`HealthChecks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZooDB`.`HealthChecks` (
  `CheckID` INT NOT NULL AUTO_INCREMENT,
  `DateOfCheck` DATETIME NULL,
  `Results` VARCHAR(255) NULL,
  `Recommendations` VARCHAR(255) NULL,
  `ZooStaff_StaffID` INT NOT NULL,
  `Animals_AnimalID` INT NOT NULL,
  PRIMARY KEY (`CheckID`),
  INDEX `fk_HealthChecks_ZooStaff1_idx` (`ZooStaff_StaffID` ASC) VISIBLE,
  INDEX `fk_HealthChecks_Animals1_idx` (`Animals_AnimalID` ASC) VISIBLE,
  UNIQUE INDEX `CheckID_UNIQUE` (`CheckID` ASC) VISIBLE,
  CONSTRAINT `fk_HealthChecks_ZooStaff1`
    FOREIGN KEY (`ZooStaff_StaffID`)
    REFERENCES `ZooDB`.`ZooStaff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HealthChecks_Animals1`
    FOREIGN KEY (`Animals_AnimalID`)
    REFERENCES `ZooDB`.`Animals` (`AnimalID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ZooDB`.`TicketPricing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZooDB`.`TicketPricing` (
  `TicketID` INT NOT NULL AUTO_INCREMENT,
  `Type` VARCHAR(255) NULL,
  `Price` FLOAT NULL,
  PRIMARY KEY (`TicketID`),
  UNIQUE INDEX `TicketID_UNIQUE` (`TicketID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ZooDB`.`Visitors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZooDB`.`Visitors` (
  `VisitorID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(255) NULL,
  `LastName` VARCHAR(255) NULL,
  `VisitDate` DATETIME NULL,
  `NumberOfTickets` INT NULL,
  `TotalAmount` FLOAT NULL,
  `TicketPricing_TicketID` INT NOT NULL,
  PRIMARY KEY (`VisitorID`),
  INDEX `fk_Visitors_TicketPricing1_idx` (`TicketPricing_TicketID` ASC) VISIBLE,
  UNIQUE INDEX `VisitorID_UNIQUE` (`VisitorID` ASC) VISIBLE,
  CONSTRAINT `fk_Visitors_TicketPricing1`
    FOREIGN KEY (`TicketPricing_TicketID`)
    REFERENCES `ZooDB`.`TicketPricing` (`TicketID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ZooDB`.`ZooEvents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZooDB`.`ZooEvents` (
  `EventID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NULL,
  `Date` DATETIME NULL,
  `Description` VARCHAR(255) NULL,
  `TicketPricing` FLOAT NULL,
  `ZooStaff_StaffID` INT NOT NULL,
  PRIMARY KEY (`EventID`),
  INDEX `fk_ZooEvents_ZooStaff1_idx` (`ZooStaff_StaffID` ASC) VISIBLE,
  UNIQUE INDEX `EventID_UNIQUE` (`EventID` ASC) VISIBLE,
  CONSTRAINT `fk_ZooEvents_ZooStaff1`
    FOREIGN KEY (`ZooStaff_StaffID`)
    REFERENCES `ZooDB`.`ZooStaff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ZooDB`.`Donations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZooDB`.`Donations` (
  `DonationID` INT NOT NULL AUTO_INCREMENT,
  `DonorName` VARCHAR(255) NULL,
  `Amount` FLOAT NULL,
  `Date` DATETIME NULL,
  `ZooEvents_EventID` INT NOT NULL,
  PRIMARY KEY (`DonationID`),
  INDEX `fk_Donations_ZooEvents1_idx` (`ZooEvents_EventID` ASC) VISIBLE,
  UNIQUE INDEX `DonationID_UNIQUE` (`DonationID` ASC) VISIBLE,
  CONSTRAINT `fk_Donations_ZooEvents1`
    FOREIGN KEY (`ZooEvents_EventID`)
    REFERENCES `ZooDB`.`ZooEvents` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ZooDB`.`Feedbacks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZooDB`.`Feedbacks` (
  `FeedbackID` INT NOT NULL AUTO_INCREMENT,
  `Comments` VARCHAR(255) NULL,
  `Date` DATETIME NULL,
  `Visitors_VisitorID` INT NOT NULL,
  PRIMARY KEY (`FeedbackID`),
  INDEX `fk_Feedbacks_Visitors1_idx` (`Visitors_VisitorID` ASC) VISIBLE,
  UNIQUE INDEX `FeedbackID_UNIQUE` (`FeedbackID` ASC) VISIBLE,
  CONSTRAINT `fk_Feedbacks_Visitors1`
    FOREIGN KEY (`Visitors_VisitorID`)
    REFERENCES `ZooDB`.`Visitors` (`VisitorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
