/* Animals */
INSERT INTO animals (
    id,
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg )
VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg )
VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8.0);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg )
VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg )
VALUES (4, 'Devimon', '2017-05-12', 5, true, 11.0);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg )
VALUES (5, 'Charmander', '2020-02-8', 0, false, -11.0),
(6, 'Plantmon', '2021-11-15', 2, true, -5.7),
(7, 'Squirtle', '1993-04-02', 3, false, -12.13),
(8, 'Angemon', '2005-06-12', 1, true, -45.0),
(9, 'Boarmon', '2005-06-07', 7, true, 20.4),
(10, 'Blossom', '1998-02-13', 3, true, 17.0),
(11, 'Ditto', '2022-05-14', 4, true, 22.0);

/* Owners */
-- Insert data into owners table
INSERT INTO owners ( full_name, age )
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- Modify owners_id column
UPDATE animals
SET owners_id = 1
WHERE name = 'Agumon';

UPDATE animals
SET owners_id = 2
WHERE name IN ('Pikachu', 'Gabumon');

UPDATE animals
SET owners_id = 3
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owners_id = 4
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owners_id = 5
WHERE name IN ('Angemon', 'Boarmon');

/* Species */
-- Insert data into species table
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

-- Modify species_id column
UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = 1
WHERE name NOT LIKE '%mon';

/* Vets */
INSERT INTO vets(name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

/* Specializations */
INSERT INTO specializations(vet_id, species_id)
VALUES (1, 1), (3, 1), (3, 2), (4,2);

/* Visits */
INSERT INTO visits(vet_id, animals_id, date_of_visit)
VALUES (1, 1, '2020-05-24'),
(3, 1, '2020-07-22'),
(4, 2, '2021-02-02'),
(3, 2, '2020-01-05'),
(3, 2, '2020-03-08'),
(3, 2, '2020-05-14'),
(3, 4, '2021-05-04'),
(4, 5, '2021-02-24'),
(2, 6, '2019-12-21'),
(1, 6, '2020-08-10'),
(2, 6, '2021-04-07'),
(3, 7, '2019-09-29'),
(4, 8, '2020-10-03'),
(4, 8, '2020-11-04'),
(2, 9, '2019-01-24'),
(2, 9, '2019-05-15'),
(2, 9, '2020-02-27'),
(2, 9, '2020-08-03'),
(3, 10, '2020-05-24'),
(1, 10, '2021-01-11');
