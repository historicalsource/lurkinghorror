"BROWN for
				Horror
	(c) Copyright 1986 Infocom, Inc. All Rights Reserved."

<ROOM BROWN-BUILDING
      (IN ROOMS)
      (DESC "Brown Building")
      (UP TO BROWN-TOP-FLOOR)
      (DOWN TO BROWN-BASEMENT)
      (SOUTH TO COURTYARD)
      (OUT TO COURTYARD)
      (FLAGS ONBIT)
      (GLOBAL OUTSIDE-DOOR)
      (ACTION BROWN-BUILDING-F)>

<OBJECT BROWN-ELEVATOR
	(IN BROWN-BUILDING)
	(DESC "elevator doors")
	(SYNONYM DOOR DOORS ELEVATOR)
	(ADJECTIVE ELEVATOR)
	(FLAGS NDESCBIT)
	(ACTION BROWN-ELEVATOR-F)>

<ROUTINE BROWN-ELEVATOR-F ()
	 <COND (<VERB? OPEN PRY WEDGE>
		<TELL
"It's broken." CR>)>>

<GLOBAL THE-LOBBY "This is the lobby of the ">

<ROUTINE BROWN-BUILDING-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
,THE-LOBBY "Brown Building, an eighteen-story skyscraper
which houses the Meteorology Department and other outposts of the
Earth Sciences. The elevator is out of order, but a long stairway leads up
to the roof, and another leads
down to the basement. A revolving door leads out into the night." CR>)>>

<ROOM COURTYARD
      (IN ROOMS)
      (DESC "Small Courtyard")
      (LDESC
"This courtyard is a triumph of modern architecture. It is spare,
cold, angular, overwhelming in size, and bears a striking resemblance
to a wind tunnel whenever the breeze picks up. Right now this is true
of the whole campus, though. A huge mass lurks nearby, and an almost
featureless skyscraper is to the north.")
      (IN TO BROWN-BUILDING)
      (NORTH TO BROWN-BUILDING)
      (GLOBAL OUTSIDE-DOOR)
      (FLAGS ONBIT OUTSIDE)
      (ACTION COURTYARD-F)
      (THINGS <PSEUDO (FLOPPY TRIANGLE RANDOM-PSEUDO)
		      (HUGE MASS RANDOM-PSEUDO)>)>

<ROUTINE COURTYARD-F (RARG)
	 <COND ;(<RARG? LOOK>
		<TELL
 CR>)
	       (<RARG? ENTER>
		<EXIT-TO-COLD>)
	       (<RARG? LEAVE>
		<EXIT-FROM-COLD>)>>

<OBJECT OUTSIDE-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "outside door")
	(SYNONYM DOOR)
	(ADJECTIVE OUTSIDE)
	(FLAGS DOORBIT LOCKED NDESCBIT OPENABLE)
	(GENERIC GENERIC-DOOR-F)
	(ACTION OUTSIDE-DOOR-F)>

