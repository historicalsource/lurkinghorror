"GLOBALS for
			   The Lurking Horror
	(c) Copyright 1986 Infocom, Inc. All Rights Reserved."

<DIRECTIONS ;"Do not change the order of the first 8 without consulting MARC!"
 	    NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

<SYNONYM NORTH N>
<SYNONYM SOUTH S>
<SYNONYM EAST E>
<SYNONYM WEST W>
<SYNONYM DOWN D>
<SYNONYM UP U>
<SYNONYM NE NORTHEAST>
<SYNONYM NW NORTHWEST>
<SYNONYM SE SOUTHEAST>
<SYNONYM SW SOUTHWEST>
<SYNONYM IN AHEAD>

<GLOBAL HERE <>>

<GLOBAL LIT <>>

<GLOBAL MOVES 0>

<GLOBAL SCORE 0>

;<GLOBAL DIR-TABLE
	<PLTABLE 1 P?NORTH "north"
		 2 P?EAST "east"
		 4 P?WEST "west"
		 8 P?SOUTH "south"
		 16 P?NE "northeast"
		 32 P?NW "northwest"
		 64 P?SE "southeast"
		 128 P?SW "southwest">>

<CONSTANT DIR-BIT 1>
<CONSTANT DIR-DIR 2>
<CONSTANT DIR-NAME 3>

;<ROUTINE DIR-BASE (DIR I O "AUX" (L <GET ,DIR-TABLE 0>))
	 <DO (CNT 0 .L 3)
	     <COND (<EQUAL? <GET ,DIR-TABLE <+ .CNT .I>> .DIR>
		    <RETURN <GET ,DIR-TABLE <+ .CNT .O>>>)>>>

"global objects and associated routines"

<OBJECT GLOBAL-OBJECTS
	(FLAGS AN
	       CONTBIT
	       DOORBIT
	       INVISIBLE
	       LOCKED
	       NDESCBIT
	       NOABIT
	       NOTHEBIT
	       ONBIT
	       OUTSIDE
	       OPENBIT
	       PERSON
	       POWERBIT
	       ;RAIRBIT
	       READBIT
	       RLANDBIT
	       RMUNGBIT
	       ;RWATERBIT
	       SEARCHBIT
	       SLIMEBIT
	       SURFACEBIT
	       TAKEBIT
	       THE
	       TOOLBIT
	       TOUCHBIT
	       TRANSBIT
	       TRYTAKEBIT
	       VEHBIT
	       WEAPONBIT
	       WEARBIT)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZZMGCK) ;"Yes, this needs to exist."
	(DESCFCN 0)
        (CONTFCN 0)
	(GLOBAL GLOBAL-OBJECTS)
	(FDESC "F")
	(LDESC "F")
	;(NAME 0)
	;(PSEUDO "FOOBAR" V-WALK)
	(THINGS 0)
	(COUNT 0)
	(SIZE 0)
	(TEXT "")
	(CAPACITY 0)>

<OBJECT ROOMS
	(IN TO ROOMS)>

<GLOBAL P-DIRECTION <>>

<OBJECT INTDIR
	(IN GLOBAL-OBJECTS)
	(DESC "direction")>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(DESC "number")
	(SYNONYM INTNUM)
	(ADJECTIVE NUMBER)
	(ACTION INTNUM-F)>

<ROUTINE INTNUM-F ()
	 <COND (<PRSO? ,INTNUM>
		<COND (<HERE? ,CS-ELEVATOR-ROOM>
		       <REDIRECT ,INTNUM ,FLOOR-BUTTON>
		       <RTRUE>)
		      (<HERE? ,KITCHEN>
		       <PUT ,P-ADJW 0 ,W?INTNUM>
		       <REDIRECT ,INTNUM ,CONTROLS>
		       <RTRUE>)
		      (<VERB? PUSH>
		       <TELL S "There's no number ""to push here." CR>)>)>>

