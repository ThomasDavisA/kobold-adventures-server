BEGIN;

TRUNCATE
    resolutions,
    encounters,
    locations,
    kobolds,
    users
    RESTART IDENTITY CASCADE;

INSERT INTO users (username, password)
VALUES
    ('dunder', 'password'),
    ('maria', 'password2'),
    ('jacob', 'password3');

INSERT INTO kobolds (user_id, kobold_name, kobold_level)
VALUES
    (1, 'Bobbles', 2),
    (2, 'Jarjar', 4),
    (3, 'Blinky', 10);

INSERT INTO locations (location_name, location_description, location_level)
VALUES
    ('The Forest', 'A test area.', 1),
    ('The Lake', 'A test area 2', 3),
    ('The Town', 'A test area 3.', 8);

INSERT INTO encounters (location_id, encounter_name, encounter_text, encounter_level, encounter_base_difficulty, encounter_base_reward)
VALUES 
    (1, 'A Slime!', 'A slime blocks you!', 1, 1, 1),
    (1, 'A Blue Slime!', 'A slime blocks you!', 3, 1, 1),
    (1, 'A Red Slime!', 'A slime blocks you!', 8, 1, 1),
    (2, 'Another Kobold!', 'A kobold blocks you!', 3, 1, 1),
    (2, 'A big Kobold!', 'A bigger kobold blocks you!', 5, 1, 1),
    (2, 'A giant Kobold!', 'A massive kobold blocks you!', 10, 1, 1),
    (3, 'A guard!', 'A guard blocks you!', 8, 1, 1),
    (3, 'A captain!', 'The captain blocks you!', 10, 1, 1),
    (3, 'A king!', 'The King blocks you!', 20, 1, 1);

INSERT INTO resolutions (encounter_id, resolution_name, resolution_action, resolution_stat, resolution_success, resolution_fail)
VALUES 
    (1, 'Poke it!', 'Muscle', 10, 'You poke the Slime!', 'Oops, the slime poked you...'),
    (1, 'Jump over!', 'Fitness', 5, 'You leap over the Slime!', 'Oops, you land on the slime.  Eww...'),
    (1, 'Zap it!', 'Mana', 15, 'You zap the slime!', 'You do not quite zap it...'),
    (1, 'Reason it!', 'Intellect', 10, 'You convince the slime to move!', 'The slime wobbles.  Oops, its not moving...'),
    (1, 'Dance!', 'Eloquence', 5, 'The slime wobbles out the way!', 'The slime wobbles against you.  Eww...'),
    (2, 'Poke it!', 'Muscle', 10, 'You poke the Slime!', 'Oops, the slime poked you...'),
    (2, 'Jump over!', 'Fitness', 5, 'You leap over the Slime!', 'Oops, you land on the slime.  Eww...'),
    (2, 'Zap it!', 'Mana', 15, 'You zap the slime!', 'You do not quite zap it...'),
    (2, 'Reason it!', 'Intellect', 10, 'You convince the slime to move!', 'The slime wobbles.  Oops, its not moving...'),
    (2, 'Dance!', 'Eloquence', 5, 'The slime wobbles out the way!', 'The slime wobbles against you.  Eww...'),
    (3, 'Poke it!', 'Muscle', 10, 'You poke the Slime!', 'Oops, the slime poked you...'),
    (3, 'Jump over!', 'Fitness', 5, 'You leap over the Slime!', 'Oops, you land on the slime.  Eww...'),
    (3, 'Zap it!', 'Mana', 15, 'You zap the slime!', 'You do not quite zap it...'),
    (3, 'Reason it!', 'Intellect', 10, 'You convince the slime to move!', 'The slime wobbles.  Oops, its not moving...'),
    (3, 'Dance!', 'Eloquence', 5, 'The slime wobbles out the way!', 'The slime wobbles against you.  Eww...'),
    (4, 'Smack it!', 'Muscle', 20, 'You smack the Kobold!',  'Ow, the kobold smacks you!'),
    (4, 'Run around it!', 'Fitness', 30, 'You outrun the Kobold!', 'The Kobold grabs you.  Oops.'),
    (4, 'Zap it!', 'Mana', 20, 'You Zap the Kobold!', 'The Kobold Zaps you!  Ouch!'),
    (4, 'Reason it!', 'Intellect', 15, 'The Kobold lets you by.', 'The Kobold smacks you.  Ouch.'),
    (4, 'Dance!', 'Eloquence', 20, 'The Kobold dances by you!', 'The Kobold shoves you onto the ground.'),
    (5, 'Smack it!', 'Muscle', 20, 'You smack the Kobold!',  'Ow, the kobold smacks you!'),
    (5, 'Run around it!', 'Fitness', 30, 'You outrun the Kobold!', 'The Kobold grabs you.  Oops.'),
    (5, 'Zap it!', 'Mana', 20, 'You Zap the Kobold!', 'The Kobold Zaps you!  Ouch!'),
    (5, 'Reason it!', 'Intellect', 15, 'The Kobold lets you by.', 'The Kobold smacks you.  Ouch.'),
    (5, 'Dance!', 'Eloquence', 20, 'The Kobold dances by you!', 'The Kobold shoves you onto the ground.'),
    (6, 'Smack it!', 'Muscle', 20, 'You smack the Kobold!',  'Ow, the kobold smacks you!'),
    (6, 'Run around it!', 'Fitness', 30, 'You outrun the Kobold!', 'The Kobold grabs you.  Oops.'),
    (6, 'Zap it!', 'Mana', 20, 'You Zap the Kobold!', 'The Kobold Zaps you!  Ouch!'),
    (6, 'Reason it!', 'Intellect', 15, 'The Kobold lets you by.', 'The Kobold smacks you.  Ouch.'),
    (6, 'Dance!', 'Eloquence', 20, 'The Kobold dances by you!', 'The Kobold shoves you onto the ground.');
    
COMMIT;