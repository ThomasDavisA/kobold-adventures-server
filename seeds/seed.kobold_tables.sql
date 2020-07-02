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
    ('dunder', '$2a$12$peY6J21B.74IPSh9I/b4oOewgCj0YI5j3XEioI7ptCcsPrLVXnhi.'),
    ('maria', '$2a$12$aNi4fyIx6RHYw6Oe0BPHNerPzdfrfZqy5HeOIjksIqD/41A5N4l3S'),
    ('jacob', '$2a$12$Xd/E6g1BM3bojhzZRJzoyufIQL19E32tJlDjXa0LeUm7uqX3f0fR6');

INSERT INTO kobolds (user_id, kobold_name, kobold_level, kobold_muscle)
VALUES
    (1, 'Bobbles', 2, 1),
    (2, 'Jarjar', 4, 4),
    (3, 'Blinky', 10, 8);

INSERT INTO locations (location_name, location_description, location_level)
VALUES
    ('Grasslands of Tir', 'Open plains, great sky, and the freedom to spot any feature a mile away!  The perfect spot for a kobold to start their adventure.', 1),
    ('The Angaro Lakeside', 'The mists raise in the day to shelter those from the heat, but you never know what you''ll bump into.  Stay on your clawtips, little one!', 3),
    ('Filnswyth', 'A cozy town full of lizardfolk and humans.  A perfect place to stumble onto your next escapade!', 8);

INSERT INTO encounters (location_id, encounter_name, encounter_text, encounter_level, encounter_base_difficulty, encounter_base_reward)
VALUES 
    (1, 'A small slime!', 'Travelling along the plains, you discover a small slime.  Such a low level monster out here makes a perfect encounter for newer kobolds.', 1, 1, 1),
    (1, 'Circle of Stones', 'A simple monument of stones can be seen in the distance!  These ruins, which look to be from an old town, are the perfect spot for a bit of excercise and burning all the energy little kobolds have.', 3, 1, 1),
    (1, 'A field of flowers!', 'While the grasslands can be nondescript at times, seeing a field of flowers is always worth mentioning!  Every kobold knows that such a scene is good luck for your next adventure.', 3, 1, 1),
    (1, 'A roadside Inn!', 'What luck!  You chance upon an inn on a dirt path, simple and quiet.  Several guests are there, and the innkeeper even greets you like a not kobold!', 4, 1, 1)
    (1, 'A glowing crystal!', 'When kobolds go on adventures, they always bring back some curious thing from their time out.  This day yields a glowing crystal found nestled on top of a hill, pulsing with what can only be assumed to be energy.', 2, 1, 1)
    (2, 'Another Kobold!', 'A kobold blocks you!', 3, 1, 1),
    (2, 'A big Kobold!', 'A bigger kobold blocks you!', 5, 1, 1),
    (2, 'A giant Kobold!', 'A massive kobold blocks you!', 10, 1, 1),
    (3, 'A guard!', 'A guard blocks you!', 8, 1, 1),
    (3, 'A captain!', 'The captain blocks you!', 10, 1, 1),
    (3, 'A king!', 'The King blocks you!', 20, 1, 1);

