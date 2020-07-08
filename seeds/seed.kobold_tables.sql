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

INSERT INTO kobolds (user_id, kobold_name, kobold_level, kobold_unspent_points)
VALUES
    (1, 'Bobbles', 2, 6),
    (2, 'Jarjar', 4, 12),
    (3, 'Blinky', 10, 30);

INSERT INTO locations (location_name, location_description, location_level)
VALUES
    ('Grasslands of Tir', 'Open plains, great sky, and the freedom to spot any feature a mile away!  The perfect spot for a kobold to start their adventure.', 1),
    ('The Angaro Lakeside', 'The mists raise in the day to shelter those from the heat, but you never know what you''ll bump into.  Stay on your clawtips, little one!', 3),
    ('Filnswyth', 'A cozy town full of lizardfolk and humans.  A great place to stumble onto your next escapade!', 8);

INSERT INTO encounters (location_id, encounter_name, encounter_text, encounter_level, encounter_base_difficulty, encounter_base_reward)
VALUES 
    (1, 'A small slime!', 'Travelling along the plains, you discover a small slime.  Such a low level monster out here makes a perfect encounter for newer kobolds.', 1, 1, 1),
    (1, 'Circle of Stones', 'A simple monument of stones can be seen in the distance!  These ruins, which look to be from an old town, are the perfect spot for a bit of excercise and burning all the energy little kobolds have.', 3, 1, 1),
    (1, 'A field of flowers!', 'While the grasslands can be nondescript at times, seeing a field of flowers is always worth mentioning!  Every kobold knows that such a scene is good luck for your next adventure.', 3, 1, 1),
    (1, 'A roadside Inn!', 'What luck!  You chance upon an inn on a dirt path, simple and quiet.  Several guests are there, and the innkeeper even greets you like a not kobold!', 4, 1, 1),
    (1, 'A glowing crystal!', 'When kobolds go on adventures, they always bring back some curious thing from their time out.  This day yields a glowing crystal found nestled on top of a hill, pulsing with what can only be assumed to be energy.', 2, 1, 1),
    (2, 'Another Kobold!', 'The mists obscure everything at this time of day, and as you travel along you, you discover a familiar outline of a creature ahead!  Upon getting closer, you discover its another kobold!  He yips at you in response.', 3, 1, 1),
    (2, 'A Mysterious Shrine', 'The mists obscure your vision as you walk around, but you suddenly find yourself a small mystical stone shrine.  The inscriptions are faded (you can''t read them anyway), and a small pool of water sits still in the center of the shrine.', 5, 1, 1),
    (2, 'A gem!', 'The fog lays thick around this time, and you have difficulty moving around... though eventaully you find a shiny gem at your feet!  Pretty and glittering, it shines with an unnatural aura.', 10, 1, 1),
    (2, 'A small beach!', 'Despite it being a lake, your travels seem to case you finding a small cave that leads you to a small and tiny beach, with sand and a breeze!  Perhaps its magical, but how its existance is here, at a lake, is anyone''s guess.', 5, 1, 1),
    (2, 'A fruit stand!', 'The sun has pierced through the fog for now, revealing a crystal clear lake before you!  And more importantly, a fruit stand with a human selling goods.  A perfect opportunity to do a little kobolding.', 10, 1, 1),
    (2, 'A quiet spot.', 'The sun has pierced through the fog for now, revealing a very secluded spot on the lakeside.  It''s quite serene and is very inviting to just lay and relax to listen to the water lap against the shoreline.', 1, 1, 1),
    (3, 'A thief!', 'Walking through the town is quite a sight, with many people bustling about!  However, a thief nearby manages to snatch a purse and makes a run for it!  He ends up turning down an alleyway and is stuck at a fence, trying to climb his way out of the situation.', 8, 1, 1),
    (3, 'A Quiet Alleyway.', 'The town of Filnswyth is home to many traders and the town is bustling at this hour!  Thankfully, there is a quiet alleyway that seems perfect for kobolds to spend their time in.', 10, 1, 1),
    (3, 'The king!', 'The king is visiting today!  He may be impressive to the people, but he has nothing on the dragons kobolds worship.  As he makes his way down the street in a parade, he looks around and nods to all of his subjects.', 20, 1, 1);

