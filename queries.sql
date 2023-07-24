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