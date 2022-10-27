SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-01-01';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.4;

/* Update animals table using transactions */
-- Set the species column to unspecified
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

-- Set the species column to digimon for all animals that have a name ending in mon.
-- Set the species column to pokemon for all animals that don't have species already set.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT species FROM animals;

-- Delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT save1;
UPDATE animals SET weight_kg = weight_kg*-1;
ROLLBACK TO save1;
UPDATE animals SET weight_kg = weight_kg*-1 WHERE weight_kg < 0;
COMMIT;
SELECT weight_kg FROM animals;

/* Write queries to answer questions */
-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2001-01-01' GROUP BY species;

/* Write queries to answer questions */
-- What animals belong to Melody Pond?
SELECT name FROM animals JOIN owners
ON animals.owners_id = owners.id
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals JOIN species
ON animals.species_id = species.id
WHERE species_id = 1;

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT name, full_name FROM animals RIGHT JOIN owners
ON animals.owners_id = owners.id;

-- How many animals are there per species?
SELECT COUNT(*) FROM animals JOIN species
ON animals.species_id = species.id 
GROUP BY species;

-- List all Digimon owned by Jennifer Orwell.
SELECT name FROM animals JOIN owners
ON animals.owners_id = owners.id 
WHERE full_name = 'Jennifer Orwell' AND species_id = 2;

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals JOIN owners
ON animals.owners_id = owners.id 
WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
SELECT COUNT(*) AS owners_count, owners.full_name
FROM animals JOIN owners ON owners.id = animals.owners_id
GROUP BY owners.full_name ORDER BY owners_count DESC LIMIT 1;

/* Write queries to answer questions */
-- Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.date_of_visit FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT(date_of_visit) 
FROM visits LEFT JOIN vets ON visits.vet_id = vets.id
WHERE name = 'Stephanie Mendez'
GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets JOIN specializations
ON vets.id = specializations.vet_id JOIN species
ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM animals JOIN visits
ON animals.id = visits.animals_id JOIN vets
ON vets.id = visits.vet_id
WHERE vets.id = 3 AND visits.date_of_visit >='2020-04-04' AND visits.date_of_visit <='2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(*) FROM visits JOIN animals
ON animals.id = visits.animals_id 
GROUP BY animals.name
ORDER BY COUNT DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name AS animal_name, vets.name AS vet_name, visits.date_of_visit 
FROM visits JOIN animals ON animals.id = visits.animals_id 
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'	
ORDER BY visits.date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.id AS animal_id, animals.name AS animal_name, animals.date_of_birth,
vets.id AS vet_id, vets.name AS vet_name, vets.age AS vet_age, date_of_visit 
FROM visits JOIN animals ON animals.id = visits.animals_id 
JOIN vets ON vets.id = visits.vet_id;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM visits JOIN vets
ON vets.id = visits.vet_id
WHERE vets.id = 2;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(visits.animals_id) FROM visits
JOIN vets ON visits.vet_id = vets.id FULL JOIN animals
ON visits.animals_id = animals.id JOIN species 
ON species.id = animals.species_id WHERE vets.id = 2
GROUP BY species.name;
