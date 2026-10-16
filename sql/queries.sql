-- Paws & Whiskers Animal Care: example SQL queries
USE paws_whiskers;

-- ============ A) Operations used by the screens ============

-- Add a new pet (OwnerID must exist because of the foreign key)
INSERT INTO Pet (Name, Species, Breed, DOB, Gender, OwnerID)
VALUES ('Rex', 'Dog', 'Labrador', '2020-05-12', 'Male', 1);

-- Record a treatment (3 steps)
INSERT INTO Treatment (TreatmentType, `Date`, Prescription, NextCheckupDate, PetID)
VALUES ('Vaccination', '2024-02-10', 'Rabies Dose 1', '2025-02-10', 1);

INSERT INTO Treatment_Staff (TreatmentID, StaffID, RoleInTreatment)
VALUES (LAST_INSERT_ID(), 1, 'Lead Vet');

INSERT INTO Treatment_Equipment (TreatmentID, EquipmentID)
VALUES (LAST_INSERT_ID(), 1);

-- Delete a treatment safely: remove child rows first, then the parent.
-- Deleting the parent first fails with a foreign key error (integrity protection).
DELETE FROM Treatment_Staff     WHERE TreatmentID = 1;
DELETE FROM Treatment_Equipment WHERE TreatmentID = 1;
DELETE FROM Treatment           WHERE TreatmentID = 1;

-- Search treatment history for a pet by name and date range, newest first
SELECT p.Name AS Pet, t.TreatmentType, t.`Date`, t.NextCheckupDate
FROM Treatment t
JOIN Pet p ON t.PetID = p.PetID
WHERE p.Name = 'Buddy'
  AND t.`Date` BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY t.`Date`;

-- ============ B) Reporting queries ============

-- 1. Dogs owned by people in York
SELECT p.Name AS Pet, o.FirstName, o.LastName
FROM Pet p
JOIN Owner o ON p.OwnerID = o.OwnerID
WHERE p.Species = 'Dog' AND o.Address LIKE '%York%';

-- 2. Change the breed of the pet named 'Max'
UPDATE Pet
SET Breed = 'Golden Retriever'
WHERE Name = 'Max';

-- 3. Treatments carried out in 2023 (annual report)
SELECT TreatmentID, PetID, TreatmentType, `Date`
FROM Treatment
WHERE `Date` BETWEEN '2023-01-01' AND '2023-12-31';

-- 4. Staff with clinical roles (rota planning)
SELECT StaffID, FirstName, LastName, Role
FROM Staff
WHERE Role IN ('Veterinarian', 'Vet Nurse', 'Groomer');

-- 5. Number of pets per species
SELECT Species, COUNT(*) AS PetCount
FROM Pet
GROUP BY Species;

-- 6. Alphabetical list of pets (reception quick search)
SELECT PetID, Name, Species, Breed
FROM Pet
ORDER BY Name ASC;

-- 7. Species with more than two pets
SELECT Species, COUNT(*) AS PetCount
FROM Pet
GROUP BY Species
HAVING COUNT(*) > 2;

-- 8. Frequent patients: pets with more than 3 treatments
SELECT PetID, COUNT(*) AS NumTreatments
FROM Treatment
GROUP BY PetID
HAVING COUNT(*) > 3;

-- 9. All X-ray treatments for a given pet
SELECT TreatmentType, `Date`
FROM Treatment
WHERE PetID = 1 AND TreatmentType = 'X-ray';

-- 10. Correct an incorrect follow-up date
UPDATE Treatment
SET NextCheckupDate = '2024-03-15'
WHERE TreatmentID = 1;
