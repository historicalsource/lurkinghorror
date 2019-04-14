"FROB for
			   The Lurking Horror
	(c) Copyright 1986 Infocom, Inc. All Rights Reserved."

<ROOM TUNNEL-ENTRANCE
      (IN ROOMS)
      (DESC "Tunnel Entrance")
      (LDESC
"The tunnel continues west from here, becoming narrow, muddy, and
forbidding. The walls no longer seem to be as finished as they were.
The steam pipe and coaxial cable disappear into the ceiling at this
point. The temperature has dropped considerably, as well.")
      (EAST TO TUNNEL-WEST)
      (WEST TO MUDDY-TUNNEL)
      (DOWN TO MUDDY-TUNNEL)
      (IN TO MUDDY-TUNNEL)
      (GLOBAL CABLE)>

<ROOM MUDDY-TUNNEL
      (IN ROOMS)
      (DESC "Muddy Tunnel")
      (LDESC
"The tunnel you came through continues down, barely large enough to
enter. It is made of sticky gelatinous mud that's been pushed by
something into a semblance of a passage.")
      (DOWN TO LARGE-CHAMBER)
      (UP TO TUNNEL-ENTRANCE)
      (EAST TO TUNNEL-ENTRANCE)
      (GLOBAL POOL)
      ;(ACTION MUDDY-TUNNEL-F)>

;<ROUTINE MUDDY-TUNNEL-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
 CR>)>>

<ROOM LARGE-CHAMBER
      (IN ROOMS)
      (DESC "Large Chamber")
      (UP TO MUDDY-TUNNEL)
      (DOWN PER LAIR-EXIT) ;"LAIR"
      (GLOBAL GLOBAL-HOLE)
      (ACTION LARGE-CHAMBER-F)>

<ROUTINE LAIR-EXIT ()
	 <COND (<FSET? ,URCHINS ,RMUNGBIT> ;,URCHIN-FLAG
		<TELL
"A few of the urchins grab feebly at you as you pass, but none is a
serious barrier." CR CR>
		,LAIR-1)
	       (<IN? ,URCHINS ,SLOTS>
		<TELL
"Something is blocking the downward passage. It's moving, slowly and
painfully, trying to climb up." CR>
		<RFALSE>)
	       (ELSE
		<TELL
"The urchins lurch, almost as one, into your way, grabbing at you feebly
but effectively. Their pale, limp hands can't grab you, but they can
stop you. There is no way past." CR>
		<RFALSE>)>>

;<GLOBAL URCHIN-FLAG <>>

<ROUTINE LARGE-CHAMBER-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"This is a wide spot in the tunnel, just as wet and muddy as elsewhere.
The walls are slimy as well. Numerous slots or
indentations about two feet wide and a foot high open here and there. ">
		<COND (<LOC ,URCHINS>
		       <COND (<FSET? ,URCHINS ,RMUNGBIT> ;,URCHIN-FLAG
			      <TELL
"Stubs of the wire still ">)
			     (ELSE
			      <TELL
"Thin, wire or ropelike growths emerge
from a hole further down and ">)>
		       <COND (<IN? ,URCHINS ,SLOTS>
			      <TELL "enter each of the slots. There is
background noise here, almost loud enough to hear clearly.">)
			     (<IN? ,URCHINS ,HERE>
			      <TELL "envelop the head of each urchin. The
urchins are ">
			      <COND (<FSET? ,URCHINS ,RMUNGBIT> ;,URCHIN-FLAG
				     <TELL "catatonic.">)
				    (ELSE
				     <TELL
"saying or chanting something repetitive and monotonal,
almost machinelike.">)>)>)
		      (ELSE
		       <TELL
"There is a" S " hole leading down.">)>
		<CRLF>)
	       (<RARG? ENTER>
		<SETG LAIR-FLAG <>>	;"normally what lair room you're in"
		%<IFSOUND
		  <COND (<IN? ,URCHINS ,HERE>
			 <SOUNDS ,S-VOICE ,S-START 2>)
			(<IN? ,URCHINS ,SLOTS>
			 <SOUNDS ,S-VOICE ,S-START 8>)>>
		<QUEUE I-URCHINS -1>)
	       (<RARG? LEAVE>
		%<IFSOUND <SOUNDS ,S-VOICE ,S-STOP>>)
	       (<RARG? BEG>
		<COND (<P? THROUGH GLOBAL-HOLE>
		       <DO-WALK ,P?DOWN>)
		      (<P? EXAMINE GLOBAL-HOLE>
		       <TELL
"It's a slimy, muddy hole, but it's the only way down." CR>)
		      (<AND <VERB? WALK>
			    <NOT <EQUAL? ,P-WALK-DIR ,P?DOWN ,P?UP>>>
		       <PERFORM ,V?THROUGH ,SLOTS>
		       <RTRUE>)
		      (<P? LISTEN (NOISE <>)>
		       <NEW-PRSO <COND (<IN? ,URCHINS ,SLOTS>
					,SLOTS)
				       (ELSE
					,URCHINS)>>
		       <RTRUE>)>)>>

<OBJECT URCHINS
	(IN SLOTS)
	(DESC "urchins")
	(SYNONYM URCHIN CHILDREN KIDS KID)
	(FLAGS INVISIBLE PERSON NOABIT )
	(DESCFCN URCHINS-DESC)
	(ACTION URCHINS-F)>

<ROUTINE URCHINS-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?> <RTRUE>)
	       (ELSE
		<TELL "There are urchins here.">)>>

<GLOBAL NO-RESPONSE "There is no response.">

<ROUTINE URCHINS-F ()
	 <COND (<WINNER? URCHINS>
		<COND (<FSET? ,URCHINS ,RMUNGBIT> ;,URCHIN-FLAG
		       <TELL
,NO-RESPONSE " It's as though they don't hear you." CR>)
		      (ELSE
		       <TELL
"The urchins turn to you in unison. They smile, revealing red, broken
teeth. They never stop their deep-voiced, incomprehensible chant." CR>)>
		<END-QUOTE>)
	       (<VERB? EXAMINE>
		<TELL
"These are not normal looking urchins. Their clothes are
muddy and tattered. They are barefoot in midwinter, and covered with
mud. Around their heads are draped the ">
		<COND (<FSET? ,URCHINS ,RMUNGBIT> ;,URCHIN-FLAG
		       <TELL "stubs of the ">)>
		<TELL
"ropy growths that you've been
noticing in this area. Although their eyes are open, they stare
catatonically." CR>)
	       (<OR <HOSTILE-VERB?>
		    <VERB? SEARCH>>
		<TELL "They ignore you." CR>)
	       (<VERB? HELP UNTIE>
		<BEYOND-HELP>)
	       (<P? (GIVE SHOW) * (,URCHINS ,GLOBAL-URCHINS)>
		<TELL
"They ignore your offer, caught up in something only they can
sense." CR>)
	       (<VERB? WAKE>
		<TELL "They seem quite awake." CR>)
	       (<VERB? LISTEN>
		<TELL
"The strange chant never stops. They don't move their lips to make it.
It resonates deep within their chests." CR>)
	       (<VERB? TELL> <RFALSE>)
	       (ELSE
		<GLOBAL-URCHINS-F>)>>

<OBJECT URCHIN-CLOTHES
	(IN URCHIN)
	(DESC "clothes")
	(SYNONYM PARKA HAT SHOES)
	(ADJECTIVE SKI BUMPY BULKY)
	(FLAGS NDESCBIT TRYTAKEBIT TAKEBIT)
	(ACTION URCHIN-CLOTHES-F)>

<ROUTINE URCHIN-CLOTHES-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It bulges in odd places." CR>)
	       (<VERB? TAKE OPEN RUB LOOK-INSIDE LOOK-UNDER SEARCH>
		<TELL
"\"Hey! Keep off, sucker!">
		<COND (<EQUAL? <GET ,P-NAMW 0> ,W?PARKA>
		       <TELL " " ,YOU-CANT "scare me!">)>
		<TELL "\"" CR>)>>

<OBJECT URCHIN
	(IN AERO-LOBBY)
	(DESC "urchin")
	(SYNONYM URCHIN CHILD KID YOURSELF)
	(ADJECTIVE YOUNG)
	(FLAGS PERSON AN SEARCHBIT OPENBIT CONTBIT)
	(DESCFCN URCHIN-DESC)
	(ACTION URCHIN-F)>

<ROUTINE URCHIN-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?> <RTRUE>)
	       (ELSE
		<TELL
"Slouching nearby is an urchin.">
		<COND (<NOT <FSET? ,URCHIN ,TOUCHBIT>>
		       <FSET ,URCHIN ,TOUCHBIT>
		       <URCHIN-FIRST-LOOK>)>
		<RFATAL>)>>

<ROUTINE URCHIN-FIRST-LOOK ()
	 <TELL " He's " ,URCHIN-LDESC ". He's jumpy,
and looks suspiciously at you.">>

<GLOBAL URCHIN-LDESC 
	 "a youngish teenager wearing a ski hat, running shoes,
and a bulky, suspiciously bumpy, threadbare parka">

<ROUTINE URCHIN-F ("AUX" MANY?)
	 <COND (<WINNER? URCHIN>
		<COND (<VERB? LEAVE>
		       <TELL
"\"Hey! You go away, sucker.\"">)
		      (<VERB? TELL-ME-ABOUT YES NO>
		       <COND (<PRSO? ,URCHIN>
			      <TELL
"\"I just came in to get out of the snow. I wouldn't come in here if
it wasn't snowing.\"">)
			     (<PRSO? ,STUDENTS>
			      <TELL
"\"Hey, you guys got students gone missing? We got kids gone missing!\"
He looks at you suspiciously. \"You ain't the one done it, are ya?\"">)
			     (<PRSO? ,GLOBAL-URCHINS>
			      <TELL
"\"The word is out on the street, man. Don't go to Tech, or you're gonna
be gone, ya know? I wouldn't be here myself if I had a warm place to go.\"">)
			     (ELSE
			      <TELL
"He doesn't reply.">)>)
		      (<AND <VERB? WHERE>
			    <FSET? ,PRSO ,TAKEBIT>>
		       <TELL
"\"I didn't take it!\"">)
		      (<OR <VERB? TAKE OPEN UNLOCK WALK FOLLOW>
			   <HOSTILE-VERB?>>
		       <TELL
"\"I don't take no orders from bozos!\"">)
		      (ELSE
		       <TELL
"\"I don't hafta say anything. I ain't done nothing.\"">)>
		<TELL " He seems very nervous about talking to you." CR>)
	       (<VERB? EXAMINE>
		<TELL
"This is an urchin.">
		<URCHIN-FIRST-LOOK>
		<CRLF>)
	       (<VERB? SMELL>
		<TELL
"He smells damp. There is also a slight odor of fast food." CR>)
	       (<OR <P? (SHOW GIVE) HAND>
		    <P? (SCARE RUB) * HAND>>
		<COND (<FSET? ,HAND ,PERSON>
		       <REMOVE ,URCHIN>
		       <DEQUEUE I-URCHIN>
		       <FCLEAR ,BOLT-CUTTER ,INVISIBLE>
		       <MOVE ,BOLT-CUTTER ,HERE>
		       <TELL
"The urchin sees the hand twitching. \"I heard what happens around here!
I'm not gettin' fed to a monster!\" He lets loose a scream of fear
and zooms away. Some">
		       <COND (<SET MANY? <ROB ,URCHIN ,HERE>>
			      <TELL " things drop">)
			     (ELSE <TELL "thing drops">)>
		       <TELL " from beneath his parka as he departs.
He slows for a moment, decides not to retrieve ">
		       <COND (.MANY? <TELL "them">)
			     (ELSE <TELL "it">)>
		       <TELL ", and disappears
into the distance." CR>)
		      (ELSE
		       <TELL
"He stares at the hand, scared but holding his ground. \"What's that?\"
he says, voice quavering." CR>)>)
	       (<P? GIVE * URCHIN>
		<TELL
"\"My momma said never take nothin' from no stranger.\"">
		<COND (<AND <FSET? ,PRSO ,FOODBIT>
			    <NOT <PRSO? ,COKE>>>
		       <REMOVE ,PRSO>
		       <TELL " He takes " THE ,PRSO " anyway, disposing
of it in record time. \"On the other hand, I'm hungry,\" he remarks.">)>
		<CRLF>)
	       (<P? TELL-ABOUT * HAND>
		<TELL
"\"You expect me to believe garbage like that?\" the urchin sneers." CR>)
	       (<P? SHOW * URCHIN>
		<COND (<PRSO? ,MASTER-KEY>
		       <TELL
"\"I got one already.\"" CR>)
		      (<PRSO? ,DEAD-RAT>
		       <TELL
"\"I seen a lot of those.\"" CR>)
		      (ELSE
		       <TELL
"He makes an unconvincing show of disinterest." CR>)>)
	       (<HOSTILE-VERB?>
		<COND (<VERB? THROW> <MOVE ,PRSO ,HERE>)>
		<COND (<NOT <FSET? ,URCHIN ,RMUNGBIT>>
		       <FSET ,URCHIN ,RMUNGBIT>
		       <TELL
"The urchin backs off, and then draws a very large switchblade out of his
coat pocket. \"You watch out,\" he says, \"I know how to use this. Get
outa here!\"" CR>)
		      (<PRSI? <> ,HANDS>
		       <TELL
"The urchin laughs in your face, fending you off with his switchblade." CR>)
		      (<FSET? ,PRSI ,WEAPONBIT>
		       <JIGS-UP
"\"I told you to back off, you clown! You guys been takin' my friends!
Well, I'm gonna take one of you!\" He knifes you with surprising
dexterity. You exsanguinate.">)>)
	       (<VERB? SCARE>
		<TELL
"How do you propose to do that?" CR>)
	       (<VERB? WHAT>
		<NEW-PRSO ,URCHINS>
		<RTRUE>)
	       (<AND <VERB? FOLLOW>
		     <NOT <IN? ,URCHIN ,HERE>>>
		<TELL
"He got away clean. " ,YOU-CANT "follow him." CR>)>>

<GLOBAL URCHIN-TABLE <TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0>>

;<SYNTAX $URCHIN = V-$URCHIN>

;<GLOBAL URCHIN-DEBUG <>>

;<ROUTINE V-$URCHIN ()
	 <SETG URCHIN-DEBUG <NOT ,URCHIN-DEBUG>>>

<ROUTINE I-URCHIN ("AUX" (TMP 0) S RM ORM OWINNER UL)
	 <QUEUE I-URCHIN 10>
	 <PUT ,URCHIN-TABLE 0 0>
	 <SET OWINNER ,WINNER>
	 <SETG WINNER ,URCHIN>
	 <SET UL <LOC ,URCHIN>>
	 <COND (<AND <IN? ,URCHIN ,HERE>
		     <PROB 80>
		     <NOT <EQUAL? <META-LOC ,MAINTENANCE-MAN> ,HERE>>>
		<COND (,LIT
		       <TELL CR
"The urchin looks around nervously, obviously thinking of flight, but
decides against it." CR>)>)
	       (ELSE
		<MAP-DIRECTIONS (D P .UL)
			 <SET S <PTSIZE .P>>
			 ;<COND (,URCHIN-DEBUG
				<TELL "** ">
				<COND (<EQUAL? .D ,P?NORTH> <TELL "North">)
				      (<EQUAL? .D ,P?NE> <TELL "NE">)
				      (<EQUAL? .D ,P?EAST> <TELL "East">)
				      (<EQUAL? .D ,P?SE> <TELL "SE">)
				      (<EQUAL? .D ,P?SOUTH> <TELL "South">)
				      (<EQUAL? .D ,P?SW> <TELL "SW">)
				      (<EQUAL? .D ,P?WEST> <TELL "West">)
				      (<EQUAL? .D ,P?NW> <TELL "NW">)
				      (<EQUAL? .D ,P?UP> <TELL "Up">)
				      (<EQUAL? .D ,P?DOWN> <TELL "Down">)
				      (<EQUAL? .D ,P?IN> <TELL "In">)
				      (<EQUAL? .D ,P?OUT> <TELL "Out">)
				      (ELSE <TELL N .D>)>
				<TELL " ("
				      <COND (<EQUAL? .S ,UEXIT> "U")
					    (<EQUAL? .S ,NEXIT> "N")
					    (<EQUAL? .S ,CEXIT> "C")
					    (<EQUAL? .S ,DEXIT> "D")
					    (<EQUAL? .S ,FEXIT> "F")
					    (ELSE "?")>
				      "): ">)>
			 <SET RM <>>
			 <COND (<OR <EQUAL? .S ,UEXIT>
				    <AND <EQUAL? .S ,CEXIT>
					 <VALUE <GETB .P ,CEXITFLAG>>>
				    <AND <EQUAL? .S ,DEXIT>
					 <FSET? <GETB .P ,DEXITOBJ>
						,OPENBIT>>
				    <AND <EQUAL? .S ,FEXIT>
					 <SET RM <APPLY <GET .P ,FEXITFCN>>>>>
				<COND (<NOT .RM> <SET RM <GETB .P ,REXIT>>)>
				;<COND (,URCHIN-DEBUG
				       <TELL D .RM>
				       <COND (<FSET? .RM ,OUTSIDE>
					      <TELL " (outside)">)>
				       <CRLF>)>
				<COND (<AND <NOT <FSET? .RM ,OUTSIDE>>
					    <NOT <EQUAL? .RM ,TOMB>>
					    <NOT <EQUAL?
						   <META-LOC ,MAINTENANCE-MAN>
						   .RM>>>
				       <SET TMP <GET ,URCHIN-TABLE 0>>
				       <SET TMP <+ .TMP 1>>
				       <PUT ,URCHIN-TABLE 0 .TMP>
				       <PUT ,URCHIN-TABLE .TMP .RM>)>)
			       ;(ELSE
				<COND (,URCHIN-DEBUG
				       <TELL "no" CR>)>)>>
		<SETG WINNER .OWINNER>
		<SET ORM <LOC ,URCHIN>>
		<SET RM <RANDOM-ELEMENT ,URCHIN-TABLE>>
		;<COND (,URCHIN-DEBUG
			<TELL "** => " D .RM CR>)>
		<COND (<AND <HERE? .RM>
			    ,LIT>
		       <CRLF>
		       <COND (<NOT <FSET? ,URCHIN ,TOUCHBIT>>
			      <FSET ,URCHIN ,TOUCHBIT>
			      <TELL
"An urchin (" ,URCHIN-LDESC ")">)
			     (ELSE
			      <TELL "The urchin">)>
		       <TELL
" saunters nonchalantly into the room, notices you, and beats
a hasty retreat." CR>)
		      (ELSE
		       <COND (<NOT <HERE? .ORM>> <ROB .ORM ,URCHIN>)>
		       <MOVE ,URCHIN .RM>
		       <ROB .RM ,URCHIN>
		       <COND (<HERE? .ORM>
			      <TELL CR
"The urchin has disappeared." CR>)>)>)>>

<OBJECT BOLT-CUTTER
	(IN URCHIN)
	(DESC "bolt cutter")
	(SYNONYM CUTTER)
	(ADJECTIVE BOLT CHAIN)
	(FLAGS INVISIBLE TAKEBIT TOOLBIT WEAPONBIT)
	(SIZE 10)
	(VALUE 5)
	(ACTION BOLT-CUTTER-F)>

<ROUTINE BOLT-CUTTER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a heavy duty bolt or chain cutter, standard equipment for local
bicycle thieves. It will defeat any but the heaviest bicycle chains." CR>)
	       (<P? CUT (CHAIN CHAIN-1 CHAIN-2)>
		<TELL "It's too thick." CR>)>>

<OBJECT URCHIN-WIRE
	(IN LARGE-CHAMBER)
	(DESC "wire")
	(SYNONYM WIRE ROPE GROWTH WIRES)
	(ADJECTIVE THIN ROPY STREAMER ROPELIKE ROPES)
	(FLAGS NDESCBIT)
	(VALUE 5)
	(ACTION URCHIN-WIRE-F)>

<ROUTINE URCHIN-WIRE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"These are thin, fibrous, ropy growths. They look very tough." CR>)
	       (<VERB? FOLLOW>
		<TELL
"They go from the ">
		<COND (<IN? ,URCHINS ,SLOTS> <TELL "slots">)
		      (ELSE <TELL "urchins">)>
		<TELL " down the tunnel." CR>)
	       (<P? (CUT MUNG) URCHIN-WIRE>
		<COND (<PRSI? ,BOLT-CUTTER>
		       <FSET ,URCHINS ,RMUNGBIT> ;<SETG URCHIN-FLAG T>
		       <SCORE-OBJECT ,URCHIN-WIRE>
		       <REMOVE ,URCHIN-WIRE>
		       <TELL
"You strain and push the two handles of the bolt cutter together with
all your strength. At first it looks like nothing will happen, but then,
with a loud click, the jaws cut the wire!|
|
The wire, as though under tension, rapidly begins to curl up,
disappearing down the tunnel and away. ">
		       <COND (<IN? ,URCHINS ,SLOTS>
			      <FCLEAR ,URCHINS ,INVISIBLE>
			      <MOVE ,URCHINS ,HERE>
			      <TELL
"Urchins burst forth from the slots. ">)>
		       %<IFSOUND <SOUNDS ,S-VOICE ,S-STOP>>
		       <TELL "The effect on the urchins is
electric (perhaps literally). They twitch, jerk spasmodically, and fall
to the ground almost in unison. They have lost all interest in you." CR>)
		      (<AND ,PRSI
			    <OR <FSET? ,PRSI ,WEAPONBIT>
				<FSET? ,PRSI ,TOOLBIT>>>
		       <TELL
CTHE ,PRSI " drives the wire into the mud, but doesn't cut it." CR>)
		      (ELSE
		       <V-CUT>)>)>>

<OBJECT SLOTS
	(IN LARGE-CHAMBER)
	(DESC "slot")
	(SYNONYM SLOT SLOTS IDENTATIONS BURROW)
	(ADJECTIVE SMALL NARROW)
	(FLAGS NDESCBIT OPENBIT CONTBIT VEHBIT)
	(ACTION SLOTS-F)>

<ROUTINE SLOTS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The slots are narrow burrows apparently dug by hand out of the mud of
the chamber walls.">
		<COND (<IN? ,URCHINS ,SLOTS>
		       <TELL
" Most of the slots have a thin wire or rope heading
into them. You begin to be quite certain that there is something moving
inside the slot you are looking at.">)>
		<CRLF>)
	       (<P? (THROUGH BOARD) SLOTS>
		<TELL
"You squeeze your way into one of the slots. The mud coats you with
a cold, slimy coat which makes it barely possible to breathe.">
		<COND (<IN? ,URCHINS ,SLOTS>
		       <TELL " You are
about halfway in when your hands touch something fleshy in front of
you. It's cold and dead. On the other hand, it moves.">)>
		<TELL
" You slide out with all the speed you can muster." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL
,YOU-CANT-SEE "anything but the wet walls of the burrow." CR>)
	       (<VERB? REACH-IN>
		<COND (<NOT <IN? ,URCHINS ,SLOTS>>
		       <TELL
,THERE-IS-NOTHING "in the slots but cold, wet mud." CR>)
		      (ELSE
		       <TELL
"You reach inside, oblivious to the cold clammy mud. At first you feel
nothing, but just at the limit of your stretch, you feel flesh. It's
cold and dead. You jerk your hand back out." CR>)>)
	       (<VERB? LISTEN>
		<COND (<IN? ,URCHINS ,SLOTS>
		       <TELL
"The noise, as you listen more carefully, resolves itself into voices.
They are chanting, but the words are unknown to you." CR>)>)>>

<GLOBAL URCHIN-CNT 0>

<ROUTINE I-URCHINS ()
	 <COND (<AND <HERE? ,LARGE-CHAMBER>
		     <NOT <FSET? ,URCHINS ,RMUNGBIT>> ;<NOT ,URCHIN-FLAG>>
		<SETG URCHIN-CNT <+ ,URCHIN-CNT 1>>
		<COND (<EQUAL? ,URCHIN-CNT 1>
		       <TELL CR
"A small, furtive motion attracts your attention to the slots." CR>)
		      (<EQUAL? ,URCHIN-CNT 2>
		       <TELL CR
"There is motion in the slots. In fact, there is motion in almost all
of them." CR>)
		      (<IN? ,URCHINS ,SLOTS>
		       <FCLEAR ,URCHINS ,INVISIBLE>
		       <MOVE ,URCHINS ,LARGE-CHAMBER>
		       <TELL CR
"Slowly, painfully, things emerge from the slots. They are pale, thin
creatures with red mouths and staring eyes. Mold grows in their hair and
wirelike streamers wrap their heads and join a bundle on the floor.
You realize that these are urchins." CR>)
		      (ELSE <DEQUEUE I-URCHINS>)>)>>

<ROOM LAIR-1
      (IN ROOMS)
      (DESC "Wet Tunnel")
      (POINT "north")
      (UP TO LARGE-CHAMBER)
      (SOUTH TO LAIR-6)
      (NORTH TO LAIR-2)
      (EAST TO LAIR-1)
      (ACTION LAIR-F)>

<ROOM LAIR-2
      (IN ROOMS)
      (DESC "Wet Tunnel")
      (POINT "down")
      (EAST TO LAIR-1)
      (WEST TO LAIR-7)
      (UP TO LAIR-8)
      (DOWN TO LAIR-3)
      (ACTION LAIR-F)>

<ROOM LAIR-3
      (IN ROOMS)
      (DESC "Wet Tunnel")
      (POINT "south")
      (WEST TO LAIR-7)
      (SOUTH TO LAIR-4)
      (NORTH TO LAIR-6)
      (EAST TO LAIR-2)
      (ACTION LAIR-F)>

<ROOM LAIR-4
      (IN ROOMS)
      (DESC "Wet Tunnel")
      (POINT "south")
      (UP TO LAIR-3)
      (EAST TO LAIR-10)
      (DOWN TO LAIR-10)
      (SOUTH TO LAIR-5)
      (WEST TO LAIR-11)
      (ACTION LAIR-F)>

<ROOM LAIR-5
      (IN ROOMS)
      (DESC "Wet Tunnel")
      (POINT "down")
      (DOWN TO OUTER-LAIR)
      (UP TO LAIR-5)
      (NORTH TO LAIR-4)
      (WEST TO LAIR-3)
      (EAST TO LAIR-11)
      (ACTION LAIR-F)>

<ROOM LAIR-6
      (IN ROOMS)
      (DESC "Wet Tunnel")
      (POINT "west")
      (EAST TO LAIR-1)
      (WEST TO LAIR-3)
      (DOWN TO LAIR-8)
      (NORTH TO LAIR-6)
      (ACTION LAIR-F)>

<ROOM LAIR-7
      (IN ROOMS)
      (DESC "Wet Tunnel")
      (POINT "east")
      (WEST TO LAIR-1)
      (DOWN TO LAIR-7)
      (UP TO LAIR-10)
      (EAST TO LAIR-3)
      (SOUTH TO LAIR-2)
      (ACTION LAIR-F)>

<ROOM LAIR-8
      (IN ROOMS)
      (DESC "Wet Tunnel")
      (POINT "east")
      (EAST TO LAIR-2)
      (UP TO LAIR-6)
      (DOWN TO LAIR-9)
      (ACTION LAIR-F)>

<ROOM LAIR-9
      (IN ROOMS)
      (DESC "Wet Tunnel")
      (POINT "up")
      (UP TO LAIR-2)
      (EAST TO LAIR-8)
      (NORTH TO LAIR-6)
      (DOWN TO LAIR-10)
      (ACTION LAIR-F)>

<ROOM LAIR-10
      (IN ROOMS)
      (DESC "Wet Tunnel")
      (POINT "west")
      (NORTH TO LAIR-10)
      (WEST TO LAIR-7)
      (UP TO LAIR-9)
      (ACTION LAIR-F)>

<ROOM LAIR-11
      (IN ROOMS)
      (DESC "Wet Tunnel")
      (POINT "east")
      (EAST TO LAIR-9)
      (UP TO LAIR-11)
      (SOUTH TO LAIR-11)
      (ACTION LAIR-F)>

<ROOM OUTER-LAIR
      (IN ROOMS)
      (DESC "Wet Tunnel")
      (POINT "south")
      (UP TO LAIR-5)
      (IN TO INNER-LAIR IF CURTAIN-DOOR IS OPEN)
      (SOUTH TO INNER-LAIR IF CURTAIN-DOOR IS OPEN)
      (FLAGS ONBIT)
      (GLOBAL CURTAIN-DOOR POOL)
      (ACTION LAIR-F)>

<ROUTINE LAIR-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"You are lost in narrow, wet tunnels burrowed through the mud. Muddy, oily
water covers the floor.">
		<COND (<HERE? ,OUTER-LAIR>
		       <COND (<IN? ,CURTAIN ,HERE>
			      <TELL
" A curtain of moldy slime covers the south wall." CR>)
			     (ELSE
			      <TELL
" There is an ancient door in the south wall. ">
			      <TELL-OPEN-CLOSED ,CURTAIN-DOOR>)>)
		      (ELSE <CRLF>)>)
	       (<RARG? LEAVE>
		<SETG LAIR-FLAG <>>
		<FCLEAR ,HERE ,TOUCHBIT>)
	       (<RARG? BEG>
		<COND (<AND <HERE? ,OUTER-LAIR>
			    <IN? ,CURTAIN ,HERE>
			    <VERB? WALK>
			    <EQUAL? ,P-WALK-DIR ,P?SOUTH>>
		       <PERFORM ,V?THROUGH ,CURTAIN>
		       <RTRUE>)>)
	       (<RARG? END>
		<COND (<AND <IN? ,HAND ,PLAYER>
			    <FSET? ,HAND ,PERSON>
			    <IN? ,RING ,HAND>
			    <NOT <HERE? ,LAIR-FLAG>>>
		       <SETG LAIR-FLAG ,HERE>
		       <HAND-POINTS>)>)>>

<ROUTINE HAND-POINTS ()
	 <TELL CR
"The hand ">
	 <COND (<IN? ,RING ,HAND>
		<TELL
"points its mutilated ring finger " <GETP ,HERE ,P?POINT> " and ">)>
	 <TELL "grips your shoulder tightly." CR>>

<GLOBAL LAIR-FLAG <>>

<OBJECT CURTAIN
	(IN OUTER-LAIR)
	(DESC "slime curtain")
	(SYNONYM SLIME CURTAIN)
	(ADJECTIVE SLIME GREEN WET MOLDY PHOSPHORESCENT)
	(FLAGS NDESCBIT)
	(VALUE 5)
	(ACTION CURTAIN-F)>

<ROUTINE CURTAIN-F ("AUX" W)
	 <COND (<VERB? EXAMINE>
		<TELL
"The entire south wall is covered with a curtain of moldy phosphorescent
slime. There is something about the slime that makes it appear unhealthy,
as though the influences here are bad for anything living." CR>)
	       (<P? (POUR THROW) ,NITROGEN ,CURTAIN>
		<REMOVE ,NITROGEN>
		<DEQUEUE I-NITROGEN-GOES>
		<QUEUE I-MIST-GOES 2>
		<TELL
"The liquid splashes onto the curtain, and a cold mist
fills the room. The slime begins to freeze. ">
		<COND (<L? ,NITROGEN-CNT 3>
		       <TELL
"Patches of it shatter and fall, but the rest of the slime oozes into
the ruined spots, and the curtain appears unharmed." CR>)
		      (ELSE
		       <SETG SCORE <+ ,SCORE 5>>
		       <REMOVE ,CURTAIN>
		       <FCLEAR ,CURTAIN-DOOR ,INVISIBLE>
		       <TELL
"Nearly the entire curtain solidifies, shatters, and drops to the
ground, revealing an ancient wooden door." CR>)>)
	       (<OR <HOSTILE-VERB?>
		    <P? (TAKE PRY THROUGH LOOK-BEHIND RAISE) CURTAIN>>
		<COND (<PRSO? ,CURTAIN> <SET W ,PRSI>)
		      (ELSE <SET W ,PRSO>)>
		<COND (<EQUAL? .W <> ,HANDS>
		       <DEQUEUE I-SLIME-OBJECT>
		       <QUEUE I-SLIME -1>
		       <COND (<AND <IN? ,GLOVES ,WINNER>
				   <FSET? ,GLOVES ,WEARBIT>>
			      <TELL
"The curtain is very slick and wet. Some of it sticks to your gloves." CR>)
			     (<IN? ,SLIME ,WINNER>
			      <MORE-SLIME ,HANDS>)
			     (ELSE
			      <TELL
"The feel is greasy, wet, and at first cold. Then you get a burning
sensation, like that from a sea-nettle sting. You jerk
away, but some of the slime sticks to you!" CR>)>
		       <MOVE ,SLIME ,WINNER>)
		      (ELSE
		       <COND (<VERB? THROW> <MOVE .W ,HERE>)>
		       <COND (<FSET? .W ,SLIMEBIT>
			      <MORE-SLIME .W>)
			     (ELSE
			      <FSET .W ,SLIMEBIT>
			      <QUEUE I-SLIME-OBJECT 2>
			      <TELL
CTHE .W " touches the curtain, and immediately some of the
slime attacks, flowing almost intelligently onto it. " CTHE .W
" is now covered with slime." CR>)>)>)>>

<ROUTINE MORE-SLIME (OBJ)
	 <TELL
"More slime flows onto " THE .OBJ "." CR>>

<OBJECT SLIME
	(DESC "crawling slime")
	(SYNONYM SLIME)
	(ADJECTIVE CRAWLING)
	(DESCFCN SLIME-DESC)
	(ACTION SLIME-F)>

<ROUTINE SLIME-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?> <RTRUE>)
	       (ELSE
		<TELL
"There is slime crawling up your arm. It has reached your "
<GET ,SLIMES ,SLIME-CNT> ".">)>>

<ROUTINE SLIME-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's flowing, dark-green, and undulates slowly as it crawls up your
arm." CR>)
	       (<VERB? RUB>
		<TELL
"You already did that once. Twice would be stupid!" CR>)
	       (<VERB? MUNG KILL>
		<TELL
S "There is no effect"". You only succeed in hurting your arm." CR>)
	       (<P? POUR NITROGEN>
		<JIGS-UP
"You succeed in pouring the freezing liquid all over your arm. This
kills the slime. It also kills you, but then, one
must make sacrifices, right?">)
	       (<VERB? DROP TAKE-OFF>
		<TELL
"You try to scrape it off, but to no avail. It just flows back into
place around your arm." CR>)>>

<ROUTINE I-SLIME-OBJECT ("OPT" (WHAT <>))
	 <COND (<NOT .WHAT> <SET WHAT ,WINNER>)>
	 <MAP-CONTENTS (W .WHAT)
		       <COND (<AND <FSET? .W ,SLIMEBIT>
				   <NOT <FSET? .W ,RMUNGBIT>>>
			      <FSET .W ,RMUNGBIT>
			      <COND (<EQUAL? .WHAT ,WINNER>
				     <MOVE ,SLIME .WHAT>
				     <DEQUEUE I-SLIME-OBJECT>
				     <QUEUE I-SLIME -1>
				     <TELL CR
"The slime has now flowed from " THE .W>
				     <COND (<FSET? ,GLOVES ,WEARBIT>
					    <REMOVE ,GLOVES>
					    <TELL
", devoured your gloves">)>
				     <TELL ", and begun attacking
your hand." CR>
				     <RTRUE>)
				    (ELSE
				     <FSET .WHAT ,SLIMEBIT>
				     <QUEUE I-SLIME-OBJECT 1>)>)
			     (<AND <FSET? .W ,CONTBIT>
				   <FSET? .W ,OPENBIT>>
			      <I-SLIME-OBJECT .W>)>>>

<ROUTINE I-SLIME ()
	 <COND (<IN? ,SLIME ,WINNER>
		<COND (<AND <ZERO? ,SLIME-CNT>
			    <IN? ,GLOVES ,WINNER>
			    <FSET? ,GLOVES ,WEARBIT>>
		       <REMOVE ,GLOVES>
		       <TELL CR
"The slime eats through your gloves! It begins to attack your hand,
and you feel a hot, stinging sensation, like a sea-nettle sting." CR>)
		      (<G? <SETG SLIME-CNT <+ ,SLIME-CNT 1>> 5>
		       <DEQUEUE I-SLIME>
		       <CRLF>
		       <JIGS-UP
"The slime engulfs your nose! You cough, choke, and begin to suffocate!
You fall to the floor, splashing in the water. You either
suffocate or drown. After you're dead, it makes no difference.">)
		      (ELSE
		       <TELL CR
"The slime is creeping slowly up your arm! It's reached your "
<GET ,SLIMES ,SLIME-CNT> ,PERIOD>)>)
	       (ELSE <DEQUEUE I-SLIME>)>>

<GLOBAL SLIME-CNT 0>

<GLOBAL SLIMES
	<LTABLE (PURE)
		"wrist"
		"elbow"
		"bicep"
		"shoulder"
		"neck">>

<OBJECT CURTAIN-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "ancient door")
	(SYNONYM DOOR LOCK)
	(ADJECTIVE ANCIENT WOODEN)
	(FLAGS AN INVISIBLE NDESCBIT DOORBIT LOCKED OPENABLE)
	(ACTION CURTAIN-DOOR-F)>

<ROUTINE CURTAIN-DOOR-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This door, blackened by age, is
built of ancient, rotting timbers, but still looks very strong. It is
set in a rough-hewn arch. Oddly, in addition to an old, rusted-away
lock, there is another which looks new and shiny. ">
		<TELL-OPEN-CLOSED ,CURTAIN-DOOR>)
	       (<AND <HERE? ,INNER-LAIR>
		     <P? (LOCK UNLOCK) CURTAIN-DOOR MASTER-KEY>>
		<TELL
"The lock doesn't appear to work from this side!" CR>)
	       (<P? UNLOCK CURTAIN-DOOR MASTER-KEY>
		<FCLEAR ,CURTAIN-DOOR ,LOCKED>
		<TELL ,DOOR-NOW-UNLOCKED>)
	       (<P? (ATTACK MUNG) CURTAIN-DOOR>
		<COND (<PRSI? <> ,HANDS>
		       <TELL
"You only bruise your hands." CR>)
		      (ELSE
		       <TELL
"The door is surprisingly solid." CR>)>)>>

<GLOBAL DOOR-NOW-UNLOCKED "The door is now unlocked.|">

<ROOM INNER-LAIR
      (IN ROOMS)
      (DESC "Inner Lair")
      (UP TO OUTER-LAIR IF CURTAIN-DOOR IS OPEN)
      (GLOBAL CURTAIN-DOOR POOL)
      (POINT "down")
      (FLAGS ONBIT)
      (ACTION INNER-LAIR-F)>

<ROUTINE INNER-LAIR-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
S "The floor here is ""a stagnant, slime infested pool of water.
It feels to ">
		<COND (<NOT <FSET? ,BOOTS ,WEARBIT>>
		       <TELL "your sodden feet to ">)>
		<TELL "be about six inches deep.">
		<COND (<IN? ,MASS ,HERE>
		       <TELL " Ropes
or wires tumble down the slope, where they enter a
large whitish mass which takes up much of the chamber. The noise is loud
here, and comes from the mass, which undulates in synchrony
with the noise.">)>
		<TELL " Wan, sourceless light illuminates the chamber." CR>)
	       (<RARG? BEG>
		<COND (<P? LISTEN (<> NOISE)>
		       <NEW-PRSO ,MASS>
		       <RTRUE>)>)
	       (<RARG? ENTER>
		%<IFSOUND <SOUNDS ,S-ZOMBIE>>
		<FSET ,CURTAIN-DOOR ,LOCKED>
		<FCLEAR ,CURTAIN-DOOR ,OPENBIT>
		<QUEUE I-HAND-DIVES -1>
		<MOVE ,HACKER ,LAIR-5>
		<QUEUE I-HACKER-RETURNS 2>
		<AS-YOU-ENTER-LEAVE "enter">)>>

<ROUTINE I-HAND-DIVES ()
	 <COND (<FSET? ,HAND ,PERSON>
		<COND (<HELD? ,HAND>
		       <MOVE ,HAND ,INNER-LAIR>
		       <TELL CR
"Suddenly, the hand leaps from your shoulder into the slime-encrusted
puddle. It dives beneath the water." CR>)
		      (<IN? ,HAND ,INNER-LAIR>
		       <TELL CR
"The hand repeatedly dives and bobs to the surface in one part
of" ,THE-POOL>)>)>>

<GLOBAL THE-POOL " the pool near your feet.|">

<GLOBAL LAIR-CNT 0>

<GLOBAL HACKER-STARES "The hacker stares at ">

<ROUTINE I-HACKER-RETURNS ("AUX" HERE?)
	 <SET HERE? <IN? ,HACKER ,HERE>>
	 <COND (<IN? ,HACKER ,INNER-LAIR>
		<SETG LAIR-CNT <+ ,LAIR-CNT 1>>
		<COND (<EQUAL? ,LAIR-CNT 1>
		       <TELL CR
,HACKER-STARES "the thing in the cave. \"I got very suspicious
about your problems with the net. I began to trace some coax, found
some repeaters and bridges that weren't on the layout charts, and
started following them. Anyway, here I am. That thing there, whatever
it is, and those
wires, are interfaced to the whole campus net. And that means it's tied
into all the nets, commercial, government, even military,
potentially.\"" CR>)
		      (<EQUAL? ,LAIR-CNT 2>
		       <TELL CR
"\"I guess I better do something. It could be a serious compromise of
system integrity if this thing isn't dealt with.\" He peers at the
mass, as if evaluating it. He then reaches into a pocket and pulls out
a small pair of wire strippers." CR>)
		      (<EQUAL? ,LAIR-CNT 3>
		       <FSET ,HACKER ,INVISIBLE>
		       <FSET ,HACKER ,RMUNGBIT>
		       <TELL CR
"The hacker advances on the mass, apparently planning to cut some of
the wires leading into it. As he approaches it, the sound stops completely,
and the wires begin a frantic, looping, twining dance. The mass begins to
flow towards the hacker almost as quickly as he walks toward it. They
reach each other and begin to merge together. He screams; a long, ululating
cry that echoes through the cavern. Then he is engulfed." CR>)
		      (<EQUAL? ,LAIR-CNT 4 5 6>
		       <TELL CR
"The mass is bulging, vibrating, and rippling.">
		       <COND (<EQUAL? ,LAIR-CNT 6>
			      <TELL " A huge tear is forming near
where the hacker was absorbed.">)>
		       <CRLF>)
		      (<EQUAL? ,LAIR-CNT 7>
		       <FCLEAR ,HACKER ,INVISIBLE>
		       <TELL CR
"The hacker pulls himself out of the side of the mass. As he does, you
think you can see many pairs of eyes appear briefly in the semitransparent
mass, watching curiously. Wires and
tentacles trail from his body, and tiny, almost rat-like creatures cling
to his body everywhere, crawling about like ants. He walks slowly,
jerkily towards you. \"Be one!\" he says, haltingly but fervently."
CR>)
		      (<EQUAL? ,LAIR-CNT 8>
		       <TELL CR
"The hacker grabs for you. \"Join us! Serve the master!\" he croaks. Some
of the creatures leap onto you, biting at exposed skin." CR>)
		      (<EQUAL? ,LAIR-CNT 9>
		       <CRLF>
		       <JIGS-UP
"The hacker is surprisingly strong. He
drags you toward the thing in the corner, exhorting you
to join it, and at last, forcibly, you do. You are not the first, or
the last." T>)>
		<RFATAL>)
	       (<IN? ,HACKER ,OUTER-LAIR>
		<MOVE ,HACKER ,INNER-LAIR>
		<TELL CR
"You hear a stumbling noise behind you, turn and see the hacker staggering
into the cavern." CR CR
,HACKER-STARES "you, shocked. \"It's you! When I gave you my key,
I never suspected you'd get this far!\"" CR>)
	       (<IN? ,HACKER ,LAIR-5>
		<QUEUE I-HACKER-RETURNS -1>
		<MOVE ,HACKER ,OUTER-LAIR>
		<TELL CR
"You hear noises outside the door." CR>)>>

<OBJECT MASS
	(IN INNER-LAIR)
	(DESC "whitish mass")
	(SYNONYM MASS)
	(ADJECTIVE LARGE WHITE WHITISH)
	(FLAGS NDESCBIT PERSON)
	(ACTION MASS-F)>

<ROUTINE MASS-F ()
	 <COND (<WINNER? ,MASS>
		<TELL
"When you speak, the noise stops, if only briefly. When it resumes, it's
more insistent." CR>
		<END-QUOTE>)
	       (ELSE
		<COND (<VERB? EXAMINE>
		       <TELL
"The mass is strangely, even wrongly, shaped. It is hard to get a fix on
what's wrong with it, but it doesn't look like it could or should exist
in any sane universe. It quivers and bubbles as though air were pumping
through it. Many wires, tentacles, and combinations of the two enter the
mass from all sides, making it almost fuzzy in appearance." CR>)
		      (<VERB? LISTEN>
		       <TELL
"You listen closely to the sounds, which are loud and at first seem random.
The more you listen, the more you sense a strange regularity to them. You
get impressions, one after another, of electronic music, a simple sine
wave pattern, and telephone crosstalk. They are all overlaid with speech,
or something like speech, nearer random babbling, or many people talking
at once. You can't understand any of it, but it's so near intelligibility
that you feel that if you moved closer, you just might get it." CR>)
		      (<VERB? GIVE SHOW>
		       <TELL
"There is no reaction that you can detect." CR>)
		      (<VERB? RUB>
		       <PERFORM ,V?ATTACK
				,PRSO
				<COND (,PRSI ,PRSI)
				      (ELSE ,HANDS)>>
		       <RTRUE>)
		      (<P? PUT-ON HIGH-VOLTAGE MASS>
		       <SWAP-VERB ,V?RUB>
		       <RTRUE>)
		      (<VERB? ATTACK THROUGH>
		       <COND (<PRSI? <> ,HANDS>
			      <TELL S "You approach the "
				    "mass and grab onto it.">
			      <JIGS-UP ,TOUCHING-MASS T>)
			     (<PRSI? ,HIGH-VOLTAGE>
			      <COND (<FSET? ,HIGH-VOLTAGE ,RMUNGBIT>
				     <TELL
"Deftly avoiding the exposed wire, the">)
				    (ELSE
				     <TELL "The">)>
			      <TELL " tentacles grab you and pull you
into the rippling slime.">
			      <JIGS-UP ,TOUCHING-MASS T>)
			     (<FSET? ,PRSI ,WEAPONBIT>
			      <REMOVE ,PRSI>
			      <TELL
CTHE ,PRSI " is engulfed by the mass and disappears. The mass itself
is unchanged." CR>)>)>)>>

<GLOBAL TOUCHING-MASS
" Immediately, your mind is
overwhelmed with visions and vistas it cannot assimilate. As the mass
pulls you into itself, it all becomes clearer, but it's much too late
by then.">

<OBJECT REPEATER
	(IN INNER-LAIR)
	(DESC "metal box")
	(SYNONYM REPEATER BOX)
	(ADJECTIVE LAN NETWORK METAL)
	(FLAGS TRANSBIT CONTBIT SEARCHBIT OPENABLE)
	(DESCFCN REPEATER-DESC)
	(ACTION REPEATER-F)>

<ROUTINE REPEATER-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?> <RTRUE>)
	       (ELSE
		<TELL
"Set on the wall, incongruous in its surroundings, is a metal box. ">
		<DESCRIBE-BOX>
		<RFATAL>)>>

<GLOBAL ENDS-IN-STUMP " ends in a blackened stump">

<ROUTINE DESCRIBE-BOX ()
	 <TELL
"On one side a coaxial cable enters the box. On the other, " A ,OUTPUT-CABLE
" leads from the box ">
	 <COND (<IN? ,MASS ,HERE> <TELL "to the mass">)
	       (ELSE <TELL "and" ,ENDS-IN-STUMP>)>
	 <TELL ". ">
	 <COND (<FSET? ,REPEATER ,OPENBIT>
		<TELL
"The cover is off the box, revealing electronic innards.">)
	       (ELSE
		<TELL
S "There is a ""metal cover on the box.">)>>

<ROUTINE REPEATER-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<DESCRIBE-BOX>
		<COND (<FSET? ,REPEATER ,OPENBIT>
		       <TELL " ">
		       <DESCRIBE-CABLES>)
		      (ELSE <CRLF>)>
		<RTRUE>)
	       (<P? OPEN REPEATER>
		<NEW-PRSO ,REPEATER-COVER>
		<RTRUE>)
	       (<P? CLOSE REPEATER>
		<PERFORM ,V?PUT ,REPEATER-COVER ,REPEATER>
		<RTRUE>)
	       (<P? PLUG * REPEATER>
		<COND (<AND <FSET? ,REPEATER-COVER ,OPENBIT>
			    <NOT <IN? ,INPUT-CABLE ,INPUT-SOCKET>>>
		       <NEW-PRSI ,INPUT-SOCKET>)
		      (ELSE
		       <TELL
"You'll have to be more specific." CR>)>)>>

<OBJECT REPEATER-COVER
	(IN REPEATER)
	(DESC "metal cover")
	(SYNONYM COVER SCREWS)
	(ADJECTIVE METAL FINGER)
	(FLAGS TAKEBIT OPENABLE)
	(ACTION REPEATER-COVER-F)>

<ROUTINE REPEATER-COVER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a metal cover with simple finger screws to hold it on." CR>)
	       (<AND <VERB? UNTIE>
		     <FSET? ,REPEATER ,OPENBIT>>
		<TELL "You already opened it." CR>)
	       (<OR <VERB? OPEN UNTIE>
		    <AND <VERB? TAKE TAKE-OFF>
			 <IN? ,REPEATER-COVER ,REPEATER>>>
		<COND (<OR <NOT <VERB? TAKE TAKE-OFF>>
			   <EQUAL? <ITAKE> T>>
		       <FSET ,REPEATER ,OPENBIT>
		       <TELL
"You remove the cover, revealing a plethora of electronic innards. ">
		       <DESCRIBE-CABLES>)
		      (ELSE
		       <RTRUE>)>)
	       (<OR <VERB? CLOSE>
		    <P? (PUT TIE) REPEATER-COVER REPEATER>>
		<COND (<FSET? ,REPEATER ,OPENBIT>
		       <FCLEAR ,REPEATER ,OPENBIT>
		       <MOVE ,REPEATER-COVER ,REPEATER>
		       <TELL S "You screw it back on.|">)
		      (ELSE
		       <TELL
"It's already screwed on tightly." CR>)>)>>

<ROUTINE DESCRIBE-CABLES ()
	 <TELL "Most prominent are a socket ">
	 <COND (<IN? ,INPUT-CABLE ,INPUT-SOCKET>
		<TELL
"into which the coaxial cable is plugged">)
	       (ELSE
		<TELL
"(now empty) next to which a coaxial cable hangs">)>
	 <TELL ", and a connector into
which the glistening " 'OUTPUT-CABLE " disappears." CR>>

<OBJECT INPUT-CABLE
	(IN INPUT-SOCKET)
	(DESC "coaxial cable")
	(SYNONYM CABLING CABLE)
	(ADJECTIVE COAXIAL COAX)
	(FLAGS NDESCBIT)
	(ACTION INPUT-CABLE-F)>

<ROUTINE INPUT-CABLE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This looks like pretty standard coax to you. It appears almost
spontaneously from high in the wall, and enters the box, where ">
		<COND (<FSET? ,REPEATER ,OPENBIT>
		       <TELL "it's ">
		       <COND (<AND <FSET? ,INPUT-CABLE ,RMUNGBIT>
				   <NOT <IN? ,INPUT-CABLE ,INPUT-SOCKET>>>
			      <TELL
"ends next to an empty socket.">)
			     (<FSET? ,INPUT-CABLE ,RMUNGBIT>
			      <TELL
"cut.">)
			     (<NOT <IN? ,INPUT-CABLE ,INPUT-SOCKET>>
			      <TELL
"hanging loose next to a socket.">)
			     (ELSE
			      <TELL
"plugged into the socket.">)>)
		      (ELSE
		       <TELL "it " S "disappears from sight.">)>
		<CRLF>)
	       (<VERB? UNPLUG UNTIE>
		<COND (<IN? ,INPUT-CABLE ,INPUT-SOCKET>
		       <MOVE ,INPUT-CABLE ,REPEATER>
		       <TELL
"You unscrew the cable. It now hangs unconnected inside the box." CR>)
		      (ELSE
		       <TELL ,IT-ALREADY-IS>)>)
	       (<VERB? TAKE>
		<COND (<IN? ,INPUT-CABLE ,INPUT-SOCKET>
		       <NEW-VERB ,V?UNTIE>
		       <RTRUE>)
		      (ELSE
		       <TELL
"It's threaded through the box: impossible to take." CR>)>)
	       (<P? (PLUG TIE PUT) INPUT-CABLE INPUT-SOCKET>
		<COND (<NOT <IN? ,INPUT-CABLE ,INPUT-SOCKET>>
		       <MOVE ,INPUT-CABLE ,INPUT-SOCKET>
		       <TELL S "You screw it back on.|">)
		      (ELSE
		       <TELL ,IT-ALREADY-IS>)>)
	       (<VERB? CUT>
		<COND (<FSET? ,INPUT-CABLE ,RMUNGBIT>
		       <ITS-ALREADY-X "cut">)
		      (<PRSI? ,BOLT-CUTTER ,AXE>
		       <FSET ,INPUT-CABLE ,RMUNGBIT>
		       <TELL
"You neatly snip the cable in two." CR>)
		      (ELSE
		       <PRSI-USELESS>)>)>>

<OBJECT INPUT-SOCKET
	(IN REPEATER)
	(DESC "socket")
	(SYNONYM SOCKET CONNECT)
	(FLAGS NDESCBIT OPENBIT CONTBIT SEARCHBIT)
	(ACTION INPUT-SOCKET-F)>

<ROUTINE INPUT-SOCKET-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<IN? ,INPUT-CABLE ,INPUT-SOCKET>
		       <TELL
"It has a coaxial cable plugged into it." CR>)
		      (ELSE
		       <TELL
"It's empty." CR>)>)>>

<OBJECT OUTPUT-CABLE
	(IN REPEATER)
	(DESC "cablelike appendage")
	(SYNONYM CABLING CABLE APPENDAGE TENTACLE)
	(ADJECTIVE OUTPUT CABLELIKE)
	(FLAGS NDESCBIT)
	(ACTION OUTPUT-CABLE-F)>

<ROUTINE OUTPUT-CABLE-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<IN? ,MASS ,HERE>
		       <TELL
"This is " A ,OUTPUT-CABLE " of the mass in the end of the cave.
It enters the box and ">
		       <COND (<FSET? ,OUTPUT-CABLE ,RMUNGBIT>
			      <TELL "is cut.">)
			     (<FSET? ,REPEATER ,OPENBIT>
			      <TELL "connects to a connector inside it.">)
			     (ELSE
			      <TELL S "disappears from sight.">)>
		       <TELL
" The cable twitches periodically." CR>)
		      (ELSE
		       <TELL
CTHE ,OUTPUT-CABLE ,ENDS-IN-STUMP "." CR>)>)
	       (<OR <VERB? UNPLUG UNTIE>
		    <P? TAKE OUTPUT-CABLE>>
		<TELL
"There is no way to do that. The appendage and its socket
blend together indistinguishably." CR>)
	       (<VERB? CUT ATTACK>
		<COND (<FSET? ,OUTPUT-CABLE ,RMUNGBIT>
		       <ITS-ALREADY-X "cut">)
		      (<NOT <FSET? ,REPEATER ,OPENBIT>>
		       <TELL
"The tentacle whips out of your way." CR>)
		      (<PRSI? ,BOLT-CUTTER ,AXE>
		       <FSET ,OUTPUT-CABLE ,RMUNGBIT>
		       <TELL
"You cut the tentacle in two inside the box, where it can't get away,
precipitating a deafening shriek from the direction of the mass." CR>)
		      (ELSE
		       <PRSI-USELESS>)>)>>

<ROUTINE PRSI-USELESS ()
	 <TELL
CTHE ,PRSI " is useless for this purpose." CR>>

<OBJECT HIGH-VOLTAGE
	(DESC "power line")
	(SYNONYM LINE)
	(ADJECTIVE POWER HIGH VOLTAGE)
	(FLAGS TAKEBIT WEAPONBIT)
	(ACTION HIGH-VOLTAGE-F)>

<ROUTINE HIGH-VOLTAGE-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<FSET? ,HIGH-VOLTAGE ,RMUNGBIT>
		       <TELL
"This is one end of a high voltage power line. The conductors are
visible within the slashed outer insulation." CR>)
		      (<FSET? ,HIGH-VOLTAGE ,POWERBIT>
		       <TELL
"This is a thick, hard cable. It reminds you of a high voltage
power line." CR>)
		      (ELSE
		       <TELL "It's still under the water." CR>)>)
	       (<OR <VERB? TAKE>
		    <AND <VERB? MOVE> <NOT <HELD? ,PRSO>>>>
		<DEQUEUE I-HAND-DIVES>
		<COND (<NOT <EQUAL? <ITAKE> T>>
		       <RTRUE>)
		      (<FSET? ,HIGH-VOLTAGE ,RMUNGBIT>
		       <DEQUEUE I-LINE-IN-WATER>
		       <COND (<FSET? ,HIGH-VOLTAGE ,POWERBIT>
			      <TELL
"You carefully grab the line just as it's about to drop into the
water." CR>)
			     (<FSET? ,GLOVES ,WEARBIT>
			      <TELL "Taken." CR>)
			     (ELSE
			      <JIGS-UP
"As you foolishly reach into the water for the line, your hands
become electrified. Nanoseconds later, the rest of you does as well.">)>)
		      (ELSE
		       <FSET ,HIGH-VOLTAGE ,POWERBIT>
		       <TELL
"You pull a length of the line out of the water. It's like holding a
large, heavy snake." CR>)>)
	       (<VERB? MOVE>
		<TELL
,YOU-CANT "pull any more of it out." CR>)
	       (<OR <VERB? DROP>
		    <P? PUT * POOL>>
		<MOVE ,HIGH-VOLTAGE ,HERE>
		<TELL S "You release the ""line.">
		<COND (<FSET? ,HIGH-VOLTAGE ,RMUNGBIT>
		       <QUEUE I-LINE-IN-WATER 2>)>
		<CRLF>)
	       (<AND <P? RUB * HIGH-VOLTAGE>
		     <FSET? ,HIGH-VOLTAGE ,RMUNGBIT>>
		<PERFORM ,V?ATTACK ,PRSO ,HIGH-VOLTAGE>
		<RTRUE>)
	       (<P? (CUT ATTACK) HIGH-VOLTAGE>
		<COND (<FSET? ,HIGH-VOLTAGE ,RMUNGBIT>
		       <ITS-ALREADY-X "cut">)
		      (<NOT <FSET? ,HIGH-VOLTAGE ,POWERBIT>>
		       <TELL
"You splash around in the water, to no avail. You can't see the line." CR>)
		      (<PRSI? ,AXE>
		       <COND (<G? <SETG HV-CNT <+ ,HV-CNT 1>> 2>
			      <FSET ,HIGH-VOLTAGE ,RMUNGBIT>
			      <MOVE ,HIGH-VOLTAGE ,HERE>
			      <QUEUE I-LINE-IN-WATER 2>
			      <TELL
"The line parts! The two ends begin to sink towards the water as they
straighten out." CR>)
			     (<EQUAL? ,HV-CNT 2>
			      <TELL
"Your blow cuts through more insulation and into the conductors." CR>)
			     (ELSE
			      <TELL
"You strike the line with the axe, making a deep gash in the
insulation." CR>)>)
		      (<PRSI? ,BOLT-CUTTER>
		       <TELL
"The jaws of the bolt cutter won't open far enough to fit around the
line." CR>)
		      (ELSE
		       <TELL
"You'd probably have as much success trying to bite it in two." CR>)>)
	       (<P? (PUT PLUG TIE) HIGH-VOLTAGE INPUT-SOCKET>
		<COND (<NOT <FSET? ,HIGH-VOLTAGE ,RMUNGBIT>>
		       <TELL
"There's no end to the line that you could plug in." CR>)
		      (<FIRST? ,INPUT-SOCKET>
		       <TELL
"There's already " A <FIRST? ,INPUT-SOCKET> " in the socket." CR>)
		      (ELSE
		       %<IFSOUND <SOUNDS ,S-SPARKY>>
		       <TELL
"You shove the exposed conductors into the socket, producing a shower of
sparks!">
		       <COND (<NOT <FSET? ,GLOVES ,WEARBIT>>
			      <MOVE ,HIGH-VOLTAGE ,HERE>
			      <QUEUE I-LINE-IN-WATER 2>
			      <TELL
" The sparks burn your hands! You jerk back, dropping the line!" CR>)
			     (<NOT <FSET? ,BOOTS ,WEARBIT>>
			      <JIGS-UP
" You are standing in electrified water. You are even
grounded. Do you know what this means? Can you say \"dead?\"">)
			     (<FSET? ,OUTPUT-CABLE ,RMUNGBIT>
			      <MOVE ,HIGH-VOLTAGE ,INPUT-SOCKET>
			      <TELL
" The stump of the tentacle still connected to the connector
shrivels and fries." CR>)
			     (<NOT <QUEUED? I-FROB-APPEARS>>
			      <MOVE ,HIGH-VOLTAGE ,INPUT-SOCKET>
			      <DEQUEUE I-HACKER-RETURNS>
			      <QUEUE I-FROB-APPEARS -1>
			      <TELL
" The tentacle connected to the other socket begins to jerk and twitch
spasmodically. The mass it's connected to quivers, and a horrible
noise, almost like a huge machine running without oil, issues from
the thing.">
			      %<IFSOUND <SOUNDS ,S-CRETIN>>
			      <COND (<NOT <FSET? ,HACKER ,INVISIBLE>>
				     <TELL
" The hacker screams soundlessly and drops into the water.">)>
			      <TELL CR CR
"The mass begins to change shape, compacting, darkening. You can
briefly see human outlines within the grey, gelatinous mass. They
surround something larger, of a shape not human, not animal, like
nothing you've seen before." CR>)
			     (ELSE <RTRUE>)>)>)
	       (<VERB? FOLLOW>
		<COND (<FSET? ,HIGH-VOLTAGE ,POWERBIT>
		       <TELL
"Both ends of the line disappear into the water and mud of the lair." CR>)>)>>

<GLOBAL HV-CNT 0>

<ROUTINE I-LINE-IN-WATER ()
	 %<IFSOUND <SOUNDS ,S-SPARKY>>
	 <CRLF>
	 <COND (<FSET? ,HIGH-VOLTAGE ,POWERBIT>
		<TELL
"The exposed ends of the high voltage line drop into the water! ">
		<FCLEAR ,HIGH-VOLTAGE ,POWERBIT>)>
	 <COND (<NOT <FSET? ,BOOTS ,WEARBIT>>
		<JIGS-UP
"Four thousand volts of electricity, only slightly attenuated by the resistance
of the water, course through your body! The result is shocking.">)
	       (ELSE
		<QUEUE I-LINE-IN-WATER -1>
		<TELL
"Sparks and bubbles burst from the electrified water." CR>)>>

<OBJECT POOL
	(IN LOCAL-GLOBALS)
	(DESC "pool")
	(SYNONYM POOL WATER PUDDLE)
	(ADJECTIVE SLIME ENCRUSTED INFESTED)
	(FLAGS NDESCBIT VEHBIT)
	(ACTION POOL-F)>

<ROUTINE POOL-F ()
	 <COND (<VERB? SWIM THROUGH BOARD STAND-ON LEAP WALK-AROUND>
		<TELL
,ALREADY-IN-IT " It covers most of the floor!" CR>)
	       (<VERB? PUT-UNDER>
		<TELL
CTHE ,PRSO " gets wet." CR>)
	       (<HERE? ,INNER-LAIR>
		<COND (<VERB? EXAMINE>
		       <TELL
"The floor is covered by a pool of stagnant water. Near your
feet there is a slightly deeper part that seems to have something in
it." CR>)
		      (<VERB? DRINK DRINK-FROM FILL>
		       <TELL
"You couldn't bear to drink the water from this pool." CR>)
		      (<VERB? LOOK-INSIDE>
		       <TELL
,YOU-CANT-SEE "a thing, as the water is foul and murky." CR>)
		      (<VERB? REACH-IN SEARCH>
		       <COND (<LOC ,HIGH-VOLTAGE>
			      <TELL
,YOU-FIND-NOTHING " you would wish to touch again." CR>)
			     (ELSE
			      <TELL
S "You root around ""blindly in the gooey, slimy water. ">
			      <COND (<QUEUED? I-HAND-DIVES>
				     <DEQUEUE I-HAND-DIVES>
				     <MOVE ,HIGH-VOLTAGE ,HERE>
				     <TELL
S "You feel something " "thick and slippery! A tentacle? No, it's cold and
dead. " ,IT-SEEMS-TO-BE "a line of some kind, just below the
surface." CR>)
				    (ELSE
				     <TELL
,YOU-FIND-NOTHING "." CR>)>)>)
		      (<VERB? CROSS>
		       <PERFORM ,V?THROUGH ,MASS>
		       <RTRUE>)>)
	       (ELSE
		<COND (<VERB? EXAMINE>
		       <TELL
"It's a pool of rather yucky water." CR>)
		      (<VERB? LOOK-INSIDE>
		       <TELL
"It's about as clear as mud." CR>)
		      (<VERB? REACH-IN>
		       <TELL
"It feels greasy, cold, and generally unpleasant." CR>)>)>>

<OBJECT FROB
	(DESC "thing")
	(SYNONYM CREATURE THING BEING)
	(FLAGS NDESCBIT PERSON)
	(GENERIC GENERIC-CREATURE-F)
	(ACTION FROB-F)>

<ROUTINE FROB-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It is not from any wholesome place. It is the stuff of nightmares. It
is the thing that waits in the dark, the thing that scratches at your
windows late at night. It is not death, for next to this, death is a
friend to be cherished." CR>)
	       (<P? THROW SMOOTH-STONE FROB>
		<COND (<EQUAL? ,END-CNT 1>
		       <REMOVE ,SMOOTH-STONE>
		       <TELL
"The stone hurtles through the air and is swallowed by the black nothing
at its center. The creature howls in pain!" CR>)
		      (<EQUAL? ,END-CNT 2>
		       <REMOVE ,FROB>
		       <TELL
"The stone smashes into the creature, sticking to its ichorous hide.
The thing thrashes about, trying to bite at the stone, which is glowing
brighter and brighter. Small hands issue from beneath its scales to tug
in vain at the irritant. The creature begins to show gaping holes of
dark, light-devouring nothingness around the stone. Its wings spread
painfully, as though it were trying to fly away, and then fold. It
widens its jaw in an almost human scream of agony. The black hole of
its maw overwhelms it, and indeed the creature appears to be
swallowing itself. At last, a grey cloud of greasy smoke surrounds the
glowing stone, still suspended in midair. Then even that vanishes, and
the stone drops to the ground, no longer glowing. The thing is gone." CR>
		       <MOVE ,SMOOTH-STONE ,HERE>
		       <FCLEAR ,SMOOTH-STONE ,TOUCHBIT>
		       <SETG SCORE 100>)>)
	       (<OR <P? RUB FROB SMOOTH-STONE>
		    <P? ATTACK FROB HIGH-VOLTAGE>>
		<TELL
,YOU-CANT "force yourself to get that close to it." CR>)
	       (<HOSTILE-VERB?>
		<TELL
"Defiantly, the creature shrugs off your puny attack." CR>)>>

<GLOBAL END-CNT 0>

<ROUTINE I-FROB-APPEARS ()
	 <SETG END-CNT <+ ,END-CNT 1>>
	 <COND (<EQUAL? ,END-CNT 1>
		<REMOVE ,HACKER>
		<REMOVE ,MASS>
		%<IFSOUND <SOUNDS ,S-CRETIN ,S-STOP>>
		<FSET ,OUTPUT-CABLE ,RMUNGBIT>
		<SETG SCORE <+ ,SCORE 5>>
		<MOVE ,FROB ,HERE>
		<TELL CR
"The gelatinous mass solidifies and compacts, leaving behind a
litter of smoking debris. In the debris squats a being. Huge,
misshapen, it stares at you with baleful yellow eyes. Its scaly wings
beat slowly, driving a fetid stench through the stale air of the
cavern. A barbed tongue slides across its broken, daggerlike fangs.">
		<COND (<HELD? ,SMOOTH-STONE>
		       <TELL CR CR
CTHE ,SMOOTH-STONE " vibrates. It starts to feel warm.">)>
		<CRLF>)
	       (<EQUAL? ,END-CNT 2>
		<TELL CR
"The thing tenses, preparing to leap. Its mouth opens, revealing not
the glistening interior, but a dead-black outline like a hole into
nothingness.">
		<COND (<HELD? ,SMOOTH-STONE>
		       <TELL CR CR
CTHE ,SMOOTH-STONE " is now glowing with a bright-red heat that nevertheless
fails to burn you.">)>
		<CRLF>)
	       (<EQUAL? ,END-CNT 3>
		<COND (<LOC ,FROB>
		       <TELL CR
"The creature leaps, a mountain falling on you, and the darkness
swallows you, never to brighten again.">
		       <COND (<HELD? ,SMOOTH-STONE>
			      <TELL CR CR
CTHE ,SMOOTH-STONE ", all that's left where you were standing, drops quietly
into the pool.">)>
		       <JIGS-UP <>>
		       <RFATAL>)>)>>

<OBJECT BOOTS
	(IN BROWN-BASEMENT)
	(DESC "pair of rubber boots")
	(SYNONYM BOOTS)
	(ADJECTIVE RUBBER PAIR)
	(FLAGS TAKEBIT)
	(ACTION BOOTS-F)>

<ROUTINE BOOTS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"They are well-used rubber boots." CR>)
	       (<VERB? WEAR>
		<COND (<EQUAL? <IWEAR> T>
		       <TELL "Snug, but okay." CR>)
		      (ELSE <RTRUE>)>)>>

<ROUTINE IWEAR ()
	 <COND (<FSET? ,PRSO ,WEARBIT>
		<TELL ,YOU-ARE ,PERIOD>
		<RFALSE>)
	       (<NOT <HELD? ,PRSO>>
		<TELL ,YOU-ARENT " holding that!" CR>
		<RFALSE>)
	       (ELSE
		<MOVE ,PRSO ,WINNER>
		<FSET ,PRSO ,WEARBIT>
		<RTRUE>)>>