<OBJECT PSEUDO-OBJECT
	(IN GLOBAL-OBJECTS)
	(DESC "pseudo")
	(ACTION ME-F)>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THEM OBJECT FROB)
	(DESC "it")
	(FLAGS AN NOABIT NOTHEBIT NDESCBIT TOUCHBIT)>

<OBJECT HIM
	(IN GLOBAL-OBJECTS)
	(SYNONYM HIM HER)
	(DESC "him")
	(FLAGS NOABIT NOTHEBIT NDESCBIT TOUCHBIT)>

<OBJECT NOT-HERE-OBJECT
	(DESC "it")
	(FLAGS NOABIT NOTHEBIT)
	(ACTION NOT-HERE-OBJECT-F)>

"NOT-HERE-OBJECT-F returns false if it was successful in substituting
an object for the not-here-object. if it returns true, it failed for
some reason."

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) (X <>))
	 <COND (<AND <PRSO? ,NOT-HERE-OBJECT>
		     <PRSI? ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<PRSO? ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>
		<COND (<VERB? FOLLOW WAIT-FOR FIND
			      TELL WHAT WHERE WHO>
		       <SET X T>)>)
	       (T
		<SET TBL ,P-PRSI>
		<COND (<VERB? ASK-ABOUT ASK-FOR TELL-ABOUT>
		       <SET X T>)>
		<SET PRSO? <>>)>
	 <COND (<AND .X <NOT <FIND-NOT-HERE .TBL .PRSO?>>>
		<COND (<VERB? FOLLOW>
		       <TELL
"I'm afraid that's not possible." CR>
		       <RTRUE>)
		      (<VERB? WAIT-FOR>
		       <COND (<AND <PRSO? ,RATS>
				   <IN-TUNNEL? ,RATS>
				   <IN-TUNNEL?>>
			      <TELL "All in good time..." CR>
			      <RTRUE>)
			     (ELSE
			      <COND (<PLURAL? ,PRSO>
				     <TELL "They're">)
				    (ELSE
				     <TELL "He's">)>
			      <TELL " not expected any time soon." CR>
			      <RTRUE>)>)
		      (<AND <VERB? TELL>
			    <OR <NOT <EQUAL? <LOC ,PRSO>
					     ,INF-1 ,INF-2 ,INF-3
					     ,INF-4 ,INF-5>>
				<NOT <HERE? ,INF-1 ,INF-2 ,INF-3
					    ,INF-4 ,INF-5>>>>
		       ;<CANT-SEE-ANY-HERE .PRSO?>
		       ;<RTRUE>)	
		      (ELSE
		       <RFALSE>)>)>
	 ;"Here is the default 'cant see any' printer"
	 <CANT-SEE-ANY-HERE .PRSO?>>

<ROUTINE CANT-SEE-ANY-HERE (PRSO?)
	 <COND (<WINNER? ,PLAYER>
		<TELL "You">)
	       (ELSE
		<TELL CTHE ,WINNER>)>
	 <TELL " can't see any ">
	 <COND (,P-OFLAG
		<COND (<PRINT-ADJT ,P-XADJNT>)>
		<COND (,P-XNAM <PRINTB ,P-XNAM>)>)
	       (ELSE
		<THING-PRINT .PRSO?>)>
	 <TELL " here." CR>
	 <END-QUOTE>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
