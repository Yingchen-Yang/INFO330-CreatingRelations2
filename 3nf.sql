--type 3nf
CREATE TABLE pokemon_types_3nf (
  type_id INTEGER PRIMARY KEY AUTOINCREMENT,
  type1_name TEXT,
  type2_name TEXT);
  
  INSERT INTO pokemon_types_3nf (type1_name, type2_name)
  SELECT DISTINCT type1,type2
  FROM pokemon_otherinfo_2nf;
 
 --against 3nf
CREATE TABLE pokemon_against_3nf (
  type_id PRIMARY KEY,
 against_bug, against_dark, against_electric, 
 against_fairy, against_fight, against_fire, against_flying, 
 against_ghost, against_grass, against_ground, against_ice, 
 against_normal, against_poison, against_psychic, against_rock, 
 against_steel, against_water);
 
INSERT OR IGNORE INTO pokemon_against_3nf (type_id, against_bug, against_dark, against_electric, 
 against_fairy, against_fight, against_fire, against_flying, 
 against_ghost, against_grass, against_ground, against_ice, 
 against_normal, against_poison, against_psychic, against_rock, 
 against_steel, against_water)
SELECT t.type_id, o.against_bug, o.against_dark, o.against_electric, 
 o.against_fairy, o.against_fight, o.against_fire, o.against_flying, 
 o.against_ghost, o.against_grass, o.against_ground, o.against_ice, 
 o.against_normal, o.against_poison, o.against_psychic, o.against_rock, 
 o.against_steel, o.against_water
FROM pokemon_types_3nf t
JOIN pokemon_otherinfo_2nf o ON t.type1_name = o.type1 AND t.type2_name = o.type2;

--abilities id 3nf
CREATE TABLE pokemon_abilitiesid_3nf (
  abilities_id INTEGER PRIMARY KEY AUTOINCREMENT,
  abilities TEXT);
  
  INSERT INTO pokemon_abilitiesid_3nf (abilities)
  SELECT DISTINCT TRIM(abilities)
  FROM pokemon_abilities_2nf;
  
  --trim abilities
UPDATE pokemon_abilities_2nf
SET abilities = TRIM(abilities);

--abilties and poke number 3nf
 CREATE TABLE pokemon_abilities_pokemonid_3nf (
  pokedex_number,
  abilities_id
  );
  
INSERT INTO pokemon_abilities_pokemonid_3nf (pokedex_number, abilities_id)
SELECT a.pokedex_number, i.abilities_id
FROM pokemon_abilities_2nf a
JOIN pokemon_abilitiesid_3nf i ON a.abilities = i.abilities;

  
