-- Paws & Whiskers Animal Care: Vet Clinic Database
-- Schema: 5 entity tables + 2 junction tables (MySQL)
-- Run this file first, then sample-data.sql, then try queries.sql

CREATE DATABASE IF NOT EXISTS paws_whiskers;
USE paws_whiskers;

CREATE TABLE Owner (
  OwnerID   INT AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  LastName  VARCHAR(50) NOT NULL,
  Address   VARCHAR(200),
  Phone     VARCHAR(20),
  Email     VARCHAR(100)
);

CREATE TABLE Pet (
  PetID   INT AUTO_INCREMENT PRIMARY KEY,
  Name    VARCHAR(50) NOT NULL,
  Species VARCHAR(50) NOT NULL,
  Breed   VARCHAR(50),
  DOB     DATE,
  Gender  VARCHAR(10),
  OwnerID INT NOT NULL,
  FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID)
);

CREATE TABLE Staff (
  StaffID       INT AUTO_INCREMENT PRIMARY KEY,
  FirstName     VARCHAR(50) NOT NULL,
  LastName      VARCHAR(50) NOT NULL,
  DOB           DATE,
  Qualification VARCHAR(100),
  Role          VARCHAR(50),
  Phone         VARCHAR(20),
  Email         VARCHAR(100),
  Address       VARCHAR(200)
);

CREATE TABLE Treatment (
  TreatmentID     INT AUTO_INCREMENT PRIMARY KEY,
  TreatmentType   VARCHAR(100) NOT NULL,
  `Date`          DATE NOT NULL,
  Prescription    TEXT,
  NextCheckupDate DATE,
  PetID           INT NOT NULL,
  FOREIGN KEY (PetID) REFERENCES Pet(PetID)
);

CREATE TABLE Equipment (
  EquipmentID        INT AUTO_INCREMENT PRIMARY KEY,
  EquipmentType      VARCHAR(50) NOT NULL,
  MaintenanceDate    DATE,
  AvailabilityStatus VARCHAR(20)
);

-- Junction tables for many-to-many relationships
CREATE TABLE Treatment_Staff (
  TreatmentID     INT NOT NULL,
  StaffID         INT NOT NULL,
  RoleInTreatment VARCHAR(50),
  PRIMARY KEY (TreatmentID, StaffID),
  FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID),
  FOREIGN KEY (StaffID)     REFERENCES Staff(StaffID)
);

CREATE TABLE Treatment_Equipment (
  TreatmentID INT NOT NULL,
  EquipmentID INT NOT NULL,
  PRIMARY KEY (TreatmentID, EquipmentID),
  FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID),
  FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);