;"Special-case code goes here. <MOBY-FIND .TBL> returns # of matches. If 1,
then P-MOBY-FOUND is it. You can treat the 0 and >1 cases alike or differently.
Always return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
	%<DEBUG-CODE
	  <COND (,ZDEBUG
		 <TELL "[Found " N .M-F " obj]" CR>)>>
	<COND (<EQUAL? 1 .M-F>
	       %<DEBUG-CODE
		 <COND (,ZDEBUG
			<TELL "[Namely: " D ,P-MOBY-FOUND "]" CR>)>>
	       <COND (.PRSO?
		      <SETG PRSO ,P-MOBY-FOUND>)
		     (T
		      <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (T
	       ,NOT-HERE-OBJECT)>>

<OBJECT LIGHT
	(IN GLOBAL-OBJECTS)
	(DESC "light")
	(SYNONYM LIGHT LIGHTS)
        (ACTION LIGHT-F)>

<ROUTINE LIGHT-F ()
	 <COND (<VERB? LAMP-ON>
		<COND (,LIT
		       <TELL ,IT-IS-ALREADY "light" ,PERIOD>)
		      (T
		       <TELL
"You need a light source!" CR>)>)
	       (<VERB? LAMP-OFF>
		<TELL ,WASTE-OF-TIME>)>>

<OBJECT GLOBAL-HOLE
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "hole")
	(SYNONYM HOLE)
	(ADJECTIVE MUDDY)
	(ACTION GLOBAL-HOLE-F)>

<ROUTINE GLOBAL-HOLE-F ()
	 <COND (<P? DIG GLOBAL-HOLE *>
		<PERFORM ,V?DIG ,PRSI>
		<RTRUE>)
	       (<VERB? REACH-IN>
		<TELL ,YOU-FIND-NOTHING " of interest." CR>)>>

<OBJECT CEILING
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "ceiling")
	(SYNONYM CEILIN ROOF)
	(ACTION CEILING-F)>

<ROUTINE CEILING-F ()
	 <COND (<VERB? LOOK-UNDER>
		<NEW-VERB ,V?LOOK>
		<RTRUE>)>>

<OBJECT AIR
	(IN GLOBAL-OBJECTS)
	(DESC "air")
	(SYNONYM AIR COLD)
	(FLAGS AN NOABIT)>

<OBJECT FEET
	(IN GLOBAL-OBJECTS)
	(SYNONYM FEET FOOT)
	(DESC "your feet")
	(FLAGS NDESCBIT TOOLBIT TOUCHBIT NOABIT NOTHEBIT)>

<OBJECT HANDS
	(IN GLOBAL-OBJECTS)
	(SYNONYM HANDS HAND)
	(ADJECTIVE BARE MY)
	(DESC "your hand")
	(FLAGS NDESCBIT TOOLBIT TOUCHBIT NOABIT NOTHEBIT)
	(GENERIC GENERIC-HAND-F)>

<ROUTINE GENERIC-HAND-F ()
	 ,HAND>

<OBJECT HEAD
	(IN GLOBAL-OBJECTS)
	(DESC "your head")
	(SYNONYM HEAD FACE)
	(ADJECTIVE YOUR MY)
	(FLAGS NOABIT NOTHEBIT)>

<OBJECT EYES
	(IN GLOBAL-OBJECTS)
	(DESC "your eyes")
	(SYNONYM EYE EYES)
	(ADJECTIVE YOUR MY)
	(FLAGS NOABIT NOTHEBIT)
	(ACTION EYES-F)>

<ROUTINE EYES-F ()
	 <COND (<VERB? OPEN>
		<TELL "They are." CR>)
	       (<VERB? CLOSE>
		<TELL "That won't help." CR>)
	       (<NOT ,LIT>
		<TELL ,TOO-DARK>)>>

<OBJECT PLAYER
	(IN TERMINAL-ROOM)
	(SYNONYM PROTAG)
	(DESC "it")
	(FLAGS NDESCBIT INVISIBLE PERSON CONTBIT TRANSBIT)
	(ACTION PLAYER-F)>

<ROUTINE PLAYER-F ("AUX" DOOR)
	 <COND (,ON-CABLE?
		<COND (<OR <P? DROP ROOMS>
			   <VERB? DISEMBARK TAKE TAKE-OFF>
			   <HOSTILE-VERB?>
			   <AND <VERB? WALK>
				<EQUAL? ,P-WALK-DIR ,P?DOWN>>>
		       <SETG ON-CABLE? <>>
		       <TELL "You let go of the cable and drop to the floor">
		       <COND (,RATS-HERE
			      <COND (<L? ,RATS-HERE 2>
				     <SETG RATS-HERE 2>)>
			      <TELL
" among the now-frenzied rats">)>
		       <TELL ,PERIOD>)>)
	       (,HOLDING-DOORS?
		<SET DOOR <THIS-FLOOR-DOOR>>
		<COND (<AND <NOT <PRSO? ,ELEVATOR-DOOR .DOOR>>
			    <NOT <PRSI? ,ELEVATOR-DOOR .DOOR>>
			    <NOT <GAME-VERB?>>
			    <NOT <PASSIVE-VERB?>>>
		       <TELL ,HOLDING-IS-ALL CR>)>)
	       (ELSE <RFALSE>)>>

