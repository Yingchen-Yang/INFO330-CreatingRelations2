-- update one value
UPDATE imported_pokemon_data
SET capture_rate = 285
WHERE pokedex_number=774;

--spilt abilties
CREATE TABLE pokemon_abilities AS
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

--combine and make it 1nf
CREATE TABLE pokemon_1nf AS
SELECT i.pokedex_number, p.abilities, i.against_bug, i.against_dark, 
i.against_electric, i.against_fairy, i.against_fight, i.against_fire, 
i.against_flying, i.against_ghost, i.against_grass, i.against_ground,
 i.against_ice, i.against_normal, i.against_poison, i.against_psychic, 
 i.against_rock, i.against_steel, i.against_water, i.attack, i.base_egg_steps,
 i.base_happiness, i.base_total, i.capture_rate, i.classfication, i.defense, 
 i.experience_growth, i.height_m, i.hp, i.name, i.percentage_male, i. sp_attack, 
 i.sp_defense, i.speed, i.type1, i.type2, i.weight_kg, i.generation, i.is_legendary
FROM imported_pokemon_data i
JOIN pokemon_abilities p ON i.pokedex_number = p.pokedex_number;