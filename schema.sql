/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id int PRIMARY KEY NOT NULL,
    name varchar(80),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal
);

ALTER TABLE animals ADD COLUMN species varchar(100);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name varchar(100),
    age int
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name varchar(100)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_ID INT REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owners_id INT REFERENCES owners(id);