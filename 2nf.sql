--pokemon otherinfo 2nf
CREATE TABLE pokemon_otherinfo_2nf AS
SELECT pokedex_number, against_bug, against_dark, against_electric, against_fairy, against_fight, 
against_fire, against_flying, against_ghost, against_grass, against_ground, against_ice, 
against_normal, against_poison, against_psychic, against_rock, against_steel, against_water, 
attack, base_egg_steps, base_happiness, base_total, capture_rate, classfication, defense, 
experience_growth, height_m, hp, name, percentage_male, sp_attack, 
sp_defense, speed, type1, type2, weight_kg, generation, is_legendary
FROM imported_pokemon_data;

--abilities 2nf
CREATE TABLE pokemon_abilities_2nf AS
WITH split (pokedex_number, abilities, nextabilities) AS (
    SELECT pokedex_number, '' AS abilities, abilities||',' AS nextabilities
    FROM imported_pokemon_data
    UNION ALL
    SELECT pokedex_number, 
        substr(nextabilities, 0, instr(nextabilities,',')) AS abilities,
        substr(nextabilities, instr(nextabilities, ',')+1) AS nextabilities
    FROM split
    WHERE nextabilities !=''
)
SELECT DISTINCT pokedex_number, abilities
FROM split
WHERE abilities !=''
ORDER BY CAST(pokedex_number AS UNSIGNED);