<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM ME MYSELF SELF)
	(DESC "yourself")
	(FLAGS PERSON TOUCHBIT NOABIT NOTHEBIT)
	(ACTION ME-F)>

<ROUTINE MENTAL-COLLAPSE ()
	 <TELL
"Talking to yourself is a sign of impending mental collapse." CR>>

<ROUTINE ME-F ("AUX" OLIT)
	 <COND (<P? EXAMINE ,ME>
		<V-DIAGNOSE>)
	       (<VERB? TELL HELP>
		<MENTAL-COLLAPSE>
		<END-QUOTE>)
	       (<VERB? LISTEN>
		<TELL "Yes?" CR>)
	       (<VERB? WAKE>
		<TELL ,YOU-ARE>
		<TELL ,PERIOD>)
	       (<AND <WINNER? ,PLAYER>
		     <VERB? GIVE>>
		<COND (<PRSO? ,ME>
		       <TELL ,WASTE-OF-TIME>)
		      (<PRSI? ,ME>
		       <COND (<IN? ,PRSO ,PLAYER>
			      <PRE-TAKE>)
			     (T
			      <PERFORM ,V?TAKE ,PRSO>
			      <RTRUE>)>)>)
	       (<VERB? MOVE>
		<V-WALK-AROUND>)
	       (<VERB? SEARCH>
		<V-INVENTORY>
		<RTRUE>)
	       (<VERB? KILL MUNG BURY SMELL>
		<JIGS-UP
"Verdict: suicide while the balance of the mind was disturbed.">
		<RTRUE>)
	       (<VERB? WHO>
		<V-WHAT>)
	       (<VERB? FOLLOW>
		<TELL
"You're getting ahead of yourself." CR>)
	       (<VERB? LOOK-BEHIND>
		<TELL
"You look back over your shoulder. ">
		<COND (<PROB 80>
		       <TELL
S "There's nothing ""there." CR>)
		      (<PROB 80>
		       <TELL
"Was that a flicker of movement in the distance?" CR>)
		      (ELSE
		       <TELL
"You see something duck back into the shadows." CR>)>)>>

