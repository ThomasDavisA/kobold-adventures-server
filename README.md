# Kobold Adventures!

**Live App: https://kobold-adventures.thomasdavisa.vercel.app/**

## Summary

Kobold Adventures is a simple text-based adventure game where you take control of a kobold and go out to explore the lands to have silly and simple adventures.  To start, you may login or register to the website.  We have three dummy accounts for you to trial the game as well:

Name | Password
---------|----------
dunder | password
maria | password2
jacob | password3

Upon logging in, you'll be greeted with the news screen, and the choice to adventure or look at your status.  You may assign status points in the status screen, and may re-allocate points whenever you want.  When you go adventuring, you are presented with several locations to pick.  Upon selecing an area, you are then taken to the encounter screens, where you must play out each encounter.  Regardless of success or failure of each encounter, you make progress throughout the day.  At the end of the day, your adventure is complete, and you tally up all the currencies and experience you gain through the adventure.  And that's it!  Continue to explore each area fully to see all the options you can discover, as every encounter has multiple ways of resolving themselves.

![Going on an adventure!](https://i.imgur.com/KXBl3Er.png) ![The status screen.](https://i.imgur.com/LzclImT.png)

## Technologies

Kobold Adventures uses Node.js and PostgreSQL for its serverside and database functionality.  The client uses React.

## API
The Server API is seperated into:
### Auth
The Auth API is used purely for ensuring all login credentials are secure.
### Users
The Users API is used for creating new user accounts.
```
Path: /api/users/
POST
Body: username, password
Returns: A username
```

### Kobold
The Kobold API is used to get kobolds from user information, adventures, and rewards information after adventures.

```
Path: /api/kobolds/
GET
Requires: Authorization as a JWT.
Returns: A kobold object, based on the username from the token.

POST
Body: Username
Returns: A new kobold object, based on the username given.  The Username must exist in the database beforehand.
```
```
Path: /api/kobolds/:id
GET
Requires: Authorization as a JWT
Returns: A koobld ojbect, based on the id provided in the params.

PATCH
Requires: Authorization as a JWT
Body: An object containing:
    kobold_unspent_points
    kobold_muscle
    kobold_fitness
    kobold_eloquence
    kobold_intellect
    kobold_mana
Returns: Nothing.  Updates these stats to the server, based on the id provided in the params.
```

### Adventures
The Adenvtures API handles most logic for any adventure a Kobold my go on, including handling resolutions, rewards, and encounter outcomes.
```
Path: /api/adventure/:id
GET
Requires: Authorization as a JWT
Returns: A new object that contains an array of two objects, an encounter object and a Resolutions Object.
```
```
Path: /api/adventure/:koboldId/progress
GET
Requires: Authorization as a JWT
Returns: The adventure progress of a kobold, based on the :koboldId.

PATCH
Requires: Authorization as a JWT
Returns: Nothing.  Instead, tells the server to clear the adventure progress for the kobold based on :koboldId.
```
```
Path: /api/adventure/resolution/:id/:koboldId
GET
Requires: Authorization as a JWT
Retruns: An object that contains a status boolean and a message.  Updates progress and rewards on the server side for the kobold based on :koboldId.
```
```
Path: /api/adventure/rewards/:id
GET
Requires: Authorization as a JWT
Returns: An Object that contains:
    xp: Your total xp for the adventure.
    nickles: Total wood nickles from the adventures.
    scrap: Total scraps from the adventures.
    influence: Total influence from the adventures.
    levelUp: A boolean flag if the Kobold leveled up.
```

### Locations
The Locations API is used to get locations for all Kobold Adventures.
```
Path: /api/locations/
GET
Requires: Authorization as a JWT
Returns: A list of locations as an array of objects.
```

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).