/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

--setting the species column to unspecified
BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

--Update the species column to digimon for all animals that have a name ending in mon
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species = 'NULL' OR species = '';
SELECT * FROM animals;

COMMIT;
SELECT * FROM animals;

--delete all records in the animals table

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;

--Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE FROM animals
WHERE date_of_birth  > '2022-01-01';
--
BEGIN
SAVEPOINT sp1;

UPDATE animals
SET weight_kg  = weight_kg  * -1;
ROLLBACK TO SAVEPOINT sp1;


UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS average_escape_attempts FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

 SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
 GROUP BY neutered;

SELECT full_name, name FROM animals
INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.id = 4;

SELECT animals.name, species.name FROM animals 
INNER JOIN species  ON animals.species_id = species.id WHERE species.id = 1;

SELECT species.name, COUNT(*) FROM animals INNER JOIN species ON animals.species_id = species.id
INNER JOIN owners ON animals.owner_id = owners.id GROUP BY species.name;

SELECT * FROM animals 
INNER JOIN owners ON animals.owner_id = owners.id
INNER JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT * FROM animals 
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name as owner, COUNT(*) as total_animals
FROM animals    
JOIN owners         
ON animals.owner_id = owners.id
GROUP BY owner
ORDER BY total_animals DESC
LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT a.name AS animal_name
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS vet ON vet.id = v.vet_id
WHERE vet.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT v.animal_id) AS animal_count
FROM visits AS v
JOIN vets AS vet ON vet.id = v.vet_id
WHERE vet.name = 'Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet_name, species.name AS specialty
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id
ORDER BY vet_name;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS animal_name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
AND visits.visit_date >= '2020-04-01'
AND visits.visit_date <= '2020-08-30';

--What animal has the most visits to vets?
SELECT animals.name AS animal_name, COUNT(visits.id) AS visit_count
FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.id
ORDER BY visit_count DESC
LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT animals.name AS animal_name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date
LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.visit_date DESC
LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS mismatched_specialties_count
FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS vet ON vet.id = v.vet_id
LEFT JOIN specializations AS s ON vet.id = s.vet_id AND a.species_id = s.species_id
WHERE s.id IS NULL;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT sp.name AS specialty, COUNT(*) AS visit_count
FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS vet ON vet.id = v.vet_id
JOIN specializations AS s ON vet.id = s.vet_id
JOIN species AS sp ON sp.id = s.species_id
WHERE vet.name = 'Maisy Smith'
GROUP BY sp.id
ORDER BY visit_count DESC
LIMIT 1;




