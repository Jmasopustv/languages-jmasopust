:- dynamic at/2, i_am_at/1, alive/1.   /* Needed by SWI-Prolog. */
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)).
/* This defines my current location. */

i_am_at(yard).


/* These facts describe how the rooms are connected. */

path(yard, n, house).
        path(house, n, room) :- at(key, in_hand).
        path(house, n, room) :-
                write('How do you expect to get in without a key?'), nl,
                !, fail.
        path(house, w, stairwell).
                path(stairwell, w, bear_den).
        path(house, e, empty_room).
path(yard, e, cabin).
        path(cabin, u, attic).
path(yard, s, river).       
path(yard, w, forest).

path(house, s, yard).
        path(room, s, house).
        path(stairwell, w, house).
        path(empty_room, w, house).
path(cabin, w, yard).
        path(river, n, yard).
path(forest, e, yard).


/* These facts tell where the various objects in the game
   are located. */

at(axe, forest).
at(key, bear_den).


/* This fact specifies that the bear is alive. */

alive(bear).


/* These rules describe how to pick up an object. */

take(X) :-
        at(X, in_hand),
        write('You''re already holding it!'),
        nl, !.

take(X) :-
        i_am_at(Place),
        at(X, Place),
        retract(at(X, Place)),
        assert(at(X, in_hand)),
        write('OK.'),
        nl, !.

take(_) :-
        write('I don''t see it here.'),
        nl.


/* These rules describe how to put down an object. */

drop(X) :-
        at(X, in_hand),
        i_am_at(Place),
        retract(at(X, in_hand)),
        assert(at(X, Place)),
        write('OK.'),
        nl, !.

drop(_) :-
        write('You aren''t holding it!'),
        nl.


/* These rules define the six direction letters as calls to go/1. */

n :- go(n).
:- discontiguous n/0.

s :- go(s).
:- discontiguous (s)/0.

e :- go(e).
:- discontiguous e/0.

w :- go(w).
:- discontiguous w/0.   

u :- go(u).
:- discontiguous u/0.   

d :- go(d).     
:- discontiguous d/0.       

/* This rule tells how to move in a given direction. */

go(Direction) :-
        i_am_at(Here),
        path(Here, Direction, There),
        retract(i_am_at(Here)),
        assert(i_am_at(There)),
        look, !.

go(_) :-
        write('You can''t go that way.').


/* This rule tells how to look about you. */

look :-
        i_am_at(Place),
        describe(Place),
        nl,
        notice_objects_at(Place),
        nl.


/* These rules set up a loop to mention all the objects
   in your vicinity. */

notice_objects_at(Place) :-
        at(X, Place),
        write('There is a '), write(X), write(' here.'), nl,
        fail.

notice_objects_at(_).


/* These rules tell how to handle killing the lion and the spider. */

kill :-
        i_am_at(bear_den),
        write('Oh, bad idea! You have just been eaten by a bear.'), nl,
        !, die.

kill :-
        i_am_at(empty_room),
        write('Oh, yikes! this room is full of ghost!'), nl,
        !, die.

kill :-
        i_am_at(river),
        write('You are on the bank of a river.'), nl,
        write('The ground below you sinks into the river.'), nl,
        write('The current is too strong. You were swept away!'), nl,
        !, die.

kill :-
        i_am_at(bear_den),
        at(axe, in_hand),
        retract(alive(bear)),
        write('You heave your axe at the bear.'), nl,
        write('Through sheer luck it looks like you won.'),
        nl, !.


kill :-
        write('I see nothing to kill here.'), nl.


/* This rule tells how to die. */

die :-
        !, finish.


/* Under UNIX, the   halt.  command quits Prolog but does not
   remove the output window. On a PC, however, the window
   disappears before the final output can be seen. Hence this
   routine requests the user to perform the final  halt.  */

finish :-
        nl,
        write('The game is over. Please enter the   halt.   command.'),
        nl, !.


/* This rule just writes out game instructions. */

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.                   -- to start the game.'), nl,
        write('n.  s.  e.  w.  u.  d.   -- to go in that direction.'), nl,
        write('take(Object).            -- to pick up an object.'), nl,
        write('drop(Object).            -- to put down an object.'), nl,
        write('kill.                    -- to attack an enemy.'), nl,
        write('look.                    -- to look around you again.'), nl,
        write('instructions.            -- to see this message again.'), nl,
        write('halt.                    -- to end the game and quit.'), nl,
        nl.


/* This rule prints out instructions and tells where you are. */

start :-
        instructions,
        look.


/* These rules describe the various rooms.  Depending on
   circumstances, a room may have more than one description. */

describe(room) :-
        at(key, in_hand),
        write('Congratulations!!  You have saved your friend!'), nl,
        write('and won the game.'), nl,
        finish, !.

describe(yard) :-
        write('You are in a yard of what look to be a haunted house.'), nl,
        write('To the North in the house, you hear the screams of your '), nl,
        write('friend. Your assignment is to save your friend from the'), nl,
        write('house and go home'), nl.

describe(cabin) :-
        write('You are in a small cabin.  The exit is to the west.'), nl,
        write('There seems to be another room above you. '), nl.

describe(house) :-
        write('This place is creepy. To the north is'), nl,
        write('a locked room. To the West a dark and scary '), nl,
        write('stairwell, and to your west is seemingly empty room.'), nl.

describe(forest) :-
        write('This place seems like it never ends!'), nl.