<OBJECT GLOBAL-ROOM
	(IN GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM CHAMBER PLACE BASEMENT)
	(ADJECTIVE AREA)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ()
	 <COND (<VERB? LOOK EXAMINE LOOK-INSIDE>
		<V-LOOK>
		<RTRUE>)
	       (<P? PUT * ,GLOBAL-ROOM>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<VERB? THROUGH WALK-TO>
		<V-WALK-AROUND>)
	       (<VERB? DROP LEAVE EXIT>
		<DO-WALK ,P?OUT>)
	       (<VERB? WALK-AROUND>
		<TELL
"Walking around the room reveals nothing new. To move elsewhere, just type
the desired direction." CR>)
	       (<VERB? LAMP-ON>
		<NEW-PRSO ,LIGHT>
		<RTRUE>)>>


<SETG C-NORTH 1>
<SETG C-EAST 2>
<SETG C-WEST 4>
<SETG C-SOUTH 8>
<SETG C-NE 16>
<SETG C-NW 32>
<SETG C-SE 64>
<SETG C-SW 128>

<CONSTANT C-NORTH 1>
<CONSTANT C-EAST 2>
<CONSTANT C-WEST 4>
<CONSTANT C-SOUTH 8>
<CONSTANT C-NE 16>
<CONSTANT C-NW 32>
<CONSTANT C-SE 64>
<CONSTANT C-SW 128>

<OBJECT NORTH-WALL
	(IN GLOBAL-OBJECTS)
	(DESC "north wall")
	(SYNONYM WALL)
	(ADJECTIVE NORTH)
	(GENERIC GENERIC-WALL-F)
	(ACTION WALL-F)>

<OBJECT EAST-WALL
	(IN GLOBAL-OBJECTS)
	(DESC "east wall")
	(SYNONYM WALL)
	(ADJECTIVE EAST)
	(FLAGS AN)
	(GENERIC GENERIC-WALL-F)
	(ACTION WALL-F)>

<OBJECT WEST-WALL
	(IN GLOBAL-OBJECTS)
	(DESC "west wall")
	(SYNONYM WALL)
	(ADJECTIVE WEST)
	(GENERIC GENERIC-WALL-F)
	(ACTION WALL-F)>

<OBJECT SOUTH-WALL
	(IN GLOBAL-OBJECTS)
	(DESC "south wall")
	(SYNONYM WALL)
	(ADJECTIVE SOUTH)
	(GENERIC GENERIC-WALL-F)
	(ACTION WALL-F)>

<OBJECT WALL
	(IN GLOBAL-OBJECTS)
	(DESC "wall")
	(SYNONYM WALL WALLS)
	(GENERIC GENERIC-WALL-F)
	(ACTION WALL-F)>

<ROUTINE GENERIC-WALL-F ()
	 ,WALL>

<ROUTINE WALL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL ,IT-LOOKS-LIKE "a wall." CR>)
	       (<VERB? LOWER MUNG>
		<TELL ,YOU-CANT "pull down a wall that easily." CR>)>>

<OBJECT DIRT
	(IN GLOBAL-OBJECTS)
	(DESC "dirt")
	(SYNONYM RUBBLE DEBRIS DUST DIRT)
	(FLAGS NOABIT)>

<OBJECT GROUND
	(IN GLOBAL-OBJECTS)
	(SYNONYM FLOOR GROUND FIELD)
	(ADJECTIVE STONE SANDY TINY LEVEL)
	(DESC "floor")
	;(FLAGS NOABIT)
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ()
	 <COND (<VERB? EXAMINE>
		<COND ;(<FSET? ,HERE ,RAIRBIT>
		       <TELL
"It's a long way down." CR>)
		      (ELSE
		       <TELL
"It's still there." CR>)>)
	       (<P? PUT * ,GROUND>
		<PERFORM ,V?BURY ,PRSO>
		<RTRUE>)
	       (<VERB? CLIMB-UP CLIMB-ON CLIMB-FOO BOARD>
		<TELL ,WASTE-OF-TIME>)
	       (<VERB? LOOK-UNDER>
		<TELL
"You never did master X-rays. Freshman physics was such a drag." CR>)>>

<OBJECT CORRIDOR
	(IN GLOBAL-OBJECTS)
	(DESC "passage")
	(SYNONYM PASSAGE CORRIDOR EXIT TUNNEL)
	(ADJECTIVE LONG DARK STEAM)
	(ACTION CORRIDOR-F)>

<ROUTINE CORRIDOR-F ()
	 <COND (<VERB? THROUGH WALK-TO>
		<V-WALK-AROUND>)
	       (<AND <VERB? FOLLOW CLIMB-DOWN>
		     <HERE? ,YUGGOTH ,BOWL-ROOM ,PLATFORM-ROOM>>
		<DO-WALK ,P?DOWN>)
	       (<VERB? CLIMB-DOWN>
		<COND (<HERE? ,DEAD-STORAGE>
		       <DO-WALK ,P?EAST>)>)>>

;<OBJECT LOCAL-WATER
	(SYNONYM WATER)
	(ADJECTIVE FRESH SALT SEA)
	(DESC "water")
	(FLAGS NOABIT)
	(ACTION WATER-F)>

