/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '2018-11-15', 2, TRUE, 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon', '2017-05-12', 5, TRUE, 11);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
(5, 'Charmander', '2020-02-08', 0, FALSE, -11),
(6, 'Plantmon', '2021-11-15', 2, TRUE, -5.7),
(7, 'Squirtle', '1993-04-02', 3, FALSE, -12.13),
(8, 'Angemon', '2005-01-12', 1, TRUE, -45),
(9, 'Boarmon', '2005-01-07', 7, TRUE, 20.4),
(10, 'Blossom', '1998-10-13', 3, TRUE, 17),
(11, 'Ditto', '2022-05-14', 4, TRUE, 22);


INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob',45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = 1
WHERE name NOT LIKE '%mon';

UPDATE animals SET owner_id=1 WHERE name = 'Agumon';
UPDATE animals SET owner_id=2 WHERE name IN ('Pikachu', 'Gabumon');
UPDATE animals SET owner_id=3 WHERE name IN ('Devimon','Plantmon');
UPDATE animals SET owner_id=4 WHERE name IN ('Charmander','Squirtle','Blossom');
UPDATE animals SET owner_id=5 WHERE name IN ('Angemon','Boarmon');

INSERT INTO vets (name, age, date_of_graduation) 
VALUES('William Tatcher', 45,'2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-01-08');


INSERT INTO visits (animal_id, vet_id, visit_date)
SELECT 
    animals.id AS animal_id,
    vets.id AS vet_id,
    visit_dates.visit_date
FROM 
    (VALUES
        ('Agumon', 'William Tatcher', '2020-05-24'),
        ('Agumon', 'Stephanie Mendez', '2020-07-22'),
        ('Gabumon', 'Jack Harkness', '2021-02-02'),
        ('Pikachu', 'Maisy Smith', '2020-01-05'),
        ('Pikachu', 'Maisy Smith', '2020-03-08'),
        ('Pikachu', 'Maisy Smith', '2020-05-14'),
        ('Devimon', 'Stephanie Mendez', '2021-05-04'),
        ('Charmander', 'Jack Harkness', '2021-02-24'),
        ('Plantmon', 'Maisy Smith', '2019-12-21'),
        ('Plantmon', 'William Tatcher', '2020-08-10'),
        ('Plantmon', 'Maisy Smith', '2021-04-07'),
        ('Squirtle', 'Stephanie Mendez', '2019-09-29'),
        ('Angemon', 'Jack Harkness', '2020-10-03'),
        ('Angemon', 'Jack Harkness', '2020-11-04'),
        ('Boarmon', 'Maisy Smith', '2019-01-24'),
        ('Boarmon', 'Maisy Smith', '2019-05-15'),
        ('Boarmon', 'Maisy Smith', '2020-02-27'),
        ('Boarmon', 'Maisy Smith', '2020-08-03'),
        ('Blossom', 'Stephanie Mendez', '2020-05-24'),
        ('Blossom', 'William Tatcher', '2021-01-11')
    ) AS visit_dates (animal_name, vet_name, visit_date)
JOIN animals ON animals.name = visit_dates.animal_name
JOIN vets ON vets.name = visit_dates.vet_name;