<ROUTINE OUTSIDE-DOOR-F ()
	 <COND (<FSET? ,HERE ,OUTSIDE>
		<COND (<VERB? THROUGH>
		       <DO-WALK ,P?IN>)
		      (<HERE? ,MASS-AVE ,SMITH-ST ,COURTYARD ,CS-ROOF>
		       <COND (<VERB? OPEN>
			      <TELL
"The door opens from this side." CR>)
			     (<P? UNLOCK * MASTER-KEY>
			      <TELL
"The door is not keyed to this key." CR>)>)
		      (<VERB? OPEN UNLOCK>
		       <TELL
"The door is securely locked." CR>)>)
	       (ELSE
		<COND (<VERB? THROUGH>
		       <DO-WALK ,P?OUT>)
		      (<VERB? OPEN>
		       <TELL
"You can open the door, but it shuts automatically immediately
thereafter." CR>)>)>>

<ROOM GREAT-COURT
      (IN ROOMS)
      (DESC "Great Court")
      (LDESC
"In the spring and summer, this cheery green court is a haven from
classwork. Right now, the majestic buildings of the main campus are
almost invisible in the howling blizzard. A locked door bars your
way to the north.")
      (NORTH "The door is locked.")
      (FLAGS ONBIT OUTSIDE)
      (GLOBAL OUTSIDE-DOOR)
      (ACTION GREAT-COURT-F)>

<ROUTINE GREAT-COURT-F (RARG)
	 <COND ;(<RARG? LOOK>
		<TELL
 CR>)
	       (<RARG? ENTER>
		<AS-YOU-ENTER-LEAVE "leave">
		<EXIT-TO-COLD>)
	       ;(<RARG? LEAVE>
		<EXIT-FROM-COLD>)>>

<ROUTINE AS-YOU-ENTER-LEAVE (EL)
	 <TELL
"As you " .EL ", the door closes and locks behind you." CR CR>>

<ROOM BROWN-BASEMENT
      (IN ROOMS)
      (DESC "Brown Basement")
      (LDESC
"This is a cluttered basement below the Brown Building. Discarded equipment
nearly blocks an already narrow hallway that terminates in a stairway leading
up. The passage itself continues northwest.")
      (UP TO BROWN-BUILDING)
      (NW TO BROWN-TUNNEL)
      (FLAGS ONBIT)
      ;(ACTION BROWN-BASEMENT-F)
      (THINGS <PSEUDO (ELECTRIC EQUIPMENT RANDOM-PSEUDO)
		      (FILE CABINET RANDOM-PSEUDO)
		      (<> DETRITUS RANDOM-PSEUDO)>)>

;<ROUTINE BROWN-BASEMENT-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
 CR>)>>

<ROOM BROWN-TOP-FLOOR
      (IN ROOMS)
      (DESC "Top Floor")
      (LDESC
"This is the top of the stairway. A door leads out to the roof here, and
you can hear the wind blowing beyond. There is a sign on the door.")
      (DOWN TO BROWN-BUILDING)
      (WEST TO BROWN-ROOF IF ROOF-DOOR IS OPEN)
      (OUT TO BROWN-ROOF IF ROOF-DOOR IS OPEN)
      (FLAGS ONBIT)
      (GLOBAL ROOF-DOOR)
      ;(ACTION BROWN-TOP-FLOOR-F)>

;<ROUTINE BROWN-TOP-FLOOR-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
 CR>)>>

<OBJECT ROOF-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "roof door")
	(SYNONYM DOOR)
	(ADJECTIVE ROOF)
	(FLAGS DOORBIT LOCKED NDESCBIT OPENABLE)
	(ACTION ROOF-DOOR-F)>

<ROUTINE ROOF-DOOR-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,ROOF-DOOR ,LOCKED>>
		     <NOT <FSET? ,ROOF-DOOR ,OPENBIT>>>
		<FSET ,ROOF-DOOR ,OPENBIT>
		<TELL
"You push the door open">
		<COND (<HERE? ,BROWN-TOP-FLOOR>
		       <TELL
", revealing a windswept, snow-covered roof. Frigid
wind whips snow into your face">)>
		<TELL "." CR>)
	       (<P? UNLOCK * MASTER-KEY>
		<FCLEAR ,PRSO ,LOCKED>
		<TELL ,DOOR-NOW-UNLOCKED>)
	       (<P? LOCK * MASTER-KEY>
		<FSET ,PRSO ,LOCKED>
		<TELL
"The door is now locked." CR>)
	       (<VERB? THROUGH>
		<COND (<HERE? ,BROWN-ROOF>
		       <DO-WALK ,P?IN>)
		      (ELSE
		       <DO-WALK ,P?OUT>)>)>>

<OBJECT ROOF-DOOR-SIGN
	(IN BROWN-TOP-FLOOR)
	(DESC "sign")
	(SYNONYM SIGN)
	(FLAGS READBIT NDESCBIT)
	(TEXT
"It says \"NO ADMITTANCE!\" In smaller, hand-written letters below,
it says \"This means you!\" and below that in different handwriting,
it says \"Who, me?\"")>

<ROOM BROWN-ROOF
      (IN ROOMS)
      (DESC "Skyscraper Roof")
      (LDESC
"A low parapet surrounds a small roof here. The air conditioning cooling
tower and the small protrusion containing the stairs are dwarfed by a
semitransparent dome which towers above you. The blowing snow obscures
all detail of the city across the river to the south.")
      (IN PER BROWN-ROOF-EXIT) ;BROWN-TOP-FLOOR
      (EAST PER BROWN-ROOF-EXIT)
      (UP TO INSIDE-DOME)
      (FLAGS ONBIT OUTSIDE)
      (GLOBAL ROOF-DOOR LADDER DOME)
      (ACTION BROWN-ROOF-F)>

<ROUTINE BROWN-ROOF-EXIT ()
	 <COND (<IN? ,FLIER ,HERE>
		<TELL
"The dark shape, its foul stench overpowering the wind, ">
		<COND (<IN? ,FLIER-SHAPE ,HERE>
		       <REMOVE ,FLIER-SHAPE>
		       <SETG FLIER-COUNT 3>
		       <TELL "drops from the dome and ">)>
		<TELL "blocks your escape." CR>
		<RFALSE>)
	       (<FSET? ,ROOF-DOOR ,OPENBIT>
		,BROWN-TOP-FLOOR)
	       (ELSE
		<TELL "The door leading inside is closed." CR>
		<RFALSE>)>>

<ROUTINE BROWN-ROOF-F (RARG)
	 <COND ;(<RARG? LOOK>
		<TELL
 CR>)
	       (<RARG? ENTER>
		<EXIT-TO-COLD>)
	       (<RARG? LEAVE>
		<EXIT-FROM-COLD>)
	       (<RARG? BEG>
		<ROOF-BEGS>)>>

<ROUTINE ROOF-BEGS ()
	 <COND (<P? EXAMINE CEILING>
		<TELL "It's made of ">
		<COND (<HERE? ,ON-DOME>
		       <TELL "concrete." CR>)
		      (ELSE
		       <TELL "tiny, tarry cinders." CR>)>)
	       (<P? THROW-OFF * CEILING>
		<COND (<AND <PRSO? SMOOTH-STONE>
			    <IN? ,FLIER ,HERE>>
		       <PERFORM ,V?ATTACK ,FLIER ,SMOOTH-STONE>
		       <RTRUE>)
		      (ELSE
		       <COND (<HERE? ,BROWN-ROOF>
			      <MOVE ,PRSO ,COURTYARD>)
			     (ELSE <REMOVE ,PRSO>)>
		       <OBJ-OFF-ROOF ,PRSO>)>)
	       (<VERB? LEAP>
		<COND (<IN? ,FLIER ,HERE>
		       <TELL
"The creature sees you preparing to leap, and springs toward you in a
desperate effort, blood-red mouth contorted with a cry of frustration,
but it's too late." CR>)>
		<JIGS-UP
"You leap over the edge. Freezing ice crystals hitting you in the face
as you fall. Then you hit the ground, which is more unpleasant still.">)>>

<OBJECT DOME
	(IN LOCAL-GLOBALS)
	(DESC "dome")
	(SYNONYM DOME)
	(ADJECTIVE LARGE WEATHER GREAT)
	(FLAGS NDESCBIT)
	(ACTION DOME-F)>

<ROUTINE DOME-F ()
	 <COND (<VERB? THROUGH CLIMB-FOO>
		<DO-WALK ,P?UP>)
	       (<HERE? ,BROWN-ROOF>
		<COND (<VERB? EXAMINE>
		       <TELL
"The dome is large and semitransparent. It's made of some sort of
milky-colored plastic. It dominates the roof. You can climb up to the
entrance via a short ladder." CR>)>)
	       (ELSE
		<COND (<VERB? LEAP>
		       <JIGS-UP
"It was a long way down. It was quick, though.">)>)>>

<ROOM INSIDE-DOME
      (IN ROOMS)
      (DESC "Inside Dome")
      (LDESC
"You are inside a large domed area. The dome contains equipment that
makes it clear it is a weather observation station. For some reason,
it also contains a small peach tree. Wind whistles outside, and snow
blasts against the semitransparent material of the dome.")
      (DOWN PER INSIDE-DOME-EXIT) ;BROWN-ROOF
      (OUT PER INSIDE-DOME-EXIT)
      (FLAGS ONBIT)
      (GLOBAL GLOBAL-HOLE LADDER)
      (ACTION INSIDE-DOME-F)
      (THINGS
       <PSEUDO (<> EQUIPMENT RANDOM-PSEUDO)
	       (<> DOME RANDOM-PSEUDO)>)>

<ROUTINE INSIDE-DOME-EXIT ()
	 <COND (<IN? ,FLIER ,HERE>
		<TELL
"The creature is blocking your exit." CR>
		<RFALSE>)
	       (ELSE
		,BROWN-ROOF)>>

<ROUTINE INSIDE-DOME-F (RARG)
	 <COND ;(<RARG? LOOK>
		<TELL
 CR>)
	       (<RARG? ENTER>
		<COND (<AND <ZERO? ,FLIER-COUNT>
			    <HELD? ,SMOOTH-STONE>>
		       <QUEUE I-FLIER -1>)>)
	       (<RARG? BEG>
		<COND (<P? (DIG SEARCH) DIRT>
		       <NEW-PRSO ,TUB>
		       <RTRUE>)>)
	       (<RARG? END>
		<COND (<AND <ZERO? ,FLIER-COUNT>
			    <HELD? ,HAND>>
		       <QUEUE I-FLIER -1>)>)>>

<GLOBAL FLIER-COUNT 0>

<ROUTINE I-FLIER ()
	 <COND (<AND <NOT <ZERO? ,FLIER-COUNT>>
		     <IN? ,FLIER ,GLOBAL-OBJECTS>>
		<DEQUEUE I-FLIER>
		<RFALSE>)>
	 <SETG FLIER-COUNT <+ ,FLIER-COUNT 1>>
	 <QUEUE I-FLIER -1>
	 <COND (<HERE? ,INSIDE-DOME>
		<COND (<EQUAL? ,FLIER-COUNT 1>
		       <MOVE ,FLIER-SHAPE ,HERE>
		       <MOVE ,FLIER ,BROWN-ROOF>
		       <TELL CR
"Something smashes against the glass of the dome! You turn
and see a dark shape clinging to the outside of the structure." CR>)
		      (<EQUAL? ,FLIER-COUNT 2>
		       <TELL CR ,SHAPE-TWITCHES CR>)
		      (<EQUAL? ,FLIER-COUNT 3>
		       <REMOVE ,FLIER-SHAPE>
		       <TELL CR
"The shape drops out of view." CR>)
		      (<EQUAL? ,FLIER-COUNT 4>
		       <TELL CR
"You hear, on the ladder outside, hard claws painfully
climbing towards the dome entrance." CR>)
		      (<AND <G=? ,FLIER-COUNT 5>
			    <NOT <IN? ,FLIER ,HERE>>>
		       <MOVE ,FLIER ,HERE>
		       <TELL CR
"The creature enters the dome, screaming viciously at you, its
claws reaching out to grasp and rend." CR>)
		      (ELSE
		       <FLIER-EATS-HAND?>)>)
	       (<HERE? ,BROWN-ROOF>
		<COND (<EQUAL? ,FLIER-COUNT 1>
		       <MOVE ,FLIER-SHAPE ,INSIDE-DOME>
		       <MOVE ,FLIER ,BROWN-ROOF>
		       <TELL CR
"You hear a strange confusion of wings, and then something
dark and shapeless smashes against the dome above you!" CR>)
		      (<EQUAL? ,FLIER-COUNT 2>
		       <TELL CR ,SHAPE-TWITCHES CR>)
		      (<EQUAL? ,FLIER-COUNT 3>
		       <REMOVE ,FLIER-SHAPE>
		       <TELL CR
"The shape drops, crunching into the snow almost next to you.
Its scaly head turns toward you, eyes like coals
staring into yours." CR>)
		      (<EQUAL? ,FLIER-COUNT 4>
		       <TELL CR
"The shape rises, baring needle-sharp teeth and pumping its
wings painfully in the gale." CR>)
		      (<EQUAL? ,FLIER-COUNT 5>
		       <TELL CR
"The creature approaches, hissing at you as it nears." CR>)
		      (ELSE <FLIER-EATS-HAND?>)>)>>

<GLOBAL SHAPE-TWITCHES
"The dark shape moves. Above the howl of the wind you
hear a high-pitched keening noise.">

<ROUTINE FLIER-EATS-HAND? ("OPT" (NOCR? <>))
	 <COND (<AND <IN? ,FLIER ,HERE>
		     <OR .NOCR?
			 <IN? ,HAND ,PLAYER>
			 <IN? ,HAND ,HERE>>>
		<MOVE ,FLIER ,GLOBAL-OBJECTS>
		<COND (<NOT .NOCR?> <CRLF>)>
		<TELL
"In a snake-like strike, the creature ">
		<COND (<IN? ,HAND ,WINNER>
		       <TELL
"attacks! Its toothy jaws close on your hand! Not your hand, but the ">)
		      (ELSE
		       <TELL
"snaps at the ">)>
		<REMOVE ,HAND>
		<COND (<NOT <FSET? ,HAND ,PERSON>>
		       <TELL "mummified ">)>
		<TELL "hand you dug out of the
tub! With a disgusting gobbling noise, the flier swallows the hand, and
then, ">
		<COND (<HERE? ,BROWN-ROOF>
		       <TELL
"its wings beating feebly against the wind, it sails away into the gale.">)
		      (ELSE
		       <TELL
"using its wings to push itself away, it scuttles out into the cold and
away.">)>
		<CRLF>)>>

<OBJECT FLIER-SHAPE
	(DESC "dark shape")
	(SYNONYM SHAPE FLIER THING)
	(ADJECTIVE DARK SHAPELESS)
	(FLAGS NDESCBIT)
	(ACTION FLIER-SHAPE-F)>

<ROUTINE FLIER-SHAPE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
,YOU-CANT "tell much from here. It's large and dark,
but the dome obscures all detail." CR>)>>

<OBJECT FLIER
	(DESC "creature")
	(SYNONYM SHAPE FLIER CREATURE)
	(ADJECTIVE DARK)
	(DESCFCN FLIER-DESC)
	(GENERIC GENERIC-CREATURE-F)
	(VALUE 5)
	(ACTION FLIER-F)>

<ROUTINE FLIER-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?> <RTRUE>)
	       (ELSE
		<TELL
"A dark shape watches balefully from nearby.">)>>

<ROUTINE FLIER-F ()
	 <COND (<IN? ,FLIER ,GLOBAL-OBJECTS>
		<COND (<NOT <ABSTRACT-VERB?>>
		       <TELL
"The creature has disappeared as though it never was." CR>)>)
	       (<VERB? EXAMINE>
		<TELL
"Like a black sheet flapping in the wind, the dark flier is hard to see.
Red eyes glow like coals on its scaly, bullet-shaped head. Human-like
hands clench and unclench. Sharp needles of teeth project wickedly from
its twisted jaw." CR>)
	       (<VERB? SMELL>
		<TELL
"Its stench is that of a foul eater of carrion, overlaid with another
smell you can't place, but which is even less appetizing." CR>)
	       (<AND <VERB? ATTACK KILL> <NOT <PRSI? ,SMOOTH-STONE>>>
		<TELL
"Hissing and screeching, the creature fends off your attack. Its
head jerks from side to side, watching you." CR>)
	       (<VERB? GIVE>
		<COND (<PRSO? ,HAND>
		       <FLIER-EATS-HAND? T>)
		      (<PRSO? ,SMOOTH-STONE>
		       <TELL
CTHE ,PRSI " edges away." CR>)>)
	       (<AND <P? (THROW POUR) * FLIER>
		     <NOT <PRSO? ,SMOOTH-STONE ,ELIXIR>>>
		<MOVE ,PRSO ,HERE>
		<TELL
"The creature darts to the side, dodging " THE ,PRSO ,PERIOD>)>>

<OBJECT PEACH-TREE
	(IN INSIDE-DOME)
	(DESC "peach tree")
	(SYNONYM TREE)
	(ADJECTIVE PEACH)
	(FLAGS NDESCBIT)
	(ACTION PEACH-TREE-F)>

<ROUTINE PEACH-TREE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a small peach tree planted in a very large tub of
earth. It appears healthy, although as it is wintertime, the tree
has no leaves." CR>)
	       (<VERB? RUB>
		<TELL
"It feels like wood, but there is something slippery on it higher up." CR>)
	       (<P? (ATTACK CUT) * AXE>
		<TELL
"At the last second, you realize it would be an unspeakable act of
vandalism." CR>)
	       (<VERB? SHAKE>
		<TELL
"You shake it, but nothing drops. Its branches are bare." CR>)
	       (<VERB? CLIMB-ON CLIMB-UP CLIMB-FOO>
		<TELL
S "You start to climb " "the tree, but
as you get partway up, your hands encounter a slippery substance
which covers the limbs at this height. Not only is it extremely unpleasant
to touch, it makes the tree too slippery to climb any further." CR>)>>

<OBJECT TUB
	(IN INSIDE-DOME)
	(DESC "tub of dirt")
	(SYNONYM TUB DIRT EARTH)
	(ADJECTIVE WOODEN LARGE)
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 30)
	(ACTION TUB-F)>

<ROUTINE TUB-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The tub is full of dirt and \"condo chips\" (those pine bark
chips that are spread around condos and shopping centers by the
ton). The dirt has been disturbed recently." CR>)
	       (<VERB? DIG SEARCH LOOK-INSIDE>
		<COND (<NOT <FSET? ,HAND ,TOUCHBIT>>
		       <FSET ,HAND ,TOUCHBIT>
		       <MOVE ,HAND ,TUB>
		       <SCORE-OBJECT ,HAND>
		       <TELL
S "You root around ""in the dirt for a while, when you encounter something
hard. Further exploration reveals it to be a dried, chewed
looking human hand." CR>)
		      (ELSE
		       <TELL
,YOU-FIND-NOTHING " further, which is something of a relief." CR>)>)>>

<OBJECT TATTOO
	(IN HAND)
	(DESC "tattoo")
	(SYNONYM TATTOO SYMBOL)
	(ADJECTIVE STRANGE)
	(FLAGS NDESCBIT)
	(SIZE 0)
	(GENERIC GENERIC-SYMBOL-F)
	(ACTION TATTOO-F)>

<ROUTINE TATTOO-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"The tattoo is old and faded. It was done in red ink and is very
artistically drawn. ">
		<TELL-SYMBOL ,HAND>
		<CRLF>)
	       (<VERB? RUB>
		<TELL
"This part of the hand feels particularly cold." CR>)>>

<OBJECT HAND
	(DESC "human hand")
	(SYNONYM HAND)
	(ADJECTIVE DEAD MUMMIFIED HUMAN)
	(VALUE 5)
	(HEAT 0)
	(FLAGS TAKEBIT SEARCHBIT OPENBIT CONTBIT)
	(GENERIC GENERIC-HAND-F)
	(CONTFCN HAND-F)
	(ACTION HAND-F)>

<ROUTINE HAND-F ("OPT" (RARG <>))
	 <COND (<RARG? CONTAINER>
		<COND (<FSET? ,HAND ,PERSON>
		       <COND (<VERB? WEAR>
			      <TAKE-OUT-FIRST ,PRSO ,HAND>)
			     (<OR <NOT <VERB? TAKE>>
				  <NOT <HELD? ,HAND>>>
			      <NEW-PRSO ,HAND>)>)>)
	       (<WINNER? ,HAND>
		<TELL
"As you speak, the hand sits still, but there is
no other noticeable result." CR>
		<END-QUOTE>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,HAND ,PERSON>
		       <TELL
"There are stains, scars, ">
		       <COND (<IN? ,RING ,HAND>
			      <TELL A ,RING ", ">)>
		       <TELL "and a tattoo on the hand. ">
		       <COND (,LAIR-FLAG
			      <COND (<HELD? ,HAND>
				     <HAND-POINTS>)
				    (ELSE
				     <TELL
"It's splashing in" ,THE-POOL>)>)
			     (ELSE
			      <TELL
"It looks perfectly normal and alive, ignoring the fact that there
is no arm attached to it. It doesn't appear to mind, so why should you?" CR>)>)
		      (ELSE
		       <TELL
"The hand is very old. It's dry and very light, mummified in fact. There
are stains, scars, and dried blood on it. There is a tattoo on the back
of it. The hand appears to have been severed by the application of very
sharp teeth, perhaps an animal's." CR>)>)
	       (<AND <PRSO? ,HAND>
		     <OR <VERB? TAKE PUT THROW>
			 <P? RUB * HAND>
			 <HOSTILE-VERB?>>
		     <FSET? ,HAND ,PERSON>>
		<COND (<HERE? ,INNER-LAIR>
		       <TELL
CTHE ,HAND ", muddy and wet, wiggles out of your grasp." CR>)
		      (<IN? ,HAND ,PLAYER>
		       <TELL
CTHE ,HAND " scuttles away to your other shoulder." CR>)>)
	       (<P? PUT-ON RING HAND>
		<COND (<FSET? ,HAND ,PERSON>
		       <FCLEAR ,RING ,WEARBIT>
		       <MOVE ,RING ,HAND>
		       <TELL
"The ring fits the hand perfectly." CR>)
		      (ELSE
		       <TELL
,YOU-CANT "get the ring onto the dry flesh of the hand." CR>)>)
	       (<P? (GIVE SHOW) * HAND>
		<COND (<FSET? ,HAND ,PERSON>
		       <TELL "The hand ">
		       <COND (<IN? ,HAND ,VAT>
			      <TELL "is preoccupied." CR>)
			     (<FSET? ,PRSO ,PERSON>
			      <TELL "doesn't react." CR>)
			     (ELSE
			      <TELL
"scurries to " THE ,PRSO " and touches it all over, much as a
blind person would examine something." CR>)>)>)
	       (<P? RUB ,HAND>
		<COND (<NOT <HELD? ,HAND>>
		       <NOT-HOLDING ,HAND>)
		      (<FSET? ,HAND ,PERSON>
		       <TELL
"It's warm and dry." CR>)
		      (ELSE
		       <TELL
"It's dry and cold. In fact, it's mummified." CR>)>)
	       (<AND <VERB? FOLLOW>
		     <HERE? ,INNER-LAIR>>
		<TELL
"The pool isn't that deep!" CR>)>>
