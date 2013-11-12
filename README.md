Robot Space Wars

The basic premis. You have a base and several fleets of ships. You build up your base like many
existing games (sim city, lacuna-expanse, Vega Conflict , etc) and this allows you to create a (small)
number of fleets of ships.

You have the option to attack other bases with your fleets, you can attack other fleets, on a one
against one basis in 'manual' mode.

So far what has been described is a copy of Vega Conflict.

The 'value added' bit however is that you are able to program your fleets to carry out a
pre-programmed set of actions and carry out battles autonomously.

This pre-programmed concept should attract many people who were attracted to games such as Lacuna
Expanse and to the early computer game RobotWar (see http://en.wikipedia.org/wiki/RobotWar)

It is anticipated that a set of pre-defined scripts will be provided to carry out basic attacks.
This is similar to Vega Conflict where fleets can be attacked whilst the owner is away, in which case
they carry out a basic set of strategies (but which cannot be modified in Vega Conflict).

How people create Battle Scripts is still to be defined, but the following are options.

  * An in-built script (similar to Robot Wars) using a bespoke language.
  * Plug-ins for other languages, such a Javascript, Perl, Python, Java

Links:

  * Vega Conflict   - https://www.kixeye.com/game/vegaconflict
  * Lacuna Expanse  - http://lacunaexpanse.com/
  * Robot Wars      - http://en.wikipedia.org/wiki/RobotWar

Fleet to Fleet battles.

Fleets from different empires will have many opportunities to interact.

  * When attacking a 'base' you may have to defeat the fleets which are set to defend it.
  * You may want to attack a fleet which is in transit, in order to steal it's cargo
  * In Tournaments, your fleet may be competing in competition with empires of similar rank
  * You may attack an AI player fleet

In each of these interactions, if one or more of the empires who are competing is not on line
then the auto scripts take control of the fleet. These auto scripts may either be pre-built
one's (supplied by the server) or one's supplied by the empire.

If either empire is on-line they will be informed of the battle and have the opportunity to
'take command' of their fleet and control it manually.

This then allows both one-on-one interaction between players and AIs.

Tournaments
===========

Empires can join a tournament. A tournament is arranged to allow empires to compete in a series
of one-on-one battles, totally under the control of their scripts (i.e. no manual intervention)
with the aim to find out which empire has the best fleet/script.

There can be two types of tournament.

1) Anything goes... where the player is free to choose the combination of ships making up his fleet,
the ships armament, shilds, weapons and the 'script' that they wish to play.

2) Even stevens... where every player is given the same class and level of ships, armament, weapons etc,
and all that the player can select is the 'script' they wish to play.

The first tournament type will enable players to compete against similar ranked players and can be
used to calculate their rank.

The second tournament type will allow players to compete against any other player with the aim to see
who has the best script. Effectively we will be ranking the scripts and again, awards can be given
to the players who 'own' or have written the scripts.

(note to self, can we somehow tag scripts written by people so we can track how they evolve?
perhaps by tracking them in git? Do we want to 'register' scripts and make them announce their
'name' and 'version' whenever they are run?)

We may also be able to do 'base hit' tournaments, where players create scripts to attack bases
with a fleet of ships. Each fleet is targetted against the same base (an AI base) and the results
are collected to see which empires fleet did best.

A consequence of this is that it may be possible to script base defence (to control how the base
units target the enemy). Look into this for a later update.

Scripts
=======

The main aspect of the game is the ability for people to create scripts that control their robotic
ships. The scripts control things such as the ship location, speed, direction, rate of fire, direction
of fire. The scripts determine if the ships work together, or individually, how they target the enemy,
how they evade the enemy etc. Battles that take place without human intervention are totally controlled
by the scripts. Although some battles allow the human to take over control (for example when doing action
against other players) in some circumstances (tournaments, attacks while the player is afk) the script
is the sole controller of the ships.

It is anticipated that there will be a lot of exchanging of scripts, modifications, tweaks etc. by
players trying to obtain the best script.

We want to make the script language as open as possible, so that many different languages can be used.

We also need to make sure that all players have the ability to run scripts.

Where do we run scripts?
========================

Giving players the ability to run any language script on the server is fraught with problems, not
least the issue of security (running unknown code on the server).

Ideally, scripts should run on the users own machine, but means we have to provide a way to run
scripts remotely.

We also need to be able to support those people who do not have the technical ability to create
or run scripts of their own.

We need to provide a level playing field between scripters and script-kiddies (who may be able to
run predefined scripts, but not create their own).

At the basic level we need to create an interpreted language that can be used by anyone. These scripts
being interpreted can be created by the players and run on our own servers.

Running scripts remotely, we need to provide an API based around Web Sockets. This allows a remote
server, under the control of the player, to be created which contains the scripts used to control 
their fleets.

To ensure a level playing field, the scripts run on our own servers should also be based around the
Web Socket protocol. This allows us to load-balance by putting the scripts on one server and the core
code on another server.

We can provide a simple framework which will allow people to run a web service on their own servers,
with libraries of routines that they can use to build their scripts.

Web Socket Protocol
===================

The scripts will need to comply with a protocol based around Web Sockets.

Every script will have a unique URL (this can be parameterised so that multiple scripts can run on
the same server). This URL will be registered with the game server against the players empire.

For example, URL = http://example.com/scripts/










