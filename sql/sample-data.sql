-- Small illustrative dataset so the example queries return results.
-- This is made-up sample data, not real clinic records.
USE paws_whiskers;

INSERT INTO Owner (FirstName, LastName, Address, Phone, Email) VALUES
('Sarah', 'Thompson', '12 Micklegate, York',        '01904 000001', 'sarah.t@example.com'),
('James', 'Wilson',   '5 Bishopthorpe Road, York',  '01904 000002', 'james.w@example.com'),
('Emily', 'Clarke',   '8 High Street, Leeds',       '0113 000003',  'emily.c@example.com');

INSERT INTO Pet (Name, Species, Breed, DOB, Gender, OwnerID) VALUES
('Buddy', 'Dog',    'Beagle',   '2021-05-15', 'Male',   1),
('Max',   'Dog',    'Labrador', '2019-03-02', 'Male',   2),
('Luna',  'Cat',    'Siamese',  '2020-09-21', 'Female', 2),
('Bella', 'Dog',    'Poodle',   '2018-11-30', 'Female', 3),
('Milo',  'Cat',    'Tabby',    '2022-01-10', 'Male',   3),
('Coco',  'Rabbit', 'Dwarf',    '2023-04-05', 'Female', 1);

INSERT INTO Staff (FirstName, LastName, Role, Qualification) VALUES
('Anna', 'Patel', 'Veterinarian', 'BVSc'),
('Tom',  'Reed',  'Vet Nurse',    'Veterinary Nursing Diploma'),
('Lisa', 'Gray',  'Groomer',      'Animal Grooming Certificate'),
('Mark', 'Hall',  'Receptionist', NULL);

INSERT INTO Equipment (EquipmentType, MaintenanceDate, AvailabilityStatus) VALUES
('X-ray Machine',      '2024-01-15', 'Available'),
('Ultrasound Scanner', '2024-02-01', 'Available'),
('Grooming Table',     '2024-03-10', 'In use');

INSERT INTO Treatment (TreatmentType, `Date`, Prescription, NextCheckupDate, PetID) VALUES
('Check-up',    '2023-03-12', NULL,            '2024-03-12', 1),
('X-ray',       '2024-02-10', NULL,            '2024-08-10', 1),
('Vaccination', '2024-06-10', 'Rabies dose 1', '2025-06-10', 1),
('Dental',      '2024-09-15', NULL,            '2025-09-15', 1),
('Vaccination', '2023-07-20', 'Booster',       '2024-07-20', 2),
('Check-up',    '2023-11-02', NULL,            '2024-11-02', 3);

INSERT INTO Treatment_Staff (TreatmentID, StaffID, RoleInTreatment) VALUES
(1, 1, 'Lead Vet'), (2, 1, 'Lead Vet'), (2, 2, 'Assistant'),
(3, 1, 'Lead Vet'), (4, 1, 'Lead Vet'), (5, 1, 'Lead Vet'), (6, 2, 'Nurse');

INSERT INTO Treatment_Equipment (TreatmentID, EquipmentID) VALUES
(2, 1), (4, 2);