;<OBJECT WATER
	(IN LOCAL-GLOBALS)
	(SYNONYM WATER)
	(DESC "water")
	(FLAGS NDESCBIT NOABIT)
	(ACTION WATER-F)>

;<ROUTINE WATER-F ()
	 <COND (<P? (POUR THROW) ,LOCAL-WATER>
		<COND (<AND <LOC ,PRSO>
			    <IN? <LOC ,PRSO> ,WINNER>>
		       <PERFORM ,V?POUR <LOC ,PRSO>>
		       <RTRUE>)
		      (ELSE
		       <DONT-HAVE-THAT>)>)
	       (<VERB? EAT DRINK DRINK-FROM>
	        <COND (<PRSO? ,LOCAL-WATER>
		       <COND (<IN? <LOC ,PRSO> ,WINNER>
			      <COND (<FSET? <LOC ,PRSO> ,OPENBIT>
				     <REMOVE ,PRSO>)
				    (ELSE
				     <TELL-OPEN-CLOSED <LOC ,PRSO>>
				     <RTRUE>)>)
			     (<NOT <GLOBAL-IN? ,WATER ,HERE>>
			      <TELL ,YOU-DONT-HAVE THE <LOC ,PRSO> ,PERIOD>
			      <RTRUE>)>)>
		<COND (<OR <AND <PRSO? ,LOCAL-WATER>
				<FSET? ,PRSO ,RMUNGBIT>>
			   ;<AND <PRSO? ,WATER>
				<HERE? ;"ROOM WITH WATER">>>
		       <TELL
"It's bitter and you spit it out immediately.">)
		      (ELSE
		       <TELL
"That was refreshing, but you shouldn't drink untested water.">)>
		<CRLF>)
	       (<VERB? REACH-IN RUB>
		<TELL
"It's wet." CR>)
	       (<VERB? LOOK-INSIDE LOOK-UNDER>
		<MAKE-OUT>)
	       ;(<VERB? THROUGH LEAP>
		<COND (<FSET? ,HERE ,RWATERBIT>
		       <TELL ,YOU-ARE ,PERIOD>)>)>>

<ROUTINE RANDOM-PSEUDO ()
	 <COND (<AND <EQUAL? ,P-PNAM ,W?SHAFT>
		     <VERB? EXAMINE LOOK-UP>>
		<LIKE-A-SHAFT>)
	       (<AND <EQUAL? ,P-PNAM ,W?TRIANGLE>
		     <VERB? EXAMINE>>
		<TELL
"It's \"Floppy Triangles,\" a work of modern sculpture." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE LOOK-BEHIND>
		<TELL S "You see nothing special about " "it." CR>)
	       (<VERB? TAKE>
		<YOU-CANT-X-THAT "take">)>>

"sleep, hunger, etc."

;<GLOBAL LAST-SLEPT 40> ;"move when you last woke-up, for purposed of V-TIME"

<OBJECT GLOBAL-SLEEP
	(IN GLOBAL-OBJECTS)
	(DESC "sleep")
	(SYNONYM SLEEP NAP)
	(FLAGS NOABIT NOTHEBIT)
	(ACTION GLOBAL-SLEEP-F)>

<ROUTINE GLOBAL-SLEEP-F ()
	 <COND (<VERB? WALK-TO TAKE>
                <NEW-VERB ,V?SLEEP>
		<RTRUE>)
	       (<VERB? FIND>
		<TELL "Sleep anywhere." CR>)>>

<OBJECT NOISE
	(IN GLOBAL-OBJECTS)
	(DESC "noise")
	(SYNONYM NOISE SOUND)>

<OBJECT SNOW
	(IN GLOBAL-OBJECTS)
	(DESC "snow")
	(SYNONYM SNOW SNOWSTORM BLIZZARD)
	(ACTION SNOW-F)>

<ROUTINE SNOW-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<FSET? ,HERE ,OUTSIDE>
		       <TELL "It's still coming down." CR>)
		      (ELSE <TELL "You are inside." CR>)>)>>