INSERT INTO resolutions (encounter_id, resolution_name, resolution_action, resolution_stat, resolution_success, resolution_fail)
VALUES 
    -- Encounter: Grasslands, Slime --
    (1, 'Poke the slime with a stick!',
        'Muscle', 1,
        'You poke the Slime!  It jiggles and slowly wobbles away.  You feel great!',
        'The stick gets stuck in the slime, and it wobbles in such a way that the stick jabs you back!  Ouch!  You decide it best not to touch the slime after.'),
    (1, 'Leap over the slime!',
        'Fitness', 5,
        'With a hop and a skip, you manage to jump right over the slime!  Its a fun excersice and leaves you feeling quite pleased.',
        'You stumble on your lead up and land snout first into the slime!  The slime jiggles as you pull away, disgusted and feeling it best to get away instead.'),
    (1, 'Draw some magic out of the slime!',
        'Mana', 15,
        'Focusing on your hand, you place it on the slime and slowly draw some mana out of the slime.  It wobbles to your touch, but makes you feel quite refreshed for the next encounter of the day!',
        'Focusing on your hand, you place it on the slime... but accidently draw mana out of you into the slime!  The slime grows from it and you make a quick retreat, not wanting to deal with larger slimes after draining yourself!'),
    (1, 'Talk to the slime!',
        'Intellect', 10, 
        'You feel you can reason with the slime before you, and with a couple of yips, the slime just... wobbles from one spot to another.  You feel incredibly smart.', 
        'You feel you can reason with the slime before you, and with a couple of yips, the slime just... sits there.  Did you yip something wrong?  Oh dear, you leave before you embarress yourself any further.'),
    (1, 'Dance with the slime!', 
        'Eloquence', 5, 
        'Doing a spry dance is the kobold way!  It seems the slime is part kobold as well, as it wobbles with your movements, enough so that it wobbles off in a direction, leaving you feeling great about your own skills.', 
        'Doing a spry dance is what kobols do, but your dance has a couple missteps, leaving you planting your snout right into the slime!  You quickly pull yourself out as it wobbles from that, and hurriedly run off, quite embarressed from the lack of coordiantion.'),
    -- Encounter: Grasslands, Circle of Stones --
    (2, 'Throw some heavy rocks around!', 
        'Muscle', 10, 
        'With a show of strength and power, you manage to heft a rock the side of your hand and hurl it into one of the stone pillars!  It makes a satifying clack against stone and makes you feel particularly pleased.', 
        'Try as you might, you can''t seem to find any rock you can properly lift that looks impressive to train on!  You settle for some small pebbles instead, but they really dont make impressive sounds when you throw them agains a stone pillar.'),
    (2, 'Run around the ruins in a make believe course!', 
        'Fitness', 5, 
        'What an excellent obstacle course!  You perform incredible acrobatic feats, leaping from pillar to pillar, running along a ruined all, and even dashing down what seems to be a worn statue from long ago!  You do cartwheels and leap over small walls, and by the end of if, you feel invigorated.', 
        'What an excellent obstacle course!  You slip and fall on the pillars and accidently run into a wall, and even slide down a worn down statue!  You trip over samll stone outcroppings and even fall from a height marginally higher than you!  You don''t feel great after that.'),
    (2, 'Meditate among the ruins.', 
        'Mana', 15, 
        'You find a nice open area and sit down, focusing on your mind and letting yourself relax.  You get the tiniest glimpse of what these ruins were before you came, only in a vague and hazy memory of a well formed wall.  When you open your eyes, you see the ruined wall before you.  You feel at peace and ready to continue.', 
        'You try to find an open area, with the circle of stones being more ruins than anything, finding any spot that looks good to meditate in proves quite fruitless for you!  With a frustrated huff, you end up leaving the ruins instead.'),
    (2, 'Search the circle of stones for clues.', 
        'Intellect', 10, 
        'You decide investigating the ruins is the best option, and quickly go about searching the place for clues of... anything, really!  These stones are ancient, and its obvious to you at least that there is simply no way you''ll discover some special secret about them. You still get a feeling of warmth, happy to delve into history today.', 
        'Investigating the stone monuments seem like a good idea!  However, trying to figure out where it all came from is simply too much for your kobold self, and you quickly find yourself distracted at counting the pebbles on the floor that look particularly round.'),
    (2, 'Play make believe in the ruins.', 
        'Eloquence', 5, 
        'What better place to practice your yips than in what looks like a den you would rule? A Kingbold does not come out their den fully formed after all!  You tidy up a small place and start to pracice your yips and yaps, echoing off some pillars for greater effect.  You certainly feel like you can command a kobold or two yourself after this!', 
        'What better place to practice your yips than in what looks like a den you would rule? A Kingbold does not come out of their den fully formed after all! Unfortunately, the idea of leading other kobolds gives you a little bit of anxiety this time, so you instead opt for practicing being the Bakerbold instead.  Not as glamorous...'),
    -- Encounter: Grasslands, Field of Flowers --
    (3, 'Pull up some flowers!', 
        'Muscle', 10, 
        'Using your great kobold strength, you manage to uproot some of the larger flowers in the field, making a rather gorgeous boquet!  It smells wonderful, and leaves you feeling quite refreshed, ready to take on your next adventure.', 
        'Using your great kobold strength, you... don''t manage to pull up any flowers.  They seem rooted to the earth!  Tugging as hard as you can, you manage to arouse the slumber of a great plant beast within the field!  You quickly run off before anything more dangerous occurs.'),
    (3, 'Run through the fields!', 
        'Fitness', 5, 
        'A kobold as fit as you would run through the flowers!  As you dart through the field, leaving behind a small trail, the delicate scent of the flowers envelop you and leave you feeling more invigorated than before!  A kobold trailblazer, you are!', 
        'A kobold as fit as you would run through the flowers!  As you dart through the field, you stumble and fall into a nappfler, a dangerous flower that puts creatures to sleep!  You quickly get away from the think, but not without feeling quite drained by it.'),
    (3, 'Take in some of the energies of the field!', 
        'Mana', 15, 
        'You managed to find a small clearing in the field of flowers and settle there to focus, drawing upon the energies of the field around you.  The flowers seem to respond quite well, giving strength to you and making you feel more invigorated than ever, ready to take on a little more today!', 
        'You do not quite zap it...'),
    (3, 'Study the flowers.', 
        'Intellect', 10, 
        'Being the genius kobold that you are, you study and examine the flowers, discovering that they extrude a sweet nectar.  A perfect snack for a kobold, you pick a bunch, squeeze the nectar into a cup you found, and happily sip on the juice as you continue your travels, keeping you going quite well!', 
        'You study and examine the flowers, discovering that these are the rare ''five-petaled starseed'' flowers known only to antiquity!  You hastily pick a bunch, thinking of the riches you make until you realize a bit later that it was six-petaled, not five!  What a waste of energy!'),
    (3, 'Practice your flower picking technique!', 
        'Eloquence', 5, 
        'Each flower must be plucked with precision to precisely place the pleasant point of scent for your snout! Its a difficult task, but you manage to pluck with extreme elegance, and if any kobold saw, they would undoubtedly be envious of you.', 
        'Plucking flowers is not as all easy, and you feel you kobold-handle these things with the grace of a glarrish wielding a porkansh!  That is to say, you do terribly, and you feel tired after it all.  At the least, you smell nice!'),
    -- Encounter: Grasslands, Inn --
    (4, 'Go Arm Wreslting!', 
        'Muscle', 40, 
        'You are certainly confident for a kobold!  You decide to partake in the ancient adventure ritual of wresting arms on tables, and decide to try your strength against an easy-going lizard man in the corner. You''re a kobold, so of course you lose, but you put up a good enough fight against the lizard that he offers you a drink, helping you recover from such a tough match!  Even a loss gives rewards here!',  
        'You are certainly confident for a kobold!  You decide to partake in the ancient adventure ritual of wresting arms on tables, and decide to try your strength against an easy-going lizard man in the corner. You are so quickly beaten that you actually fall off the chair you were standing on, tumbling on the floor and bumping your head!  Maybe arm wrestling bigger people wasn''t the best idea...'),
    (4, 'Ask to do some work!', 
        'Fitness', 30, 
        'You ask the innkeeper for some work.  Unsurprisingly, this leads you to cleaning the place, wiping floors, walls, tables, chairs, mugs, stairs, beds, chimneys, pipes, barrels, chests, the innkeeper, plates, swords, the porch, copper coins, cutlery, an- wait, coins?  It lifts your spirits that you get free beer, spending the copper coin you just chanced upon the floor, making you feel better to keep going.', 
        'You ask the innkeeper for some work.  This leads to cleaning, and a lot of it!  In fact, its too much for you to handle, and your whining and yipping by the fourth task!  The innkeeper shakes his head and lets you down gently that you just aren''t cut out for this work.'),
    (4, 'Talk to the wizard at the counter!', 
        'Mana', 20, 
        'Talking to strangers is a kobold thing to do, and you certainly don''t violate that rule!  The wizard chuckles at your antics of yipping and yapping at him, and he eventually decides to show you some neat cantrips!  His last trick involved him giving you a little magical energy to keep going, which felt great!', 
        'Talking is strangers is a kobold thing to do, but it gets them in trouble!  The wizard finds your yipping and yapping quite bothersome, and eventually does a cantrip that teleports you outside the inn!  It also leaves you feeling drained, pulling from you own magical reserves!'),
    (4, 'Haggle for a drink!', 
        'Intellect', 15, 
        'You''re a smart kobold, you can convince the barkeep to give you a drink!  So you swaddle up and start yipping and yapping at him, eager for a free drink!  Whatever you''ve managed to say struck a good chord with the barkeep, who ends up giving you a drink in the end!  It tastes sweet, hinted with honey, and it reinvigorates you to continue your adventure.', 
        'You are the smartest kobold, and you are eager to prove your worth, so you swagger up to the barkeep and start yapping and yipping for a free drink!  The barkeep chuckles and sure enough, brings out a drink to you!  However, on first sip, the drink knocks you right to the floor, the drink far too strong for a kobold!  You sputter out of the bar, woozy and dizzy!'),
    (4, 'Play an instrument!', 
        'Eloquence', 20, 
        'A kobold of status like yourself should be well trained in an instrument, and as such, you end up finding an instrument tucked into a corner -- a reed flute of sorts, crudely made.  Still, it works for you, and you blow into it and start to play some music!  Its good music, for kobold standards, and even earns you a well-deserved pat on the head by a burly adventurer type.  Such praise leaves you feeling great!', 
        'Such a distinguished kobold like yourself should be playing instruments, and so you seek to find one and eventually come up with a drum of sorts in the corner of the inn.  You start to yip and yap and beat the drum, harkening to an ancient kobold ritual, but are quickly chased out by some of the people in the inn, eager to not see more kobolds appear!'),
    -- Encounter: Grasslands, Crystal --
    (5, 'Throw the crystal as hard as you can!',
        'Muscle', 5, 
        'With a great yap, you throw the crystal into the air as hard as possible!  It flies upward and... curves?  It explodes in the air with a strange glitter of pulsing lights, and eventually fades away, leaving you completely alone.  Though, whatever it was has certainly made you feel better, ready to take on the world!',  
        'With a great yap, you throw the crystal into the air as hard as possible!  It comes back down with a dull thud, and the crystal stops glowing.  Whatever you did seemed to just make the crystal inert, and it makes you feel sad.  What a lousy way for this to end.'),
    (5, 'Hold onto the crystal!', 
        'Fitness', 10, 
        'Holding onto the crystal is quite a lot of fun, as the pulsing lights you up nicely!  The glow does slowly die out as you travel and soon the crystal is completely inert.  Whatever was in that crystal though was certainly potent, as all that traveling still leaves you feeling completely refreshed as though you just woke up!', 
        'The crystal seems resistant to you holding it, and try as you might, it keeps slipping out of your hands every few steps you take.  Eventually its get to be troublesome enough that you give up, and leave it behind, having bent over to pick up well over a dozen times.  Its left you drained and annoyed!'),
    (5, 'Tap into its power!', 
        'Mana', 5, 
        'You focus your thoughts on the crystal in an attempt to draw out whatever power lay dormant within... and as you focus, you can feel the energies of the crystal flow out and into you!  By the time you are done, the crystal is all but dormant, and you are feeling refreshed and exuberant, ready to continue your adventure!', 
        'You focus your thoughts on the crystal, but are distracted by some noise!  Its enough to make the crystal unstable, and as it vibrates in your hand, you quickly throw it, the glowing rock shattering into many shards!  Some of them poke you but evaporate on contact, but has left you feeling drained.'),
    (5, 'Study the crystal to learn more!', 
        'Intellect', 25, 
        'Such a mysterious object should be examined, though its not an easy task.  You spend quite a lot of time just looking at it, before finally coming to the conclusion that this is a mana crystal, and one that a great mage has accidentally dropped.  Its great you have it, but knowing its use, you quickly use it and feel refreshed to continue your adventure instead!', 
        'This is a glowing crystal, and no kobold would have the knowledge to just identify a random glowing crystal.  You eventually decide its a crystal that summons another kobold, and to activate it, you bury the crystal in the ground.  It does nothing, and eventually you grow frustrated and bored, leaving it alone.'),
    (5, 'Wear the crystal!', 
        'Eloquence', 1, 
        'You fashion a quick necklace using some string and wear the crystal like a necklace.  Its incredible how pretty it looks, and its glow makes you feel refreshed and great all throughout!  The glow fades, but you can''t help but want to keep adventuring now!', 
        'You decide to wear the crystal as a shoe, which seems impossible given the circumstances!  But, you manage to, and shatter it on first step, hurting yourself and draining yourself incredibly fast!  Its incredible you even did this, or are even reading this text!'),
    (6, 'Smack it!', 'Muscle', 20, 'You smack the Kobold!',  'Ow, the kobold smacks you!'),
    (6, 'Run around it!', 'Fitness', 30, 'You outrun the Kobold!', 'The Kobold grabs you.  Oops.'),
    (6, 'Zap it!', 'Mana', 20, 'You Zap the Kobold!', 'The Kobold Zaps you!  Ouch!'),
    (6, 'Reason it!', 'Intellect', 15, 'The Kobold lets you by.', 'The Kobold smacks you.  Ouch.'),
    (6, 'Dance!', 'Eloquence', 20, 'The Kobold dances by you!', 'The Kobold shoves you onto the ground.');
    
COMMIT;