INSERT INTO resolutions (encounter_id, resolution_name, resolution_action, resolution_stat, resolution_success, resolution_fail)
VALUES 
    -- Encounter: Grasslands, Slime --
    (1, 'Poke the slime with a stick!',
        'Muscle', 3,
        'You poke the Slime!  It jiggles and slowly wobbles away.  You feel great!',
        'The stick gets stuck in the slime, and it wobbles in such a way that the stick jabs you back!  Ouch!  You decide it best not to touch the slime after.'),
    (1, 'Leap over the slime!',
        'Fitness', 3,
        'With a hop and a skip, you manage to jump right over the slime!  Its a fun excersice and leaves you feeling quite pleased.',
        'You stumble on your lead up and land snout first into the slime!  The slime jiggles as you pull away, disgusted and feeling it best to get away instead.'),
    (1, 'Draw some magic out of the slime!',
        'Mana', 8,
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
        'Fitness', 4, 
        'What an excellent obstacle course!  You perform incredible acrobatic feats, leaping from pillar to pillar, running along a ruined all, and even dashing down what seems to be a worn statue from long ago!  You do cartwheels and leap over small walls, and by the end of if, you feel invigorated.', 
        'What an excellent obstacle course!  You slip and fall on the pillars and accidently run into a wall, and even slide down a worn down statue!  You trip over samll stone outcroppings and even fall from a height marginally higher than you!  You don''t feel great after that.'),
    (2, 'Meditate among the ruins.', 
        'Mana', 10, 
        'You find a nice open area and sit down, focusing on your mind and letting yourself relax.  You get the tiniest glimpse of what these ruins were before you came, only in a vague and hazy memory of a well formed wall.  When you open your eyes, you see the ruined wall before you.  You feel at peace and ready to continue.', 
        'You try to find an open area, with the circle of stones being more ruins than anything, finding any spot that looks good to meditate in proves quite fruitless for you!  With a frustrated huff, you end up leaving the ruins instead.'),
    (2, 'Search the circle of stones for clues.', 
        'Intellect', 15, 
        'You decide investigating the ruins is the best option, and quickly go about searching the place for clues of... anything, really!  These stones are ancient, and its obvious to you at least that there is simply no way you''ll discover some special secret about them. You still get a feeling of warmth, happy to delve into history today.', 
        'Investigating the stone monuments seem like a good idea!  However, trying to figure out where it all came from is simply too much for your kobold self, and you quickly find yourself distracted at counting the pebbles on the floor that look particularly round.'),
    (2, 'Play make believe in the ruins.', 
        'Eloquence', 4, 
        'What better place to practice your yips than in what looks like a den you would rule? A Kingbold does not come out their den fully formed after all!  You tidy up a small place and start to pracice your yips and yaps, echoing off some pillars for greater effect.  You certainly feel like you can command a kobold or two yourself after this!', 
        'What better place to practice your yips than in what looks like a den you would rule? A Kingbold does not come out of their den fully formed after all! Unfortunately, the idea of leading other kobolds gives you a little bit of anxiety this time, so you instead opt for practicing being the Bakerbold instead.  Not as glamorous...'),
    -- Encounter: Grasslands, Field of Flowers --
    (3, 'Pull up some flowers!', 
        'Muscle', 5, 
        'Using your great kobold strength, you manage to uproot some of the larger flowers in the field, making a rather gorgeous boquet!  It smells wonderful, and leaves you feeling quite refreshed, ready to take on your next adventure.', 
        'Using your great kobold strength, you... don''t manage to pull up any flowers.  They seem rooted to the earth!  Tugging as hard as you can, you manage to arouse the slumber of a great plant beast within the field!  You quickly run off before anything more dangerous occurs.'),
    (3, 'Run through the fields!', 
        'Fitness', 6, 
        'A kobold as fit as you would run through the flowers!  As you dart through the field, leaving behind a small trail, the delicate scent of the flowers envelop you and leave you feeling more invigorated than before!  A kobold trailblazer, you are!', 
        'A kobold as fit as you would run through the flowers!  As you dart through the field, you stumble and fall into a nappfler, a dangerous flower that puts creatures to sleep!  You quickly get away from the think, but not without feeling quite drained by it.'),
    (3, 'Take in some of the energies of the field!', 
        'Mana', 10, 
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
        'Fitness', 8, 
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
        'Eloquence', 2, 
        'You fashion a quick necklace using some string and wear the crystal like a necklace.  Its incredible how pretty it looks, and its glow makes you feel refreshed and great all throughout!  The glow fades, but you can''t help but want to keep adventuring now!', 
        'You decide to wear the crystal as a shoe, which seems impossible given the circumstances!  But, you manage to, and shatter it on first step, hurting yourself and draining yourself incredibly fast!  Its incredible you even did this, or are even reading this text!'),
    -- Encounter: Lakeside, Kobold --
    (6, 'Play with the other Kobold!',
        'Muscle', 12, 
        'You decide playing with the other kobold is the best course of action!  You yip at him, he yips back, and before long you two are adventuring together along the lakeside, making noises and picking up smooth pebbles and throwing them, climbing things and having a good time!  Eventually though, you both tire and yap your goodbyes, leaving refreshed mentally.',  
        'You decide playing with the other kobold is the best course of action!  Unfortunately, the other kobold is a bit stronger than you, and you tire out before he does, and gives a disapproving growl.  You slink away, dejected from not being able to keep up with your kobold pal.'),
    (6, 'Run with the kobold!', 
        'Fitness', 15, 
        'You give a very competitive yapping, and the other kobold quickly understands, before you both dart off, trying to beat the other in a race!  Thankfully your fitness wins out in the end, and the other kobold is left panting behind.  You give a celebratory yipping dance, and part ways with the other kobold, quite happy and pleased with yourself.', 
        'You give a very competitive yapping, and the other kobold quickly understands, before you both dart off, trying to beat the other in a race! Unfortunately, your fitness isn''t quite up to speed with the other kobold, and he outpaces you before long.  By the time you''re exhausted, you''ve lost sight of him, and dejectedly wander off.'),
    (6, 'Use magic!', 
        'Mana', 20, 
        'You concentrate, and in true kobold fashion, you dazzle the other kobold with a shower of sprinkly lights!  The other Kobold loves it, and soon joins you, creating his own little dazzling display of lights, and you two soon create a field of lights that surround you two!  Its all very adorable and by the time you two part ways, you feel incredibly refreshed and ready to move on.', 
        'You concentrate, and in true kobold fashion, you spray the other kobold with some of the lake water using your magic!  The other kobold doesn''t like it that much, and gives combative yaps at you, using his own magic to pelt you with some pebbles.  You break away and retreat from the angry kobold.'),
    (6, 'Talk to the kobold!', 
        'Intellect', 10, 
        'Talking to kobolds usually involves many indistinguishable yips, yaps, growls, and barks.  Thankfully, you are smart enough to converse with your kobold friend.  You yip and yarp and he haps and yirps, and eventually come to an agreement to hang out later one.', 
        'Talking to kobolds usually involves many indistinguishable yips, yaps, growls, and barks.  Unfortunately, this kobold has some accent that you can''t quite understand and have a miscommunicated yip, the other kobold growls at you and turns away.  Whatever you said insulted him so you leave dejected.'),
    (6, 'Dance!', 
        'Eloquence', 13, 
        'Any kobold that calls themself such would know how to dance, and so you square off against the kobold in a dance battle!  Both of you do flips and dives and all sorts of creative moves but you eventually win out in the end, the other kobold bowing to you in respect.  You both part ways after, with you feeling particularly good about yourself, eager to continue your adventure!', 
        'Any kobold that calls themself such would know how to dance!  However, you reveal some rather akward moves as the other kobold busts flips and tricks you''ve not seen or tried before and its not long before you bow your head in defeat to the greater dancer.  The kobold is friendly enough but after you part ways, you feel rather dejected.'),
    -- Encounter: Lakeside, Shrine --
    (7, 'Fix the Shrine up.', 
        'Muscle', 23, 
        'You take some stones that have fallen and start to clean up the shrine a bit.  While it doesn''t do much, the shrine does look a bit more tidy by the end of all your stone lifting.  Such a small act leaves you feeling serene and happy, ready to continue on your adventure.', 
        'You take some stones that have fallen and start to clean up the shrine a bit.  However, you don''t prove to be strong enough to move the stones and instead cause more mess.  Leaving the shrine in such disarray makes you a bit sad, and you continue your adventure as a lesser kobold.'),
    (7, 'Smooth some of the stones.', 
        'Fitness', 17, 
        'You decide to spend some time making the shrine just a little nicer by smoothing some of the stones around the area.  Your claws do nicely as you grind rocks against each other and into some water, smoothing them quite nicely.  By the time you leave, the shrine has a somewhat smoother pillar, leaving you feeling quite good about the future.', 
        'You decide to spend some time making the shrine just a little nicer by smoothing some of the stones around the area.  Unfortunately, you make no progress before you tire out completely, unsure how anyone, much less a kobold, can take the time to smooth stone!  You leave the shine no better than it was, and feel a little less great.'),
    (7, 'Sip the water.', 
        'Mana', 14, 
        'You decide to take a sip of the water at the shrine.  It tastes particularly clean, and leaves you feeling very pure, as the magic of the shrine wells up in you!  After a while, the magic fades out, but you feel quite refreshed as you leave the shrine, a skip in your step.', 
        'You decide to take a sip of the water at the shrine.  It tastes particularly clean, but you feel overwhlemed by a sensation, '),
    (7, 'Study the Shrine!', 
        'Intellect', 22, 
        'You can''t help but study the shrine and discover its origins!  You instead get distracted and discover some kobold scribbling on one of the pillars.  The kobolds are beating up a human and taking its money.  It makes you laugh and fills you with a renewed sense of adventure.', 
        'You just want to study the shrine and discover its origins!  So you spend hours staring at the stone pillars, discovering... nothing.  Well, the pursuit is also its own reward, but it leaves you feeling quite drained overall.'),
    (7, 'Dance to the shrine!', 
        'Eloquence', 18, 
        'Sometimes kobolds just need to dance. So you do! You dance around the shrine and make ceremonial yips and yaps! You seem to have appeased the spirits of the shrine, as the water in the shrine glows a soft blue before fading back to clear.  It leaves you feeling reinvigorated and ready to continue your day!', 
        'Sometimes kobolds just need to dance. So you do! You dance around the shrine, but trip over your moves and fall on your back!  It leaves you feeling sore, and the shrine certainly doesn''t seem to even register your dance either.  You leave a bit dejected.'),
    -- Encounter: Lakeside, Gem --
    (8, 'Throw the Gem!', 
        'Muscle', 30, 
        'Sparkling spooky gems can only mean one thing -- Something is inside it!  With all of you kobold might, you throw the thing at a nearby rock outcropping, the gem smashing to pieces and releasing eerie wails!  It frightens you, but a spirit arises of a beauitful maiden, who thanks you and gives you a small pat on the head with her ghostly hand, before disappearing.  It bolsters you greatly and you feel confident to continue the day!', 
        'Throw a sparkling gem?  Whatever is going through your mind, you throw it with all of your kobold might, right into a nearby outcropping.  It simply ricochet''s off the wall and disappears into some brush! No matter how much you try, you can''t seem to find it again, and you leave the site a bit saddened.'),
    (8, 'Travel with the Gem!', 
        'Fitness', 50, 
        'Travelling with the gem proves to be extremely difficult -- Even with all of your fitness, you can''t help but feel more and more drained the longer you carry it.  You feel week and your knees start to buckle after quite some time, until the gem flashes and nearly blinds you!  When you regain sight, you see a ghostly spirit of a maiden who pats you on the head, thanks you, and disappears, the gem having vanished as well.  Whatever you did, all of that effort has made you feel incredibly good and ready to continue, your energy returned and then some!', 
        'Try as you might, traveling with the gem seems impossible -- After all, the longer you hold onto it, the more it seems to suck the life out of you!  You struggle and strain, but eventually toss the thing, as the gem just feels far too heavy in your weak hands.  Upon dropping it, you feel much more refreshed, though a bit saddened you had to give up such a pretty gem.'),
    (8, 'Draw power from the Gem!', 
        'Mana', 20, 
        'The gem has such an unsettling aura... so you decide to draw power from it, focussing on the gem.  Power comes suddenly, as you pull more than what you expected, the spirit of a maiden breaking free from the gem as it shatters in your hand!  She appears tall and beautiful, thanking you for freeing her and giving you a gentle pat on the head before disappearing.  You can''t help but feel great about that, ready to take on your next adventure!', 
        'You decide to pull mana out of the gem, focussing on it and using your latent ability to draw out some energy from the gem.  It flahes in your hand, and loses it shine... but you feel a lot weaker instead!  You drop the gem and whine, feeling quite tired instead of refreshed, the gem having taken some energy from you instead!  You leave it, unhappy and a little weaker.'),
    (8, 'Study the gem!', 
        'Intellect', 10, 
        'The eerie gem is pretty easy to discover that a poor soul was caputred by its power, though how to release it is beyond you!  You hold onto the gem briefly, searching some someone who can help before you discover a nearby human adventurer.  You give him the gem as he looks completely confused by the fact a kobold is giving him something, before you walk away, feeling much better that he''ll be able to free the spirit rather than you!', 
        'The gem is simply a gem to you, and the eerieness is just there for effects and to scare away not greedy kobolds!  You clasp it in your claws and hold onto it, but you bump into a wandering bandit, who brandishes a dagger at you!  You quickly give up the gem for your life and run away, feeling a bit more dejected.'),
    (8, 'Wear the gem as a necklace!', 
        'Eloquence', 14, 
        'You wear it quite well, wrapping it around a simple bit of twine.  It feels warm on your chest, and as you travel, the aura fades and you feel oddly refreshed.  You feel a gentle pat on your head, and when you turn around, you briefly see the spirit of a beautiful maiden as she disappears.  You feel refreshed!', 
        'You wear it quite well, but you wrap it around twine rather poorly.  The gem slips from its place quickly enough and you lose it in the brush.  Unfortunately, losing the gem also seems to make you feel a bit drained, as you trudge on to the next adventure.'),
    -- Encounter: Lakeside, Beach --
    (9, 'Play in the sand!', 
        'Muscle', 8, 
        'Playing in the sand a simple kobold affair!  And fun.  You have fun playing in the sand and making sand castles, and you leave the beach feeling quite refreshed.', 
        'Playing in the sand should be simple, but somehow, you manage to get some sand in your eyes and it turns into a bad experience!  You leave the beach feeling worse overall.'),
    (9, 'Go swimming!', 
        'Fitness', 15, 
        'Being at a beach is perfect for swimming!  So you leap into the water and have a good splash.  You eventually come back out, ready to take on the rest of the day!', 
        'You leap for the water for a swim!  But you tire out faster than you expect, and feel an undercurrent trying to pull you away from the shore!  It turns into a frightening experience and you leave the beach worse for wear.'),
    (9, 'Meditate at the beach.', 
        'Mana', 12, 
        'You seat yourself down at a nearby stone and concentrate on the beach, feeling the magic well up inside you!  For a kobold, that''s not much, but you get plenty of energy from it and feel refreshed and ready to keep going for your next adventure!', 
        'You seat yourself into the sandy beach and concentrate on everything around you, feeling the magic all around!  You don''t absorb any of it, but you at least can feel it.  Still, it leaves you feeling drained rather than refreshed, getting up and leaving the beach behind.'),
    (9, 'Study the Beach!', 
        'Intellect', 26, 
        'You decide to investigate the beach for clues of its origins... and as you do, you stumble upon several glowing crystals in a formation!  Its obvious that these are created artificially, and it makes you quite pleased to learn that someone had constructed this with plenty of magic!  You leave, pleased with your discoveries.', 
        'You decide to investiage the beach for clues of its origins.... You discover shiny pebbles.  Unfortunately, that is all you really discover, as however this beach came to be is completely up in the air!  You leave quite dejected, shuffling off sadly.'),
    (9, 'Dance!', 
        'Eloquence', 8, 
        'Dancing on the beach turns out to be quite fun!', 
        'You trip on the sand and bury your head in it.  It turns out to be no fun.'),
    -- Encounter: Lakeside, Fruit Stand --
    (10, 'Lift some fruits!', 
        'Muscle', 12, 
        'You lift some fruits!', 
        'You drop some fruits.'),
    (10, 'Help the Stand Owner.', 
        'Fitness', 28, 
        'You carry some fruits to and fro!', 
        'You drop some fruits.'),
    (10, 'Draw energy from the fruits.', 
        'Mana', 40, 
        'You draw energy from the fruits!', 
        'You make one accidentally explode.  Oops.'),
    (10, 'Converse with the human.', 
        'Intellect', 10, 
        'You yip and yap and get a free fruit!', 
        'You yarp and yirp and get chased off.'),
    (10, 'Dance!', 
        'Eloquence', 16, 
        'You dance!', 
        'You get chased off for poorly dancing.'),    
    -- Encounter: Lakeside, Quiet Spot --
    (11, 'Work out!', 
        'Muscle', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (11, 'Skip rocks!', 
        'Fitness', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (11, 'Practice magic!', 
        'Mana', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (11, 'Study the area!', 
        'Intellect', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (11, 'Practice your speech!', 
        'Eloquence', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    -- Encounter: Town, Thief --
    (12, 'Fix the Shrine up.', 
        'Tackle the thief!', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (12, 'Climb the fence before he does!', 
        'Fitness', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (12, 'Use magic to stop him!', 
        'Mana', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (12, 'Find a shortcut to cut him off!', 
        'Intellect', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (12, 'Talk him down!', 
        'Eloquence', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    -- Encounter: Town, Alleyway --
    (13, 'Bang on the walls!', 
        'Muscle', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (13, 'Run around!', 
        'Fitness', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (13, 'Practice some magic.', 
        'Mana', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (13, 'Study the alleyway.', 
        'Intellect', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (13, 'Dance!', 
        'Eloquence', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    -- Encounter: Town, King --
    (14, 'Throw rocks!', 
        'Muscle', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (14, 'Follow the parade!', 
        'Fitness', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (14, 'Cast some sparkles!', 
        'Mana', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (14, 'Study the king.', 
        'Intellect', 20, 
        'Placeholder Success', 
        'Placeholder Failure'),
    (14, 'Step in the parade!', 
        'Eloquence', 80, 
        'Placeholder Success', 
        'Placeholder Failure');
COMMIT;