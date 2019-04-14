"CS for
			   The Lurking Horror
	(c) Copyright 1986 Infocom, Inc. All Rights Reserved."

"Computer Center: three floors plus basement and roof.  has a computer
  room, a terminal room, an elevator, etc."

<OBJECT OFFICE-DOOR
	(IN LOCAL-GLOBALS)
	(SYNONYM OFFICE DOOR DOORS)
	(ADJECTIVE CLOSED DARK LOCKED)
	(DESC "office")
	(FLAGS NDESCBIT DOORBIT OPENABLE)
	(GENERIC GENERIC-DOOR-F)
	(ACTION OFFICE-DOOR-F)>

<ROUTINE OFFICE-DOOR-F ()
	 <TELL "The offices are inaccessible." CR>>

<ROUTINE GENERIC-DOOR-F ()
	 <COND (<HERE? ,CHEMISTRY-BLDG>
		,ALCHEMY-DOOR)
	       (<HERE? ,INF-1 ,INF-3>
		,OUTSIDE-DOOR)>>

<ROOM SMITH-ST
      (IN ROOMS)
      (DESC "Smith Street")
      (SOUTH TO COMP-CENTER)
      (IN TO COMP-CENTER)
      (WEST "Impenetrable snow drifts block the street.")
      (EAST TO SMITH-ST-2)
      (GLOBAL OUTSIDE-DOOR)
      (ACTION SMITH-ST-F)
      (FLAGS ONBIT OUTSIDE)>

<ROUTINE SMITH-ST-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
'SMITH-ST " runs east and west along the north side of the main campus
area. At the moment, it is an arctic wasteland of howling wind and
drifting snow. On the other side of the street, barely visible, are
the lidless eyes of streetlights. The street hasn't been plowed, or
if it has been, it did no good." CR>)
	       (<AND <RARG? ENTER>
		     <NOT <EQUAL? ,OHERE ,SMITH-ST-2>>>
		<EXIT-TO-COLD>)>>

<ROOM SMITH-ST-2
      (IN ROOMS)
      (DESC "Smith Street")
      (SOUTH TO TEMPORARY-LAB)
      (IN TO TEMPORARY-LAB)
      (WEST TO SMITH-ST)
      (EAST "Impenetrable snow drifts block the street.")
      (GLOBAL OUTSIDE-DOOR)
      (ACTION SMITH-ST-2-F)
      (FLAGS ONBIT OUTSIDE)>

<ROUTINE SMITH-ST-2-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
'SMITH-ST " runs west towards the computer center here. To the south is
a dilapidated grey wooden building. The street is an impassable sea of
blowing and drifting snow." CR>)
	       (<RARG? ENTER>
		<COND (<EQUAL? ,OHERE ,TEMPORARY-LAB>
		       <EXIT-TO-COLD>)>)>>

<GLOBAL FREEZE-COUNT 0>

<GLOBAL FREEZING
	<LTABLE (PURE)
"Bitter, bone-cracking cold assaults you continuously. The
temperature and the blizzard conditions are both horrible."
"You can feel the cold worming its way through your layers of
clothing and biting into your flesh."
"You can no longer feel the tips of your fingers. As for your toes,
they have long since ceased to report."
"Your eyes are icing up."
"Each breath you take is like swallowing knives.">>

<ROUTINE I-FREEZE-TO-DEATH ()
	 <COND (<NOT <FSET? ,HERE ,OUTSIDE>>
		<RFALSE>)
	       (<G? <SETG FREEZE-COUNT <+ ,FREEZE-COUNT 1>> 5>
		<CRLF>
		<JIGS-UP
"You are suffused with a warm, blissful numbness. It is marred only by
the knowledge that before you wake again, you will die.">)
	       (ELSE
		<QUEUE I-FREEZE-TO-DEATH 4>
		<TELL CR <GET ,FREEZING ,FREEZE-COUNT> CR>)>>

<ROUTINE CS-BEGS ()
	 <COND (<AND <VERB? WALK>
		     <AND <NOT <EQUAL? ,P-WALK-DIR ,P?SOUTH>>
			  <OR <NOT <HERE? ,CS-BASEMENT>>
			      <NOT <EQUAL? ,P-WALK-DIR ,P?DOWN ,P?IN>>>>>
		<MOVE-FROM-DOORS>)
	       (<P? ENTER <>>
		<NEW-PRSO ,ELEVATOR>
		<RTRUE>)>>

<ROOM COMP-CENTER
      (IN ROOMS)
      (DESC "Computer Center")
      (NORTH TO SMITH-ST)
      (IN PER CS-ELEVATOR-ENTER)
      (SOUTH PER CS-ELEVATOR-ENTER)
      (UP TO CS-2ND)
      (DOWN TO CS-BASEMENT)
      (FLOOR 1)
      (FLAGS ONBIT)
      (GLOBAL ELEVATOR ;ELEVATOR-DOOR-1 UP-BUTTON DOWN-BUTTON)
      (ACTION COMP-CENTER-F)>

<ROUTINE COMP-CENTER-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
,THE-LOBBY 'COMP-CENTER ". ">
		<ELEVATOR-AND-BUTTONS>
		<TELL "to the south.">
		<DESCRIBE-STAIRS>
		<TELL
S "To the north is " 'SMITH-ST "." CR>)
	       (<RARG? BEG>
		<CS-BEGS>)
	       (<RARG? ENTER>
		<EXIT-FROM-COLD>)>>

<ROOM CS-2ND
      (IN ROOMS)
      (DESC "Second Floor")
      (NORTH TO TERMINAL-ROOM)
      (WEST TO KITCHEN)
      (SOUTH PER CS-ELEVATOR-ENTER)
      (IN PER CS-ELEVATOR-ENTER)
      (UP TO CS-3RD)
      (DOWN TO COMP-CENTER)
      (FLOOR 2)
      (FLAGS ONBIT)
      (GLOBAL ELEVATOR ;ELEVATOR-DOOR-2 UP-BUTTON DOWN-BUTTON)
      (ACTION CS-2ND-F)>

<ROUTINE DESCRIBE-ELEVATOR-AND-BUTTONS ()
	 <TELL
" floor of the " 'COMP-CENTER ". ">
	 <ELEVATOR-AND-BUTTONS>
	 <TELL "on the south side of the hallway.">>

<ROUTINE ELEVATOR-AND-BUTTONS ()
	 <TELL "An elevator and call button">
	 <COND (<NOT <HERE? CS-3RD CS-BASEMENT>> <TELL "s">)>
	 <TELL " are ">>

<ROUTINE CS-2ND-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"This is the second">
		<DESCRIBE-ELEVATOR-AND-BUTTONS>
		<TELL " A large, noisy room is to the north.">
		<DESCRIBE-STAIRS>
		<TELL
"To the west
a corridor leads into a smaller room." CR>)
	       (<RARG? BEG>
		<CS-BEGS>)>>

<ROOM CS-3RD
      (IN ROOMS)
      (DESC "Third Floor")
      (NORTH "There is a glass wall in the way.")
      (IN PER CS-ELEVATOR-ENTER)
      (SOUTH PER CS-ELEVATOR-ENTER)
      (UP TO CS-ROOF)
      (OUT TO CS-ROOF)
      (DOWN TO CS-2ND)
      (FLOOR 3)
      (FLAGS ONBIT)
      (GLOBAL ELEVATOR DOWN-BUTTON OUTSIDE-DOOR)
      (ACTION CS-3RD-F)
      (THINGS
       <PSEUDO (COMPUTER EQUIPMENT RANDOM-PSEUDO)
	       (<> COMPUTER RANDOM-PSEUDO)
	       (<> GLASS RANDOM-PSEUDO)
	       (GLASS WALL RANDOM-PSEUDO)
	       (GLASS WINDOW RANDOM-PSEUDO)>)>

<ROUTINE CS-3RD-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"This is the third">
		<DESCRIBE-ELEVATOR-AND-BUTTONS>
		<DESCRIBE-STAIRS>
		<TELL
S "To the north is ""a glass wall beyond which
you can see a computer room crammed with computer equipment. A stairway
leads up." CR>)
	       (<RARG? BEG>
		<CS-BEGS>)>>

<ROOM CS-ROOF
      (IN ROOMS)
      (DESC "Roof")
      (DOWN TO CS-3RD)
      (IN TO CS-3RD)
      (GLOBAL OUTSIDE-DOOR)
      (ACTION CS-ROOF-F)
      (FLAGS ONBIT OUTSIDE)>

<ROUTINE CS-ROOF-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"This is the roof of the " 'COMP-CENTER ". A door leads to the stairway.
The roof is covered with tarred pea gravel and drifted snow. The wind
howls around your ears. To the south and southeast you can dimly see the
looming shapes of the Great Dome and the Brown Building." CR>)
	       (<RARG? BEG>
		<ROOF-BEGS>)
	       (<RARG? ENTER>
		<TELL "You push through the door to the roof. ">
		<EXIT-TO-COLD>)
	       (<RARG? LEAVE>
		<EXIT-FROM-COLD>)>>

<ROOM TERMINAL-ROOM
      (IN ROOMS)
      (DESC "Terminal Room")
      (LDESC
"This is a large room crammed with computer terminals, small
computers, and printers. An exit leads south. Banners, posters, and
signs festoon the walls. Most of the tables are covered with waste
paper, old pizza boxes, and empty Coke cans. There are usually a lot of
people here, but tonight it's almost deserted.")
      (SOUTH PER HACKER-EXIT) ;CS-2ND
      (OUT PER HACKER-EXIT) ;CS-2ND
      (ACTION TERMINAL-ROOM-F)
      (GLOBAL PROGRAM OUTLET)
      (FLAGS ONBIT)
      (THINGS <PSEUDO (<> BANNER RANDOM-PSEUDO)
		      (<> POSTER RANDOM-PSEUDO)
		      (<> SIGN RANDOM-PSEUDO)
		      (<> SIGNS RANDOM-PSEUDO)>)>

<ROUTINE HACKER-EXIT ()
	 <COND (<OR <HELD? ,PC> <HELD? ,CHAIR>>
		<TELL
,HACKER-PREVENTS ,YOU-CANT "walk off with that!
It's Tech property!\"" CR>
		<RFALSE>)
	       (ELSE ,CS-2ND)>>

<ROUTINE TERMINAL-ROOM-F (RARG)
	 <COND ;(<RARG? LOOK>
		<TELL
 CR>)
	       (<RARG? BEG>
		<COND (<AND <NOT <VERB? TELL>> <GAME-VERB?>>
		       <RFALSE>)
		      (<QUEUED? I-HACKER-HELPS>
		       <COND (<P? (RUB POINT CLICK HELP)
				  (MENU-BOX MORE-BOX <>)>
			      <TELL
,HACKER-PREVENTS "Who's the hacker here?\" he snarls." CR>)>)
		      (<QUEUED? I-COMPULSION>
		       <COND (<P? (RUB POINT CLICK PUSH ATTACK) MORE-BOX>
			      <RFALSE>)
			     (<P? READ ,ODD-PAPER>
			      <RFALSE>)
			     (ELSE
			      <COND (<VERB? TELL HELLO>
				     <TELL
"Your throat tightens, and no sound issues forth. ">)
				    (<VERB? INVENTORY LAMP-OFF>
				     <TELL
"Your body refuses to obey your brain's command. ">)>
			      <TELL
"Instead, you find your finger moving towards the MORE box, and you touch
it. The screen feels oddly cold." CR>
			      <COND (<VERB? TELL>
				     <END-QUOTE>)
				    (ELSE <RTRUE>)>)>)>)
	       (<AND <RARG? ENTER>
		     <EQUAL? ,OHERE ,PLATFORM-ROOM>>
		<QUEUE I-HACKER-HELPS -1>
		<TELL
"You are awakened by the thump of your head hitting the terminal
in front of you. Falling asleep over term papers! It must have been a
nightmare. Embarrassed, you glance around. Yes, the hacker is looking
in your direction. He must have heard the thump." CR CR>)>>

<GLOBAL HACKER-HELP 0>

<ROUTINE I-HACKER-HELPS ()
	 <COND (<HERE? ,TERMINAL-ROOM>
		<SETG HACKER-HELP <+ ,HACKER-HELP 1>>
		<CRLF>
		<COND (<EQUAL? ,HACKER-HELP 1>
		       <TELL
S "The hacker wanders ""over, trying to look nonchalant">
		       <COND (<IN? ,PLAYER ,CHAIR>
			      <MOVE ,PLAYER ,HERE>
			      <FCLEAR ,HACKER ,CONTBIT>
			      <MOVE ,HACKER ,CHAIR>
			      <TELL
" as he takes over your chair">)>
		       <TELL ". \"Losing,
huh?\" he asks wittily. He ">
		       <COND (<FSET? ,PC ,POWERBIT>
			      <TELL "glances at">)
			     (ELSE
			      <TELL "turns on">)>
		       <TELL
" your terminal, which displays a pattern of snow and unusual characters.
He appears somewhat excited." CR>)
		      (<EQUAL? ,HACKER-HELP 2>
		       <TELL
"The hacker, mumbling under his breath,
begins a flurry of activity. First the screen returns to something
nearly normal, then windows begin popping up like toadstools after a
rain. The screen looks a lot like the top of his terminal table (or the
bottom of a trash can)." CR>)
		      (<EQUAL? ,HACKER-HELP 3>
		       <TELL
"The hacker types furiously, and the screen displays what to you looks
like an explosion in a teletype factory. After a while he says. \"Chomping
file system. Your directory has gone seriously west. I fixed it.\" He
checks the screen. \"It was mixed up on the file server with some files
from the Department of
Alchemy.\" He grunts. \"People's names for their nodes are getting
weird. This one is called 'Lovecraft.'\" He pauses. \"Your paper is gone,
though. Sorry. Maybe they could help you down there.\"" CR>)
		      (ELSE
		       <MOVE ,HACKER ,TERMINAL-ROOM>
		       <FSET ,HACKER ,CONTBIT>
		       <DEQUEUE I-HACKER-HELPS>
		       <TELL
S "The hacker wanders " "back to his terminal and returns to
his hacking." CR>)>)
	       (ELSE <DEQUEUE I-HACKER-HELPS>)>>

<ROOM CS-BASEMENT
      (IN ROOMS)
      (DESC "Basement")
      (UP TO COMP-CENTER)
      (SOUTH PER CS-ELEVATOR-ENTER)
      (IN PER CS-ELEVATOR-ENTER)
      (EAST TO TEMPORARY-BASEMENT)
      (WEST TO AERO-BASEMENT)
      (DOWN PER CS-PIT-ENTER)
      (FLOOR 0)
      (FLAGS ONBIT)
      (GLOBAL ELEVATOR ELEVATOR-DOOR-B UP-BUTTON CABLE STEAM-PIPES)
      (ACTION CS-BASEMENT-F)>

<ROUTINE CS-PIT-ENTER ()
	 <COND (<WINNER? ,URCHIN> <RFALSE>)
	       (<AND <FSET? ,ELEVATOR-DOOR-B ,OPENBIT>
		     <NOT <ZERO? ,ELEVATOR-LOC>>>
		<TELL
"You drop to the floor below, which isn't all that far down.">
		<COND (,HOLDING-DOORS?
		       <SETG HOLDING-DOORS? <>>
		       <FCLEAR ,ELEVATOR-DOOR-B ,OPENBIT>
		       <ELEVATOR-WANTED?>
		       <TELL
" The doors shut as soon as you release them">
		       <IN-DARK?>)
		      (ELSE <CRLF>)>
		<CRLF>
		,ELEVATOR-PIT)
	       (ELSE
		<CANT-GO>
		<RFALSE>)>>

<ROUTINE CS-BASEMENT-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"Bare concrete walls line a wide corridor leading east and west. ">
		<ELEVATOR-AND-BUTTONS>
		<TELL "to the south.">
		<DESCRIBE-STAIRS>
		<TELL S
"From floor to ceiling run wire channels and steam pipes.|">)
	       (<RARG? BEG>
		<CS-BEGS>)>>

<ROOM TEMPORARY-BASEMENT
      (IN ROOMS)
      (DESC "Temporary Basement")
      (LDESC
"During the Second World War, some temporary buildings were built to house
war-related research. Naturally, these buildings, though flimsy and ugly,
are still around. This is the basement of one of them. The basement
extends west, a stairway leads up, and a large passage is to the east.")
      (WEST TO CS-BASEMENT)
      (EAST TO DEAD-STORAGE)
      (UP TO TEMPORARY-LAB)
      (FLAGS ONBIT)>

<ROOM DEAD-STORAGE
      (IN ROOMS)
      (DESC "Dead Storage")
      (WEST TO TEMPORARY-BASEMENT)
      (EAST PER STORAGE-EXIT)
      (IN PER STORAGE-EXIT)
      (GLOBAL JUNK)
      (ACTION DEAD-STORAGE-F)>

<ROUTINE DEAD-STORAGE-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"This is a storage room. It contains an incredible assemblage of discarded
junk. Some of it is so old and mouldering that you can't be sure where one
bit of junk stops and the next begins. It's piled to the ceiling on
ancient, rotting pallets">
		<COND (<L? ,JUNK-MOVED? ,JUNK-MOVES-NEEDED>
		       <TELL
"; you can't even see the east wall.">)
		      (ELSE
		       <TELL
". A narrow path winds eastward through the junk.">)>
		<CRLF>)
	       (<RARG? BEG>
		<COND (<P? THROUGH ROOMS>
		       <DO-WALK ,P?EAST>)
		      (<P? MOVE CORRIDOR>
		       <NEW-PRSO ,JUNK>
		       <RTRUE>)>)>>

<GLOBAL JUNK-MOVED? <>>
<CONSTANT JUNK-MOVES-NEEDED 3>

<ROUTINE STORAGE-EXIT ()
	 <COND (<WINNER? ,URCHIN> <RFALSE>)
	       (<G? ,JUNK-MOVED? ,JUNK-MOVES-NEEDED> ,STORAGE-ROOM) 
	       (,JUNK-MOVED?
		<TELL
"There is still no path all the way through the junk, but you can now
tell for sure that there's a room to the east." CR>
		<RFALSE>)
	       (ELSE
		<TELL
"You climb around on the junk for a while, and you get the impression that
there is an opening 'way on the east wall, but there is so much stuff in
the way that you can't get to it." CR>
		<RFALSE>)>>

<OBJECT JUNK
	(IN LOCAL-GLOBALS)
	(DESC "junk")
	(SYNONYM JUNK DEBRIS PALLET PILE)
	(ADJECTIVE MOULDERING OLD PILE)
	(FLAGS NDESCBIT NOABIT)
	(ACTION JUNK-F)>

<ROUTINE JUNK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Looking more closely only emphasizes how completely entropy has taken
over this room." CR>)
	       (<VERB? MOVE PRY>
		<TELL
"You have obviously underestimated the amount of junk in here. It's
not only voluminous, it's heavy." CR>)
	       (<VERB? SEARCH>
		<TELL
"You find many worthless items of hardware, old discarded memos and
papers, but nothing of any use or value." CR>)>>

<OBJECT FORKLIFT
	(IN AERO-BASEMENT)
	(DESC "forklift")
	(SYNONYM FORKLIFT LIFT)
	(ADJECTIVE FORK)
	(FLAGS VEHBIT SURFACEBIT OPENBIT CONTBIT SEARCHBIT)
	(ACTION FORKLIFT-F)>

<GLOBAL FORKLIFT-WONT-FIT "The forklift won't fit into the ">

<GLOBAL A-DEAD-FORKLIFT " a forklift that isn't running.">

<ROUTINE FORKLIFT-F ("OPT" (RARG <>) "AUX" O)
	 <COND (<RARG? BEG>
		<COND (<P? OPEN MANHOLE-COVER FORKLIFT>
		       <RFALSE>)
		      (<AND <VERB? LEAP BOARD MUNG>
			    ,PRSO
			    <NOT <IN? ,PRSO ,FORKLIFT>>
			    <NOT <PRSO? ,FORKLIFT>>>
		       <PERFORM ,V?DRIVE-ON ,FORKLIFT ,PRSO>
		       <RTRUE>)
		      (<VERB? DRIVE-ON DRIVE-TO> <RFALSE>)
		      (<P? THROUGH JUNK>
		       <TELL
"The forklift isn't that powerful." CR>)
		      (<VERB? WALK>
		       <COND (<EQUAL? ,P-WALK-DIR ,P?DOWN>
			      <PERFORM ,V?DISEMBARK>
			      <RTRUE>)
			     (<NOT <FSET? ,FORKLIFT ,POWERBIT>>
			      <TELL
,YOU-CANT "go anywhere in" ,A-DEAD-FORKLIFT CR>)
			     (<AND <IN? ,FORKLIFT ,DEAD-STORAGE>
				   <EQUAL? ,P-WALK-DIR ,P?EAST>>
			      <COND (<G? ,JUNK-MOVED? ,JUNK-MOVES-NEEDED>
				     <GOTO ,STORAGE-ROOM>)
				    (<NOT ,JUNK-MOVED?>
				     <TELL
"There is no path through the junk for you, much less for a forklift." CR>)
				    (ELSE
				     <TELL
,YOU-HAVE-TO "move some more junk first, I'm afraid." CR>)>)
			     (<OR <AND <IN? ,FORKLIFT ,AERO-BASEMENT>
				       <EQUAL? ,P-WALK-DIR ,P?WEST ,P?UP>>
				  <AND <IN? ,FORKLIFT ,TEMPORARY-BASEMENT>
				       <EQUAL? ,P-WALK-DIR ,P?UP>>>
			      <TELL
,FORKLIFT-WONT-FIT "stairwell." CR>)
			     (<IN? ,FORKLIFT ,CS-BASEMENT>
			      <COND (<AND <EQUAL? ,P-WALK-DIR
						  ,P?SOUTH ,P?IN ,P?DOWN>
					  <FSET? ,ELEVATOR-DOOR-B ,OPENBIT>>
				     <TELL ,FORKLIFT-WONT-FIT>
				     <COND (<ELEVATOR-HERE?>
					    <TELL "elevator." CR>)
					   (ELSE <TELL "shaft." CR>)>)
				    (<EQUAL? ,P-WALK-DIR ,P?UP>
				     <TELL
,FORKLIFT-WONT-FIT "stairwell." CR>)>)>)
		      (<P? LAMP-ON FORKLIFT>
		       <COND (<NOT <FSET? ,PRSO ,POWERBIT>>
			      <FSET ,FORKLIFT ,POWERBIT>
			      <TELL
"The forklift sputters to life." CR>)
			     (ELSE
			      <TELL "It's wheezing away already." CR>)>)
		      (<P? (LAMP-OFF STOP) FORKLIFT>
		       <COND (<FSET? ,PRSO ,POWERBIT>
			      <FCLEAR ,FORKLIFT ,POWERBIT>
			      <TELL
"The forklift coughs once, and dies." CR>)
			     (ELSE
			      <ITS-ALREADY-X "off">)>)
		      (<OR <P? MOVE>
			   <P? PRY * FORKLIFT>>
		       <COND (<NOT ,LIT>
			      <TELL ,TOO-DARK>)
			     (<NOT <FSET? ,FORKLIFT ,POWERBIT>>
			      <TELL
,YOU-CANT "move anything with" ,A-DEAD-FORKLIFT CR>)
			     (<PRSO? ,JUNK>
			      <COND (<HERE? ,STORAGE-ROOM>
				     <TELL
S "There's nothing ""on pallets here, hence the forklift is useless." CR>)
				    (<NOT ,JUNK-MOVED?>
				     <SETG JUNK-MOVED? 1>
				     <TELL
"You have a little trouble using the forklift, but it's not really all
that hard. You start clearing junk, moving it around and trying to
create a passage." CR>
				     <RTRUE>)
				    (<G? <SETG JUNK-MOVED? <+ ,JUNK-MOVED? 1>>
					 ,JUNK-MOVES-NEEDED>
				     <COND (<G? ,JUNK-MOVED?
						<+ ,JUNK-MOVES-NEEDED 1>>
					    <TELL
"I suppose you're planning to clear the entire room? You've made a nice
path to the next room already." CR>)
					   (ELSE
					    <TELL
"You've built a fairly narrow (about one forklift wide) path through the
junk. You can see an opening into a further storage room beyond this
one." CR>)>)
				    (ELSE
				     <TELL
"You continue moving junk, becoming more proficient with the forklift." CR>)>)
			     (ELSE
			      <TELL
"The forklift is ineffective in manipulating " THE ,PRSO ,PERIOD>)>)
		      (<SET O <NOT-REACHABLE?>>
		       <CANT-REACH-FROM-VEHICLE .O>)>)
	       (<RARG? <>>
		<COND (<VERB? EXAMINE>
		       <TELL
"This is a rusty ">
		       <COND (<FSET? ,FORKLIFT ,POWERBIT>
			      <TELL "and wheezing ">)>
		       <TELL "old forklift. It looks like you could
control it fairly easily, though." CR>)
		      (<VERB? LAMP-ON LAMP-OFF STOP>
		       <TELL
,YOU-HAVE-TO "get in it first." CR>)
		      (<P? (MOVE PRY) JUNK FORKLIFT>
		       <TELL
"You're trying to operate the forklift by telepathy?" CR>)>)>>

<ROOM STORAGE-ROOM
      (IN ROOMS)
      (DESC "Ancient Storage")
      (LDESC
"What's deader than dead storage? That's what's in this room. Most of the
contents have collapsed or rusted back to the primordial ooze. There is
mold growing on some of the unidentifiable piles. Stagnant
puddles of water pollute the floor. You can now believe how old some of these
foundations are said to be.")
      (WEST TO DEAD-STORAGE)
      (DOWN PER MANHOLE-EXIT)
      (VALUE 5)
      (GLOBAL JUNK POOL)
      (ACTION STORAGE-ROOM-F)>

<ROUTINE STORAGE-ROOM-F (RARG)
	 <COND (<RARG? ENTER> 
		<FCLEAR ,MANHOLE ,NDESCBIT>
		<MOVE ,MANHOLE ,HERE>)>>

<ROUTINE MANHOLE-EXIT ()
	 <COND (<NOT <IN? ,MANHOLE-COVER ,MANHOLE>>
		<SETG SCORE <+ ,SCORE ,MANHOLE-SCORE>>
		<SETG MANHOLE-SCORE 0>
		,BRICK-TUNNEL)
	       (ELSE
		<COND (<WINNER? ,PLAYER>
		       <TELL
S "There is a ""steel cover on the manhole." CR>)>
		<RFALSE>)>>

<OBJECT MANHOLE
	(IN STORAGE-ROOM)
	(DESC "manhole")
	(SYNONYM MANHOLE HOLE RING)
	(ADJECTIVE MAN STEEL)
	(FLAGS OPENBIT CONTBIT SEARCHBIT RMUNGBIT DOORBIT)
	(CAPACITY 200)
	(DESCFCN MANHOLE-DESC)
	(ACTION MANHOLE-F)>

<ROUTINE MANHOLE-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?> <RTRUE>)
	       (ELSE
		<COND (<IN? ,MANHOLE-COVER ,MANHOLE>
		       <TELL
S "There is a ""closed, disused-looking manhole here.">)
		      (ELSE
		       <TELL
S "There is an open ""manhole here.">)>
		<RFATAL>)>>

<ROUTINE MANHOLE-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<NOT <IN? ,MANHOLE-COVER ,MANHOLE>>
		       <TELL
"It's a manhole.">
		       <COND (<HERE? ,STORAGE-ROOM>
			      <TELL
" It's very dark inside, but you can see that crude
brick handholds provide a slippery path down. Cool air rises out of
the hole.">)>
		       <CRLF>)
		      (ELSE
		       <TELL
"It's a steel ring set in the ">
		       <COND (<HERE? ,STORAGE-ROOM>
			      <TELL "floor">)
			     (ELSE <TELL "ceiling">)>
		       <TELL ". It's probably a manhole." CR>)>)
	       (<VERB? LOOK-INSIDE LOOK-DOWN>
		<COND (<IN? ,MANHOLE-COVER ,MANHOLE>
		       <TELL "You see only the cover." CR>)
		      (<HERE? ,BRICK-TUNNEL>
		       <TELL
"You can't see much." CR>)
		      (ELSE
		       <TELL
"You can see a dark, grimy tunnel below." CR>)>)
	       (<P? (PUT PUT-ON) * MANHOLE>
		<COND (<PRSO? ,MANHOLE-COVER> <RFALSE>)
		      (<NOT <IN? ,MANHOLE-COVER ,MANHOLE>>
		       <MOVE ,PRSO ,BRICK-TUNNEL>
		       <TELL
"You drop " THE ,PRSO ", and it hits the ground not far below." CR>)
		      (ELSE
		       <TELL "The manhole is covered right now." CR>)>)
	       (<P? (THROUGH BOARD CLIMB-DOWN) MANHOLE>
		<COND (<HERE? ,STORAGE-ROOM>
		       <DO-WALK ,P?DOWN>)
		      (ELSE <DO-WALK ,P?UP>)>)
	       (<P? (RAISE PRY MOVE) MANHOLE>
		<PERFORM-PRSA ,MANHOLE-COVER ,PRSI>
		<RTRUE>)
	       (<VERB? OPEN>
		<COND (<PRSI? ,CROWBAR>
		       <NEW-VERB ,V?PRY>
		       <RTRUE>)
		      (<IN? ,MANHOLE-COVER ,MANHOLE>
		       <TELL
"The only way would seem to be to remove the manhole cover." CR>)>)
	       (<VERB? CLOSE>
		<PERFORM ,V?PUT ,MANHOLE-COVER ,MANHOLE>
		<RTRUE>)>>

<OBJECT MANHOLE-COVER
	(IN MANHOLE)
	(DESC "manhole cover")
	(FDESC
"In one corner of the room a manhole cover is partly buried in the dirt and
crud.")
	(SYNONYM COVER DISC DISK)
	(ADJECTIVE MANHOLE OLD RUSTY STEEL)
	(FLAGS TAKEBIT TRYTAKEBIT SURFACEBIT CONTBIT OPENBIT
	       SEARCHBIT)
	(SIZE 200)
	(ACTION MANHOLE-COVER-F)>

<ROUTINE MANHOLE-COVER-F ()
	 <COND (<PRSO? ,MANHOLE-COVER>
		<COND (<VERB? EXAMINE>
		       <TELL
"It's an old, rusty, steel " 'MANHOLE-COVER>
		       <COND (<IN? ,MANHOLE-COVER ,MANHOLE>
			      <TELL
" set in a steel ring embedded in the ">
			      <COND (<HERE? ,STORAGE-ROOM> <TELL "floor">)
				    (ELSE <TELL "ceiling">)>)>
		       <TELL "." CR>)
		      (<VERB? TAKE TAKE-OFF>
		       <COND (<IN? ,MANHOLE-COVER ,MANHOLE>
			      <TELL
,YOU-CANT S "get a good grip on " "it; it's heavy and in a steel ring;
impossible to just ">
			      <COND (<HERE? ,STORAGE-ROOM>
				     <TELL "drag it away." CR>)
				    (ELSE
				     <TELL "push it off." CR>)>)>)
		      (<P? (CLIMB-ON STEP-ON)>
		       <TELL ,WASTE-OF-TIME>)
		      (<AND <P? (PRY OPEN) * CROWBAR>
			    <IN? ,MANHOLE-COVER ,MANHOLE>>
		       <MOVE ,MANHOLE-COVER ,STORAGE-ROOM>
		       <TELL
"You lever the " 'MANHOLE-COVER " aside">
		       <COND (<HERE? ,STORAGE-ROOM>
			      <TELL ", and crusted dirt falls into a dark">
			      <COND (<FSET? ,MANHOLE ,RMUNGBIT>
				     <TELL ", partly obstructed">)>
			      <TELL " hole below." CR>)
			     (ELSE <TELL "." CR>)>)
		      (<P? (PUSH-TO PUT-ON PUT) * MANHOLE>
		       <MOVE ,MANHOLE-COVER ,MANHOLE>
		       <TELL
"You manage to shove the " 'MANHOLE-COVER " back over the hole." CR>)
		      (<VERB? OPEN>
		       <COND (<IN? ,MANHOLE-COVER ,MANHOLE>
			      <TELL "An interesting idea, but how?" CR>)>)
		      (<VERB? MOVE RAISE>
		       <COND (<NOT <IN? ,MANHOLE-COVER ,MANHOLE>>
			      <TELL
"You move it a little way, but it's very heavy." CR>)
			     (ELSE
			      <TELL
"It doesn't budge." CR>)>)
		      (<VERB? PUSH>
		       <COND (<IN? ,MANHOLE-COVER ,MANHOLE>
			      <TELL
"It's sitting inside a steel ring, so pushing it does nothing." CR>)>)
		      (<VERB? CUT MUNG>
		       <TELL
"The cover is heavy.">
		       <COND (,PRSI
			      <TELL
" Your " 'PRSI " won't thank you for this.">)>
		       <CRLF>)>)>>

<ROOM BRICK-TUNNEL
      (IN ROOMS)
      (DESC "Brick Tunnel")
      (UP PER BRICK-TUNNEL-EXIT)
      (NORTH TO CAVE-ROOM)
      (SOUTH TO UNDER-ALCHEMY-LAB)
      (ACTION BRICK-TUNNEL-F)
      (THINGS <PSEUDO (<> BRICKS RANDOM-PSEUDO)
		      (<> STONES RANDOM-PSEUDO)>)>

<GLOBAL MANHOLE-SCORE 5>

<ROUTINE BRICK-TUNNEL-EXIT ()
	 <COND (<NOT <IN? ,MANHOLE-COVER ,MANHOLE>>
		,STORAGE-ROOM)
	       (ELSE
		<TELL
S "There is a " 'MANHOLE-COVER " blocking your way." CR>
		<RFALSE>)>>

<ROUTINE BRICK-TUNNEL-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"This is an ancient tunnel constructed of roughly
mortared bricks and stones. ">
		<COND (<ZERO? ,MANHOLE-SCORE>
		       <TELL "A slippery and almost invisible set of
handholds leads up. ">)>
		<TELL "The tunnel continues a long way north and south from here." CR>)
	       (<RARG? ENTER>
		<FSET ,MANHOLE ,NDESCBIT>
		<MOVE ,MANHOLE ,HERE>
		<COND (<AND <EQUAL? ,OHERE ,STORAGE-ROOM>
			    <FSET? ,MANHOLE ,RMUNGBIT>>
		       <FCLEAR ,MANHOLE ,RMUNGBIT>
		       <TELL
S "You push your way through ""cobwebs, damp fungus,
and other obstructions." CR CR>)
		      (<EQUAL? ,OHERE ,UNDER-ALCHEMY-LAB>
		       <TELL ,DOWN-LONG-TUNNEL>)>)
	       (<RARG? LEAVE>
		<COND (<EQUAL? ,OHERE ,UNDER-ALCHEMY-LAB ,CAVE-ROOM>
		       <TELL ,DOWN-LONG-TUNNEL>)>)>>

<GLOBAL DOWN-LONG-TUNNEL "You make your way along the long tunnel.||">

<ROOM CAVE-ROOM
      (IN ROOMS)
      (DESC "Renovated Cave")
      (SOUTH TO BRICK-TUNNEL)
      (DOWN TO CAVE-ALTAR)
      (GLOBAL SLAB CARVINGS)
      (ACTION CAVE-ROOM-F)>

<ROUTINE CAVE-ROOM-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"You are in a huge, cave-like construction. A path leads down to a
floor partly covered with rough concrete. The walls and ceiling
are high and reinforced with beams of wood, iron, and steel. In the center
of the floor you can see a large, flat " 'SLAB ". The only
exit is behind you to the south." CR>)>>

<OBJECT SLAB
	(IN CAVE-ALTAR)
	(DESC "slab of granite")
	(SYNONYM SLAB ALTAR)
	(ADJECTIVE GRANITE)
	(FLAGS NDESCBIT SEARCHBIT VEHBIT OPENBIT SURFACEBIT CONTBIT)
	(CAPACITY 200)
	(ACTION SLAB-F)>

<ROUTINE SLAB-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The slab is roughly circular, made of indifferently dressed New England
granite, and about three feet high.">
		<COND (<HERE? ,CAVE-ALTAR>
		       <TELL " It is carved all over with odd glyphs,
symbols, and strange animal (or part-animal?) figures. The top is covered
with a brown stain shading to red at the edges.">)>
		<CRLF>)
	       (<VERB? BOARD RUB READ PUSH>
		<COND (<HERE? ,CAVE-ROOM>
		       <TELL ,ARENT-CLOSE-ENOUGH>)
		      (<VERB? READ>
		       <NEW-PRSO ,CARVINGS>
		       <RTRUE>)
		      (<AND <VERB? RUB>
			    ,PRSI
			    <NOT <PRSI? ,HANDS>>>
		       <TELL ,NOTHING-HAPPENS>)
		      (ELSE
		       <TELL
"An inexplicable revulsion prevents you from touching it." CR>)>)
	       (<VERB? WALK-TO>
		<COND (<HERE? ,CAVE-ROOM>
		       <DO-WALK ,P?DOWN>)
		      (ELSE
		       <TELL
S "You approach the " "slab warily. It is disquieting to look at." CR>)>)>>

<OBJECT CARVING-SYMBOL
	(IN SLAB)
	(DESC "incised symbol")
	(SYNONYM SYMBOL)
	(ADJECTIVE INCISED LARGE)
	(FLAGS NDESCBIT)
	(GENERIC GENERIC-SYMBOL-F)
	(ACTION CARVING-SYMBOL-F)>

<ROUTINE CARVING-SYMBOL-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"The symbol appears to be the oldest thing carved on the altar.
It is beautifully incised in the rocks. Its age is apparent from
its wear and the overlay of newer carvings and scratchings over it. ">
		<TELL-SYMBOL ,CARVINGS>
		<CRLF>)>>

<OBJECT CARVINGS
	(IN LOCAL-GLOBALS)
	(DESC "carvings")
	(SYNONYM CARVINGS GRAFFITI CREATURE PEOPLE)
	(ADJECTIVE CARVED STAINED OBSCENE REVOLTING INDESCRIBABLE)
	(FLAGS NDESCBIT READBIT SEARCHBIT OPENBIT CONTBIT)
	(GENERIC GENERIC-CREATURE-F)
	(ACTION CARVINGS-F)>

<ROUTINE CARVINGS-F ()
	 <COND (<VERB? EXAMINE READ>
		<COND (<HERE? ,CAVE-ALTAR>
		       <TELL
"The carvings are in a variety of styles. Some are almost like graffiti,
and have carved dates as early as 1655 and as recent as last year. Some
are creatures, or people, or combinations of the two. Some are obscene,
or revolting, or just indescribable. One is a strange " 'CARVING-SYMBOL ".
Most are at least partly spotted with brown stains." CR>)
		      (ELSE
		       <TELL ,ARENT-CLOSE-ENOUGH>)>)
	       (<VERB? RUB>
		<NEW-PRSO ,SLAB>
		<RTRUE>)>>

<GLOBAL ARENT-CLOSE-ENOUGH "You aren't close enough.|">

<ROOM CAVE-ALTAR
      (IN ROOMS)
      (DESC "Before the Altar")
      (UP TO CAVE-ROOM)
      (GLOBAL ;SLAB CARVINGS)
      (ACTION CAVE-ALTAR-F)>

<ROUTINE CAVE-ALTAR-F (RARG)
	 <COND (<RARG? LOOK>
		<THIS-IS-IT ,CARVING-SYMBOL>
		<TELL
"You are at the bottom of the cave. The huge " 'SLAB " in the center
is a sort of altar. It is carved with strange and
disturbing symbols, the largest of which looks very familiar. Some
of the symbols are obscured by rusty red stains. Nearby
is an iron plate set in the concrete of the floor." CR>)
	       (<RARG? BEG>
		<COND (<AND <P? FIND STUDENTS>
			    ,SEEN-PIT?>
		       <TELL
"You no longer need to look for them. You now understand the stains
on the altar." CR>)
		      (<AND <VERB? WALK>
			    <EQUAL? ,P-WALK-DIR ,P?DOWN>
			    ,SEEN-PIT?>
		       <TELL
"You're joking." CR>)>)
	       (<RARG? ENTER>
		<COND (<FSET? ,IRON-PLATE ,OPENBIT>
		       <QUEUE I-PANEL-NOISES -1>)>)>>

<OBJECT KNIFE
	(IN CAVE-ALTAR)
	(DESC "knife")
	(FDESC
"Lying to one side of the altar stone is a sharp, thin-bladed
knife.")
	(SYNONYM KNIFE BLADE)
	(ADJECTIVE SHARP THIN THIN-BLADED)
	(FLAGS TAKEBIT WEAPONBIT TOOLBIT)
	(ACTION KNIFE-F)>

<ROUTINE KNIFE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This small knife is clean, sharp, and has a long, thin blade
and a wooden handle. Only the tip of the blade appears at all dull or
used." CR>)
	       (<VERB? SHARPEN>
		<TELL
"The blade doesn't look any different after this operation." CR>)>>

<OBJECT IRON-PLATE
	(IN CAVE-ALTAR)
	(DESC "iron plate")
	(SYNONYM PLATE HOLE PANEL OPENING)
	(ADJECTIVE IRON)
	(FLAGS AN NDESCBIT CONTBIT TRANSBIT OPENABLE)
	(ACTION IRON-PLATE-F)>

<ROUTINE IRON-PLATE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The plate is iron, about two feet square, and ">
		<COND (<NOT <FSET? ,IRON-PLATE ,OPENBIT>>
		       <TELL "looks like it could be slid ">)>
		<TELL "open. A curious feature of the plate
is that it has upward projecting dents in it which appear to have
been punched from below.">
		<CRLF>)
	       (<VERB? OPEN MOVE>
		<COND (,SEEN-PIT?
		       <TELL S
"You would sooner die than open that panel again.|">)
		      (<NOT <FSET? ,PRSO ,OPENBIT>>
		       <FSET ,PRSO ,OPENBIT>
		       <QUEUE I-PANEL-NOISES -1>
		       <TELL
"You slide open the panel, revealing a dark pit below. Immediately,
there is a response from below." CR>)>)
	       (<VERB? RAISE>
		<TELL
"It doesn't lift, it slides." CR>) 
	       (<P? PUT * ,IRON-PLATE>
		<COND (<FSET? ,PRSI ,OPENBIT>
		       <REMOVE ,PRSO>
		       <COND (<FSET? ,PRSO ,FOODBIT>
			      <TELL
"Sounds of ghoulish excitement issue from the opening." CR>)
			     (ELSE
			      <TELL
"The sounds from below increase in intensity." CR>)>)
		      (ELSE
		       <TELL "The panel isn't open." CR>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <DEQUEUE I-PANEL-NOISES>
		       <TELL
"You close the panel. You no longer hear the noises, much to your
relief." CR>)>)
	       (<VERB? LISTEN>
		<COND (,SEEN-PIT?
		       <TELL
,UNABLE "do that again." CR>)
		      (<FSET? ,IRON-PLATE ,OPENBIT>
		       <TELL
"Disturbing noises issue from the open panel." CR>)
		      (ELSE
		       <TELL
"You hear very faint noises through the closed panel." CR>)>)
	       (<VERB? LOOK-INSIDE LOOK-UNDER REACH-IN LEAP BOARD>
		<COND (,SEEN-PIT?
		       <TELL S
"You would sooner die than open that panel again.|">)
		      (<FSET? ,IRON-PLATE ,OPENBIT>
		       <FCLEAR ,IRON-PLATE ,OPENBIT>
		       <DEQUEUE I-PANEL-NOISES>
		       <SETG SEEN-PIT? T>
		       <TELL
"You peer through the hole, shining your light into the stygian darkness
below. The commotion below is growing louder, and suddenly you catch a
glimpse of things moving in the pit. Without consciously realizing you
have done it, you slam the panel shut, reeling away from the source of
such images. Now you know what has been done with the
missing students." CR>)
		      (ELSE
		       <TELL-OPEN-CLOSED ,PRSO>)>)>>

<GLOBAL UNABLE "You find yourself unable to ">

<GLOBAL SEEN-PIT? <>>

<ROUTINE I-PANEL-NOISES ("OPT" (NOCR? <>))
	 <COND (<NOT <HERE? ,CAVE-ALTAR ,CAVE-ROOM>>
		<DEQUEUE I-PANEL-NOISES>
		<RFALSE>)
	       (<AND <NOT .NOCR?> <VERB? LISTEN>>
		<RFALSE>)
	       (<HERE? ,CAVE-ALTAR>
		<COND (<NOT .NOCR?> <CRLF>)>
		<TELL
"A low, guttural, groaning and snarling issues from the opening." CR>)
	       (ELSE
		<COND (<NOT .NOCR?> <CRLF>)>
		<TELL
"You can still hear faint groans and snarls from the larger cave." CR>)>>

<ROOM UNDER-ALCHEMY-LAB
      (IN ROOMS)
      (DESC "Cinderblock Tunnel")
      (NORTH TO BRICK-TUNNEL)
      (UP PER UNDER-ALCHEMY-LAB-EXIT)
      (GLOBAL ALCHEMY-TRAP-DOOR LAB LADDER)
      (ACTION UNDER-ALCHEMY-LAB-F)>

<ROUTINE UNDER-ALCHEMY-LAB-EXIT ()
	 <COND (<NOT <FSET? ,ALCHEMY-TRAP-DOOR ,OPENBIT>>
		<COND (<WINNER? ,PLAYER>
		       <THIS-IS-IT ,ALCHEMY-TRAP-DOOR>
		       <TELL
"The trapdoor isn't open." CR>)>
		<RFALSE>)
	       (ELSE
		,ALCHEMY-LAB)>>

<ROUTINE UNDER-ALCHEMY-LAB-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"This is a tunnel whose walls are cinderblock, with a concrete floor and
ceiling. A metal ladder leads up to ">
		<AN-OPEN/CLOSED ,ALCHEMY-TRAP-DOOR>
		<TELL " in the ceiling, and the
tunnel continues north, where the cinderblock walls become brick." CR>)>>

<ROUTINE AN-OPEN/CLOSED (DOOR)
	 <COND (<FSET? .DOOR ,OPENBIT> <TELL "an open ">)
	       (ELSE <TELL "a closed ">)>
	 <TELL D .DOOR>>

<ROOM TEMPORARY-LAB
      (IN ROOMS)
      (DESC "Temporary Lab")
      (LDESC
"This is a laboratory of some sort. It takes up most of the building on
this level, all the interior walls having been knocked down. (One reason
these temporary buildings are still here is their
flexibility: no one cares if they get more or less destroyed.) A stairway
leads down, and a door leads north.")
      (NORTH TO SMITH-ST-2)
      (OUT TO SMITH-ST-2)
      (DOWN TO TEMPORARY-BASEMENT)
      (GLOBAL OUTSIDE-DOOR)
      (ACTION TEMPORARY-LAB-F)>

<ROUTINE TEMPORARY-LAB-F (RARG)
	 <COND (<RARG? ENTER>
		<DEQUEUE I-FREEZE-TO-DEATH>
		<COND (<G? ,FREEZE-COUNT 0>
		       <SETG FREEZE-COUNT 0>
		       <TELL
,PUSH-INTO "comparative warmth of a laboratory." CR CR>)>)>>

<GLOBAL PUSH-INTO "You push your way into the ">

<OBJECT FLASK
	(IN TEMPORARY-LAB)
	(DESC "metal flask")
	(SYNONYM FLASK)
	(ADJECTIVE LARGE METAL DEWAR)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT OPENABLE)
	(SIZE 50)
	(CAPACITY 9)
	(CONTFCN FLASK-CONT)
	(ACTION FLASK-F)>

<ROUTINE FLASK-CONT (RARG)
	 <COND (<VERB? TAKE>
		<COND (<AND <IN? ,NITROGEN ,FLASK>
			    <NOT <PRSO? ,NITROGEN>>>
		       <REMOVE ,PRSO>
		       <TELL
"You manage to fish " THE ,PRSO " out without freezing your fingers
somehow, but it's frozen solid. It's also fragile. It
shatters into a million pieces, and is gone." CR>)>)>>

<ROUTINE FLASK-F ()
	 <COND (<PRSO? ,FLASK>
		<COND (<VERB? EXAMINE>
		       <TELL
S "This is a large ""metal flask, about the size of a water cooler bottle. ">
		       <COND (<FSET? ,FLASK ,OPENBIT>
			      <TELL
"The flask is open">
			      <COND (<IN? ,NITROGEN ,FLASK>
				     <TELL
", and a thin, cold mist flows out of it">)>
			      <TELL ,PERIOD>)
			     (ELSE
			      <TELL-OPEN-CLOSED ,FLASK>)>)
		      (<VERB? RUB>
		       <TELL
"The metal of the flask is ">
		       <COND (<IN? ,NITROGEN ,FLASK>
			      <TELL "very ">)>
		       <TELL "cold." CR>)
		      (<VERB? OPEN>
		       <COND (<NOT <FSET? ,FLASK ,OPENBIT>>
			      <FSET ,FLASK ,OPENBIT>
			      <TELL
"You open the flask">
			      <COND (<IN? ,NITROGEN ,FLASK>
				     <MOVE ,MIST ,HERE>
				     <QUEUE I-NITROGEN-GOES 3>
				     <TELL
", and a cold, white mist boils out">)>
			      <TELL ,PERIOD>)>)
		      (<VERB? CLOSE>
		       <COND (<FSET? ,FLASK ,OPENBIT>
			      <DEQUEUE I-NITROGEN-GOES>
			      <QUEUE I-MIST-GOES 2>
			      <FCLEAR ,FLASK ,OPENBIT>
			      <TELL
"You screw the flask closed." CR>)>)
		      (<VERB? FILL>
		       <CANT-FILL-IT>)
		      (<AND <VERB? POUR>
			    <IN? ,NITROGEN ,FLASK>>
		       <NEW-PRSO ,NITROGEN>
		       <RTRUE>)>)
	       (<AND <P? PUT * FLASK>
		     <G? <GETP ,PRSO ,P?SIZE>
			 <GETP ,FLASK ,P?CAPACITY>>>
		<TELL "The neck of " THE ,FLASK " is too small." CR>)>>

<OBJECT MIST
	(DESC "mist")
	(SYNONYM MIST GAS)
	(ADJECTIVE THIN COLD THICK BLACK)
	(ACTION MIST-F)>

<ROUTINE MIST-F ()
	 <COND (<NOT ,TIED-UP?>
		<COND (<VERB? EXAMINE>
		       <TELL
"The mist is boiling up ">
		       <COND (<IN? ,NITROGEN ,FLASK>
			      <TELL "out of the flask">)
			     (ELSE
			      <TELL "off of the ground">)>
		       <TELL ". It is thin, white, and cold." CR>)
		      (<VERB? RUB>
		       <TELL
"The mist is very cold." CR>)
		      (<VERB? SMELL>
		       <TELL
"The mist is odorless." CR>)>)>>

<ROUTINE I-MIST-GOES ("AUX" L)
	 <COND (<NOT <QUEUED? I-NITROGEN-GOES>>
		<SET L <LOC ,MIST>>
		<REMOVE ,MIST>
		<COND (<HERE? .L>
		       <TELL CR
"The mist dissipates." CR>)>)>>

<OBJECT NITROGEN
	(IN FLASK)
	(DESC "cold liquid")
	(SYNONYM NITROGEN LIQUID)
	(ADJECTIVE LIQUID THIN COLD)
	(FLAGS TAKEBIT WEAPONBIT)
	(ACTION NITROGEN-F)>

<ROUTINE NITROGEN-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The flask contains a clear, " 'NITROGEN " with a thin white mist
boiling off of it." CR>)
	       (<VERB? TAKE RUB>
		<TELL
"The liquid is extremely cold. In fact, you burn your finger on it." CR>)
	       (<VERB? SMELL>
		<TELL
"The liquid has no smell." CR>)
	       (<VERB? POUR PUT DROP THROW>
		<REMOVE ,NITROGEN>
		<DEQUEUE I-NITROGEN-GOES>
		<QUEUE I-MIST-GOES 2>
		<COND (<PRSI? ,FLASK>
		       <TELL ,GOOD-TRICK>)
		      (<AND ,PRSI
			    <FSET? ,PRSI ,PERSON>
			    <NOT <PRSI? ,ME ,HAND>>>
		       <SWAP-VERB ,V?ATTACK>
		       <RTRUE>)
		      (ELSE
		       <TELL
"The freezing liquid pours out">
		       <COND (,PRSI
			      <TELL " onto " THE ,PRSI>)>
		       <TELL ", boiling into cold mist almost immediately">
		       <COND (,PRSI
			      <COND (<OR <HELD? ,PRSI>
					 <INTRINSIC? ,PRSI>>
				     <JIGS-UP
", but not before it freezes you as well.">
				     <RFATAL>)
				    (<FSET? ,PRSI ,SLIMEBIT>
				     <FCLEAR ,PRSI ,SLIMEBIT>)
				    (<FSET? ,PRSI ,TAKEBIT>
				     <REMOVE ,PRSI>
				     <TELL
", but " THE ,PRSI " freezes and then shatters from the cold">)>)>
		       <TELL "." CR>)>)>>

<GLOBAL NITROGEN-CNT 5>

<ROUTINE I-NITROGEN-GOES ()
	 <COND (<IN? ,NITROGEN ,FLASK>
		<QUEUE I-NITROGEN-GOES 3>
		<SETG NITROGEN-CNT <- ,NITROGEN-CNT 1>>
		<COND (<ZERO? ,NITROGEN-CNT>
		       <DEQUEUE I-NITROGEN-GOES>
		       <QUEUE I-MIST-GOES 2>
		       <REMOVE ,NITROGEN>
		       <RFALSE>)
		      (ELSE
		       <COND (<ACCESSIBLE? ,FLASK>
			      <TELL CR
"Cold white mist continues to boil out of the flask." CR>)>)>)>>

<ROOM CS-ELEVATOR-ROOM
      (IN ROOMS)
      (DESC "Elevator")
      (OUT PER CS-ELEVATOR-EXIT)
      (NORTH PER CS-ELEVATOR-EXIT)
      (GLOBAL ELEVATOR GRAFFITI ;ELEVATOR-DOOR)
      (FLAGS ONBIT)
      (ACTION CS-ELEVATOR-ROOM-F)>

<ROUTINE CS-ELEVATOR-ROOM-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"This is a battered, rather dirty elevator. The fake wood walls are
scratched and marred with graffiti. ">
		<ELEVATOR-DOORS-OPEN-CLOSED ,ELEVATOR-DOOR>
		<TELL ,TO-THE-RIGHT "doors is an
area with " 'FLOOR-BUTTON "s (B and 1 through 3), an " 'OPEN-BUTTON ", a "
'CLOSE-BUTTON ", a " 'STOP-SWITCH ", and an " 'ALARM-BUTTON ".">
		<TELL-BUTTON 0 %<ASCII !\B>>
		<TELL-BUTTON 1 %<ASCII !\1>>
		<TELL-BUTTON 2 %<ASCII !\2>>
		<TELL-BUTTON 3 %<ASCII !\3>>
		<TELL
" Below these is an " 'ACCESS-PANEL " which is ">
		<OPEN-CLOSED ,ACCESS-PANEL>)
	       (<RARG? BEG>
		<COND (<VERB? DISEMBARK>
		       <DO-WALK ,P?NORTH>)>)>>

<GLOBAL TO-THE-RIGHT " To the right of the ">

<ROUTINE TELL-BUTTON (N C)
	 <COND (<BTST <GET ,BUTTONS .N> ,E-GO>
		<TELL " The \"">
		<PRINTC .C>
		<TELL "\" button is glowing.">)>>

<OBJECT ACCESS-PANEL
	(IN CS-ELEVATOR-ROOM)
	(DESC "access panel")
	(SYNONYM PANEL)
	(ADJECTIVE ACCESS)
	(CAPACITY 20)
	(FLAGS NDESCBIT AN CONTBIT SEARCHBIT OPENABLE)
	(ACTION ACCESS-PANEL-F)>

<ROUTINE ACCESS-PANEL-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<NOT <FSET? ,ACCESS-PANEL ,OPENBIT>>
		       <TELL
"This panel presumably opens to access the inner maintenance controls
of the elevator." CR>)
		      (ELSE
		       <TELL
"The panel conceals a small space which probably contained maintenance
controls for the elevator once, but these have been torn out by someone,
leaving a bare metal cavity. ">
		       <DESCRIBE-SENT ,ACCESS-PANEL>
		       <CRLF>)>)>>

<OBJECT FLASHLIGHT
	(IN ACCESS-PANEL)
	(DESC "flashlight")
	(SYNONYM FLASHLIGHT LIGHT LAMP)
	(ADJECTIVE FLASH)
	(FLAGS TAKEBIT LIGHTBIT)
	(ACTION FLASHLIGHT-F)>

<ROUTINE FLASHLIGHT-F ("AUX" OLIT)
	 <COND (<VERB? EXAMINE>
		<TELL
"The flashlight is a heavy-duty shop-style light.">
		<COND (<FSET? ,FLASHLIGHT ,ONBIT>
		       <TELL S " It is currently ""on.">)>
		<CRLF>)
	       (<VERB? LAMP-ON>
		<COND (<NOT <FSET? ,FLASHLIGHT ,LIGHTBIT>>
		       <TELL
,IT-SEEMS-TO-BE "burned out." CR>)
		      (<FSET? ,FLASHLIGHT ,ONBIT>
		       <TELL
"It is!" CR>)
		      (ELSE
		       <FSET ,FLASHLIGHT ,ONBIT>
		       <QUEUE I-FLASHLIGHT <GET ,FLASHLIGHT-TABLE 0>>
		       <TELL CTHE ,FLASHLIGHT " clicks on." CR>
		       <SET OLIT ,LIT>
		       <SETG LIT <LIT? ,HERE>>
		       <COND (<AND <NOT .OLIT> ,LIT>
			      <CRLF>
			      <V-LOOK>)>
		       <RTRUE>)>)
	       (<VERB? LAMP-OFF>
		<COND (<NOT <FSET? ,FLASHLIGHT ,ONBIT>>
		       <TELL
"It is!" CR>)
		      (ELSE
		       <FCLEAR ,FLASHLIGHT ,ONBIT>
		       <PUT ,FLASHLIGHT-TABLE 0 <DEQUEUE I-FLASHLIGHT>>
		       <TELL
CTHE ,FLASHLIGHT " clicks off">
		       <IN-DARK? T>)>)
	       (<VERB? OPEN>
		<TELL
"It doesn't open. It appears to be one of those rechargeable lights,
so you can't easily get at the battery." CR>)>>

<ROUTINE I-FLASHLIGHT ("AUX" (HERE? <>) OLIT)
	 <COND (<SET HERE? <EQUAL? <META-LOC ,FLASHLIGHT> ,HERE>>
		<TELL CR CTHE ,FLASHLIGHT <GET ,FLASHLIGHT-TABLE 1>>)>
	 <SETG FLASHLIGHT-TABLE <REST ,FLASHLIGHT-TABLE 4>>
	 <COND (<ZERO? <GET ,FLASHLIGHT-TABLE 0>>
		<FCLEAR ,FLASHLIGHT ,ONBIT>
		<FCLEAR ,FLASHLIGHT ,LIGHTBIT>
		<COND (.HERE?
		       <TELL CTHE ,FLASHLIGHT " has burned out">
		       <IN-DARK? T>)>)
	       (ELSE
		<QUEUE I-FLASHLIGHT <GET ,FLASHLIGHT-TABLE 0>>)>
	 <COND (.HERE? <CRLF>)>>

<GLOBAL FLASHLIGHT-TABLE
	<TABLE 200
	       " is a little dimmer now."
	       100
	       " is producing much less light."
	       50
	       " is very dim."
	       25
	       " is flickering."
	       5
	       " is practically out."
	       1
	       " fails."
	       0>>

<ROUTINE THIS-FLOOR-DOOR ()
	 <COND (<HERE? ,CS-BASEMENT ,ELEVATOR-PIT> ,ELEVATOR-DOOR-B)
	       (<HERE? ,COMP-CENTER> ,ELEVATOR-DOOR-1)
	       (<HERE? ,CS-2ND> ,ELEVATOR-DOOR-2)
	       (<HERE? ,CS-3RD> ,ELEVATOR-DOOR-3)>>

<ROUTINE DOOR-AT-ELEVATOR () 
	 <COND (<EQUAL? ,ELEVATOR-LOC 0> ,ELEVATOR-DOOR-B)
	       (<EQUAL? ,ELEVATOR-LOC 1> ,ELEVATOR-DOOR-1)
	       (<EQUAL? ,ELEVATOR-LOC 2> ,ELEVATOR-DOOR-2)
	       (ELSE ,ELEVATOR-DOOR-3)>>

<ROUTINE FLOOR-SHAFT ()
	 <COND (<HERE? ,CS-BASEMENT ,ELEVATOR-PIT> ,SHAFT-B)
	       (<HERE? ,COMP-CENTER> ,SHAFT-1)
	       (<HERE? ,CS-2ND> ,SHAFT-2)
	       (<HERE? ,CS-3RD> ,SHAFT-3)>>

<OBJECT OPEN-BUTTON
	(IN CS-ELEVATOR-ROOM)
	(DESC "open button")
	(SYNONYM BUTTON)
	(ADJECTIVE OPEN)
	(FLAGS NDESCBIT AN)
	(ACTION OPEN-BUTTON-F)>

<ROUTINE OPEN-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<COND (,ELEVATOR-STOPPED?
		       <QUEUE I-ELEVATOR-DOOR-CLOSES 2>
		       <COND (<FSET? ,ELEVATOR-DOOR ,OPENBIT>
			      <TELL "The doors stay open." CR>)
			     (ELSE
			      <FSET <DOOR-AT-ELEVATOR> ,OPENBIT>
			      <FSET ,ELEVATOR-DOOR ,OPENBIT>
			      <TELL "The doors spring open." CR>)>)
		      (ELSE
		       <TELL
,STILL-MOVING " " ,NOTHING-HAPPENS>)>)>>

<OBJECT CLOSE-BUTTON
	(IN CS-ELEVATOR-ROOM)
	(DESC "close button")
	(SYNONYM BUTTON)
	(ADJECTIVE CLOSE)
	(FLAGS NDESCBIT)
	(ACTION CLOSE-BUTTON-F)>

<ROUTINE CLOSE-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<COND (,ELEVATOR-STOPPED?
		       <COND (<FSET? ,ELEVATOR-DOOR ,OPENBIT>
			      <QUEUE I-ELEVATOR-DOOR-CLOSES 2>
			      <TELL "You push the button." CR>)
			     (ELSE
			      <TELL "The door is already closed." CR>)>)
		      (ELSE
		       <TELL
S "The elevator is ""moving, the door is closed." CR>)>)>>

<OBJECT FLOOR-BUTTON
	(IN CS-ELEVATOR-ROOM)
	(DESC "floor button")
	(SYNONYM BUTTON)
	(ADJECTIVE FLOOR INTNUM)
	(FLAGS NDESCBIT)
	(ACTION FLOOR-BUTTON-F)>

<OBJECT BASEMENT-BUTTON
	(IN CS-ELEVATOR-ROOM)
	(DESC "B button")
	(SYNONYM BUTTON)
	(ADJECTIVE B BASEMENT)
	(FLAGS NDESCBIT)
	(ACTION FLOOR-BUTTON-F)>

<ROUTINE FLOOR-BUTTON-F ("AUX" OLD)
	 <COND (<VERB? PUSH>
		<COND (<PRSO? ,BASEMENT-BUTTON>
		       <SETG P-NUMBER 0>)>
		<COND (<G? ,P-NUMBER 3>
		       <TELL
"There are only three floors and a basement in this building." CR>)
		      (<EQUAL? ,P-NUMBER ,ELEVATOR-LOC>
		       <COND (<HERE? ,CS-ELEVATOR-ROOM>
			      <TELL
"The button doesn't light." CR>)
			     (ELSE <RTRUE>)>)
		      (ELSE
		       <SET OLD <GET ,BUTTONS ,P-NUMBER>>
		       <COND (<NOT <BTST .OLD ,E-GO>>
			      <PUT ,BUTTONS ,P-NUMBER <BOR .OLD ,E-GO>>
			      <QUEUE I-ELEVATOR-MOVES 1>
			      <COND (,ELEVATOR-STOPPED?
				     <PICK-ELEVATOR-DIRECTION>)>
			      <COND (<HERE? ,CS-ELEVATOR-ROOM>
				     <TELL
"The button for the " <GET ,FLOOR-NAMES ,P-NUMBER> S " begins to glow.|">)
				    (ELSE <RTRUE>)>)
			     (ELSE
			      <COND (<HERE? ,CS-ELEVATOR-ROOM>
				     <TELL ,ALREADY-GLOWING>)
				    (ELSE <RTRUE>)>)>)>)>>

<GLOBAL FLOOR-NAMES
	<TABLE (PURE) "basement" "first floor" "second floor" "third floor">>

<ROUTINE ELEVATOR-HERE? ()
	 <COND (<HERE? ,CS-ELEVATOR-ROOM> <RTRUE>) 
	       (<AND <GETPT ,HERE ,P?FLOOR>
		     <EQUAL? <GETP ,HERE ,P?FLOOR> ,ELEVATOR-LOC>>
		<RTRUE>)
	       (ELSE <RFALSE>)>>

<ROUTINE ELEVATOR-WANTED? ()
	 <COND (<OR <NOT <ZERO? <GET ,BUTTONS 0>>>
		    <NOT <ZERO? <GET ,BUTTONS 1>>>
		    <NOT <ZERO? <GET ,BUTTONS 2>>>
		    <NOT <ZERO? <GET ,BUTTONS 3>>>>
		<QUEUE I-ELEVATOR-MOVES 1>)>>

<ROUTINE I-ELEVATOR-DOOR-OPENS ()
	 <QUEUE I-ELEVATOR-DOOR-CLOSES 2>
	 <COND (<NOT <FSET? ,ELEVATOR-DOOR ,OPENBIT>>
		<SETG ELEVATOR-STOPPED? 3>
		<FSET <DOOR-AT-ELEVATOR> ,OPENBIT>
		<FSET ,ELEVATOR-DOOR ,OPENBIT>
		<COND (<ELEVATOR-HERE?>
		       <TELL CR CTHE ,ELEVATOR-DOOR " slide open." CR>)>)>>

"called when door closes on its own"

<ROUTINE CHAIN-IN-DOOR? ()
	 <COND (<AND ,CHAIN-HOOKED?
		     <EQUAL? <META-LOC ,HOOK> ,HERE>
		     <OR <HELD? ,CHAIN>
			 <IN? ,CHAIN ,HERE>>>
		,CHAIN)>>

"called when door closes on its own"

<ROUTINE I-ELEVATOR-DOOR-CLOSES ("AUX" W)
	 <COND (<NOT <FSET? ,ELEVATOR-DOOR ,OPENBIT>>
		<RFALSE>)
	       (<OR <SET W <FIRST? <DOOR-AT-ELEVATOR>>>
		    ,HOLDING-DOORS?
		    <SET W <CHAIN-IN-DOOR?>>>
		<QUEUE I-ELEVATOR-DOOR-CLOSES 2>
		<COND (<ELEVATOR-HERE?>
		       <TELL CR
CTHE ,ELEVATOR-DOOR " bounce against ">
		       <COND (.W <TELL THE .W>)
			     (ELSE <TELL "your body">)>
		       <TELL ", trying to close." CR>)>)
	       (ELSE
		<ELEVATOR-WANTED?>
		<FCLEAR ,ELEVATOR-DOOR ,OPENBIT>
		<FCLEAR <DOOR-AT-ELEVATOR> ,OPENBIT>
		<COND (<ELEVATOR-HERE?>
		       <TELL CR CTHE ,ELEVATOR-DOOR " slide closed." CR>)>)>>

"called when door released after being held open by person or object"

<ROUTINE CLOSE-ELEVATOR-DOOR (DOOR)
	 <SETG HOLDING-DOORS? <>>
	 <SETG ELEVATOR-STOPPED? 1>
	 <ELEVATOR-WANTED?>
	 <FCLEAR .DOOR ,OPENBIT>
	 <COND (<ELEVATOR-HERE?>
		<FCLEAR ,ELEVATOR-DOOR ,OPENBIT>)
	       (ELSE
		<REMOVE <FLOOR-SHAFT>>)>>

<ROUTINE PICK-ELEVATOR-DIRECTION ("AUX" ZERO ONE TWO THREE)
	 <COND (<EQUAL? ,ELEVATOR-LOC 0>
		<SETG ELEVATOR-DIRECTION 1>)
	       (<EQUAL? ,ELEVATOR-LOC 3>
		<SETG ELEVATOR-DIRECTION -1>)
	       (ELSE
		<SET ZERO <GET ,BUTTONS 0>>
		<SET ONE <GET ,BUTTONS 1>>
		<SET TWO <GET ,BUTTONS 2>>
		<SET THREE <GET ,BUTTONS 3>>
		<COND (<EQUAL? ,ELEVATOR-DIRECTION -1>
		       <COND (<EQUAL? ,ELEVATOR-LOC 1>
			      <COND (<ZERO? .ZERO>
				     <SETG ELEVATOR-DIRECTION 1>)>)
			     (<EQUAL? ,ELEVATOR-LOC 2>
			      <COND (<AND <ZERO? .ZERO>
					  <ZERO? .ONE>>
				     <SETG ELEVATOR-DIRECTION 1>)>)>)
		      (<EQUAL? ,ELEVATOR-DIRECTION 1>
		       <COND (<EQUAL? ,ELEVATOR-LOC 2>
			      <COND (<ZERO? .THREE>
				     <SETG ELEVATOR-DIRECTION -1>)>)
			     (<EQUAL? ,ELEVATOR-LOC 1>
			      <COND (<AND <ZERO? .TWO>
					  <ZERO? .THREE>>
				     <SETG ELEVATOR-DIRECTION -1>)>)>)>)>>

"T if elevator called from another floor than current one"

<ROUTINE ELEVATOR-CALLED? ()
	 <COND (<AND <NOT <ZERO? <GET ,BUTTONS 0>>>
		     <NOT <ZERO? ,ELEVATOR-LOC>>>
		<RTRUE>)
	       (<AND <NOT <ZERO? <GET ,BUTTONS 1>>>
		     <NOT <EQUAL? ,ELEVATOR-LOC 1>>>
		<RTRUE>)
	       (<AND <NOT <ZERO? <GET ,BUTTONS 2>>>
		     <NOT <EQUAL? ,ELEVATOR-LOC 2>>>
		<RTRUE>)
	       (<AND <NOT <ZERO? <GET ,BUTTONS 3>>>
		     <NOT <EQUAL? ,ELEVATOR-LOC 3>>>
		<RTRUE>)>>

<ROUTINE NO-HIGHER-UP-CALLS? ("AUX" (ZERO <GET ,BUTTONS 0>)
			      (ONE <GET ,BUTTONS 1>) (TWO <GET ,BUTTONS 2>)
			      (THREE <GET ,BUTTONS 3>))
	 <COND (<ZERO? ,ELEVATOR-LOC>
		<COND (<OR <BTST .ONE <+ ,E-UP ,E-GO>>
			   <BTST .TWO <+ ,E-UP ,E-GO>>
			   <BTST .THREE <+ ,E-UP ,E-GO>>>
		       <RFALSE>)
		      (ELSE <RTRUE>)>)
	       (<EQUAL? ,ELEVATOR-LOC 1>
		<COND (<OR <BTST .TWO <+ ,E-UP ,E-GO>>
			   <BTST .THREE <+ ,E-UP ,E-GO>>>
		       <RFALSE>)
		      (ELSE <RTRUE>)>)
	       (<EQUAL? ,ELEVATOR-LOC 2>
		<COND (<BTST .THREE <+ ,E-UP ,E-GO>>
		       <RFALSE>)
		      (ELSE <RTRUE>)>)
	       (<EQUAL? ,ELEVATOR-LOC 3>
		<RTRUE>)>>

<ROUTINE NO-LOWER-DOWN-CALLS? ("AUX" (ZERO <GET ,BUTTONS 0>)
			      (ONE <GET ,BUTTONS 1>) (TWO <GET ,BUTTONS 2>)
			      (THREE <GET ,BUTTONS 3>))
	 <COND (<ZERO? ,ELEVATOR-LOC>
		<RTRUE>)
	       (<EQUAL? ,ELEVATOR-LOC 1>
		<COND (<BTST .ZERO <+ ,E-DOWN ,E-GO>>
		       <RFALSE>)
		      (ELSE <RTRUE>)>)
	       (<EQUAL? ,ELEVATOR-LOC 2>
		<COND (<OR <BTST .ZERO <+ ,E-DOWN ,E-GO>>
			   <BTST .ONE <+ ,E-DOWN ,E-GO>>>
		       <RFALSE>)
		      (ELSE <RTRUE>)>)
	       (<EQUAL? ,ELEVATOR-LOC 3>
		<COND (<OR <BTST .ZERO <+ ,E-DOWN ,E-GO>>
			   <BTST .ONE <+ ,E-DOWN ,E-GO>>
			   <BTST .TWO <+ ,E-DOWN ,E-GO>>>
		       <RFALSE>)
		      (ELSE <RTRUE>)>
		<RTRUE>)>>

<GLOBAL BRICK-WALL-SCORE 5>

<ROUTINE I-ELEVATOR-MOVES ("AUX" OLD STOPPING?)
	 <QUEUE I-ELEVATOR-MOVES 1>
	 <COND (<OR <FSET? ,ELEVATOR-DOOR ,OPENBIT>
		    <FSET? ,ELEVATOR-DOOR-B ,OPENBIT>
		    <FSET? ,ELEVATOR-DOOR-1 ,OPENBIT>
		    <FSET? ,ELEVATOR-DOOR-2 ,OPENBIT>
		    <FSET? ,ELEVATOR-DOOR-3 ,OPENBIT>>
		<RFALSE>)>
	 <COND (<AND ,ELEVATOR-STOPPED?
		     <ELEVATOR-CALLED?>>
		<SETG ELEVATOR-STOPPED? <- ,ELEVATOR-STOPPED? 1>>
		<COND (<ZERO? ,ELEVATOR-STOPPED?>
		       <COND (<OR <HERE? ,ELEVATOR-PIT>
				  <AND <HERE? ,STEAM-TUNNEL-EAST>
				       <EQUAL? ,BRICK-FLAG ,BF-BOTH>>>
			      <TELL CR
"A loud mechanical whining ">
			      <COND (<HERE? ,ELEVATOR-PIT>
				     <TELL
"begins above you." CR>)
				    (ELSE
				     <TELL
"is audible through the hole." CR>)>)
			     (<HERE? ,CS-ELEVATOR-ROOM>
			      <TELL CR
"The elevator begins to move " <COND (<G? ,ELEVATOR-DIRECTION 0> "upward")
				     (ELSE "downward")> ,PERIOD>)
			     (<GETPT ,HERE ,P?FLOOR>
			      <TELL CR
"You hear the elevator begin moving." CR>)>)>)
	       (ELSE
		<COND (<OR <AND <ZERO? ,ELEVATOR-LOC>
				<L? ,ELEVATOR-DIRECTION 0>>
			   <AND <EQUAL? ,ELEVATOR-LOC 3>
				<G? ,ELEVATOR-DIRECTION 0>>>
		       ;<TELL
"** Elevator confused at " N ,ELEVATOR-LOC " **" CR>
		       <PICK-ELEVATOR-DIRECTION>)
		      (ELSE
		       <SETG ELEVATOR-LOC
			     <+ ,ELEVATOR-LOC ,ELEVATOR-DIRECTION>>
		       <COND (<ZERO? ,ELEVATOR-LOC>
			      <MOVE ,ELEVATOR-CEILING ,SHAFT-1>
			      <FSET ,ELEVATOR-FLOOR ,NDESCBIT>
			      <MOVE ,ELEVATOR-FLOOR ,ELEVATOR-PIT>)
			     (<EQUAL? ,ELEVATOR-LOC 1>
			      <MOVE ,ELEVATOR-CEILING ,SHAFT-2>
			      <MOVE ,ELEVATOR-FLOOR ,SHAFT-B>
			      <COND (<EQUAL? ,CHAIN-HOOKED? ,HOOK>
				     <MOVE ,CHAIN ,ELEVATOR-PIT>
				     <COND (<HERE? ,ELEVATOR-PIT>
					    <TELL CR
"A greasy chain descends out of the shaft into a pile at your feet." CR>)>)>)
			     (<EQUAL? ,ELEVATOR-LOC 2>
			      <MOVE ,ELEVATOR-CEILING ,SHAFT-3>
			      <MOVE ,ELEVATOR-FLOOR ,SHAFT-1>
			      <COND (<AND ,CHAIN-LOOPED? ,CHAIN-HOOKED?>
				     <FSET ,CHAIN-2 ,INVISIBLE>
				     ;<REMOVE ,CHAIN-2>
				     <SETG CHAIN-LOOPED? <>>
				     <COND (<FSET? ,CHAIN-2 ,LOCKED>
					    <FCLEAR ,ELEVATOR-PIT ,TOUCHBIT>
					    <REMOVE ,ROD>
					    <REMOVE ,PADLOCK>
					    <FCLEAR ,CHAIN-2 ,LOCKED>
					    <SETG PADLOCK-ON? <>>
					    <SETG BRICK-WALL-FLAG T>
					    <SETG SCORE
						  <+ ,SCORE ,BRICK-WALL-SCORE>>
					    <SETG BRICK-WALL-SCORE 0>
					    <COND (<HEAR-CHAIN?>
						   <CHAIN-NOISES>
						   <TELL
"tearing, rending sound, then a rumbling
crash." CR>)
						  (<HERE? ,ELEVATOR-PIT>
						   <TELL CR
"The length of chain grows taut, pulling at the rod.
Suddenly, the bricks give up, and a steel reinforcing rod pulls free
of the shattered wall. It flies across the room, impaling you with
uncanny precision." CR>
						   <JIGS-UP>)>)
					   (ELSE
					    <COND (<HEAR-CHAIN?>
						   <CHAIN-NOISES>
						   <TELL
"metallic sliding sound, then silence." CR>)
						  (<HERE? ,ELEVATOR-PIT>
						   <TELL CR
"The chain slides off the rod and away into the air." CR>)>)>)
				    (,CHAIN-HOOKED?
				     <COND (<IN? ,CHAIN ,WINNER>
					    <REMOVE ,CHAIN>
					    <TELL CR
"Suddenly, the chain is torn from your grasp!" CR>)
					   (<IN? ,CHAIN ,ELEVATOR-PIT>
					    <REMOVE ,CHAIN>)>)>)
			     (<EQUAL? ,ELEVATOR-LOC 3>
			      <REMOVE ,ELEVATOR-CEILING>
			      <MOVE ,ELEVATOR-FLOOR ,SHAFT-2>)>)>
		<SET OLD <GET ,BUTTONS ,ELEVATOR-LOC>>
		<COND (<G? ,ELEVATOR-DIRECTION 0>
		       <COND (<BTST .OLD ,E-UP>
			      <SET STOPPING? ,UP-BUTTON>)
			     (<AND <BTST .OLD ,E-DOWN>
				   <NO-HIGHER-UP-CALLS?>>
			      <PICK-ELEVATOR-DIRECTION>
			      <SET STOPPING? ,DOWN-BUTTON>)>)
		      (<L? ,ELEVATOR-DIRECTION 0>
		       <COND (<BTST .OLD ,E-DOWN>
			      <SET STOPPING? ,DOWN-BUTTON>)
			     (<AND <BTST .OLD ,E-UP>
				   <NO-LOWER-DOWN-CALLS?>>
			      <PICK-ELEVATOR-DIRECTION>
			      <SET STOPPING? ,UP-BUTTON>)>)>
		<COND (<OR .STOPPING? <BTST .OLD ,E-GO>>
		       <COND (<NOT .STOPPING?>
			      <COND (<OR <AND <G? ,ELEVATOR-DIRECTION 0>
					      <NO-HIGHER-UP-CALLS?>>
					 <AND <L? ,ELEVATOR-DIRECTION 0>
					      <NO-LOWER-DOWN-CALLS?>>>
				     <PICK-ELEVATOR-DIRECTION>)>)>
		       <PUT ,BUTTONS
			    ,ELEVATOR-LOC
			    <COND (<EQUAL? .STOPPING? ,UP-BUTTON>
				   <BAND .OLD ,E-DOWN>)
				  (<EQUAL? .STOPPING? ,DOWN-BUTTON>
				   <BAND .OLD ,E-UP>)
				  (ELSE 0)>>
		       <DEQUEUE I-ELEVATOR-MOVES>
		       <SETG ELEVATOR-STOPPED? 3>
		       <QUEUE I-ELEVATOR-DOOR-OPENS 1>
		       <COND (<HERE? ,ELEVATOR-PIT>
			      <COND (<ZERO? ,ELEVATOR-LOC>
				     <JIGS-UP
"The machinery stops. Unfortunately, before doing so it squashed you
into the concrete floor. Yuck!">
				     <RFATAL>)
				    (ELSE
				     <TELL CR
"The noise stops." CR>)>)
			     (<AND <HERE? ,STEAM-TUNNEL-EAST>
				   <EQUAL? ,BRICK-FLAG ,BF-BOTH>>
			      <TELL CR
S "The whining noise ""in the hole stops." CR>)
			     (<HERE? ,CS-ELEVATOR-ROOM>
			      <TELL CR
"The elevator slows and comes to a stop.">
			      <COND (<BTST .OLD ,E-GO>
				     <TELL
" The button for the " <GET ,FLOOR-NAMES ,ELEVATOR-LOC> " blinks off.">)>
			      <CRLF>)
			     (<AND <EQUAL? .STOPPING? ,UP-BUTTON ,DOWN-BUTTON>
				   <NOT <HERE? ,CS-ELEVATOR-ROOM>>
				   <ELEVATOR-HERE?>>
			      <TELL CR
CTHE .STOPPING? " blinks off." CR>)
			     (<GETPT ,HERE ,P?FLOOR>
			      <TELL CR
"You no longer" ,HEAR-THE-ELEVATOR>)>)
		      (<NOT ,ELEVATOR-STOPPED?>
		       <COND (<HERE? ELEVATOR-PIT>
			      <TELL CR
S "The whining noise ""is moving ">
			      <COND (<G? ,ELEVATOR-DIRECTION 0>
				     <TELL "away from you">)
				    (ELSE
				     <TELL "closer to you">
				     <COND (<EQUAL? ,ELEVATOR-LOC 1>
					    <TELL
". In fact, it's very close. It must be just above your head">)>)>
			      <TELL ,PERIOD>)
			     (<AND <HERE? STEAM-TUNNEL-EAST>
				   <EQUAL? ,BRICK-FLAG ,BF-BOTH>>
			      <TELL CR
S "The whining noise ""from the hole is getting "
			      <COND (<G? ,ELEVATOR-DIRECTION 0>
				     "softer")
				    (ELSE "louder")> ,PERIOD>)
			     (<HERE? CS-ELEVATOR-ROOM>
			      <TELL CR
"The elevator continues to move " <COND (<G? ,ELEVATOR-DIRECTION 0> "upward")
					(ELSE "downward")> ,PERIOD>)
			     (<GETPT ,HERE ,P?FLOOR>
			      <TELL CR
"You" ,HEAR-THE-ELEVATOR>)>)>)>>

<GLOBAL HEAR-THE-ELEVATOR " hear the elevator moving.|">

<ROUTINE HEAR-CHAIN? ()
	 <COND (<ELEVATOR-HERE?> <RTRUE>)
	       (<HERE? ,CS-BASEMENT
		    ,COMP-CENTER
		    ,CS-2ND
		    ,CS-3RD
		    ,STEAM-TUNNEL
		    ,STEAM-TUNNEL-EAST>
		<RTRUE>)>>

<ROUTINE CHAIN-NOISES ()
	 <TELL CR "From ">
	 <COND (<HERE? ,STEAM-TUNNEL
		       ,STEAM-TUNNEL-EAST>
		<TELL "the pit">)
	       (ELSE <TELL "below">)>
	 <TELL ", you hear a ">>

<OBJECT ALARM-BUTTON
	(IN CS-ELEVATOR-ROOM)
	(DESC "alarm button")
	(SYNONYM BUTTON)
	(ADJECTIVE ALARM)
	(FLAGS NDESCBIT AN)
	(ACTION ALARM-BUTTON-F)>

<ROUTINE ALARM-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<TELL
"For as long as you hold the button down, an ear-splitting alarm bell
rings." CR>)>>

<OBJECT STOP-SWITCH
	(IN CS-ELEVATOR-ROOM)
	(DESC "stop switch")
	(SYNONYM SWITCH)
	(ADJECTIVE STOP)
	(FLAGS NDESCBIT)
	(ACTION STOP-SWITCH-F)>

<ROUTINE STOP-SWITCH-F ()
	 <COND (<VERB? TURN LAMP-ON LAMP-OFF>
		<TELL
"You flip the switch, but" ,LC-NOTHING-HAPPENS CR>)>>

<GLOBAL LC-NOTHING-HAPPENS " nothing happens.">

<OBJECT ELEVATOR
	(IN LOCAL-GLOBALS)
	(DESC "elevator")
	(SYNONYM ELEVATOR)
	(FLAGS AN VEHBIT)
	(ACTION ELEVATOR-F)>

<ROUTINE ELEVATOR-F ("AUX" DOOR)
	 <COND (<VERB? EXAMINE>
		<COND (<HERE? ,CS-ELEVATOR-ROOM>
		       <PERFORM ,V?LOOK>
		       <RTRUE>)
		      (ELSE
		       <TELL
"You aren't in it." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<FSET? <SET DOOR <DOOR-AT-ELEVATOR>> ,OPENBIT>
		       <TELL
"There is an elevator there, unsurprisingly." CR>)
		      (ELSE
		       <TELL-OPEN-CLOSED .DOOR>)>)
	       (<P? (THROUGH BOARD) ELEVATOR>
		<COND (<HERE? ,CS-ELEVATOR-ROOM>
		       <TELL ,ALREADY-IN-IT CR>)
		      (ELSE <DO-WALK ,P?SOUTH>)>)
	       (<VERB? SAY>
		<COND (<HERE? ,CS-ELEVATOR-ROOM>
		       <TELL ,YOURE-IN-IT>)
		      (ELSE
		<TELL
"You'll to press one of the call buttons (up or down)." CR>)>)
	       (<P? (PUT THROW) * ELEVATOR>
		<COND (<HERE? ,CS-ELEVATOR-ROOM>
		       <TELL ,YOURE-IN-IT>)
		      (<FSET? ,ELEVATOR-DOOR ,OPENBIT>
		       <MOVE ,PRSO ,CS-ELEVATOR-ROOM>
		       <TELL "Thrown." CR>)>)
	       (<VERB? OPEN>
		<NEW-PRSO <COND (<HERE? ,CS-ELEVATOR-ROOM> ,ELEVATOR-DOOR)
				(ELSE <THIS-FLOOR-DOOR>)>>
		<RTRUE>)>>

<OBJECT ELEVATOR-DOOR
	(IN CS-ELEVATOR-ROOM)
	(DESC "elevator doors")
	(SYNONYM DOOR DOORS)
	(ADJECTIVE ELEVATOR)
	(FLAGS NDESCBIT AN DOORBIT OPENABLE)
	(ACTION ELEVATOR-DOOR-F)>

<ROUTINE ELEVATOR-DOOR-F ()
	 <COND (<VERB? OPEN>
		<PERFORM ,V?PUSH ,OPEN-BUTTON>
		<RTRUE>)
	       (<VERB? CLOSE>
		<PERFORM ,V?PUSH ,CLOSE-BUTTON>
		<RTRUE>)
	       (<VERB? THROUGH>
		<DO-WALK ,P?NORTH>
		<RTRUE>)
	       (ELSE
		<COND (<EQUAL? ,ELEVATOR-LOC 0>
		       <REDIRECT ,ELEVATOR-DOOR ,ELEVATOR-DOOR-B>)
		      (<EQUAL? ,ELEVATOR-LOC 1>
		       <REDIRECT ,ELEVATOR-DOOR ,ELEVATOR-DOOR-1>)
		      (<EQUAL? ,ELEVATOR-LOC 2>
		       <REDIRECT ,ELEVATOR-DOOR ,ELEVATOR-DOOR-2>)
		      (<EQUAL? ,ELEVATOR-LOC 3>
		       <REDIRECT ,ELEVATOR-DOOR ,ELEVATOR-DOOR-3>)>)>>

<OBJECT ELEVATOR-DOOR-B
	(IN CS-BASEMENT ;LOCAL-GLOBALS)
	(DESC "elevator doors")
	(SYNONYM DOOR DOORS)
	(ADJECTIVE ELEVATOR)
	(FLAGS SEARCHBIT AN CONTBIT DOORBIT OPENABLE)
	(CONTFCN ELEVATOR-DOOR-CONT)
	(DESCFCN ELEVATOR-DOORS-DESC)
	(ACTION ELEVATOR-DOORS-F)>

<OBJECT ELEVATOR-DOOR-1
	(IN COMP-CENTER ;LOCAL-GLOBALS)
	(DESC "elevator doors")
	(SYNONYM DOOR DOORS)
	(ADJECTIVE ELEVATOR)
	(FLAGS SEARCHBIT AN CONTBIT DOORBIT OPENABLE)
	(CONTFCN ELEVATOR-DOOR-CONT)
	(DESCFCN ELEVATOR-DOORS-DESC)
	(ACTION ELEVATOR-DOORS-F)>

<OBJECT ELEVATOR-DOOR-2
	(IN CS-2ND ;LOCAL-GLOBALS)
	(DESC "elevator doors")
	(SYNONYM DOOR DOORS)
	(ADJECTIVE ELEVATOR)
	(FLAGS SEARCHBIT AN CONTBIT DOORBIT OPENABLE)
	(CONTFCN ELEVATOR-DOOR-CONT)
	(DESCFCN ELEVATOR-DOORS-DESC)
	(ACTION ELEVATOR-DOORS-F)>

<OBJECT ELEVATOR-DOOR-3
	(IN CS-3RD ;LOCAL-GLOBALS)
	(DESC "elevator doors")
	(SYNONYM DOOR DOORS)
	(ADJECTIVE ELEVATOR)
	(FLAGS SEARCHBIT AN CONTBIT DOORBIT OPENABLE)
	(CONTFCN ELEVATOR-DOOR-CONT)
	(DESCFCN ELEVATOR-DOORS-DESC)
	(ACTION ELEVATOR-DOORS-F)>

<ROUTINE ELEVATOR-DOORS-DESC (RARG DOOR)
	 <COND (<RARG? OBJDESC?>
		<COND (<FSET? .DOOR ,OPENBIT> <RTRUE>)
		      (ELSE <RFATAL>)>)
	       (ELSE
		<BUTTON-GLOWING ,UP-BUTTON ,E-UP>
		<BUTTON-GLOWING ,DOWN-BUTTON ,E-DOWN>
		<ELEVATOR-DOORS-OPEN-CLOSED .DOOR>)>>

<ROUTINE BUTTON-GLOWING (OBJ BIT
			 "AUX" (F <GETP ,HERE ,P?FLOOR>))
	 <COND (<AND <GLOBAL-IN? .OBJ ,HERE>
		     <BTST <GET ,BUTTONS .F> .BIT>>
		<TELL CTHE .OBJ " is glowing. ">)>>

<ROUTINE ELEVATOR-DOORS-OPEN-CLOSED (DOOR "AUX" H?)
	 <TELL CTHE ,ELEVATOR-DOOR " are ">
	 <COND (<FSET? .DOOR ,OPENBIT>
		<COND (<FIRST? .DOOR>
		       <TELL
"wedged open with " A <FIRST? .DOOR> ", revealing ">
		       <COND (<SET H? <ELEVATOR-HERE?>>
			      <TELL "the elevator">)
			     (ELSE <TELL "a dim " 'SHAFT-B>)>
		       <TELL " beyond.">
		       <COND (<NOT .H?>
			      <CRLF>
			      <CRLF>
			      <SHAFT-DESC>)>)
		      (ELSE
		       <TELL "open.">)>)
	       (ELSE <TELL "closed.">)>>

<ROUTINE ELEVATOR-DOOR-CONT (RARG "AUX" L)
	 <COND (<VERB? TAKE>
		<SET L <LOC ,PRSO>>
		<COND (<EQUAL? <ITAKE> T>
		       <REMOVE-WEDGER ,PRSO .L>
		       <RTRUE>)
		      (ELSE <RTRUE>)>)>>

<ROUTINE OPEN-ELEVATOR-DOOR ()
	 <FSET ,PRSO ,OPENBIT>
	 <COND (<ELEVATOR-HERE?>
		<FSET ,ELEVATOR-DOOR ,OPENBIT>)
	       (ELSE
		<COND (<HERE? ,ELEVATOR-PIT>
		       <MOVE ,SHAFT-B ,CS-BASEMENT>)
		      (ELSE
		       <MOVE <FLOOR-SHAFT> ,HERE>)>)>>

<ROUTINE REMOVE-WEDGER (WEDGER DOOR)
	 <FCLEAR .WEDGER ,NDESCBIT>
	 <CLOSE-ELEVATOR-DOOR .DOOR>
	 <COND (<VERB? TAKE>
		<TELL "You take ">)
	       (ELSE <TELL "You pull ">)>
	 <TELL THE .WEDGER " away, and the doors spring shut">
	 <IN-DARK?>>

<GLOBAL HOLDING-DOORS? <>>

<ROUTINE RELEASE-ELEVATOR-DOORS (D)
	 <COND (,HOLDING-DOORS?
		<CLOSE-ELEVATOR-DOOR .D>
		<TELL
S "You release the ""doors, which spring shut">
		<IN-DARK?>
		<RTRUE>)>>

"called when releasing doors because player moved"

<ROUTINE MOVE-FROM-DOORS ("AUX" (D <THIS-FLOOR-DOOR>) H)
	 <SET H <RELEASE-ELEVATOR-DOORS .D>>
	 <COND (<END-OF-CHAIN? .H>)
	       (ELSE <RFALSE>)>>

<ROUTINE END-OF-CHAIN? ("OPT" (H <>))
	 <COND (<AND <HELD? ,CHAIN>
		     <OR ,CHAIN-LOOPED? ,CHAIN-HOOKED?>>
		<COND (.H <CRLF>)>
		<TELL S
"You reach the end of your chain pretty quickly.|">)>>

<ROUTINE ALREADY-WEDGED () 
	 <TELL
"It's already wedged open with " A <FIRST? ,PRSO> ,PERIOD>>

<ROUTINE NOT-WHILE-MOVING? ()
	 <COND (<AND <QUEUED? I-ELEVATOR-MOVES>
		     <NOT ,ELEVATOR-STOPPED?>>
		<TELL
"Not while the elevator is moving!" CR>)>>

<ROUTINE FORCE-DOORS ()
	 <TELL
"You force the ">
	 <COND (<HERE? ,ELEVATOR-PIT> <TELL "plates">)
	       (ELSE <TELL "doors">)>
	 <TELL " apart with ">
	 <COND (<PRSI? <> ,HANDS>
		<TELL "your hands">)
	       (ELSE
		<TELL THE ,PRSI>)>>

<ROUTINE ELEVATOR-DOORS-F ("AUX" (TMP <>) AUTO (EH? <ELEVATOR-HERE?>))
	 <COND (<VERB? EXAMINE>
		<COND (<HERE? ,ELEVATOR-PIT>
		       <TELL
"You are looking at the inside of an">
		       <COND (<FSET? ,ELEVATOR-DOOR-B ,OPENBIT>
			      <TELL " open">)>
		       <TELL " elevator door">
		       <COND (<FIRST? ,PRSO>
			      <TELL
". It's held open by " A <FIRST? ,PRSO>>)>
		       <TELL ,PERIOD>)
		      (ELSE
		       <ELEVATOR-DOORS-OPEN-CLOSED ,PRSO>
		       <CRLF>)>)
	       (<VERB? CLOSE RELEASE>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <COND (.EH?
			      <TELL
"The elevator usually does that itself." CR>)
			     (<SET TMP <FIRST? ,PRSO>>
			      <MOVE .TMP ,HERE>
			      <REMOVE-WEDGER .TMP ,PRSO>
			      <RTRUE>)
			     (ELSE
			      <RELEASE-ELEVATOR-DOORS ,PRSO>)>)
		      (ELSE
		       <TELL "They're closed already." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "You can see the ">
		       <COND (<HERE? ,ELEVATOR-PIT>
			      <TELL
"basement of the " 'COMP-CENTER "." CR>)
			     (.EH?
			      <TELL ,THE-INTERIOR ,PERIOD>)
			     (ELSE
			      <TELL
'SHAFT-B ". ">
			      <PERFORM-PRSA <FLOOR-SHAFT>>
			      <RTRUE>)>)
		      (ELSE
		       <TELL
"They're closed, opaque, and otherwise non-transparent." CR>)>)
	       (<VERB? THROUGH>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<P? PUT * (ELEVATOR-DOOR-B
			   ELEVATOR-DOOR-1
			   ELEVATOR-DOOR-2
			   ELEVATOR-DOOR-3)>
		<COND (<FIRST? ,PRSI>
		       <TELL
CTHE <FIRST? ,PRSI> " is already holding it open." CR>)
		      (<FSET? ,PRSI ,OPENBIT>
		       <SWAP-VERB ,V?WEDGE>
		       <RTRUE>)
		      (ELSE
		       <TELL
,YOU-CANT "until it's open." CR>)>)
	       (<VERB? OPEN PRY>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <COND (<FIRST? ,PRSO>
			      <ALREADY-WEDGED>)
			     (,HOLDING-DOORS?
			      <TELL ,HOLDING-IS-ALL " It's not easy." CR>)
			     (.EH?
			      <ALREADY-OPEN>)>)
		      (.EH?
		       <COND (<HERE? ,CS-ELEVATOR-ROOM>
			      <TELL
"You are in the elevator">)
			     (ELSE
			      <TELL
S "The elevator is ""here">)>
		       <TELL
", so the doors will open when you press ">
		       <COND (<HERE? ,CS-ELEVATOR-ROOM>
			      <TELL THE ,OPEN-BUTTON "." CR>)
			     (ELSE
			      <TELL "a call button." CR>)>)
		      (<PRSI? <> ,HANDS ,CROWBAR
			      ,AXE ,BOLT-CUTTER ,KNIFE>
		       <COND (<NOT-WHILE-MOVING?> <RTRUE>)>
		       <SETG HOLDING-DOORS? T>
		       <OPEN-ELEVATOR-DOOR>
		       <FORCE-DOORS>
		       <TELL ", barely able to hold them open. Beyond you
see ">
		       <COND (<HERE? ,ELEVATOR-PIT>
			      <TELL
"the basement." CR>)
			     (ELSE
			      <COND (<HERE? ,CS-BASEMENT>
				     <TELL
"the bottom of the " 'SHAFT-B " only a few feet below. ">)
				    (ELSE
				     <TELL
"the " 'SHAFT-B ". ">)>
			      <SHAFT-DESC>
			      <CRLF>
			      <RTRUE>)>)
		      (ELSE
		       <WITH-PRSI?>)>)
	       (<P? PUT-BETWEEN * (ELEVATOR-DOOR-B
				   ELEVATOR-DOOR-1
				   ELEVATOR-DOOR-2
				   ELEVATOR-DOOR-3)>
		<SWAP-VERB ,V?WEDGE>
		<RTRUE>)
	       (<P? WEDGE (ELEVATOR-DOOR-B
			   ELEVATOR-DOOR-1
			   ELEVATOR-DOOR-2
			   ELEVATOR-DOOR-3)>
		<COND (<PRSO? ,PRSI>
		       <TELL-YUKS>
		       <RTRUE>)
		      (<FIRST? ,PRSO>
		       <ALREADY-WEDGED>
		       <RTRUE>)>
		<COND (<NOT-WHILE-MOVING?>
		       <RTRUE>)
		      (<NOT <FSET? ,PRSO ,OPENBIT>>
		       <FORCE-DOORS>
		       <TELL ", revealing ">
		       <COND (<OR <HERE? ,ELEVATOR-PIT>
				  <AND <HERE? ,CS-ELEVATOR-ROOM>
				       <EQUAL? ,ELEVATOR-LOC 0>>>
			      <TELL
"the basement of the " 'COMP-CENTER ". ">)
			     (<HERE? ,CS-ELEVATOR-ROOM>
			      <COND (<EQUAL? ,ELEVATOR-LOC 1>
				     <TELL "a lobby." CR>)
				    (ELSE
				     <TELL
"a corridor." CR>)>)
			     (<NOT .EH?>
			      <SET TMP T>
			      <TELL
"a dark " 'SHAFT-B ". ">)
			     (ELSE
			      <TELL ,THE-INTERIOR ". ">)>)>
		<COND (<EQUAL? ,PRSI ,CROWBAR ,BOLT-CUTTER ,AXE>
		       <OPEN-ELEVATOR-DOOR>
		       <FSET ,PRSI ,NDESCBIT>
		       <SETG HOLDING-DOORS? <>>
		       <MOVE ,PRSI ,PRSO>
		       <TELL
CTHE ,PRSI " wedges nicely between the doors, holding them securely
open.">
		       <COND (.TMP
			      <TELL " ">
			      <SHAFT-DESC>)>
		       <CRLF>
		       <RTRUE>)
		      (<EQUAL? ,PRSI ,PLASTIC-CONTAINER>
		       <SET TMP <ROB ,PRSI ,HERE>>
		       <REMOVE ,PRSI>
		       <TELL
"The plastic container holds the doors open for a moment, and then
is crushed by the force.">
		       <COND (.TMP
			      <TELL
" The contents of the container spill to the ground.">)>
		       <CRLF>)
		      (ELSE
		       <TELL
,YOU-CANT "wedge the door with " A ,PRSI ,PERIOD>)>)>>

<GLOBAL HOLDING-IS-ALL "Holding the doors open is all you can do.">

<GLOBAL THE-INTERIOR "the interior of the elevator">

<OBJECT UP-BUTTON
	(IN LOCAL-GLOBALS)
	(DESC "up-arrow")
	(SYNONYM BUTTON ARROW)
	(ADJECTIVE UP-ARROW CALL ELEVATOR)
	(FLAGS NDESCBIT AN)
	(ACTION UP-BUTTON-F)>

<OBJECT DOWN-BUTTON
	(IN LOCAL-GLOBALS)
	(DESC "down-arrow")
	(SYNONYM BUTTON ARROW)
	(ADJECTIVE DOWN-ARROW CALL ELEVATOR)
	(FLAGS NDESCBIT)
	(ACTION DOWN-BUTTON-F)>

<ROUTINE DESCRIBE-STAIRS ()
	 <TELL " Stairs also lead ">
	 <COND (<HERE? ,COMP-CENTER ,CS-2ND>
		<TELL "up and down">)
	       (<HERE? ,CS-BASEMENT>
		<TELL "up">)
	       (ELSE <TELL "down">)>
	 <TELL ", for the energetic. ">>

<ROUTINE UP-BUTTON-F ("OPT" (BIT ,E-UP)"AUX" OLD FLOOR)
	 <SET FLOOR <GETP ,HERE ,P?FLOOR>>
	 <SET OLD <GET ,BUTTONS .FLOOR>>
	 <COND (<VERB? EXAMINE>
		<COND (<BTST .OLD .BIT>
		       <TELL CTHE ,PRSO " is glowing." CR>)>)
	       (<VERB? PUSH>
		<COND (<NOT <BTST .OLD .BIT>>
		       <COND (<AND ,ELEVATOR-STOPPED?
				   <EQUAL? <GETP ,HERE ,P?FLOOR>
					   ,ELEVATOR-LOC>>
			      <DEQUEUE I-ELEVATOR-MOVES>
			      <QUEUE I-ELEVATOR-DOOR-OPENS 1>
			      <TELL
"You push " THE ,PRSO ,PERIOD>)
			     (ELSE
			      <PUT ,BUTTONS .FLOOR <BOR .BIT .OLD>>
			      <COND (,ELEVATOR-STOPPED?
				     <PICK-ELEVATOR-DIRECTION>
				     <COND (<NOT <QUEUED?
						   I-ELEVATOR-DOOR-CLOSES>>
					    <QUEUE I-ELEVATOR-MOVES 1 T>)>)>
			      <TELL
CTHE ,PRSO S " begins to glow.|">)>)
		      (ELSE
		       <TELL ,ALREADY-GLOWING>)>)>>

<GLOBAL ALREADY-GLOWING "That button is already glowing.|">

<ROUTINE DOWN-BUTTON-F ()
	 <UP-BUTTON-F ,E-DOWN>>

<CONSTANT E-GO 1>	;"elevator told to go to a floor"
<CONSTANT E-UP 2>	;"elevator told to come to a floor"
<CONSTANT E-DOWN 4>	;"elevator told to come to a floor"

<GLOBAL BUTTONS <TABLE 0 0 0 0>>
<GLOBAL ELEVATOR-LOC:NUMBER 1>
<GLOBAL ELEVATOR-DIRECTION 1>	;"down"
<GLOBAL ELEVATOR-STOPPED? 1>

<ROUTINE CS-ELEVATOR-ENTER ()
	 <COND (<WINNER? ,URCHIN> <RFALSE>)
	       (<AND ,ELEVATOR-STOPPED?
		     <EQUAL? ,ELEVATOR-LOC <GETP ,HERE ,P?FLOOR>>>
		<COND (<FSET? <DOOR-AT-ELEVATOR> ,OPENBIT> 
		       <COND (<END-OF-CHAIN?> <RFALSE>)
			     (ELSE ,CS-ELEVATOR-ROOM)>)
		      (ELSE
		       <TELL
CTHE ,ELEVATOR-DOOR " aren't open." CR>
		       <RFALSE>)>)
	       (<AND <HERE? ,CS-BASEMENT>
		     <FSET? ,ELEVATOR-DOOR-B ,OPENBIT>>
		<CS-PIT-ENTER>)
	       (<AND <FSET? <THIS-FLOOR-DOOR> ,OPENBIT>
		     <FIRST? <THIS-FLOOR-DOOR>>>
		<TELL
"You would fall ">
		<COND (<IN? ,ELEVATOR-FLOOR ,HERE>
		       <TELL "onto the machinery">)
		      (ELSE
		       <TELL ,INTO-THE-SHAFT>)>
		<TELL ". Not a pretty fate." CR>
		<RFALSE>)
	       (ELSE
		<TELL "The elevator isn't here." CR>
		<RFALSE>)>>

<GLOBAL INTO-THE-SHAFT "into the elevator shaft">

<ROUTINE CS-ELEVATOR-EXIT ()
	 <COND (,ELEVATOR-STOPPED?
		<COND (<NOT <FSET? <DOOR-AT-ELEVATOR> ,OPENBIT>>
		       <TELL CTHE ,ELEVATOR-DOOR " are closed." CR>
		       <RFALSE>)
		      (<ZERO? ,ELEVATOR-LOC>
		       ,CS-BASEMENT)
		      (<EQUAL? ,ELEVATOR-LOC 1>
		       ,COMP-CENTER)
		      (<EQUAL? ,ELEVATOR-LOC 2>
		       ,CS-2ND)
		      (<EQUAL? ,ELEVATOR-LOC 3>
		       ,CS-3RD)>)
	       (ELSE
		<TELL ,STILL-MOVING CR>
		<RFALSE>)>>

<GLOBAL STILL-MOVING "The elevator is still moving.">

<ROOM AERO-STAIRS
      (IN ROOMS)
      (DESC "Stairway")
      (LDESC
"A dimly lit stairway leads up and down from here. A corridor continues
east.")
      (UP TO AERO-LOBBY)
      (EAST TO AERO-BASEMENT)
      (DOWN TO SUB-BASEMENT)
      (FLAGS ONBIT)>

<ROOM AERO-BASEMENT
      (IN ROOMS)
      (DESC "Aero Basement")
      (LDESC
"This basement level room is made of smooth, damp-seeming concrete.
Fluorescent lights cast harsh shadows. To the west is a stairway, and
to the east the basement area continues.")
      (EAST TO CS-BASEMENT)
      (WEST TO AERO-STAIRS)
      ;(ACTION AERO-BASEMENT-F)
      (FLAGS ONBIT)>

;<ROUTINE AERO-BASEMENT-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
 CR>)>>

<ROUTINE HEAVY-JUNK? (WHO "AUX" (F <FIRST? .WHO>))
	 <REPEAT ()
		 <COND (<NOT .F> <RFALSE>)
		       (<AND <EQUAL? .F ,HAND>
			     <FSET? .F ,PERSON>>)
		       (<EQUAL? .F ,CROWBAR>)
		       (<G? <GETP .F ,P?SIZE> 5>
			<RETURN .F>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE TOMB-SQUEEZE ("AUX" TMP)
	 <COND (<WINNER? ,PLAYER>
		<COND (<SET TMP <HEAVY-JUNK? ,WINNER>>
		       <TELL "It's too tight a fit carrying " THE .TMP ,PERIOD>
		       <THIS-IS-IT .TMP>
		       <>)
		      (<HERE? ,TOMB>
		       ,SUB-BASEMENT)
		      (ELSE
		       ,TOMB)>)
	       (ELSE
		<COND (<IN? ,WINNER ,TOMB>
		       ,SUB-BASEMENT)
		      (ELSE
		       ,TOMB)>)>>

<ROOM SUB-BASEMENT
      (IN ROOMS)
      (DESC "Subbasement")
      (LDESC
"This is the subbasement of the Aeronautical Engineering Building. A
stairway leads up. A narrow
crack in the northwest corner of the room opens into a larger
space.")
      (UP TO AERO-STAIRS)
      (NW PER TOMB-SQUEEZE)
      ;(ACTION SUB-BASEMENT-F)
      (FLAGS ONBIT)>

;<ROUTINE SUB-BASEMENT-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
 CR>)>>

<ROOM TOMB
      (IN ROOMS)
      (DESC "Tomb")
      (SE PER TOMB-SQUEEZE)
      (OUT PER TOMB-SQUEEZE)
      (DOWN TO TUNNEL IF ACCESS-HATCH IS OPEN)
      (FLAGS ONBIT)
      (ACTION TOMB-F)
      (GLOBAL GLOBAL-HOLE LADDER GRAFFITI ACCESS-HATCH)>

<ROUTINE TOMB-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL "This is a tiny, narrow, ill-fitting room. It
appears to have been a left over space from the joining of two
preexisting buildings. It is roughly coffin shaped. The walls are
covered by decades of overlaid graffiti, but there is one which is
painted in huge fluorescent letters that were apparently impossible
for later artists to completely deface. On the floor is a rusty access
hatch">
		<COND (<EQUAL? ,PADLOCK-ON? ,ACCESS-HATCH>
		       <TELL " locked with a huge padlock">)
		      (<FSET? ,ACCESS-HATCH ,OPENBIT>
		       <TELL " which is open">)>
		<TELL ,PERIOD>)
	       (<RARG? BEG>
		<COND (<P? (READ EXAMINE) (GRAFFITI WALL)>
		       <TELL
"It reads \"The Tomb of the Unknown Tool.\"" CR>)
		      (<P? (THROW DROP) * GLOBAL-HOLE>
		       <MOVE ,PRSO ,TUNNEL>
		       <TELL "Gone." CR>)>)>>

<OBJECT LADDER
	(IN LOCAL-GLOBALS)
	(DESC "ladder")
	(SYNONYM LADDER)
	(ADJECTIVE RUSTY IRON METAL SHORT)
	(FLAGS NDESCBIT)
	(ACTION LADDER-F)>

<ROUTINE LADDER-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<HERE? ,TOMB ,TUNNEL>
		       <TELL
"It's a rusty ladder made of welded iron set in the wall." CR>)>)
	       (<VERB? CLIMB-UP>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)
	       (<VERB? CLIMB-FOO>
		<COND (<HERE? ,TOMB ,INSIDE-DOME ,ALCHEMY-LAB>
		       <DO-WALK ,P?DOWN>)
		      (<HERE? ,TUNNEL ,BROWN-ROOF ,UNDER-ALCHEMY-LAB>
		       <DO-WALK ,P?UP>)>)>>

<OBJECT ACCESS-HATCH
	(IN LOCAL-GLOBALS)
	(DESC "hatch")
	(SYNONYM HATCH)
	(ADJECTIVE ACCESS RUSTY)
	(FLAGS DOORBIT OPENABLE NDESCBIT LOCKED SEARCHBIT SURFACEBIT CONTBIT)
	(ACTION ACCESS-HATCH-F)>

<ROUTINE UNLOCK-PADLOCK-FIRST ()
	 <TELL
CTHE ,PADLOCK " locks " THE ,PADLOCK-ON? " in place" ,PERIOD>>

<ROUTINE ALREADY-LOCKED-TO ()
	 <TELL
CTHE ,PADLOCK " is already locked to " THE ,PADLOCK-ON? ,PERIOD>>

<ROUTINE ACCESS-HATCH-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? <GET ,P-NAMW 0> ,W?HOLE>
		       <NEW-VERB ,V?LOOK-INSIDE>
		       <RTRUE>)
		      (ELSE
		<TELL
"The hatch is made of stamped, ridged steel. It was originally painted
institutional grey, but has been the victim of innumerable graffiti
artists since. You can still make out the stencilled warning
\"Authorized personnel only\" which has been carefully prefixed by
\"UN,\" and suffixed by \"This means you!\" both in a disgusting fiery
red. The hatch is ">
		<COND (<EQUAL? ,PADLOCK-ON? ,ACCESS-HATCH>
		       <TELL "locked with a padlock">)
		      (ELSE <TELL "unlocked">)>
		<TELL ,PERIOD>)>)
	       (<VERB? UNLOCK>
		<NEW-PRSO ,PADLOCK>
		<RTRUE>)
	       (<VERB? OPEN RAISE>
		<COND (<FSET? ,PRSO ,LOCKED>
		       <UNLOCK-PADLOCK-FIRST>)
		      (<NOT <FSET? ,PRSO ,OPENBIT>>
		       <PUT-GLOBAL ,HERE 0 ,GLOBAL-HOLE>
		       <PUT-GLOBAL ,HERE 1 ,LADDER>
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,TUNNEL ,ONBIT>
		       <FSET ,TUNNEL-EAST ,ONBIT>
		       <FSET ,TUNNEL-WEST ,ONBIT>
		       <TELL
"The hatch is heavy, and its hinges are rusty, but ">
		       <COND (<HERE? ,TUNNEL>
			      <TELL "it opens." CR>)
			     (ELSE 
			      <TELL
"you pull and strain
and it opens with a scream of metal. Revealed below is a rusty ladder
leading down. Warm, fetid air coils up out of the hole. There is a burned
out (no, smashed) utility light set in the wall a few feet down." CR>)>)>)
	       (<VERB? CLOSE LOWER>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <PUT-GLOBAL ,HERE 0 0>
		       <PUT-GLOBAL ,HERE 1 0>
		       <FCLEAR ,TUNNEL ,ONBIT>
		       <FCLEAR ,TUNNEL-EAST ,ONBIT>
		       <FCLEAR ,TUNNEL-WEST ,ONBIT>
		       <FCLEAR ,ACCESS-HATCH ,OPENBIT>
		       <TELL "The hatch closes">
		       <IN-DARK?>)>)
	       (<OR <P? LOCK ACCESS-HATCH PADLOCK>
		    <P? PUT-ON PADLOCK ACCESS-HATCH>>
		<COND (,PADLOCK-ON?
		       <ALREADY-LOCKED-TO>)
		      (<FSET? ,ACCESS-HATCH ,LOCKED>
		       <TELL ,IT-ALREADY-IS>)
		      (ELSE
		       <SETG PADLOCK-ON? ,ACCESS-HATCH>
		       <FSET ,PADLOCK ,NDESCBIT>
		       <FCLEAR ,PADLOCK ,OPENBIT>
		       <FSET ,PADLOCK ,LOCKED>
		       <MOVE ,PADLOCK ,ACCESS-HATCH>
		       <FSET ,ACCESS-HATCH ,LOCKED>
		       <FCLEAR ,ACCESS-HATCH ,OPENBIT>
		       <TELL
"Locked up safe and secure!" CR>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "You see a">
		       <COND (<HERE? ,TOMB>
			      <TELL
" dark" S " hole leading down." CR>)
			     (ELSE
			      <TELL
"n oddly shaped small room." CR>)>)
		      (ELSE
		       <TELL-OPEN-CLOSED ,PRSO>)>)
	       (<VERB? THROUGH>
		<COND (<HERE? ,TUNNEL>
		       <DO-WALK ,P?UP>)
		      (<HERE? ,TOMB>
		       <DO-WALK ,P?DOWN>)>)>>

<OBJECT PADLOCK
	(IN ACCESS-HATCH)
	(DESC "padlock")
	(SYNONYM PADLOCK LOCK)
	(ADJECTIVE PAD HUGE)
	(FLAGS NDESCBIT TAKEBIT TRYTAKEBIT LOCKED OPENABLE)
	(ACTION PADLOCK-F)>

<GLOBAL PADLOCK-ON? ACCESS-HATCH>

<ROUTINE PADLOCK-F ("AUX" LP)
	 <COND (<VERB? EXAMINE>
		<TELL
S "The padlock has ""been spray painted many times by graffiti artists.
It's currently fluorescent purple. In spite of the many coats of
paint, the lock manages to be rusty and, in fact, almost slimy-looking.
The padlock is ">
		<COND (<FSET? ,PADLOCK ,LOCKED>
		       <TELL "locked">
		       <COND (,PADLOCK-ON?
			      <TELL " to " THE ,PADLOCK-ON?>)>)
		      (ELSE <TELL "unlocked">)>
		<TELL ,PERIOD>)
	       (<VERB? READ>
		<TELL
S "The padlock has ""no identifiable brand or symbol on it." CR>)
	       (<AND <VERB? TAKE> ,PADLOCK-ON?>
		<UNLOCK-PADLOCK-FIRST>)
	       (<VERB? PUT-ON>
		<SWAP-VERB ,V?LOCK>
		<RTRUE>)
	       (<VERB? LOCK CLOSE TIE>
		<COND (,PADLOCK-ON?
		       <ALREADY-LOCKED-TO>)
		      (<PRSI? <> ,MASTER-KEY>
		       <FSET ,PRSO ,LOCKED>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL
"Okay, you've now closed the padlock." CR>)
		      (<AND <PRSI? ,PADLOCK>
			    <NOT <PRSO? CHAIN CHAIN-1 CHAIN-2 ACCESS-HATCH>>>
		       <CANT-LOCK ,PRSO>)
		      (<PRSO? ,PADLOCK>
		       <COND (<PRSI? CHAIN CHAIN-1 CHAIN-2 ACCESS-HATCH>
			      <PERFORM ,V?LOCK ,PRSI ,PADLOCK>
			      <RTRUE>)
			     (ELSE
			      <CANT-LOCK ,PRSI>)>)>)
	       (<OR <VERB? UNLOCK>
		    <AND <VERB? OPEN> <FSET? ,PADLOCK ,LOCKED>>>
		<COND (<NOT <FSET? ,PRSO ,LOCKED>>
		       <TELL ,IT-ALREADY-IS>)
		      (<NOT ,PRSI>
		       <TELL
,YOU-HAVE-TO "use a key for that." CR>)
		      (<PRSI? ,MASTER-KEY>
		       <COND (,PADLOCK-ON?
			      <SET LP <LOC ,PADLOCK>>
			      <FCLEAR .LP ,LOCKED>
			      <COND (<IN? .LP ,LOCAL-GLOBALS>
				     <MOVE ,PADLOCK ,HERE>)
				    (ELSE
				     <MOVE ,PADLOCK <LOC .LP>>)>)>
		       <FCLEAR ,PADLOCK ,NDESCBIT>
		       <FCLEAR ,PADLOCK ,LOCKED>
		       <FSET ,PADLOCK ,OPENBIT>
		       <TELL
"The lock, though rusty and unwilling, opens">
		       <COND (,PADLOCK-ON?
			      <TELL ", releasing " THE ,PADLOCK-ON?>)>
		       <SETG PADLOCK-ON? <>>
		       <TELL ,PERIOD>)
		      (<PRSI? ,KEY-1 ,KEY-2 ,KEY-3 ,KEY-4>
		       <TELL
CTHE ,PRSI S " doesn't appear to ""open this lock." CR>)
		      (<NOT ,PRSI>
		       <TELL S "You don't have ""a key." CR>)
		      (ELSE
		       <TELL
,YOU-CANT "open this lock with " A ,PRSI "!" CR>)>)
	       (<P? (MUNG CUT ATTACK) PADLOCK>
		<COND (<PRSI? ,SMOOTH-STONE>
		       <TELL
"You smash against the padlock with the stone. As expected, there is
no result. In fact, both stone and padlock are unmarred." CR>)
		      (<PRSI? ,AXE>
		       <TELL
"All you succeed in doing is blunting the axe a little." CR>)
		      (ELSE
		       <TELL
"In spite of its present defacement, this is a good padlock. Your
feeble attempts have no effect." CR>)>)>>

<ROUTINE CANT-LOCK (OBJ)
	 <TELL
CTHE ,PADLOCK " can't lock onto " THE .OBJ ,PERIOD>>

<OBJECT GRAFFITI
	(IN LOCAL-GLOBALS)
	(DESC "graffiti")
	(SYNONYM GRAFFITI LETTERS)
	(ADJECTIVE HUGE FLUORESCENT)
	(ACTION GRAFFITI-F)>

<ROUTINE GRAFFITI-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL "\"" <PICK-ONE ,GRAFFITI-TABLE> "\"" CR>)>>

<CONSTANT GRAFFITI-TABLE
	  <LTABLE 0
		  "Kilroy was here."
		  "Tech is hell."
		  "I.H.T.F.P."
		  "'God is dead' --Nietzsche|
'Nietzsche is dead' --God">>

<ROUTINE STEAM-EXIT ()
	 <COND (<FSET? ,PRESSURE-VALVE ,OPENBIT>
		<COND (<WINNER? ,PLAYER>
		       <TELL
"You would be plunging into scalding steam. Not such a smart idea, if
you ask me." CR>)>
		<RFALSE>)
	       (<HERE? ,TUNNEL> ,TUNNEL-EAST)
	       (ELSE ,TUNNEL)>>

<ROUTINE RATS-EXIT ("AUX" H)
	 <COND (<AND <IN? ,RATS ,HERE>
		     <NOT ,ON-CABLE?>>
		<SETG RATS-HERE <+ ,RATS-HERE 1>>
		<TELL
"You plunge into the mass of rats, but there are too many of them, and
you can't force your way past." CR>
		<RFALSE>)
	       (<HERE? ,TUNNEL-WEST> ,TUNNEL-ENTRANCE)
	       (<HERE? ,TUNNEL> ,TUNNEL-WEST)
	       (<HERE? ,TUNNEL-EAST>
		<STEAM-EXIT>)
	       (<HERE? ,STEAM-TUNNEL> ,TUNNEL-EAST)
	       (<HERE? ,STEAM-TUNNEL-EAST> ,STEAM-TUNNEL)>>

<ROOM TUNNEL
      (IN ROOMS)
      (DESC "Steam Tunnel")
      (UP TO TOMB IF ACCESS-HATCH IS OPEN)
      (EAST PER STEAM-EXIT) ;TUNNEL-EAST
      (WEST PER RATS-EXIT) ;TUNNEL-WEST
      (ACTION TUNNEL-F)
      (VALUE 5)
      (GLOBAL ACCESS-HATCH LADDER CABLE STEAM-PIPES)>

<ROUTINE TUNNEL-F (RARG)
	 <COND (<RARG? LOOK>
		<TUNNEL-AND-PIPE>
		<TELL
"You have
gone from the arctic to the tropics. The concrete tunnel has odd molds
and fungi growing on its walls and ceiling, and the floor is squishy.
Torn clots of insulation litter the floor.
Along the ceiling runs a thick tangle of coaxial
cable. The tunnel heads east and west. A rusty metal ladder leads up."
CR>)
	       (<RARG? BEG>
		<COND (,RATS-HERE
		       <COND (<AND <VERB? WALK>
				   <EQUAL? ,P-WALK-DIR ,P?UP>>
			      ;<COND (<NOT <LOC ,DEAD-RAT>>
				     <MOVE ,DEAD-RAT ,HERE>)>
			      ;<SETG RATS-HERE 0>
			      <SETG ON-CABLE? <>>
			      <TELL
"You force your way through the mass of rats, grabbing onto the rusty
ladder like a mast on a stormy sea, and begin to pull your way up. A few
rats drop off, squealing in anger. You climb higher, reaching the hatch,
as the last of the rats drops to the floor below." CR CR>
			      <RFALSE>)
			     (<FOOD-FOR-RATS>)>)>)
	       (<RARG? ENTER>
		<COND (<NOT <ZERO? <GETP ,PRESSURE-VALVE ,P?VALUE>>>
		       <DEQUEUE I-RATS-GO-AWAY>
		       <QUEUE I-RATS -1>)>)>>

;<GLOBAL FLASK-SCORE 5>	;"for getting flask into steam tunnel"

<ROUTINE THROW-FOOD ()
	 <REMOVE ,PRSO>
	 <TELL
"A small contingent of rats falls greedily upon " THE ,PRSO ", biting
and scratching, fighting desperately for it. The rest of the rats are
not distracted, however." CR>>

<OBJECT CROWBAR
	(IN TEMPORARY-BASEMENT)
	(DESC "crowbar")
	(SYNONYM CROWBAR BAR)
	(ADJECTIVE RUSTY)
	(SIZE 10)
	(FLAGS TAKEBIT WEAPONBIT)
	;(ACTION CROWBAR-F)>

;<ROUTINE CROWBAR-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a rusty, somewhat battered crowbar." CR>)>>

<ROOM TUNNEL-EAST
      (IN ROOMS)
      (DESC "Steam Tunnel")
      (WEST PER RATS-EXIT) ;TUNNEL
      (EAST TO STEAM-TUNNEL)
      (GLOBAL CABLE STEAM-PIPES)
      (ACTION TUNNEL-EAST-F)>

<ROUTINE TUNNEL-EAST-F (RARG)
	 <COND (<RARG? LOOK>
		<TUNNEL-AND-PIPE>
		<TELL
"A thick bundle of coaxial cable runs east to
west along the ceiling. There is a pressure release valve on the steam
pipe here.">
		<COND (<FSET? ,PRESSURE-VALVE ,OPENBIT>
		       <TELL " The valve is" ,WIDE-OPEN>)>
		<CRLF>)
	       (<RARG? BEG>
		<FOOD-FOR-RATS>)>>

<ROUTINE FOOD-FOR-RATS ()
	 <COND (,RATS-HERE
		<COND (<OR <VERB? DROP>
			   <P? GIVE * ,RATS>>
		       <COND (<FSET? ,PRSO ,FOODBIT>
			      <THROW-FOOD>)>)>)>>

<ROOM STEAM-TUNNEL
      (IN ROOMS)
      (DESC "Steam Tunnel")
      (LDESC
"The steam tunnel is narrow here, and its construction is more archaic.
It's now mostly brick, although the floor is concrete. The steam pipe
and coaxial cable continue along their appointed paths. The tunnel is
damp and even a little muddy.")
      (WEST PER RATS-EXIT) ;TUNNEL-EAST
      (EAST TO STEAM-TUNNEL-EAST)
      (GLOBAL CABLE STEAM-PIPES)
      (ACTION STEAM-TUNNEL-F)>

<ROUTINE STEAM-TUNNEL-F (RARG)
	 <COND ;(<RARG? LOOK>
		<TELL
 CR>)
	       (<RARG? BEG>
		<FOOD-FOR-RATS>)>>

<ROOM STEAM-TUNNEL-EAST
      (IN ROOMS)
      (DESC "Steam Tunnel")
      (WEST PER RATS-EXIT) ;STEAM-TUNNEL
      (EAST "The tunnel ends here, in a dank, dripping brick wall.")
      (SOUTH PER ELEVATOR-PIT-ENTER)
      (GLOBAL CABLE STEAM-PIPES ROD CHAIN-2)
      (ACTION STEAM-TUNNEL-EAST-F)>

<ROUTINE ELEVATOR-PIT-ENTER ()
	 <COND (,BRICK-WALL-FLAG
		<COND (<ZERO? ,ELEVATOR-LOC>
		       <TELL
"A " 'ELEVATOR-FLOOR " blocks your way." CR>
		       <RFALSE>)
		      (ELSE
		       ,ELEVATOR-PIT)>)
	       (ELSE
		<TELL "You are trying to walk through a brick wall." CR>
		<RFALSE>)>>

<ROUTINE STEAM-TUNNEL-EAST-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"The steam pipe and coaxial cable turn upwards and disappear into the
ceiling here. The tunnel itself comes to an end in a grimy, damp, and
dripping triad of crumbling brick walls.">
		<COND (<AND <NOT ,BRICK-WALL-FLAG>
			    <NOT ,BRICK-FLAG>>
		       <TELL
" The south wall looks particularly decrepit.">)>
		<CRLF>)
	       (<RARG? BEG>
		<COND (<P? RUB AIR>
		       <NEW-PRSO ,BRICK-WALL>
		       <RTRUE>)
		      (<P? THROUGH GLOBAL-HOLE>
		       <DO-WALK ,P?SOUTH>)
		      (ELSE
		       <FOOD-FOR-RATS>)>)
	       (<RARG? ENTER>
		<MOVE-WALL ,A?SOUTH>
		<COND (<NOT ,BRICK-WALL-FLAG>
		       <COND (<NOT <BTST ,BRICK-FLAG ,BF-TUNNEL>>
			      <MOVE ,BROKEN-BRICK ,BRICK-WALL>)
			     (<NOT <BTST ,BRICK-FLAG ,BF-PIT>>
			      <MOVE ,NEW-BRICK ,BRICK-WALL>)>)>
		<RANDOM-ELEVATOR-MOTION>
		;<COND (<HELD? ,FLASK>
		       <SETG SCORE <+ ,SCORE ,FLASK-SCORE>>
		       <SETG FLASK-SCORE 0>)>
		<COND (<AND <NOT <ZERO? <GETP ,PRESSURE-VALVE ,P?VALUE>>>
			    <NOT <FSET? ,PRESSURE-VALVE ,OPENBIT>>>
		       <DEQUEUE I-RATS-GO-AWAY>
		       <QUEUE I-RATS -1>)>)>>

<OBJECT NEW-BRICK
	(DESC "new brick")
	(SYNONYM BRICK ;BRICKS)
	(ADJECTIVE LOOSE NEW RECENT NEWER NEW-LOOKING)
	(FLAGS NDESCBIT TAKEBIT WEAPONBIT)
	(ACTION NEW-BRICK-F)>

<ROUTINE NEW-BRICK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a new brick. It appears to be of relatively recent vintage." CR>)
	       (<P? (PRY ATTACK) * CROWBAR>
		<COND (<IN? ,PRSO ,BRICK-WALL>
		       <NEW-PRSO ,BRICK-WALL>
		       <RTRUE>)
		      (ELSE
		       <TRY-ANOTHER-BRICK>)>)>>

<ROUTINE TRY-ANOTHER-BRICK ()
	 <TELL
,YOUVE-ALREADY "pried that brick loose, maybe you should attack the
wall again." CR>>

<OBJECT BROKEN-BRICK
	(DESC "broken brick")
	(SYNONYM BRICK ;BRICKS)
	(ADJECTIVE LOOSE SLIMY CRUMBLING BROKEN OLD OLDER)
	(FLAGS NDESCBIT TAKEBIT WEAPONBIT)
	(ACTION BROKEN-BRICK-F)>

<ROUTINE BROKEN-BRICK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a crumbling, broken brick. Little bits of mortar still cling
to it." CR>)
	       (<P? (PRY ATTACK) * CROWBAR>
		<COND (<IN? ,PRSO ,BRICK-WALL>
		       <NEW-PRSO ,BRICK-WALL>
		       <RTRUE>)
		      (ELSE
		       <TRY-ANOTHER-BRICK>)>)
	       (<VERB? REPAIR>
		<TELL
CTHE ,PRSO " isn't that broken." CR>)>>

<OBJECT ROD
	(IN LOCAL-GLOBALS)
	(DESC "reinforcing rod")
	(SYNONYM ROD)
	(ADJECTIVE RUSTY STEEL REINFORCING)
	(FLAGS INVISIBLE)
	(ACTION ROD-F)>

<ROUTINE ROD-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's rusty, obviously didn't help the wall all that much, and runs up
and down through the hole you have made.">
		<COND (,CHAIN-LOOPED?
		       <TELL
" There is a length of greasy chain wrapped around it.">
		       <TELL-IF-LOCKED>)>
		<CRLF>)
	       (<AND <P? (TAKE UNTIE) CHAIN ROD>
		     ,CHAIN-LOOPED?>
		<PERFORM-PRSA ,CHAIN-2 ,ROD>
		<RTRUE>)
	       (<P? LOCK (CHAIN CHAIN-2) ROD>
		<COND (<AND ,CHAIN-LOOPED?
			    <HELD? ,PADLOCK>>
		       <PERFORM-PRSA ,CHAIN-2 ,PADLOCK>
		       <RTRUE>)
		      (<HELD? ,PADLOCK>
		       <TELL
"The hasp of the padlock won't fit around the rod." CR>)
		      (ELSE
		       <TELL
"You don't seem to have anything to lock it with." CR>)>)
	       (<VERB? PRY MOVE>
		<TELL
"It's pretty solidly mortared in." CR>)>>

<OBJECT BRICK-HOLE
	(DESC "hole")
	(SYNONYM HOLE)
	(ADJECTIVE SMALL LARGE HUGE)
	(FLAGS NDESCBIT OPENBIT CONTBIT SEARCHBIT)
	(ACTION BRICK-HOLE-F)>

<ROUTINE BRICK-HOLE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL S "There is a ">
		<COND (,BRICK-WALL-FLAG
		       <TELL
"huge hole here, where the wall has collapsed." CR>)
		      (<EQUAL? ,BRICK-FLAG ,BF-BOTH>
		       <TELL
"large hole here, with a reinforcing rod running through it." CR>)
		      (<HOLE-IN-BRICKS?>
		       <TELL
"small hole in the wall where a brick was removed." CR>)>)
	       (<P? PUT * BRICK-HOLE>
		<COND (,BRICK-WALL-FLAG
		       <TELL
"The hole that's there now is big enough for you to walk through.
Hence, no such luck." CR>)
		      (ELSE
		       <MOVE ,PRSO ,HERE>
		       <TELL
"You put " THE ,PRSO " in the hole, but ">
		       <COND (<PRSO? ,NEW-BRICK ,BROKEN-BRICK>
			      <TELL
"it doesn't fit very tightly any more, so ">)
			     (ELSE
			      <TELL
"as the hole is irregular, ">)>
		       <TELL
"it falls out again and drops to the floor." CR>)>)
	       (<VERB? THROUGH>
		<COND (,BRICK-WALL-FLAG
		       <DO-WALK <COND (<HERE? ,ELEVATOR-PIT>
				       ,P?NORTH)
				      (ELSE ,P?SOUTH)>>)
		      (ELSE
		       <TELL
"The hole is the size of a brick. You are somewhat larger." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<REDIRECT ,BRICK-HOLE ,BRICK-WALL>)
	       (<VERB? REACH-IN>
		<COND (,BRICK-WALL-FLAG
		       <TELL
"Plenty of room there." CR>)
		      (<EQUAL? ,BRICK-FLAG ,BF-BOTH>
		       <TELL
"You reach in and touch the reinforcing rod." CR>)
		      (ELSE
		       <TELL
"When you reach in you get the impression there is some metal in the
hole." CR>)>)>>

<ROUTINE HOLE-IN-BRICKS? ()
	 <OR <EQUAL? ,BRICK-FLAG ,BF-BOTH>
	     <AND <HERE? ,STEAM-TUNNEL-EAST>
		  <EQUAL? ,BRICK-FLAG ,BF-TUNNEL>>
	     <AND <HERE? ,ELEVATOR-PIT>
		  <EQUAL? ,BRICK-FLAG ,BF-PIT>>>>

<OBJECT BRICK-WALL
	(IN STEAM-TUNNEL-EAST)
	(DESC "brick wall")
	(SYNONYM WALL WALLS BRICKS ;GROOVE MORTAR)
	(ADJECTIVE SOUTH ;NORTH BRICK DAMP DRIPPING CRUMBLING)
	(FLAGS SEARCHBIT OPENBIT CONTBIT)
	(CONTFCN BRICK-WALL-CONT)
	(DESCFCN BRICK-WALL-DESC)
	(ACTION BRICK-WALL-F)>

<ROUTINE BRICK-WALL-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?>
		<COND (<OR ,BRICK-WALL-FLAG <HOLE-IN-BRICKS?>>
		       <RTRUE>)
		      (ELSE <RFATAL>)>)
	       (ELSE
		<TELL "The ">
		<COND (<HERE? ,STEAM-TUNNEL-EAST>
		       <TELL "southern ">)>
		<TELL 'BRICK-WALL>
		<COND (,BRICK-WALL-FLAG
		       <TELL " has an enormous hole ripped in it.">)
		      (ELSE
		       <TELL " has a hole in it.">
		       <COND (<NOT <FSET? ,ROD ,INVISIBLE>>
			      <TELL-ABOUT-ROD>)>)>
		<RFATAL>)>>

<ROUTINE BRICK-WALL-CONT (RARG)
	 <COND (<VERB? TAKE MOVE>
		<TELL
,YOU-CANT S "get a good grip on " THE ,PRSO " with your fingers." CR>)>>

<ROUTINE BRICK-WALL-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<HERE? ,STEAM-TUNNEL-EAST>
		       <TELL CTHE ,BRICK-WALL " ">
		       <COND (,BRICK-WALL-FLAG
			      <TELL
"is demolished. There is now a large hole leading south into
another room." CR>)
			     (<HOLE-IN-BRICKS?>
			      <DESCRIBE-WALL-HOLE "a new-looking"
						  "pretty bad">)
			     (ELSE
			      <TELL
"is in terrible shape. It's aged and crumbling,
with grooves between bricks where the mortar has fallen out." CR>)>)
		      (ELSE
		       <TELL CTHE ,BRICK-WALL " ">
		       <COND (,BRICK-WALL-FLAG
			      <TELL
"is quite ruined. Fortunately it wasn't structural. There are
big chunks of brick and concrete all over the floor here." CR>)
			     (<HOLE-IN-BRICKS?>
			      <DESCRIBE-WALL-HOLE "an older, crumbly"
						  "okay">)
			     (ELSE
			      <TELL
"is in pretty good shape. It's relatively new, and
you can only see one or two loose-looking bricks." CR>)>)>)
	       (<VERB? TAKE MOVE>
		<TELL
"Though there are loose bricks, they aren't loose enough for you to
just pry them out with your fingers." CR>)
	       (<VERB? LISTEN>
		<COND (<NOT ,BRICK-FLAG>
		       <TELL
"You place your ear to the wall, slimy and dank as it is, and hear
nothing. However, you feel a weak current of cool air coming from between
some of the bricks." CR>)
		      (ELSE
		       <TELL ,COOL-AIR-FLOWING>
		       <COND (<QUEUED? I-ELEVATOR-MOVES>
			      <TELL
", and you can hear mechanical noises on the other side">)>
		       <TELL ,PERIOD>)>)
	       (<VERB? RUB>
		<TELL
"The wall is slimy, dank, and damp. ">
		<COND (<NOT ,BRICK-FLAG>
		       <TELL
"You feel a weak current of cool air coming from between some of the
bricks." CR>)
		      (ELSE
		       <TELL ,COOL-AIR-FLOWING ,PERIOD>)>)
	       (<VERB? ATTACK MUNG>
		<TELL "It doesn't do much">
		<COND (<NOT ,BRICK-FLAG>
		       <TELL
" but loosen a brick in the wall">)>
		<TELL ,PERIOD>)
	       (<VERB? TAKE-OFF>
		<COND (<NOT <EQUAL? ,BRICK-FLAG ,BF-BOTH>>
		       <TELL
S "There is a ""loose brick in the wall, but you can't remove it with
your hands." CR>)
		      (ELSE
		       <TELL "There aren't any more loose bricks." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<HERE? ,STEAM-TUNNEL-EAST>
		       <COND (,BRICK-WALL-FLAG
			      <TELL
S "There is a ""small rectangular room on the other side of the wall." CR>)
			     (<EQUAL? ,BRICK-FLAG ,BF-BOTH>
			      <TELL
S "There is an open ""space, a small room containing some machinery."
,CANT-SEE-TOO-WELL>)
			     (<HOLE-IN-BRICKS?>
			      <TELL ,INSIDE-OF-HOLE>)
			     (ELSE
			      <TELL ,CRACKS-AND-MORTAR>)>)
		      (ELSE
		       <COND (,BRICK-WALL-FLAG
			      <TELL
"You see and dark and grimy tunnel leading west." CR>)
			     (<EQUAL? ,BRICK-FLAG ,BF-BOTH>
			      <TELL
"There is some sort of tunnel." ,CANT-SEE-TOO-WELL>)
			     (<HOLE-IN-BRICKS?>
			      <TELL ,INSIDE-OF-HOLE>)
			     (ELSE
			      <TELL ,CRACKS-AND-MORTAR>)>)>)
	       (<VERB? LOWER>
		<TELL
"You aren't strong enough to pull down a brick wall." CR>)
	       (<P? (PRY ATTACK) BRICK-WALL CROWBAR>
		<COND (,BRICK-WALL-FLAG
		       <TELL
"The hole is already quite large, and further demolition would have
to involve structural supports." CR>)
		      (<NOT ,BRICK-FLAG>
		       <COND (<HERE? ,ELEVATOR-PIT>
			      <FCLEAR ,NEW-BRICK ,NDESCBIT>
			      <MOVE ,NEW-BRICK ,HERE>
			      <CHANGE-ADJECTIVE ,NEW-BRICK 0>
			      <MOVE ,BROKEN-BRICK ,BRICK-WALL>
			      <SETG BRICK-FLAG <BOR ,BRICK-FLAG ,BF-PIT>>)
			     (ELSE
			      <FCLEAR ,BROKEN-BRICK ,NDESCBIT>
			      <MOVE ,BROKEN-BRICK ,HERE>
			      <CHANGE-ADJECTIVE ,BROKEN-BRICK 0>
			      <MOVE ,NEW-BRICK ,BRICK-WALL>
			      <SETG BRICK-FLAG <BOR ,BRICK-FLAG ,BF-TUNNEL>>)>
		       <MOVE ,BRICK-HOLE ,HERE>
		       <TELL ,WALL-YIELDS "pulls out of the wall." CR>)
		      (<NOT <EQUAL? ,BRICK-FLAG ,BF-BOTH>>
		       <MOVE ,BRICK-HOLE ,HERE>
		       <SETG BRICK-FLAG ,BF-BOTH>
		       <TELL ,WALL-YIELDS>
		       <FCLEAR ,ROD ,INVISIBLE>
		       <COND (<IN? ,BROKEN-BRICK ,BRICK-WALL>
			      <FCLEAR ,BROKEN-BRICK ,NDESCBIT>
			      <MOVE ,BROKEN-BRICK ,STEAM-TUNNEL-EAST>
			      <CHANGE-ADJECTIVE ,BROKEN-BRICK 0>
			      <BRICK-DROPS ,STEAM-TUNNEL-EAST>)
			     (ELSE
			      <FCLEAR ,NEW-BRICK ,NDESCBIT>
			      <MOVE ,NEW-BRICK ,ELEVATOR-PIT>
			      <CHANGE-ADJECTIVE ,NEW-BRICK 0>
			      <BRICK-DROPS ,ELEVATOR-PIT>)>
		       <TELL
", making a hole through the wall. You can see a rusty steel reinforcing
rod in the hole.">
		       <COND (<AND <HERE? ,STEAM-TUNNEL-EAST>
				   <NOT ,ELEVATOR-STOPPED?>>
			      <TELL " You hear a whining noise through
the hole.">)>
		       <CRLF>)
		      (ELSE
		       <TELL
"There don't seem to be any more bricks as loose as the first two." CR>)>)>>

<GLOBAL INSIDE-OF-HOLE "You see another loose brick inside the hole.|">

<GLOBAL COOL-AIR-FLOWING 
"There is cool air flowing out of the hole">

<ROUTINE BRICK-DROPS (THIS-SIDE)
	 <COND (<HERE? .THIS-SIDE>
		<TELL
"comes loose and drops to the ground">)
	       (ELSE
		<TELL
"drops to the floor on the other side">)>>

<GLOBAL CRACKS-AND-MORTAR
"The cracks and crumbled mortar only go partway through.|">

<ROUTINE DESCRIBE-WALL-HOLE (BRICK OK)
	 <TELL "has a brick-size hole ">
	 <COND (<EQUAL? ,BRICK-FLAG ,BF-BOTH>
		<TELL
"through it where bricks have been pried out. A steel rod is visible">)
	       (<HOLE-IN-BRICKS?>
		<TELL
"in it where a brick was removed. You can see " .BRICK " brick">)>
	 <TELL " in the hole. The rest of the wall is in " .OK " shape." CR>>

<GLOBAL CANT-SEE-TOO-WELL " You can't see too well, though.|">

<GLOBAL WALL-YIELDS
"The wall grudgingly yields to your efforts. A brick, less well mortared than
its fellows, ">

<ROOM ELEVATOR-PIT
      (IN ROOMS)
      (DESC "Concrete Box")
      (NORTH TO STEAM-TUNNEL-EAST IF BRICK-WALL-FLAG)
      (UP PER PIT-DOOR-EXIT)
      (OUT PER PIT-DOOR-EXIT)
      (GLOBAL ELEVATOR-DOOR-B ROD CHAIN-2)
      (VALUE 5)
      (ACTION ELEVATOR-PIT-F)
      (THINGS <PSEUDO (<> SHAFT SHAFT-PSEUDO)
		      (RAILROAD RAILS RANDOM-PSEUDO)>)>

<ROUTINE THROUGH-THE (OBJ)
	 <COND (<FSET? .OBJ ,WEARBIT>
		<TELL " through " THE .OBJ>)>>

<ROUTINE PIT-DOOR-EXIT ()
	 <COND (<FIRST? ,ELEVATOR-DOOR-B>
		<COND (,RATS-HERE
		       <COND (<L? ,RATS-HERE 2>
			      <SETG RATS-HERE 2>)>
		       <TELL
"You leap up the wall towards the basement, but the rats are faster!
They bite your fingers">
		       <THROUGH-THE ,GLOVES>
		       <TELL ", and you release your hold, tumbling back to
the pit!" CR>
		       <RFALSE>)
		      (ELSE
		       <TELL
"You climb up the gritty wall and out into the basement." CR CR>
		,CS-BASEMENT)>)
	       (<FSET? ,ELEVATOR-DOOR-B ,OPENBIT>
		<TELL
"You try to climb up while holding the doors open, but it's just
outside the realm of possibility." CR>
		<RFALSE>)
	       (ELSE
		<TELL
"There is no apparent way through the closed " 'ELEVATOR-DOOR "." CR>
		<RFALSE>)>>

<GLOBAL BRICK-FLAG <>>	;"0 = no bricks out
			  1 = brick in pit out
			  2 = brick in tunnel out
			  3 = both bricks out"
<CONSTANT BF-PIT 1>
<CONSTANT BF-TUNNEL 2>
<CONSTANT BF-BOTH 3>

<GLOBAL BRICK-WALL-FLAG <>>	;"destroyed the wall"

<ROUTINE TELL-ABOUT-ROD ()
	 <COND (<NOT <FSET? ,ROD ,INVISIBLE>>
		<TELL
" There is a vertical reinforcing rod visible in the middle of the hole.">
		<COND (,CHAIN-LOOPED?
		       <TELL
" A chain is" ,LOOPED-AROUND-ROD>
		       <COND (,CHAIN-HOOKED?
			      <TELL " and disappears up into the shaft">)
			     (<IN? ,CHAIN ,ELEVATOR-PIT>
			      <TELL " and trails down onto the floor">)>
		       <TELL ".">
		       <COND (<EQUAL? ,PADLOCK-ON? ,CHAIN-2>
			      <TELL
" A padlock secures the chain.">)>)>)>>

<GLOBAL LOOPED-AROUND-ROD " looped around the rod">

<ROUTINE ELEVATOR-PIT-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"This small room is pretty bare and featureless. The north wall is
brick and the other three walls are concrete. The east and west walls
are adorned with rails not unlike railroad rails. Above you ">
		<COND (<IN? ,ELEVATOR-FLOOR ,SHAFT-B>
		       <TELL
"and out of reach, the shaft is blocked by something." CR>)
		      (ELSE
		       <TELL
"is an empty shaft. On the north side of the shaft is an elevator
door">
		       <COND (<FIRST? ,ELEVATOR-DOOR-B>
			      <TELL
" wedged open by " A <FIRST? ,ELEVATOR-DOOR-B>>)
			     (<FSET? ,ELEVATOR-DOOR-B ,OPENBIT>
			      <TELL
" which you are holding open">)>
		       <TELL ,PERIOD>)>)
	       (<RARG? ENTER>
		<MOVE-WALL ,A?NORTH>
		<COND (<NOT ,BRICK-WALL-FLAG>
		       <COND (<NOT <BTST ,BRICK-FLAG ,BF-PIT>>
			      <MOVE ,NEW-BRICK ,BRICK-WALL>)
			     (<NOT <BTST ,BRICK-FLAG ,BF-TUNNEL>>
			      <MOVE ,BROKEN-BRICK ,BRICK-WALL>)>)>
		<RANDOM-ELEVATOR-MOTION>)
	       (<RARG? BEG>
		<COND (<AND <VERB? WALK>
			    <NOT <EQUAL? ,P-WALK-DIR ,P?UP>>
			    <HELD? ,CHAIN>
			    ,CHAIN-HOOKED?>
		       <TELL S
"You reach the end of your chain pretty quickly.|">)
		      (<P? RUB AIR>
		       <NEW-PRSO ,BRICK-WALL>
		       <RTRUE>)
		      (<P? THROUGH GLOBAL-HOLE>
		       <DO-WALK ,P?NORTH>)
		      (<P? LOOK-UP ROOMS>
		       <TELL
"You see an " 'SHAFT-B "." CR>)
		      (<AND <VERB? WALK>
			    <NOT <EQUAL? ,P-WALK-DIR ,P?UP ,P?OUT>>>
		       <MOVE-FROM-DOORS>)
		      (<P? LISTEN (<> NOISE)>
		       <COND (<NOT ,ELEVATOR-STOPPED?>
			      <TELL
"You hear the whine of powerful machinery." CR>)
			     (<AND ,BRICK-WALL-FLAG
				   <IN-TUNNEL? ,RATS>>
			      <TELL ,RATS-CHITTERING>)>)>)>>

<ROUTINE MOVE-WALL (A)
	 <MOVE ,BRICK-WALL ,HERE>
	 <CHANGE-ADJECTIVE ,BRICK-WALL 0 .A>
	 <COND (<OR ,BRICK-WALL-FLAG
		    <HOLE-IN-BRICKS?>>
		<MOVE ,BRICK-HOLE ,HERE>)>>

<GLOBAL RATS-CHITTERING "You hear the chittering of rats.|">

<ROUTINE RANDOM-ELEVATOR-MOTION ()
	 <COND (<PROB 25>
		<SETG P-NUMBER <- <RANDOM 4> 1>>
		<PERFORM ,V?PUSH ,FLOOR-BUTTON>
		<RTRUE>)>>

<OBJECT ELEVATOR-CEILING
	(IN SHAFT-2)
	(DESC "tangle of machinery")
	(SYNONYM TANGLE MACHINE)
	(FLAGS NDESCBIT OPENBIT SEARCHBIT CONTBIT SURFACEBIT)>

<OBJECT ELEVATOR-FLOOR
	(IN SHAFT-B)
	(DESC "tangle of machinery")
	(SYNONYM TANGLE MACHINE)
	(FLAGS NDESCBIT OPENBIT SEARCHBIT CONTBIT)
	(ACTION ELEVATOR-FLOOR-F)>

<ROUTINE ELEVATOR-FLOOR-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
CTHE ,ELEVATOR-FLOOR " is most notable for a metal hook">
		<COND (,CHAIN-HOOKED?
		       <TELL " with a chain hanging on it">)>
		<TELL ,PERIOD>)
	       (<P? (TIE PUT PUT-ON) CHAIN>
		<COND (<NOT ,CHAIN-HOOKED?>
		       <TELL
"Only the hook seems capable of such a use, so you try that. ">)>
		<NEW-PRSI ,HOOK>
		<RTRUE>)>>

<OBJECT SHAFT-B
	(DESC "elevator shaft")
	(SYNONYM SHAFT)
	(ADJECTIVE ELEVATOR)
	(FLAGS NDESCBIT AN SEARCHBIT OPENBIT CONTBIT VEHBIT)
	(ACTION SHAFT-F)>

<OBJECT SHAFT-1
	(DESC "elevator shaft")
	(SYNONYM SHAFT)
	(ADJECTIVE ELEVATOR)
	(FLAGS NDESCBIT AN SEARCHBIT OPENBIT CONTBIT VEHBIT)
	(ACTION SHAFT-F)>

<OBJECT SHAFT-2
	(DESC "elevator shaft")
	(SYNONYM SHAFT)
	(ADJECTIVE ELEVATOR)
	(FLAGS NDESCBIT AN SEARCHBIT OPENBIT CONTBIT VEHBIT)
	(ACTION SHAFT-F)>

<OBJECT SHAFT-3
	(DESC "elevator shaft")
	(SYNONYM SHAFT)
	(ADJECTIVE ELEVATOR)
	(FLAGS NDESCBIT AN SEARCHBIT OPENBIT CONTBIT VEHBIT)
	(ACTION SHAFT-F)>

<ROUTINE SHAFT-DESC ("AUX" (OBJ <FLOOR-SHAFT>))
	 <COND (<OR <IN? ,ELEVATOR-FLOOR .OBJ>
		    <IN? ,ELEVATOR-CEILING .OBJ>>
		<TELL 
"In the " 'SHAFT-B " " A ,ELEVATOR-FLOOR " is visible.">
		<COND (<IN? ,ELEVATOR-FLOOR .OBJ>
		       <TELL
" One bit of the tangle is very much like a hook">
		       <COND (,CHAIN-HOOKED?
			      <TELL
", and indeed, a chain is hanging from it">
			      <COND (<HELD? ,CHAIN>
				     <TELL
". You are holding the other end of the chain">)
				    (ELSE
				     <TELL
". The other end of the chain is ">
				     <COND (<IN? ,CHAIN ,HERE>
					    <TELL "on the floor">)
					   (<EQUAL? <META-LOC ,CHAIN>
						    ,HERE>
					    <TELL "in "
						  THE <LOC ,CHAIN>>)
					   (ELSE
					    <TELL
"dangling in the shaft below">)>)>)>
		       <TELL ".">)
		      (<IN? ,ELEVATOR-CEILING .OBJ>
		       <TELL
" The machinery has that malevolent mechanical appearance that means
danger.">)>)
	       (ELSE
		<TELL
"The dark shaft opens like a waiting mouth.">)>
	 <RFATAL>>

<ROUTINE LIKE-A-SHAFT ()
	 <TELL
,IT-LOOKS-LIKE A ,SHAFT-B "." CR>>

<ROUTINE SHAFT-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"The dark, grimy " 'SHAFT-B " extends up ">
		<COND (<IN? ,ELEVATOR-FLOOR ,PRSO>
		       <TELL
"to " A ,ELEVATOR-FLOOR " just above the ceiling level">)
		      (ELSE
		       <TELL "into dimness">)>
		<TELL " and down ">
		<COND (<IN? ,ELEVATOR-CEILING ,PRSO>
		       <TELL
"to a tangle of dangerous-looking lifting machinery at about floor level">)
		      (<HERE? ,CS-BASEMENT>
		       <TELL
"to a concrete-lined pit below">)
		      (ELSE
		       <TELL "into a dark pit below">)>
		<COND (<IN? ,ELEVATOR-FLOOR ,PRSO>
		       <TELL
". " CTHE ,ELEVATOR-FLOOR " includes a hook-like protrusion just inside
the door">
		       <COND (,CHAIN-HOOKED?
			      <TELL
". A greasy chain is hooked onto the protrusion, ">
			      <COND (<HELD? ,CHAIN>
				     <TELL "terminating in your hands">)
				    (ELSE
				     <TELL "dropping into the pit">)>)>)>
		<TELL ,PERIOD>)
	       (<VERB? LOOK-UP>
		<LIKE-A-SHAFT>)
	       (<P? PUT * (SHAFT-B SHAFT-1 SHAFT-2 SHAFT-3)>
		<COND (<G? ,ELEVATOR-LOC <GETP ,HERE ,P?FLOOR>>
		       <COND (<AND <PRSO? ,CHAIN>
				   <G? ,ELEVATOR-LOC 1>>
			      <REMOVE ,PRSO> ;"do better eventually?")
			     (ELSE
			      <MOVE ,PRSO ,ELEVATOR-PIT>)>)
		      (ELSE
		       <MOVE ,PRSO ,ELEVATOR-CEILING>)>
		<TELL "Dropped." CR>)
	       (<VERB? THROUGH BOARD>
		<COND (<HERE? CS-BASEMENT>
		       <DO-WALK ,P?DOWN>)
		      (ELSE
		       <TELL
"It's a long way down." CR>)>)>>

<OBJECT HOOK
	(IN ELEVATOR-FLOOR)
	(DESC "hook")
	(SYNONYM HOOK PROTRUSION)
	(FLAGS NDESCBIT)
	(ACTION HOOK-F)>

<ROUTINE HOOK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The hook is actually a very strong looking welded protrusion on the
bottom of the elevator, but it is hook-like.">
		<COND (,CHAIN-HOOKED?
		       <TELL
" One end of a chain is hooked onto it, in fact.">)>
		<CRLF>)
	       (<AND <P? (TAKE UNTIE) CHAIN HOOK>
		     ,CHAIN-HOOKED?>
		<NEW-PRSO ,CHAIN-1>
		<RTRUE>)>>

<OBJECT CHAIN		;"chain in hand or on ground"
	(IN ELEVATOR-PIT)
	(DESC "greasy chain")
	(SYNONYM CHAIN)
	(ADJECTIVE GREASY)
	(FLAGS TAKEBIT SURFACEBIT CONTBIT SEARCHBIT)
	(SIZE 20)
	(DESCFCN CHAIN-DESC)
	(GENERIC GENERIC-CHAIN-F)
	(ACTION CHAIN-F)>

<ROUTINE GENERIC-CHAIN-F ()
	 <COND (<LOC ,CHAIN> ,CHAIN)
	       (<LOC ,CHAIN-2> ,CHAIN-2)
	       (ELSE ,CHAIN-1)>>

<OBJECT CHAIN-1		;"chain on hook"
	(DESC "greasy chain")
	(SYNONYM CHAIN)
	(ADJECTIVE GREASY)
	(FLAGS NDESCBIT TAKEBIT SURFACEBIT CONTBIT SEARCHBIT)
	(SIZE 20)
	(DESCFCN CHAIN-DESC)
	(GENERIC GENERIC-CHAIN-F)
	(ACTION CHAIN-F)>

<OBJECT CHAIN-2		;"chain on rod"
	(IN LOCAL-GLOBALS)
	(DESC "greasy chain")
	(SYNONYM CHAIN)
	(ADJECTIVE GREASY)
	(FLAGS INVISIBLE NDESCBIT TAKEBIT SURFACEBIT CONTBIT SEARCHBIT OPENBIT)
	(SIZE 20)
	(DESCFCN CHAIN-DESC)
	(GENERIC GENERIC-CHAIN-F)
	(ACTION CHAIN-F)>

<GLOBAL CHAIN-HOOKED? <>>
<GLOBAL CHAIN-LOOPED? <>>

<ROUTINE CHAIN-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?>
		<COND (<AND <NOT <HELD? ,CHAIN>>
			    <OR <AND ,CHAIN-HOOKED? <HERE? ,CS-BASEMENT>>
				<AND ,CHAIN-LOOPED? <HERE? ,ELEVATOR-PIT>>>>
		       <RFATAL>)
		      (ELSE <RTRUE>)>)
	       (ELSE
		<TELL "There is ">
		<COND (<OR <AND <HERE? ,ELEVATOR-PIT>
				,CHAIN-LOOPED?>
			   <AND <HERE? ,CS-BASEMENT ,ELEVATOR-PIT>
				,CHAIN-HOOKED?>>
		       <TELL "one end of ">)>
		<TELL "a greasy length of chain ">
		<COND (<NOT <FSET? ,CHAIN ,TOUCHBIT>>
		       <TELL "coiled ">)>
		<TELL "on the floor here.">)>>

<ROUTINE TELL-IF-LOCKED ()
	 <COND (<FSET? ,CHAIN-2 ,LOCKED>
		<TELL
" The chain is locked with a padlock.">)>>

<GLOBAL IT-DANGLES " and it dangles in the elevator shaft">
<GLOBAL HOOKED-TO-HOOK " and it's hooked to the hook">

<ROUTINE CHAIN-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a length of rather greasy chain. It looks strong">
		<COND (<AND <HERE? ,ELEVATOR-PIT>
			    ,CHAIN-LOOPED?
			    ,CHAIN-HOOKED?>
		       <TELL
,HOOKED-TO-HOOK " and" ,LOOPED-AROUND-ROD>)
		      (,CHAIN-HOOKED?
		       <COND (<HERE? ,CS-BASEMENT>
			      <COND (<EQUAL? <META-LOC ,HOOK> ,HERE>
				     <TELL ,HOOKED-TO-HOOK>)
				    (<ELEVATOR-HERE?>)
				    (ELSE
				     <TELL ,IT-DANGLES>)>)
			     (<HERE? ,ELEVATOR-PIT>
			      <TELL
" and it disappears up " ,INTO-THE-SHAFT>)>)
		      (,CHAIN-LOOPED?
		       <COND (<HERE? ,ELEVATOR-PIT>
			      <TELL
" and it's" ,LOOPED-AROUND-ROD>)
			     (<HERE? ,CS-BASEMENT>
			      <TELL ,IT-DANGLES>)>)>
		<TELL ".">
		<COND (<HERE? ,ELEVATOR-PIT>
		       <TELL-IF-LOCKED>)>
		<CRLF>)
	       (<VERB? TAKE>
		<COND (<AND ,CHAIN-HOOKED?
			    ,CHAIN-LOOPED?>
		       <TELL ,YOU-HAVE-TO>
		       <COND (<HERE? ,CS-BASEMENT>
			      <TELL "unhook">)
			     (<FSET? ,CHAIN-2 ,LOCKED>
			      <TELL "unlock">)
			     (ELSE
			      <TELL "unwrap">)>
		       <TELL " it first." CR>)
		      (<AND ,CHAIN-LOOPED?
			    <OR <PRSI? ,ROD>
				<HELD? ,CHAIN>
				<NOT <ACCESSIBLE? ,CHAIN>>>>
		       <PERFORM ,V?UNTIE ,CHAIN-2 ,ROD>
		       <RTRUE>)
		      (<AND ,CHAIN-HOOKED?
			    <OR <PRSI? ,HOOK>
				<HELD? ,CHAIN>
				<NOT <ACCESSIBLE? ,CHAIN>>>>
		       <PERFORM ,V?UNTIE ,CHAIN-1>
		       <RTRUE>)>)
	       (<AND <VERB? CLIMB-UP CLIMB-FOO CLIMB-DOWN>
		     ,CHAIN-HOOKED?>
		<TELL
"The chain is too greasy to climb">
		<COND (<FSET? ,GLOVES ,WEARBIT>
		       <TELL ", even wearing the gloves">)>
		<TELL ,PERIOD>)
	       (<P? UNLOCK (CHAIN-2 CHAIN) MASTER-KEY>
		<COND (<AND <FSET? ,CHAIN-2 ,LOCKED>
			    ,CHAIN-LOOPED?>
		       <NEW-PRSO ,PADLOCK>
		       <RTRUE>)
		      (ELSE
		       <TELL
"The chain isn't locked up." CR>)>)
	       (<AND <P? UNLOCK (CHAIN-2 CHAIN) <>>
		     <HELD? ,MASTER-KEY>>
		<PERFORM-PRSA ,PADLOCK ,MASTER-KEY>
		<RTRUE>)
	       (<P? (LOCK TIE) (CHAIN CHAIN-1 CHAIN-2) PADLOCK>
		<COND (<FSET? ,PADLOCK ,LOCKED>
		       <TELL CTHE ,PADLOCK " is locked already." CR>)
		      (<AND <PRSO? ,CHAIN ,CHAIN-2>
			    <NOT <FSET? ,CHAIN-2 ,LOCKED>>
			    ,CHAIN-LOOPED?>
		       <SETG PADLOCK-ON? ,CHAIN-2>
		       <MOVE ,PADLOCK ,CHAIN-2>
		       <FSET ,PADLOCK ,LOCKED>
		       <FCLEAR ,PADLOCK ,OPENBIT>
		       <FSET ,PADLOCK ,NDESCBIT>
		       <FSET ,CHAIN-2 ,LOCKED>
		       <TELL
"You lock the chain with the padlock. It now forms a secure loop around
the rod." CR>)
		      (ELSE
		       <TELL
"That's pretty pointless, as the chain isn't currently securing
anything." CR>)>)
	       (<P? (TIE ;PUT PUT-ON) (CHAIN CHAIN-1 CHAIN-2)>
		<COND (<PRSI? ,CHAIN ,CHAIN-1 ,CHAIN-2>
		       <TELL S
"I'm not sure how you are proposing to do that.|">
		       <RTRUE>)
		      (<AND ,CHAIN-HOOKED? ,CHAIN-LOOPED?>
		       <TELL
,YOUVE-ALREADY "attached the ends of the chain to the hook and the rod.">
		       <COND (<NOT <PRSI? ,ROD ,HOOK>>
			      <TELL
" " ,YOU-HAVE-TO "retrieve one first.">)
			     (<HERE? ,ELEVATOR-PIT>
			      <TELL
" There isn't enough extra chain to reach that far.">)>
		       <CRLF>
		       <RTRUE>)>
		<COND (<PRSI? ,ROD>
		       <COND (<NOT ,CHAIN-LOOPED?>
			      <FCLEAR ,CHAIN-2 ,INVISIBLE>
			      ;<MOVE ,CHAIN-2 ,ELEVATOR-PIT>
			      <SETG CHAIN-LOOPED? ,ROD>
			      <TELL
"You wrap the chain around the rod, but find it too thick to actually
tie it.">
			      <COND (,CHAIN-HOOKED?
				     <REMOVE ,CHAIN>
				     <TELL
" A few feet hangs on one side of the rod, and the rest curves up from
the rod towards the floor of the elevator.">)>
			      <CRLF>)
			     (ELSE
			      <TELL
,YOUVE-ALREADY "wrapped the chain around the rod." CR>)>)
		      (<PRSI? ,HOOK>
		       <COND (<NOT ,CHAIN-HOOKED?>
			      <COND (<AND <HELD? ,CHAIN> <NOT ,CHAIN-LOOPED?>>
				     <MOVE ,CHAIN ,HERE>
				     <TELL
"You stretch out towards the hook, find that the whole chain is just too
much weight, and put most of it on the floor. Much easier! ">)>
			      <MOVE ,CHAIN-1 <LOC ,HOOK>>
			      <SETG CHAIN-HOOKED? ,HOOK>
			      <COND (,CHAIN-LOOPED? <REMOVE ,CHAIN>)
				    (ELSE
				     <MOVE ,CHAIN ,HERE>)>
			      <TELL
"You hook the chain to the hook, where it looks quite secure." CR>)
			     (ELSE
			      <TELL
"One end of the chain is all that will fit." CR>)>)
		      (ELSE
		       <TELL
"The chain won't attach to " THE ,PRSI ,PERIOD>)>)
	       (<P? PUT * (CHAIN CHAIN-1 CHAIN-2)>
		<TELL S
"I'm not sure how you are proposing to do that.|">)
	       (<VERB? UNTIE TAKE-OFF>
		<COND (<PRSI? ,ROD>
		       <COND (,CHAIN-LOOPED?
			      <COND (<FSET? ,CHAIN-2 ,LOCKED>
				     <UNLOCK-PADLOCK-FIRST>)
				    (ELSE
				     <FSET ,CHAIN-2 ,INVISIBLE>
				     ;<REMOVE ,CHAIN-2>
				     <COND (<NOT <HELD? ,CHAIN>>
					    <MOVE ,CHAIN ,ELEVATOR-PIT>
					    <THIS-IS-IT ,CHAIN>)>
				     <SETG CHAIN-LOOPED? <>>
				     <REMOVE-CHAIN-FROM "untie">)>)
			     (ELSE
			      <TELL ,ITS-NOT-TIED>)>)
		      (<PRSI? HOOK>
		       <COND (,CHAIN-HOOKED?
			      <REMOVE-CHAIN-FROM "remove">
			      <REMOVE ,CHAIN-1>
			      <COND (<NOT <HELD? ,CHAIN>>
				     <MOVE ,CHAIN ,HERE>
				     <THIS-IS-IT ,CHAIN>)>
			      <SETG CHAIN-HOOKED? <>>
			      <RTRUE>)
			     (ELSE
			      <TELL ,ITS-NOT-TIED>)>)
		      (ELSE
		       <COND (<AND ,CHAIN-HOOKED?
				   <ACCESSIBLE? ,HOOK>>
			      <PERFORM ,V?UNTIE ,CHAIN-1 ,HOOK>)
			     (<AND ,CHAIN-LOOPED?
				   <ACCESSIBLE? ,ROD>>
			      <PERFORM ,V?UNTIE ,CHAIN-2 ,ROD>)
			     (ELSE
			      <TELL ,ITS-NOT-TIED>)>
		       <RTRUE>)>)
	       (<VERB? MOVE>
		<COND (<HERE? ,CS-BASEMENT>
		       <COND (,CHAIN-HOOKED? <PULL-HOOK>)
			     (,CHAIN-LOOPED? <PULL-ROD>)>)
		      (<HERE? ,ELEVATOR-PIT>
		       <COND (,CHAIN-LOOPED? <PULL-ROD>)
			     (,CHAIN-HOOKED? <PULL-HOOK>)>)>)>>

<ROUTINE REMOVE-CHAIN-FROM (VRB)
	 <TELL "You " .VRB " the chain from " THE ,PRSI "." CR>>

<ROUTINE PULL-HOOK ()
	 <TELL "It's pretty securely hooked.">
	 <PRETTY-SECURE>>

<ROUTINE PULL-ROD ()
	 <COND (<FSET? ,CHAIN-2 ,LOCKED>
		<TELL
"You pull as hard as you can, but you can't pull the rod out.">
		<PRETTY-SECURE>)
	       (ELSE
		<SETG CHAIN-LOOPED? <>>
		<FSET ,CHAIN-2 ,INVISIBLE>
		;<REMOVE ,CHAIN-2>
		<COND (<NOT <HELD? ,CHAIN>>
		       <MOVE ,CHAIN ,ELEVATOR-PIT>)>
		<TELL
"It clatters along the rod and then falls off." CR>)>>

<ROUTINE PRETTY-SECURE ()
	 <COND (<AND ,CHAIN-LOOPED?
		     <FSET? ,CHAIN-2 ,LOCKED>>
		<TELL
" In fact, it feels pretty secure all around.">)>
	 <CRLF>>

<OBJECT PRESSURE-VALVE
	(IN TUNNEL-EAST)
	(DESC "pressure valve")
	(SYNONYM VALVE)
	(ADJECTIVE PRESSURE RELEASE STEAM)
	(VALUE 5)
	(FLAGS NDESCBIT OPENABLE)
	(ACTION PRESSURE-VALVE-F)>

<ROUTINE PRESSURE-VALVE-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<NOT <GET ,P-NAMW 0>>
		       <COND (<FSET? ,PRESSURE-VALVE ,OPENBIT>
			      <TELL
"It looks like live steam." CR>)
			     (<NOT <ZERO? ,VALVE-OPENED?>>
			      <TELL
"It's just a trickle." CR>)
			     (ELSE
			      <TELL S "It's closed.|">)>)
		      (ELSE
		       <TELL
"It looks pretty rusty, but appears to be in working order. ">
		       <COND (<FSET? ,PRESSURE-VALVE ,OPENBIT>
			      <TELL
"In fact, it's" ,WIDE-OPEN CR>)
			     (<NOT <ZERO? ,VALVE-OPENED?>>
			      <TELL
,IT-SEEMS-TO-BE "partly open." CR>)
			     (ELSE <TELL S "It's closed.|">)>)>)
	       (<VERB? TURN>
		<COND (<FSET? ,PRESSURE-VALVE ,OPENBIT>
		       <NEW-VERB ,V?CLOSE>)
		      (ELSE
		       <NEW-VERB ,V?OPEN>)>
		<RTRUE>)
	       (<AND <VERB? ATTACK>
		     <FSET? ,PRSI ,WEAPONBIT>>
		<OPEN-VALVE>)
	       (<AND <VERB? OPEN PRY>
		     ,PRSI
		     <FSET? ,PRSI ,WEAPONBIT>>
		<OPEN-VALVE>)
	       (<AND <VERB? OPEN>
		     <OR <NOT <ZERO? ,VALVE-OPENED?>>
			 <FSET? ,PRESSURE-VALVE ,RMUNGBIT>>>
		<OPEN-VALVE>)
	       (<AND <VERB? OPEN>
		     <ZERO? ,VALVE-OPENED?>>
		<TELL
"It's too rusty. You pull and strain, but" ,LC-NOTHING-HAPPENS CR>)
	       (<VERB? CLOSE LAMP-OFF>
		<COND (<FSET? ,PRESSURE-VALVE ,OPENBIT>
		       <SETG VALVE-OPENED? 0>
		       <FSET ,PRESSURE-VALVE ,RMUNGBIT>
		       <FCLEAR ,PRESSURE-VALVE ,OPENBIT>
		       <TELL
"The valve closes, more easily than it opened." CR>)
		      (ELSE
		       <TELL ,IT-ALREADY-IS>)>)>>

<GLOBAL WIDE-OPEN " wide open and spewing live steam.">

<ROUTINE OPEN-VALVE ()
	 <COND (<FSET? ,PRESSURE-VALVE ,OPENBIT>
		<ALREADY-OPEN>)
	       (ELSE
		<COND (<FSET? ,PRESSURE-VALVE ,RMUNGBIT>
		       <SETG VALVE-OPENED? 1>)>
		<COND (<G? <SETG VALVE-OPENED? <+ ,VALVE-OPENED? 1>> 1>
		       <FSET ,PRESSURE-VALVE ,OPENBIT>
		       <DEQUEUE I-RATS>
		       <MOVE ,RATS ,GLOBAL-OBJECTS>
		       <TELL
"The valve screeches open. A jet spray of live steam issues from it,
filling the tunnel in front of you.">
		       <COND (,RATS-HERE
			      <SCORE-OBJECT ,PRESSURE-VALVE>
			      <MOVE ,DEAD-RAT ,HERE>
			      <SETG RATS-HERE 0>
			      <TELL
" The rats are caught in the full force of the blast. Horrible squeals
can be heard from the midst of the steam cloud, and scalded rats charge
past you, all interest in anything but flight forgotten.">
			      <COND (<IN? ,DEAD-RAT ,HERE>
				     <TELL
" One of their number remains, dead.">)>)>)
		      (ELSE
		       <TELL
"The valve, with a horrible scream of tortured metal, gives a little,
and a small trickle of steam issues forth.">
		       <COND (,RATS-HERE
			      <TELL " This further agitates the
rats.">)>)>
		<CRLF>)>>

<GLOBAL VALVE-OPENED? 0>

<ROOM TUNNEL-WEST
      (IN ROOMS)
      (DESC "Steam Tunnel")
      (EAST TO TUNNEL)
      (WEST PER RATS-EXIT) ;TUNNEL-ENTRANCE
      (GLOBAL CABLE STEAM-PIPES)
      (ACTION TUNNEL-WEST-F)>

<ROUTINE TUNNEL-AND-PIPE ()
	 <TELL
"This dank and grimy tunnel is largely filled with an imperfectly
insulated steam pipe. The tunnel is uncomfortably hot and damp. ">>

<ROUTINE TUNNEL-WEST-F (RARG)
	 <COND (<RARG? LOOK>
		<TUNNEL-AND-PIPE>
		<TELL
"A bundle of coaxial cable runs along the ceiling,
festooned with damp mold and cobwebs. The tunnel continues west." CR>)
	       (<RARG? BEG>
		<COND (<AND ,RATS-HERE
			    <VERB? DROP>
			    <FSET? ,PRSO ,FOODBIT>>
		       <THROW-FOOD>)>)>>

<OBJECT STEAM-PIPES
	(IN LOCAL-GLOBALS)
	(DESC "steam pipes")
	(SYNONYM PIPE PIPES)
	(ADJECTIVE STEAM)
	(FLAGS NDESCBIT)>

<OBJECT CABLE
	(IN LOCAL-GLOBALS)
	(DESC "coaxial cable")
	(SYNONYM CABLE CHANNEL WIRE WIRES)
	(ADJECTIVE COAXIAL COAX WIRE WIRES STEAM)
	(FLAGS NDESCBIT VEHBIT)
	(ACTION CABLE-F)>

<GLOBAL ON-CABLE? <>>

<ROUTINE CABLE-F ("OPT" (RARG <>))
	 <COND (<VERB? EXAMINE>
		<COND (<HERE? ,CS-BASEMENT>
		       <TELL S
"From floor to ceiling run wire channels and steam pipes.|">)
		      (ELSE
		       <TELL
"The cable runs overhead in a fat bundle. It looks like the kind
you've seen connecting nodes of the local net. This clump
is pretty grotty looking, festooned with damp cobwebs, and stained with
something that dripped from the ceiling." CR>)>)
	       (<VERB? TAKE>
		<YOU-CANT-X-THAT "take">)
	       (<VERB? CUT MUNG>
		<COND (<PRSI? <> ,HANDS>
		       <TELL-YUKS>)
		      (<PRSI? ,BOLT-CUTTER ,AXE>
		       <TELL
"You begin cutting the cables, and after a while you realize that the
inner cables look different, sort of dead white and slimy. Then you
notice that the cables you have cut are knitting back together." CR>)
		      (ELSE
		       <TELL
,YOU-CANT "expect to cut cable with " A ,PRSI ,PERIOD>)>)
	       (<VERB? FOLLOW>
		<TELL "It runs ">
		<COND (<HERE? ,CS-BASEMENT>
		       <TELL
"from floor to ceiling." CR>)
		      (<HERE? ,STEAM-TUNNEL-EAST ,TUNNEL-ENTRANCE>
		       <TELL
"down from the ceiling and off to the ">
		       <COND (<HERE? ,STEAM-TUNNEL-EAST>
			      <TELL "west." CR>)
			     (ELSE <TELL "east." CR>)>)
		      (ELSE
		       <TELL
"east and west along the ceiling." CR>)>)
	       (<VERB? CLIMB-FOO CLIMB-ON BOARD>
		<COND (<HERE? ,CS-BASEMENT>
		       <TELL-YUKS>)
		      (,ON-CABLE?
		       <TELL ,YOU-ARE ,PERIOD>)
		      (ELSE
		       <SETG ON-CABLE? T>
		       <QUEUE I-CABLE-FALL 2>
		       <TELL
"You leap, grab the damp and moldy bundle of cable, and hang suspended
off the floor.">
		       <COND (,RATS-HERE
			      <TELL
" " ,YOU-ARE-NOW "somewhat out of reach of the rats.">)>
		       <CRLF>)>)>>

<ROUTINE I-CABLE-FALL ()
	 <TELL CR
"Your grip on the cable, never too secure, loosens">
	 <SETG ON-CABLE? <>>
	 <COND (,RATS-HERE
		<TELL " fatally as an
Einstein among rats, who was crawling along the cable itself, bites your
fingers">
		<THROUGH-THE ,GLOVES>
		<TELL ". You fall, landing among the delighted rats." CR CR>
		<JIGS-UP 
"They swarm over you, a small army of furry bodies, and you are
consumed in short order.">)
	       (ELSE <TELL ", and you drop to the floor." CR>)>>

<ROUTINE I-RATS ("AUX" (ORAT <LOC ,RATS>))
	 <COND (<IN? ,RATS ,GLOBAL-OBJECTS>
		<MOVE ,RATS ,TUNNEL-WEST>
		<COND (<IN-TUNNEL?>
		       <TELL CR
"You can hear, in the distance, a chittering, scratching sound." CR>)>
		<RTRUE>)
	       (<NOT <IN? ,RATS ,HERE>>
		<COND (<NOT <ZERO? ,RATS-HERE>>
		       <COND (<IN-TUNNEL?>
			      <MOVE ,RATS ,HERE>)
			     (<OR <AND <HERE? ,TOMB>
				       <FSET? ,ACCESS-HATCH ,OPENBIT>>
				  <AND <HERE? ,CS-BASEMENT>
				       <FSET? ,ELEVATOR-DOOR-B
					      ,OPENBIT>>>
			      <QUEUE I-RATS-GO-AWAY 4 T>
			      <TELL CR
"From below you can hear the chittering of the rats." CR>
			      <RTRUE>)
			     (<HERE? ,TOMB ,CS-BASEMENT>
			      <QUEUE I-RATS-GO-AWAY 2 T>)>)
		      (<HERE? ,TOMB ,CS-BASEMENT>
		       <QUEUE I-RATS-GO-AWAY 2 T>)
		      (<G? <SETG RATS-WAITING <+ ,RATS-WAITING 1>> 3>
		       <COND (<IN? ,RATS ,TUNNEL-WEST>
			      <MOVE ,RATS ,TUNNEL>)
			     (<IN? ,RATS ,TUNNEL>
			      <MOVE ,RATS ,TUNNEL-EAST>)
			     (<IN? ,RATS ,TUNNEL-EAST>
			      <MOVE ,RATS ,STEAM-TUNNEL>)
			     (<IN? ,RATS ,STEAM-TUNNEL>
			      <MOVE ,RATS ,STEAM-TUNNEL-EAST>)
			     (<AND <IN? ,RATS ,STEAM-TUNNEL-EAST>
				   ,BRICK-WALL-FLAG>
			      <MOVE ,RATS ,ELEVATOR-PIT>)>
		       <COND (<IN? ,RATS ,HERE>
			      <SETG RATS-WAITING 0>)>)>)>
	 <COND (<IN? ,RATS ,HERE>
		<CRLF>
		<COND (<NOT <HERE? .ORAT>>
		       <COND (,RATS-HERE
			      <TELL
"The rats follow, surging around you. ">)
			     (ELSE
			      <TELL
"A troop of rats appears out of the darkness. ">)>)>
		<SETG RATS-HERE <+ ,RATS-HERE 1>>
		<COND (,ON-CABLE?
		       <TELL
"The rats leap toward you, maddened that you are out of reach!" CR>)
		      (<EQUAL? ,RATS-HERE 1>
		       <TELL
"The rats are momentarily
startled by your presence, but soon the bolder ones begin to approach.
There are more rats here than you have ever seen." CR>)
		      (<EQUAL? ,RATS-HERE 2>
		       <TELL
"The rats attack! Slimy, snarling, and hungry, they swarm over your
feet, biting at your legs">
		       <THROUGH-THE ,BOOTS>
		       <TELL " and clinging desperately to your feet." CR>)
		      (<EQUAL? ,RATS-HERE 3>
		       <TELL
"The troop of rats surges around you, scenting blood and the kill. There
are rats clinging all over you, their nasty teeth biting down in a dozen
places." CR>)
		      (ELSE
		       <I-RATS-GO-AWAY>
		       <JIGS-UP
"A particularly nasty rat, wise in the ways of death, makes its way
up your arm to your neck. For a moment it stares at you, its
yellow eyes hungry, and then it reaches your jugular. As you lose
consciousness, you think for a moment that you see the rat laugh,
exposing its own neck, and on its neck is branded a symbol.">)>)
	       (<IN-TUNNEL? ,RATS>
		<COND (<NOT <IN-TUNNEL?>>
		       <RFALSE>)
		      (<EQUAL? ,RATS-WAITING 1>
		       <TELL CR
"The sound is louder. It sounds like small animals. Is it rats?" CR>)
		      (<EQUAL? ,RATS-WAITING 2>
		       <TELL CR
"The sound continues. It's almost certainly rats." CR>)
		      (ELSE
		       <TELL CR
"The rat sounds are growing louder, but you still can't see any rats." CR>)>)>>

<ROUTINE IN-TUNNEL? ("OPT" (WHO <>) "AUX" L)
	 <COND (<NOT .WHO> <SET WHO ,PLAYER>)>
	 <SET L <LOC .WHO>>
	 <COND (<EQUAL? .L ,TUNNEL-WEST ,TUNNEL ,TUNNEL-EAST
			,STEAM-TUNNEL ,STEAM-TUNNEL-EAST>
		<RTRUE>)
	       (<AND <EQUAL? .L ,ELEVATOR-PIT>
		     ,BRICK-WALL-FLAG>
		<RTRUE>)>>

<ROUTINE I-RATS-GO-AWAY ()
	 <DEQUEUE I-RATS>
	 <MOVE ,RATS ,GLOBAL-OBJECTS>
	 <SETG RATS-HERE 0>
	 <SETG RATS-WAITING 0>
	 <RFALSE>>

<GLOBAL RATS-WAITING 0>	;"rats in tunnel-west, waiting"
<GLOBAL RATS-HERE 0>	;"rats seen you?"

<OBJECT DEAD-RAT
	(DESC "dead rat")
	(SYNONYM RAT)
	(ADJECTIVE DEAD)
	(FLAGS SEARCHBIT TAKEBIT OPENBIT CONTBIT)
	(HEAT 0)
	(GENERIC GENERIC-RAT-F)
	(ACTION DEAD-RAT-F)>

<ROUTINE DEAD-RAT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This rat appears to have been stepped on. A small trickle of blood has
clotted around its mouth. Branded into its neck is a strange symbol." CR>)
	       (<VERB? TAKE>
		<COND (<NOT <FSET? ,PRSO ,TOUCHBIT>>
		       <COND (<EQUAL? <ITAKE> T>
			      <TELL
"As you take the dead rat, it moves, but then you realize that it's only
lice and fleas bailing out." CR>)
			     (ELSE <RTRUE>)>)>)
	       (<P? PUT * DEAD-RAT>
		<SQUISH-RAT>)
	       (<VERB? BOARD STEP-ON>
		<TELL
"You crush the rat. You hear its bones snap. What a sadist!" CR>)
	       (<VERB? EAT>
		<TELL
"You dangle the rat over your mouth by its tail. You think about it.
You lower the rat towards your face. You think some more. Fortunately
for your health, you change your mind." CR>)>>

<ROUTINE SQUISH-RAT ()
	 <TELL
CTHE ,PRSO " hits ">
	 <COND (<PRSI? ,RATS> <TELL "a rat">)
	       (ELSE <TELL "the rat">)>
	 <TELL " with a satisfying squish." CR>>

<OBJECT RAT-SYMBOL
	(IN DEAD-RAT)
	(DESC "branded symbol")
	(SYNONYM SYMBOL)
	(ADJECTIVE BRANDED STRANGE INCOMPREHENSIBLE)
	(FLAGS NDESCBIT)
	(SIZE 0)
	(GENERIC GENERIC-SYMBOL-F)
	(ACTION RAT-SYMBOL-F)>

<GLOBAL SEEN-SYMBOL? <>>

<GLOBAL SYMBOL-APPEARS 
"The symbol, on close examination, appears to have been ">

<ROUTINE RAT-SYMBOL-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
,SYMBOL-APPEARS "scarred into
the hide of the rat. There is no hair growing on it, and although it
looks like scar tissue, the color is wrong -- a sort of purplish
green. ">
		<TELL-SYMBOL ,DEAD-RAT>
		<CRLF>)>>

<ROUTINE GENERIC-SYMBOL-F ()
	 <COND (<EQUAL? ,P-IT-OBJECT
			,TATTOO ,STONE-SYMBOL ,RAT-SYMBOL
			,PENTAGRAM ,CARVING-SYMBOL ,CARTON>
		,P-IT-OBJECT)
	       (<EQUAL? ,P-IT-OBJECT ,HAND>
		,TATTOO)
	       (<EQUAL? ,P-IT-OBJECT ,SMOOTH-STONE>
		,STONE-SYMBOL)
	       (<EQUAL? ,P-IT-OBJECT ,DEAD-RAT>
		,RAT-SYMBOL)
	       (<EQUAL? ,P-IT-OBJECT ,CARVINGS>
		,CARVING-SYMBOL)
	       (<EQUAL? ,P-IT-OBJECT ,CARTON>
		,CARTON)>>

<ROUTINE TELL-SYMBOL (OBJ)
	 <TELL "The symbol ">
	 <COND (<NOT ,SEEN-SYMBOL?>
		<SETG SEEN-SYMBOL? .OBJ>
		<TELL
"is like nothing you've ever seen, and yet somehow
you know it has meaning.">)
	       (<NOT <EQUAL? ,SEEN-SYMBOL? .OBJ>>
		<TELL
"looks oddly familiar.">)
	       (ELSE
		<TELL
"seems just as odd as before.">)>>

<OBJECT RATS
	(IN GLOBAL-OBJECTS)
	(DESC "sewer rats")
	(SYNONYM RAT RATS)
	(ADJECTIVE LIVE SEWER)
	(DESCFCN RATS-DESC)
	(FLAGS NOABIT)
	(GENERIC GENERIC-RAT-F)
	(ACTION RATS-F)>

<ROUTINE GENERIC-RAT-F ()
	 <COND (<ACCESSIBLE? ,DEAD-RAT> ,DEAD-RAT)
	       (ELSE ,RATS)>>

<ROUTINE RATS-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?> <RTRUE>)
	       (ELSE
		<TELL
"There are rats here.">)>>

<ROUTINE RATS-F ()
	 <COND (<AND <IN? ,RATS ,GLOBAL-OBJECTS>
		     <NOT <VERB? TELL-ABOUT ASK-ABOUT TELL-ME-ABOUT>>>
		<TELL "There are no rats here." CR>)
	       (<VERB? EXAMINE>
		<TELL
"These are strange rats. They don't look like the usual sewer rats.
There is more white in their fur, even dirty and
encrusted as it is. Some are furless, and others piebald.
Many of the older ones are scarred and look particularly
cunning." CR>)
	       (<VERB? SMELL>
		<TELL
"You catch a sharp odor over the background of damp and sewage.
It's metallic, almost stinging. It's the odor of fresh blood." CR>)
	       (<AND <VERB? THROW>
		     <FSET? ,PRSO ,FOODBIT>>
		<THROW-FOOD>)
	       (<VERB? ATTACK KILL>
		<TELL
"You strike out at the rats, but several clamp onto your hand. The
pain is horrible. The rest are all the more frenzied by the drops
of blood." CR>)
	       (<VERB? KICK>
		<TELL
"You kick, throwing off a few biting at your foot and leg">
		<THROUGH-THE ,BOOTS><TELL ". These smash
squealing into the wall, but others take their places." CR>)
	       (<P? PUT * RATS>
		<SQUISH-RAT>)
	       (<VERB? STEP-ON>
		<TELL
"You smash a rat, but it's one of hundreds." CR>)
	       (<VERB? LISTEN>
		<TELL
CTHE ,RATS " sound annoyed and hungry." CR>)>>

<ROOM MASS-AVE
      (IN ROOMS)
      (DESC "Mass. Ave.")
      (LDESC
"This is the main entrance to the campus buildings.
Blinding snow obscures the stately Grecian columns and rounded
dome to the east. You can barely make out the inscription on
the pediment (which reads \"George Vnderwood Edwards, Fovnder;
P. David Lebling, Architect\").
West across Massachusetts Avenue are
other buildings, but you can't see them.")
      (EAST TO INF-1)
      (IN TO INF-1)
      (GLOBAL OUTSIDE-DOOR)
      (FLAGS OUTSIDE ONBIT)
      (ACTION MASS-AVE-F)>

<ROUTINE MASS-AVE-F (RARG)
	 <COND ;(<RARG? LOOK>
		<TELL
 CR>)
	       (<RARG? ENTER>
		<EXIT-TO-COLD>)
	       (<RARG? LEAVE>
		<EXIT-FROM-COLD>)>>

<ROUTINE EXIT-FROM-COLD ()
	 <DEQUEUE I-FREEZE-TO-DEATH>
	 <COND (<G? ,FREEZE-COUNT 0>
		<SETG FREEZE-COUNT 0>
		<TELL
,PUSH-INTO "welcoming warmth inside." CR CR>)>>

<ROOM CHEMISTRY-BLDG
      (IN ROOMS)
      (DESC "Chemistry Building")
      (NORTH TO INF-5)
      (SOUTH TO ALCHEMY-DEPT IF ALCHEMY-DOOR IS OPEN)
      (GLOBAL ALCHEMY-DOOR ALCHEMY-WINDOW OFFICE-DOOR)
      (FLAGS ONBIT)
      (ACTION CHEMISTRY-BLDG-F)>

<ROUTINE CHEMISTRY-BLDG-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"This corridor is lined with closed, dark offices. At the south end of
the corridor is a door with a light shining behind it. ">
		<COND (<FSET? ,ALCHEMY-DOOR ,OPENBIT>
		       <TELL "The door is open.">)
		      (ELSE
		       <TELL
"There is something written on the door.">)>
		<CRLF>)
	       (<RARG? ENTER>
		<COND (<AND <EQUAL? ,OHERE ,ALCHEMY-DEPT>
			    <NOT ,PROF-DEAD?>>
		       <SETG LEFT-ALCHEMY? T>
		       <FSET ,ALCHEMY-DOOR ,LOCKED>
		       <FCLEAR ,ALCHEMY-DOOR ,OPENBIT>
		       <TELL
"The door closes behind you." CR CR>)>)>>

<OBJECT ALCHEMY-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "Alchemy Department door")
	(SYNONYM DOOR)
	(ADJECTIVE ALCHEMY DEPART DEPT)
	(FLAGS DOORBIT OPENABLE NDESCBIT READBIT LOCKED)
	(ACTION ALCHEMY-DOOR-F)>

<ROUTINE ALCHEMY-DOOR-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a standard Tech door. It's made of black-painted wood and has a ">
		<COND (<FSET? ,ALCHEMY-WINDOW ,RMUNGBIT>
		       <TELL "badly cracked ">)>
		<TELL 'ALCHEMY-WINDOW " with ">
		<COND (<HERE? ,ALCHEMY-DEPT>
		       <TELL "something painted on the other side.">)
		      (ELSE
		       <TELL "\"Department of Alchemy\" painted on it.">)>
		<COND (<AND <HERE? ,CHEMISTRY-BLDG>
			    <FSET? ,ALCHEMY-DEPT ,ONBIT>
			    <NOT ,PROF-DEAD?>>
		       <TELL
" There is a light on inside.">)>
		<CRLF>)
	       (<VERB? LOOK-INSIDE>
		<COND (<HERE? ,ALCHEMY-DEPT>
		       <TELL "You are inside it already." CR>)
		      (<NOT <FSET? ,ALCHEMY-DEPT ,ONBIT>>
		       <TELL
"It's dark inside." CR>)
		      (<NOT ,PROF-DEAD?>
		       <TELL
"Every so often, you see a shadow move across the window." CR>)
		      (ELSE
		       <TELL
"You don't see anything in particular, other than that the light is on
inside." CR>)>)
	       (<VERB? READ>
		<COND (<HERE? ,CHEMISTRY-BLDG>
		       <TELL
"Painted on the door, in calligraphy indistinguishable from any other
door at Tech, is the phrase \"Department of Alchemy.\" You always used
to wonder what was behind that door." CR>)
		      (ELSE <TELL ,YOU-CANT "read it from this side." CR>)>)
	       (<P? UNLOCK>
		<COND (<FSET? ,PRSO ,LOCKED>
		       <COND (<PRSI? ,MASTER-KEY>
			      <COND (<HERE? ,CHEMISTRY-BLDG>
				     <QUEUE I-ANSWER-DOOR 3 T>)>
			      <RFALSE>)
			     (<PRSI? ,KEY-1 ,KEY-2 ,KEY-3 ,KEY-4>
			      <TELL
"It doesn't even fit the lock." CR>)>)
		      (<HERE? ,ALCHEMY-DEPT>
		       <TELL
"You don't need to unlock it to open it from this side." CR>)>)
	       (<VERB? KNOCK KICK ATTACK>
		<TELL "You knock on the door.">
		<COND (<HERE? ,CHEMISTRY-BLDG>
		       <QUEUE I-ANSWER-DOOR 3 T>
		       <TELL
" The hollow sound reverberates down the hall.
You sort of wish you had knocked more softly.">)>
		<CRLF>)
	       (<VERB? THROUGH>
		<COND (<HERE? ,ALCHEMY-DEPT>
		       <DO-WALK ,P?NORTH>)
		      (<HERE? ,CHEMISTRY-BLDG>
		       <DO-WALK ,P?SOUTH>)>)>>

<GLOBAL LEFT-ALCHEMY? <>>

<OBJECT ALCHEMY-WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "frosted glass window")
	(SYNONYM WINDOW GLASS)
	(ADJECTIVE FROSTED GLASS)
	(FLAGS NDESCBIT READBIT TRANSBIT)
	(ACTION ALCHEMY-WINDOW-F)>

<ROUTINE ALCHEMY-WINDOW-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a frosted glass window. It's more or less opaque.">
		<COND (<FSET? ,ALCHEMY-WINDOW ,RMUNGBIT>
		       <TELL
" It's covered with a maze of cracks.">)>
		<CRLF>)
	       (<VERB? READ KNOCK>
		<NEW-PRSO ,ALCHEMY-DOOR>
		<RTRUE>)
	       (<VERB? MUNG ATTACK>
		<COND (<HERE? ,CHEMISTRY-BLDG>
		       <QUEUE I-ANSWER-DOOR 3 T>)>
		<COND (<PRSI? <> ,HANDS>
		       <TELL
S "There is no effect"", other than your hands getting somewhat sore and
a lot of noise being produced." CR>)
		      (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		       <TELL
CTHE ,PRSI " bounces harmlessly off the glass." CR>)
		      (<FSET? ,PRSO ,RMUNGBIT>
		       <TELL
"Further attacks do little to worsen the damage." CR>)
		      (ELSE
		       <FSET ,PRSO ,RMUNGBIT>
		       <TELL
"You smash the glass, and cracks spread all over the pane from the point
of impact. The window remains whole, though, as it's made of wire
reinforced glass." CR>)>)>>
	       
<ROUTINE I-ANSWER-DOOR ()
	 <COND (<HERE? ,CHEMISTRY-BLDG>
		<COND (<NOT ,PROF-DEAD?>
		       <MOVE ,PROFESSOR ,ALCHEMY-DEPT>
		       <QUEUE I-PROFESSOR -1>
		       <TELL CR
"The door opens partway, revealing a professorial man
in a white lab coat. He smiles. ">
		       <COND (<NOT ,LEFT-ALCHEMY?>
			      <TELL "\"Good evening! I don't get many visitors
this late. You're not one of my students, are you?\"">)
			     (ELSE
			      <TELL "\"Back for another visit, are you?\"">)>
		       <TELL " He ushers you
into the room without waiting for an answer, closing the door behind
you." CR CR>
		       <GOTO ,ALCHEMY-DEPT>)
		      (ELSE
		       <TELL CR
"There is no sign of life behind the door." CR>)>)>>

<OBJECT SIGNUP
	(IN ALCHEMY-DEPT)
	(DESC "sign-up sheet")
	(FDESC
"Taped to the wall to the right of the archway is a sign-up sheet.")
	(SYNONYM SHEET)
	(ADJECTIVE SIGNUP SIGN-UP)
	(FLAGS TAKEBIT TRYTAKEBIT READBIT)
	(ACTION SIGNUP-F)>

<ROUTINE SIGNUP-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"This appears to be a sign-up sheet for the lab. Strangely, although
few daytime segments are used, almost all of the nighttime ones are.
Most seem to have been taken by two different people, the professor
and another, presumably one of his graduate students.">
		<FSET ,SIGNUP ,RMUNGBIT>
		<COND (<OR <FSET? ,NOTE ,RMUNGBIT>
			   ,REMEMBERED-STUDENT?>
		       <TELL
" With a start, you realize that the author of the suicide note was the
heavy user of the lab.">)
		      (ELSE
		       <QUEUE I-REMEMBER-STUDENT 4>
		       <TELL
" The name of the graduate student is oddly familiar.">)>
		<CRLF>)
	       (<VERB? TAKE>
		<COND (<IN? ,PROFESSOR ,HERE>
		       <TELL
"\"You can't take that! It's the only way we have to keep track of who's
signed up to use the lab.\"" CR>)>)>>

<GLOBAL REMEMBERED-STUDENT? <>>

<ROUTINE I-REMEMBER-STUDENT ()
	 <SETG REMEMBERED-STUDENT? T>
	 <TELL CR
"Suddenly, you remember why the graduate student's name was familiar.
He was a missing student, until his body was found smashed
and broken at the base of the tallest building on campus." CR>>

<OBJECT ARCHWAY
	(IN LOCAL-GLOBALS)
	(DESC "archway")
	(SYNONYM ARCH ARCHWAY)
	(FLAGS NDESCBIT)
	(ACTION ARCHWAY-F)>

<ROUTINE ARCHWAY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This archway, part of the oldest section of Tech, is between a lab
and the headquarters of the Alchemy Department.">
		<COND (<AND <HERE? ,ALCHEMY-DEPT>
			    <NOT <FSET? ,SIGNUP ,TOUCHBIT>>>
		       <TELL
,TO-THE-RIGHT "archway is a sheet of paper. It looks like a sign-up
sheet.">)>
		<CRLF>)
	       (<P? THROUGH>
		<COND (<HERE? ,ALCHEMY-LAB>
		       <DO-WALK ,P?NORTH>)
		      (ELSE
		       <DO-WALK ,P?SOUTH>)>)>>

<OBJECT LAB
	(IN LOCAL-GLOBALS)
	(DESC "laboratory")
	(SYNONYM LAB LABORATORY)
	(ADJECTIVE ALCHEMY)
	(ACTION LAB-F)>

<ROUTINE LAB-F ()
	 <COND (<VERB? ENTER THROUGH>
		<COND (<HERE? ,ALCHEMY-DEPT>
		       <DO-WALK ,P?SOUTH>)
		      (<HERE? ,UNDER-ALCHEMY-LAB>
		       <COND (<FSET? ,ALCHEMY-TRAP-DOOR ,OPENBIT>
			      <DO-WALK ,P?UP>)
			     (ELSE
			      <TELL ,REFERRING CR>)>)
		      (ELSE
		       <TELL ,ALREADY-IN-IT CR>)>)
	       (<P? THROW * LAB>
		<MOVE ,PRSO ,ALCHEMY-LAB>
		<TELL "Thrown." CR>)
	       (<VERB? DROP>
		<DO-WALK ,P?NORTH>)
	       (<VERB? LOOK-INSIDE>
		<COND (<HERE? ,ALCHEMY-DEPT>
		       <LIKE-A-PRSO "looks">)
		      (<HERE? ,UNDER-ALCHEMY-LAB>
		       <COND (<AND ,LIT
				   <FSET? ,ALCHEMY-TRAP-DOOR ,OPENBIT>>
			      <LIKE-A-PRSO "looks">)
			     (ELSE
			      <TELL ,REFERRING CR>)>)
		      (ELSE
		       <TELL ,ALREADY-IN-IT CR>)>)>>

<ROOM ALCHEMY-DEPT
      (IN ROOMS)
      (DESC "Department of Alchemy")
      (NORTH TO CHEMISTRY-BLDG IF ALCHEMY-DOOR IS OPEN)
      (SOUTH PER ALCHEMY-LAB-ENTER)
      (GLOBAL ALCHEMY-DOOR ALCHEMY-WINDOW ARCHWAY OUTLET LAB)
      (FLAGS ONBIT)
      (ACTION ALCHEMY-DEPT-F)>

<ROUTINE ALCHEMY-LAB-ENTER ()
	 <COND (<WINNER? ,URCHIN> <RFALSE>)
	       (<IN? ,PROFESSOR ,ALCHEMY-DEPT>
		<COND (<LAB-ENTER?> <CRLF> ,ALCHEMY-LAB)
		      (ELSE <RFALSE>)>)
	       (ELSE ,ALCHEMY-LAB)>>

<ROUTINE LAB-ENTER? ()
	 <COND (<NOT ,PROF-SEEN-NOTE?>
		<TELL
CTHE ,PROFESSOR " stops you, not too gently. \"Sorry,\" he says, although
he doesn't sound too sorry. \"There are very delicate experiments going
on in the lab. You might hurt something.\" All you can see before he
guides you away from the archway is a great deal of odd
apparatus and equipment." CR>
		<RFALSE>)
	       (ELSE
		<MOVE ,PROFESSOR ,ALCHEMY-LAB>
		<FSET ,ALCHEMY-LAB ,ONBIT>
		<TELL
"\"Ah! You'd like to see the lab?\" the professor asks in a rather
unctuous tone. \"Come right in!\" He ushers you through the archway
into the lab, following quickly behind you and turning on the lights." CR>)>>

<GLOBAL PROF-SEEN-NOTE? <>>
<GLOBAL PROF-MAD? <>>

;<GLOBAL PROF-CNT 0>

;<GLOBAL PROF-TBL
	<LTABLE "ever so gently"
		"not so gently"
		"roughly"
		"manhandling you">>

<GLOBAL TIED-UP? 0>

<GLOBAL PROF-FLAG <>>

<ROUTINE I-PROFESSOR ()
	 <COND (<HERE? ,ALCHEMY-LAB ,UNDER-ALCHEMY-LAB ,BRICK-TUNNEL>
		<SETG TIED-UP? <+ ,TIED-UP? 1>>
		<COND (<EQUAL? ,TIED-UP? 1>
		       <MOVE ,PLAYER ,PENTAGRAM>
		       <TELL CR
CTHE ,PROFESSOR " guides you to the center of the lab, where a
strange pentagonal symbol is chalked on the floor. ">
		       <COND (<FSET? ,PENTAGRAM ,RMUNGBIT>
			      <TELL "He repairs some scuff marks on it,
muttering about sloppy students. He then ">)
			     (ELSE
			      <TELL "He ">)>
		       <TELL "cuts one of the
chalk lines with a small knife you had not previously noticed, pushes
you into the center of the chalked symbol, and redraws the line, muttering
softly and rhythmically as he does so. \"There, that's done. Don't
move from there, it'll only make things worse for you.\" He makes some
odd gestures at the archway and then goes over to the lab bench." CR>)
		      (<EQUAL? ,TIED-UP? 2>
		       <TELL CR
CTHE ,PROFESSOR " is preparing something at the lab bench. \"Alchemy is
my chosen field, and I've gotten ridiculed for it. It's like
chemistry, except that chemists don't recognize that some natural laws
are enforced by persons, not physics. Some of them
will grant power, or knowledge, but they must be placated, or even bribed.
They're not of this earth, not demons or devils, and they aren't always
friendly. To me it's just an unpleasant necessity on the path to power.
When I'm done, they won't laugh anymore!\"" CR>)
		      (<EQUAL? ,TIED-UP? 3>
		       <TELL CR
CTHE ,PROFESSOR " enters another pentagram, and begins a highly
choreographed ritual. \"This may seem a little silly to you, but the
symbology is what's important. Certain alignments, certain aspects.
In a few moments, it won't matter anyway,\" he remarks. \"There is very
little room for error here, so be calm.\" He chants, he brandishes
strange instruments, moves about
inside the pentagram, and occasionally points to you. It becomes clear
exactly what he meant by the word \"bribe.\"" CR>)
		      (<EQUAL? ,TIED-UP? 4>
		       <TELL CR
"The chant grows more complex">
		       <COND (<FSET? ,PENTAGRAM ,RMUNGBIT>
			      <TELL
", the professor having difficulty with the almost unpronounceable words">)>
		       <TELL ", with rhythms and cadences that make
you want to stop your ears. The room appears to be getting darker." CR>)
		      (<EQUAL? ,TIED-UP? 5>
		       <MOVE ,MIST ,HERE>
		       <TELL CR
"A thick black mist begins to form in the room. Parts are darker, and
parts lighter, and the dark parts form a disturbing shape. The professor
chants and calls more loudly now">
		       <COND (<NOT <IN? ,PLAYER ,PENTAGRAM>>
			      <TELL ", clearly terrified of what may
happen">)
			     (<FSET? ,PENTAGRAM ,RMUNGBIT>
			      <TELL ", his voice rising in a kind of
hysteria">)>
		       <TELL ", and you realize the calls are being
answered." CR>)
		      (<EQUAL? ,TIED-UP? 6>
		       <TELL CR
"The room is now freezing cold, though the windows are shuttered and
tightly curtained. Low, bone-rattling vibrations shake the room in
cadence with the chant. The black mist is growing thicker. The professor ">
		       <COND (<NOT <IN? ,PLAYER ,PENTAGRAM>>
			      <TELL
"is alternately looking at you and at the mist." CR>)
			     (<FSET? ,PENTAGRAM ,RMUNGBIT>
			      <TELL
"gestures in your direction, an overtone of terror in his voice." CR>)
			     (ELSE
			      <TELL
"chants more rapidly, producing strange guttural sounds, scarcely
human." CR>)>)
		      (<EQUAL? ,TIED-UP? 7>
		       <COND (<HERE? ,ALCHEMY-LAB>
			      <TELL CR
"The black mist swirls wildly around the room, and a deep bass voice
gibbers out of thin air. ">
			      <COND (<NOT <IN? ,PLAYER ,PENTAGRAM>>
				     <TELL
"\"No!\" screams the professor, and jumps toward you out of his own
pentagram. He realizes what he has done, and tries to reenter, but the
mist grabs at him." CR>)
				    (ELSE
				     <TELL CTHE ,PROFESSOR>
				     <COND (<FSET? ,PENTAGRAM ,RMUNGBIT>
					    <TELL
" points madly toward you, and the mist follows." CR>)
					   (ELSE
					    <TELL
"'s brow drips with sweat." CR>)>)>)
			     (ELSE
			      <TELL CR
"You hear a deep bass voice, and a softer, pleading baritone." CR>)>)
		      (<EQUAL? ,TIED-UP? 8>
		       <REMOVE ,MIST>
		       <COND (<OR <IN? ,PLAYER ,PENTAGRAM>
				  <IN? ,PLAYER ,ALCHEMY-LAB>>
			      <CRLF>
			      <JIGS-UP
"A thing like a tentacle with a demonic face wraps slowly around you.
The room recedes into a great distance as you are pulled
away. Before you die, you see what the tentacle is a part of.">)
			     (ELSE
			      <SETG TIED-UP? 0>
			      <ROB ,PROFESSOR ,ALCHEMY-LAB>
			      <MOVE ,PROFESSOR ,GLOBAL-OBJECTS>
			      <SCORE-OBJECT ,PROFESSOR>
			      <SETG PROF-DEAD? T>
			      <FCLEAR ,ALCHEMY-LAB ,TOUCHBIT>
			      <FCLEAR ,ALCHEMY-LAB ,ONBIT>
			      <DEQUEUE I-PROFESSOR>
			      <TELL CR
"From above, you hear a thunderous noise, a maniacal scream, and
then the sound of equipment smashing. ">
			      <COND (<FSET? ,ALCHEMY-TRAP-DOOR ,OPENBIT>
				     <FCLEAR ,ALCHEMY-TRAP-DOOR ,OPENBIT>
				     <TELL
"The trapdoor slams shut, but around it">)
				    (ELSE
				     <TELL
"Around the trapdoor">)>
			      <TELL
" pours a blinding flash of light. Finally you hear an almost
inaudible whimper, then nothing. The light fades">
			      <IN-DARK?>)>)>)
	       (<HERE? ,ALCHEMY-DEPT>
		<TELL CR
CTHE ,PROFESSOR " ">
		<COND (<NOT ,PROF-FLAG>
		       <SETG PROF-FLAG T>
		       <TELL "gazes">)
		      (ELSE
		       <TELL "continues to gaze">)>
		<TELL " at you ">
		<COND (<AND ,PROF-MAD?
			    ,PROF-SEEN-NOTE?>
		       <TELL "with a distinctly predatory air." CR>)
		      (,PROF-MAD?
		       <TELL "with malign intent." CR>)
		      (ELSE
		       <TELL "in a bored and distracted way." CR>)>)
	       (ELSE
		<DEQUEUE I-PROFESSOR>
		<RFALSE>)>>

<GLOBAL PROF-DEAD? <>>

<OBJECT PENTAGRAM
	(IN ALCHEMY-LAB)
	(DESC "pentagram")
	(SYNONYM PENTAG SHAPE LINE LINES)
	(ADJECTIVE CHALK PENTAG)
	(FLAGS NDESCBIT VEHBIT OPENBIT CONTBIT SEARCHBIT)
	(CAPACITY 200)
	(ACTION PENTAGRAM-F)>

<ROUTINE PENTAGRAM-F ("OPT" (RARG <>) "AUX" O)
	 <COND (<RARG? BEG>
		<COND (<AND <VERB? READ LOOK-INSIDE>
			    <NOT-REACHABLE?>>
		       <TELL
,YOU-CANT-SEE THE ,PRSO " well enough from here to do that." CR>)
		      (<P? POUR * (<> ,GROUND)>
		       <NEW-PRSI ,PENTAGRAM>
		       <RTRUE>)
		      (<P? BOARD PENTAGRAM>
		       <TELL ,ALREADY-IN-IT CR>)
		      (<VERB? WALK>
		       <RFALSE> ;"all exits are handled in exit routines")
		      (<VERB? DISEMBARK EXIT>
		       <COND (<NOT ,TIED-UP?>
			      <MOVE ,WINNER ,HERE>
			      <CROSS-PENTAGRAM "out of">)
			     (<NOT <FSET? ,PENTAGRAM ,RMUNGBIT>>
			      <TELL
"Your feet approach the chalk line, and then stop. You can't push your
way out." CR>)
			     (ELSE
			      <MOVE ,WINNER ,HERE>
			      <TELL
S "You push your way through ""a soft spot just over the scuff marks, and
are outside the pentagram. The air is thick and close." CR>)>)
		      (<SET O <NOT-REACHABLE?>>
		       <COND (<FSET? ,PENTAGRAM ,RMUNGBIT>
			      <CANT-REACH-FROM-VEHICLE .O>)
			     (ELSE
			      <TELL
"Your hand won't pass over the chalk line." CR>)>)>)
	       (<RARG? <>>
		<COND (<VERB? EXAMINE>
		       <TELL
"For want of a better word, call this a pentagram. It isn't
particularly pentagonal, but it's an odd shape chalked on the floor,
and it's roughly pentagonal." CR>)
		      (<P? PUT * PENTAGRAM>
		       <COND (<IDROP>
			      <MOVE ,PRSO ,PENTAGRAM>
			      <TELL "Dropped." CR>)
			     (ELSE <RTRUE>)>)
		      (<VERB? BOARD>
		       <MOVE ,PLAYER ,PENTAGRAM>
		       <CROSS-PENTAGRAM "into">)
		      (<P? POUR (COKE NITROGEN) *>
		       <COND (<FSET? ,PENTAGRAM ,RMUNGBIT>
			      <TELL
"The pentagram is now almostly entirely effaced." CR>)
			     (ELSE
			      <TELL
CTHE ,PRSO " pours on the ground, spreading towards the lines of the
pentagram. As it reaches the nearest line, it begins to smoke and boil
away, but never quite touches the chalk." CR>)>)
		      (<VERB? RUB MUNG CUT ERASE OPEN>
		       <COND (<PRSI? <> ,HANDS ,FEET>
			      <TELL
"You try, but no part of your body will touch the chalk lines." CR>)
			     (<FSET? ,PENTAGRAM ,RMUNGBIT>
			      <TELL
"You scuff it up some more." CR>)
			     (<PRSI? ,KNIFE>
			      <FSET ,PENTAGRAM ,RMUNGBIT>
			      <TELL
"You cut the outer lines of the pentagram. It no longer completely
encloses you.">
			      <PROF-REACTS>)
			     (<OR <FSET? ,PRSI ,WEAPONBIT>
				  <FSET? ,PRSI ,TOOLBIT>>
			      <TELL
CTHE ,PRSI " passes over the chalk line, but doesn't have any effect on
it." CR>)
			     (ELSE
			      <TELL
CTHE ,PRSI " doesn't even touch the chalk line." CR>)>)
		      (<VERB? CLOSE>
		       <COND (<FSET? ,PENTAGRAM ,RMUNGBIT>
			      <TELL
S "You don't have " "a piece of chalk to close it with. Besides, you don't
know the incantation." CR>)>)>)>>

<ROUTINE CROSS-PENTAGRAM (DIR)
	 <TELL
"You get " .DIR " the pentagram, being careful not to further scuff the
chalk." CR>>

<ROUTINE PROF-REACTS ()
	 <COND (,TIED-UP?
		<TELL
" The professor sees what you've done out of the corner of his eye.">
		<COND (<G? ,TIED-UP? 2>
		       <TELL
" He stares, horrified. \"Stop, don't move!\" he says between verses of
the chant. The chant takes on a pleading tone.">)
		      (ELSE
		       <ROB ,PLAYER <>>
		       <FCLEAR ,PENTAGRAM ,RMUNGBIT>
		       <TELL
" He quickly slides over and redraws the pentagram. This time he performs
a thorough search, removing all your possessions, tut-tutting all the
while.">)>)>
	 <CRLF>>

<ROUTINE ALCHEMY-DEPT-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"This office is clinically clean, shiny, and modern. It looks like
something out of a science fiction movie. ">
		<COND (<FSET? ,ALCHEMY-DOOR ,OPENBIT>
		       <TELL "An open">)
		      (ELSE <TELL "A closed">)>
		<TELL " door to the north leads
back into the corridor and an archway opens to the south." CR>)
	       (<RARG? ENTER>
		<COND (<AND <EQUAL? ,OHERE ,CHEMISTRY-BLDG>
			    <NOT ,PROF-DEAD?>>
		       <FCLEAR ,ALCHEMY-DOOR ,LOCKED>
		       <FCLEAR ,ALCHEMY-DOOR ,OPENBIT>)>)>>

<ROOM ALCHEMY-LAB
      (IN ROOMS)
      (DESC "Lab")
      (NORTH PER ALCHEMY-LAB-EXIT)
      (DOWN PER ALCHEMY-LAB-DOWN-EXIT)
      (GLOBAL ARCHWAY ALCHEMY-TRAP-DOOR OUTLET LAB)
      (ACTION ALCHEMY-LAB-F)>

<ROUTINE ALCHEMY-LAB-DOWN-EXIT ()
	 <COND (<AND ,LAB-BENCH-MOVED?
		     <FSET? ,ALCHEMY-TRAP-DOOR ,OPENBIT>>
		<MOVE ,WINNER ,HERE>
		,UNDER-ALCHEMY-LAB)
	       (,LAB-BENCH-MOVED?
		<TELL "The trapdoor bars your way." CR>
		<RFALSE>)
	       (ELSE
		<TELL "There is no obvious way down from here." CR>
		<RFALSE>)>>

<ROUTINE ALCHEMY-LAB-EXIT ()
	 <COND (,TIED-UP?
		<COND (<FSET? ,PENTAGRAM ,RMUNGBIT>
		       <TELL
"You find the archway barred by a force you can't push through." CR>)
		      (ELSE
		       <TELL
"You find it very hard to move. Your feet reach the chalk line and then
seem to meet resistance, though there is nothing there but the chalk." CR>)>
		<RFALSE>)
	       (ELSE
		<MOVE ,WINNER ,HERE>
		,ALCHEMY-DEPT)>>

<ROUTINE ALCHEMY-LAB-F (RARG)
	 <COND (<RARG? LOOK>
		<COND (<NOT ,PROF-DEAD?>
		       <TELL
"The lab is an ultramodern, fully equipped chemistry lab. Unfortunately,
or perhaps fortunately, you aren't a chemistry major, so the equipment
might as well be magical.">)
		      (ELSE
		       <TELL
"The lab is a shambles. It looks like something red and sticky has
been spread over the walls, ceiling, and floor. Much of the equipment,
particularly that near the center of the room, has been destroyed.">)>
		<COND (,LAB-BENCH-MOVED?
		       <TELL " There is ">
		       <AN-OPEN/CLOSED ,ALCHEMY-TRAP-DOOR>
		       <TELL " in the floor." CR>)
		      (ELSE <CRLF>)>)
	       (<RARG? BEG>
		<COND (<P? EXAMINE GROUND>
		       <NEW-PRSO ,PENTAGRAM>
		       <RTRUE>)
		      (<VERB? EXAMINE READ LOOK-INSIDE
			      ASK-ABOUT TELL-ME-ABOUT TELL-ABOUT>
		       <RFALSE>)
		      (<AND <IN? ,PROFESSOR ,HERE>
			    <EQUAL? ,VAT ,PRSO ,PRSI>>
		       
		       <COND (<L? ,TIED-UP? 3>
			      <TELL
CTHE ,PROFESSOR ", none too gently, prevents you. \"Plenty of time for that
later,\" he cautions you." CR>)
			     (<EQUAL? ,PERFORM-DEPTH 1>
			      <TELL
CTHE ,PROFESSOR " watches you in horror, stumbling over his ritual." CR CR>
			      <RFALSE>)>)>)>>

<OBJECT ALCHEMY-TRAP-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "metal plate")
	(SYNONYM TRAPDOOR DOOR PLATE)
	(ADJECTIVE TRAP METAL)
	(FLAGS DOORBIT NDESCBIT OPENABLE)
	(ACTION ALCHEMY-TRAP-DOOR-F)>

<GLOBAL IT-LIFTS-BUT "It lifts a few inches, but then hits ">

<ROUTINE ALCHEMY-TRAP-DOOR-F ()
	 <COND (<HERE? ,ALCHEMY-LAB>
		<COND (<VERB? EXAMINE>
		       <TELL
,IT-LOOKS-LIKE "a hinged metal plate. There is a handle on one edge." CR>)
		      (<VERB? THROUGH>
		       <DO-WALK ,P?DOWN>)
		      (<VERB? OPEN RAISE>
		       <COND (<NOT ,LAB-BENCH-MOVED?>
			      <TELL
,IT-LIFTS-BUT "the lab bench and goes no further." CR>)
			     (<NOT <FSET? ,PRSO ,OPENBIT>>
			      <FSET ,ALCHEMY-TRAP-DOOR ,OPENBIT>
			      <TELL
"It swings open easily." CR>)>)
		      (<VERB? LOOK-INSIDE>
		       <COND (<FSET? ,ALCHEMY-TRAP-DOOR ,OPENBIT>
			      <TELL
"You see a dark tunnel below." CR>)
			     (ELSE
			      <TELL
"Your X-ray eyes appear to be nonfunctional today." CR>)>)>)
	       (ELSE
		<COND (<VERB? EXAMINE>
		       <TELL
,IT-LOOKS-LIKE "a metal plate in the ceiling." CR>)
		      (<VERB? THROUGH>
		       <DO-WALK ,P?UP>)
		      (<VERB? OPEN RAISE PUSH>
		       <COND (<NOT ,LAB-BENCH-MOVED?>
			      <TELL
,IT-LIFTS-BUT "something and goes no
further." CR>)
			     (<NOT <FSET? ,PRSO ,OPENBIT>>
			      <FSET ,ALCHEMY-TRAP-DOOR ,OPENBIT>
			      <TELL
"It pushes open easily." CR>)>)
		      (<VERB? LOOK-INSIDE LOOK-BEHIND>
		       <COND (<NOT ,LIT>
			      <TELL ,TOO-DARK>)
			     (<FSET? ,ALCHEMY-TRAP-DOOR ,OPENBIT>
			      <TELL
"You see a laboratory." CR>)
			     (ELSE
			      <TELL
"Pushing the plate up as far as you can, you can see part of a workroom or
lab of some kind." CR>)>)>)>>

<OBJECT STUDENTS
	(IN GLOBAL-OBJECTS)
	(DESC "missing students")
	(SYNONYM STUDENTS TOOLS)
	(ADJECTIVE MISSING GRADUATE GRAD)
	(FLAGS NDESCBIT PERSON)
	(ACTION STUDENTS-F)>

<ROUTINE STUDENTS-F ()
	 <GLOBAL-URCHINS-F ,STUDENTS>>

<OBJECT GLOBAL-URCHINS
	(IN GLOBAL-OBJECTS)
	(DESC "missing urchins")
	(SYNONYM URCHIN KIDS CHILDREN)
	(ADJECTIVE MISSING)
	(FLAGS NDESCBIT PERSON)
	(ACTION GLOBAL-URCHINS-F)>

<ROUTINE YOU-SEE-NO (OBJ)
	 <TELL
"You see no " D .OBJ "." CR>>

<ROUTINE GLOBAL-URCHINS-F ("OPT" (OBJ <>))
	 <COND (<NOT .OBJ> <SET OBJ ,GLOBAL-URCHINS>)>
	 <COND (<OR <WINNER? .OBJ>
		    <VERB? TELL SAY HELLO>>
		<TELL
"There is no reply." CR>
		<COND (<PRSO? .OBJ>
		       <END-QUOTE>
		       <RFATAL>)
		      (ELSE <RTRUE>)>)
	       (<OR <HOSTILE-VERB?>
		    <VERB? SHOW SEARCH FIND>
		    <P? (EXAMINE TELL-ABOUT) .OBJ>>
		<YOU-SEE-NO .OBJ>)
	       (<VERB? HELP UNTIE>
		<BEYOND-HELP>)
	       (<P? WHAT (URCHINS GLOBAL-URCHINS)>
		<TELL
"That's what students call the local children who sometimes hang
around Tech. They are usually blamed when anything is stolen,
generally mistrusted, and often booted off campus by the campus
police." CR>)>>

<ROUTINE BEYOND-HELP ()
	 <TELL "They ">
	 <COND (<AND <EQUAL? ,PRSO ,STUDENTS> ,SEEN-PIT?>
		<TELL "are">)
	       (ELSE <TELL "may be">)>
	 <TELL " beyond help." CR>>

<OBJECT LOVECRAFT
	(IN ALCHEMY-LAB)
	(DESC "Alchemy Department computer")
	(SYNONYM LOVECRAFT PC COMPUTER SCREEN)
	(ADJECTIVE ALCHEMY DEPART)
	(FLAGS READBIT AN)
	(TEXT "Written with a marking pen on the display is \"Lovecraft.\"")
	(SIZE 30)
	(ACTION LOVECRAFT-F)>

<ROUTINE LOVECRAFT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This machine looks just like the ones in the terminal room. ">
		<TELL <GETP ,PRSO ,P?TEXT>>
		<COND (<NOT <FSET? ,LOVECRAFT ,POWERBIT>>
		       <TELL " It's turned off.">)>
		<CRLF>)
	       (<VERB? WHO>
		<TELL
"I suggest you consult your local library or any practitioner of
the occult arts." CR>)
	       (<VERB? LAMP-ON>
		<COND (<NOT <FSET? ,LOVECRAFT ,POWERBIT>>
		       <FSET ,LOVECRAFT ,POWERBIT>
		       <TELL
"You turn the machine on, it performs a quick self-check, and then displays
a message on the screen: "
S "\"Unable to boot because: No disk inserted. Please
insert a dismountable disk.\"">
		       <COND (<IN? ,PROFESSOR ,HERE>
			      <TELL
" The professor, who has been watching you, smiles.">)>
		       <CRLF>)
		      (ELSE
		       <TELL
"It's on, for what little good that will do you." CR>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,LOVECRAFT ,POWERBIT>
		       <COMPUTER-POWERS-OFF>)
		      (ELSE
		       <ITS-ALREADY-X "off">)>)>>

<OBJECT RING
	(IN PROFESSOR)
	(DESC "brass hyrax")
	(SYNONYM RING HYRAX)
	(ADJECTIVE BRASS GOLD)
	(FLAGS TAKEBIT TRYTAKEBIT TOUCHBIT)
	(ACTION RING-F)>

<ROUTINE RING-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The G.U.E. Tech class ring is a gold ring depicting a hyrax
eating a twig. Such rings are familiarly known as \"brass
hyraxes.\"" CR>)
	       (<AND <VERB? TAKE-OFF>
		     <FSET? ,GLOVES ,WEARBIT>>
		<TELL
,YOU-HAVE-TO "take off your gloves first." CR>)
	       (<VERB? WEAR>
		<COND (<FSET? ,GLOVES ,WEARBIT>
		       <TELL
CTHE ,RING " won't go on over the gloves." CR>)
		      (<EQUAL? <IWEAR> T>
		       <TELL
"It fits surprisingly well." CR>)
		      (ELSE <RTRUE>)>)>>

<OBJECT PROFESSOR
	(IN ALCHEMY-DEPT)
	(DESC "professor")
	(SYNONYM PROFESSOR ALCHEMY MAN PROF)
	(FLAGS PERSON OPENBIT CONTBIT SEARCHBIT)
	(VALUE 5)
	(CONTFCN PROFESSOR-F)
	(DESCFCN PROFESSOR-DESC)
	(ACTION PROFESSOR-F)>

<ROUTINE PROFESSOR-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?> <RTRUE>)
	       (ELSE
		<TELL CTHE ,PROFESSOR " is ">
		<COND (<G? ,TIED-UP? 2>
		       <TELL "performing a strange ritual ">)>
		<TELL "here.">
		<RFATAL>)>>

<ROUTINE PROFESSOR-F ("OPT" (RARG <>))
	 <COND (<RARG? CONTAINER>
		<COND (<OR <VERB? EXAMINE TAKE SHOW WEAR>
			   <AND <WINNER? ,PROFESSOR>
				<VERB? GIVE>>>
		       <COND (<PRSO? ,RING>
			      <SETG PROF-MAD? T>
			      <TELL
"He thrusts his hand into his pocket." CR>)
			     (ELSE
			      <TELL
"\"You'll get it. All in good time.\"" CR>)>)>)
	       (<WINNER? ,PROFESSOR>
		<COND (<VERB? GIVE> <RFALSE>)
		      (<VERB? TELL-ME-ABOUT>
		       <COND (<G? ,TIED-UP? 2>
			      <TELL
CTHE ,PROFESSOR " is intently following his ritual and won't be
distracted." CR>)
			     (<PRSO? ,ODD-PAPER>
			      <SETG PROF-MAD? T>
			      <TELL
"\"I don't like your insinuations.\"" CR>)
			     (<PRSO? ,RING>
			      <TELL
"\"Just a trinket.\"" CR>)
			     (<PRSO? ,LAB>
			      <COND (<LAB-ENTER?>
				     <CRLF>
				     <GOTO ,ALCHEMY-LAB>)
				    (ELSE <RTRUE>)>)
			     (<PRSO? ,SIGNUP>
			      <TELL
"\"We don't have much lab space. Everyone has to sign up for lab time.\"" CR>)
			     (<PRSO? ,STUDENTS>
			      <TELL
"\"I don't know anything about them. Tech is high-pressure.
Some people can't take it.\"" CR>)
			     (<PRSO? ,NOTE>
			      <COND (,PROF-SEEN-NOTE?
				     <TELL
"\"Obviously a nut case. He knew he was going to
flunk out, and this is clearly an attempt to put the blame somewhere
else.\"" CR>)
				    (ELSE
				     <TELL
"\"What note is that?\" he asks, nervously." CR>)>)
			     (<PRSO? ,VAT>
			      <TELL
"\"Just a little experiment of mine. The label is just a joke.\"" CR>)
			     (<PRSO? ,LOVECRAFT>
			      <TELL
"\"The machines in our department have names like that. Lovecraft
wrote some stories about alchemy. We've got Paracelsus, Dunsany,
and a couple of others, too.\"" CR>)>)
		      (,TIED-UP?
		       <TELL
,NO-RESPONSE CR>)
		      (ELSE
		       <TELL
CTHE ,PROFESSOR " looks at you in much the way a cat looks at
a mouse." CR>)>)
	       (<AND ,PROF-DEAD?
		     <NOT <ABSTRACT-VERB?>>>
		<TELL CTHE ,PROFESSOR " is no more." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The man looks like a professor. He's wearing a white lab coat, rather
stained with chemicals, and a G.U.E. Tech class ring. ">
		<COND (<HERE? ,ALCHEMY-DEPT>
		       <TELL
"He watches you with an ambiguously predatory air." CR>)
		      (ELSE
		       <TELL
"He's working on something at the lab bench in front of him." CR>)>)
	       ;(<P? ASK-FOR PROFESSOR>
		<PERFORM ,V?TAKE ,PRSI>
		<RTRUE>)
	       (<P? (SHOW GIVE) * PROFESSOR>
		<COND (<G? ,TIED-UP? 2>
		       <TELL
CTHE ,PROFESSOR " is nervously following his ritual." CR>)
		      (<PRSO? ,SMOOTH-STONE ,HAND ,KNIFE>
		       <SETG PROF-MAD? T>
		       <MOVE ,PRSO ,PROFESSOR>
		       <TELL
"\"Very interesting! I'll take that!\"" CR>)
		      (<PRSO? ,NOTE>
		       <SETG PROF-SEEN-NOTE? T>
		       <SETG PROF-MAD? T>
		       <MOVE ,NOTE ,PROFESSOR>
		       <TELL
"He reads it carefully. \"What drivel! This just confirms my suspicions.
He had clearly gone over the edge. Drug use, drinking, insanity.
It's only too bad that I didn't realize what was happening. I might have
helped him.\"" CR>)
		      (ELSE
		       <TELL
"He doesn't seem interested." CR>)>)
	       (<VERB? THROW> <RFALSE>)
	       (<HOSTILE-VERB?>
		<COND (<G? ,TIED-UP? 6>
		       <TELL
"The mist protects him, almost possessively." CR>)
		      (<G? ,TIED-UP? 2>
		       <TELL
CTHE ,PROFESSOR ", in his pentagram, is invulnerable." CR>)
		      (ELSE
		       <SETG PROF-MAD? T>
		       <TELL
"With contemptuous ease, the professor prevents you.">
		       <COND (<AND ,PRSI <FSET? ,PRSI ,WEAPONBIT>>
			      <MOVE ,PRSI ,PROFESSOR>
			      <TELL
" \"I'll take this,\" he says. \"Just for safekeeping.\" He makes "
THE ,PRSI " disappear.">)>
		       <CRLF>)>)>>

<OBJECT LAB-BENCH
	(IN ALCHEMY-LAB)
	(DESC "lab bench")
	(SYNONYM BENCH)
	(ADJECTIVE LAB)
	(FLAGS SURFACEBIT OPENBIT CONTBIT SEARCHBIT)
	(CAPACITY 200)
	(ACTION LAB-BENCH-F)>

<ROUTINE LAB-BENCH-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The bench is a chemistry lab bench. It has a marble top, and casters
at each corner. Various equipment litters the bench, none of which you
recognize">
		<COND (<FIRST? ,LAB-BENCH>
		       <TELL
", but the lab bench also contains ">
		       <DESCRIBE-REST ,LAB-BENCH>)>
		<TELL ,PERIOD>)
	       (<VERB? LOOK-UNDER>
		<COND (<NOT ,LAB-BENCH-MOVED?>
		       <TELL
"You can see a metal plate beneath the bench. Only part
of it is visible." CR>)
		      (ELSE
		       <TELL "Nothing but concrete floor there." CR>)>)
	       (<VERB? MOVE PUSH>
		<COND (<NOT ,LAB-BENCH-MOVED?>
		       <SETG LAB-BENCH-MOVED? T>
		       <TELL
"It's heavy, but it moves, revealing a hinged metal trapdoor beneath." CR>)
		      (ELSE
		       <TELL "It rolls a little." CR>)>)>>

<GLOBAL LAB-BENCH-MOVED? <>>

<OBJECT VAT
	(IN LAB-BENCH)
	(DESC "vat")
	(SYNONYM VAT LABEL)
	(ADJECTIVE VAT BUBBLING GLASS PYREX STICKY)
	(FLAGS TAKEBIT READBIT OPENBIT CONTBIT TRANSBIT SEARCHBIT)
	(CAPACITY 20)
	(SIZE 20)
	(TEXT
"The text is a long chemical-sounding name typed on a
label affixed to the container. Below is written in pencil
\"Elixir of Life.\"")
	(CONTFCN VAT-CONT-F)
	(ACTION VAT-F)>

<ROUTINE VAT-CONT-F (RARG)
	 <COND (<VERB? TAKE>
		<COND (<PRSO? ,ELIXIR>
		       <TELL
,YOU-CANT "take it, it's a liquid." CR>
		       <RTRUE>)
		      (<EQUAL? <ITAKE> <> ,M-FATAL>
		       <RTRUE>)
		      (<AND <PRSO? ,HAND>
			    <FSET? ,HAND ,PERSON>>
		       <TELL
"You grab the wiggling hand and draw it forth, newly animated, from the
vat.">)
		      (ELSE
		       <TELL
"You reach into the liquid, fish around rapidly due to the
horrible feel of the chemicals, and draw out " THE ,PRSO ".">)>
		<TELL
" As it emerges, the elixir flows off.">
		<COND (<AND <PRSO? ,HAND>
			    <FSET? ,HAND ,PERSON>>
		       <SETG SCORE <+ ,SCORE ,HAND-ANIMATED-SCORE>>
		       <SETG HAND-ANIMATED-SCORE 0>
		       <TELL
" The hand scuttles up your arm and perches quietly on your
shoulder.">)>
		       <CRLF>)>>

<ROUTINE VAT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
S "This is a large ""(a couple of liters, at least) glass or pyrex vat. It
has a label stuck to it. ">
		<DESCRIBE-SENT ,VAT>
		<CRLF>)
	       (<AND <P? PUT * VAT>
		     <IN? ,ELIXIR ,VAT>>
		<COND (<PRSO? ,DEAD-RAT>
		       <REMOVE ,DEAD-RAT>
		       <TELL
"You dip the dead rat into the elixir. Almost immediately it convulses,
begins to flop around in the liquid, and then springs out onto the
floor! It scurries away before you can catch it." CR>)
		      (<PRSO? ,HAND>
		       <MOVE ,HAND ,VAT>
		       <COND (<FSET? ,HAND ,PERSON>
			      <TELL
"Nothing unusual happens (compared to the first time, anyway)." CR>)
			     (ELSE
			      <QUEUE I-ANIMATE-HAND -1>
			      <TELL
"When you dip the mummified hand in the liquid, the elixir begins to
bubble furiously. You can't really see the hand, except when
a finger pokes up every so often." CR>)>)
		      (<PRSO-TOO-BIG?>
		       <TELL ,NO-ROOM CR>)
		      (ELSE
		       <FCLEAR ,PRSO ,WEARBIT>
		       <MOVE ,PRSO ,VAT>
		       <TELL
"You drop " THE ,PRSO " into the vat, where it is completely covered
by the tarry liquid." CR>)>)
	       (<VERB? OPEN CLOSE>
		<TELL-YUKS>)
	       (<P? POUR VAT>
		<NEW-PRSO ,ELIXIR>
		<RTRUE>)
	       (<VERB? REACH-IN>
		<TELL
"You feel the thick tarry liquid." CR>)>>

<OBJECT ELIXIR
	(IN VAT)
	(DESC "tarry liquid")
	(SYNONYM LIQUID ELIXIR LIFE)
	(ADJECTIVE TARRY BLACK ELIXIR)
	(FLAGS TAKEBIT TRYTAKEBIT)
	(ACTION ELIXIR-F)>

<ROUTINE ELIXIR-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The elixir is thick and tarry. Torpid bubbles break the
surface every so often, though you can find no source of heat to
produce them." CR>)
	       (<VERB? DRINK>
		<TELL
"It would be like drinking road tar." CR>)
	       (<VERB? RUB>
		<TELL
"You touch the liquid with your finger. It's very unpleasant.
The liquid is stingingly hot. You pull your finger out, and
it is some time before it feels normal again." CR>)
	       (<P? TAKE * <>>
		<COND (<IN? ,ELIXIR ,VAT>
		       <NEW-PRSO ,VAT>
		       <RTRUE>)>)
	       (<P? (POUR DROP THROW) ELIXIR>
		<TELL
"Remember those ketchup commercials? Remember how slow the winning
ketchup was? Well, this is a lot slower. The liquid has a very
high surface tension, and pours so slowly that you'd be here all night
waiting for it to finish." CR>)
	       (<P? PUT * ,ELIXIR>
		<NEW-PRSI ,VAT>)>>

<GLOBAL HAND-ANIMATED-SCORE 5>

<GLOBAL ANIMATION-COUNT 0>

<ROUTINE I-ANIMATE-HAND ("AUX" (HERE? <>))
	 <COND (<NOT <IN? ,HAND ,VAT>>
		<DEQUEUE I-ANIMATE-HAND>
		<RFALSE>)>
	 <COND (<EQUAL? <META-LOC ,VAT> ,HERE>
		<SET HERE? T>)>
	 <COND (<OR <G? <SETG ANIMATION-COUNT <+ ,ANIMATION-COUNT 1>> 2>
		    <FSET? ,HAND ,PERSON>>
		<FSET ,HAND ,PERSON>
		<COND (.HERE?
		       <TELL CR
"The hand is trying to crawl out of the vat.">
		       <COND (<NOT <FSET? ,HAND ,PERSON>>
			      <TELL
" The fingers flex and grab at the slippery sides, but in vain.">)>
		       <CRLF>)>)
	       (<EQUAL? ,ANIMATION-COUNT 1>
		<COND (.HERE?
		       <TELL CR
"The hand bobs to the surface. It's odd, but it looked like one of the
fingers moved." CR>)>)
	       (ELSE
		<COND (.HERE?
		       <TELL CR
"The hand splashes to the surface. The fingers are moving!" CR>)>)>>

<ROOM ENGINEERING-BLDG
      (IN ROOMS)
      (DESC "Engineering Building")
      (LDESC
"This building extends a long way south from the Infinite Corridor. It
too is full of closed, locked offices.")
      (EAST "The offices are all closed, locked, and dark.")
      (WEST "The offices are all closed, locked, and dark.")
      (SOUTH "The offices are all closed, locked, and dark.")
      (NORTH TO INF-1)
      (FLAGS ONBIT)
      (GLOBAL OFFICE-DOOR)>

<ROOM INF-1
      (IN ROOMS)
      (DESC "Infinite Corridor")
      (SIZE 1)
      (WEST TO MASS-AVE)
      (OUT TO MASS-AVE)
      (EAST PER WAXER-EXIT) ;INF-2
      (NORTH TO AERO-LOBBY)
      (SOUTH TO ENGINEERING-BLDG)
      (GLOBAL POWER-CORD GLOBAL-MAINTENANCE-MAN GLOBAL-FLOOR-WAXER
       OUTSIDE-DOOR OFFICE-DOOR)
      (FLAGS ONBIT)
      (ACTION INF-F)>

<ROOM INF-2
      (IN ROOMS)
      (DESC "Infinite Corridor")
      (SIZE 2)
      (WEST TO INF-1)
      (EAST PER WAXER-EXIT) ;INF-3
      (NORTH "The offices are all closed, locked, and dark.")
      (SOUTH "The offices are all closed, locked, and dark.")
      (GLOBAL POWER-CORD GLOBAL-FLOOR-WAXER GLOBAL-MAINTENANCE-MAN
	      OFFICE-DOOR)
      (FLAGS ONBIT)
      (ACTION INF-F)>

<ROOM INF-3
      (IN ROOMS)
      (DESC "Infinite Corridor")
      (SIZE 3)
      (WEST TO INF-2)
      (EAST PER WAXER-EXIT) ;INF-4
      (UP TO GREAT-DOME)
      (SOUTH PER GREAT-COURT-EXIT)
      (OUT PER GREAT-COURT-EXIT)
      (GLOBAL POWER-CORD GLOBAL-FLOOR-WAXER GLOBAL-MAINTENANCE-MAN
        OFFICE-DOOR OUTSIDE-DOOR)
      (FLAGS ONBIT)
      (ACTION INF-F)>

<GLOBAL DOOR-WARNING <>>

<ROUTINE GREAT-COURT-EXIT ()
	 <COND (<WINNER? ,URCHIN> <RFALSE>)
	       (,DOOR-WARNING ,GREAT-COURT)
	       (ELSE
		<SETG DOOR-WARNING T>
		<TELL
"Remember, this is one of the doors that's always locked at night.
You won't be able to get back in if you go out." CR>
		<RFALSE>)>>

<ROOM INF-4
      (IN ROOMS)
      (DESC "Infinite Corridor")
      (SIZE 4)
      (WEST TO INF-3)
      (EAST PER WAXER-EXIT) ;INF-5
      (NORTH "The offices are all closed, locked, and dark.")
      (SOUTH "The offices are all closed, locked, and dark.")
      (GLOBAL POWER-CORD GLOBAL-FLOOR-WAXER GLOBAL-MAINTENANCE-MAN OFFICE-DOOR)
      (FLAGS ONBIT)
      (ACTION INF-F)>

<ROOM INF-5
      (IN ROOMS)
      (SIZE 5)
      (DESC "Infinite Corridor")
      (WEST TO INF-4)
      (NORTH PER WAXER-EXIT) ;NUTRITION-BLDG
      (SOUTH PER WAXER-EXIT) ;CHEMISTRY-BLDG
      (GLOBAL POWER-CORD GLOBAL-FLOOR-WAXER GLOBAL-MAINTENANCE-MAN)
      (FLAGS ONBIT)
      (ACTION INF-F)>

<ROUTINE WAXER-EXIT ()
	 <COND (<WINNER? ,URCHIN> <INF-EAST-EXIT <LOC ,URCHIN>>)
	       (<AND <IN? ,FLOOR-WAXER ,HERE>
		     <IN? ,MAINTENANCE-MAN ,FLOOR-WAXER>>
		<THIS-IS-IT ,MAINTENANCE-MAN>
		<COND (,CORD-SEVERED?
		       <MAINT-DESCENDS>
		       <COND (<IN? ,FLOOR-WAX <LOC ,MAINTENANCE-MAN>>
			      <INF-EAST-EXIT ,HERE>)>)
		      (ELSE
		       <TELL
"In a deft maneuver, " THE ,MAINTENANCE-MAN " steers the " 'FLOOR-WAXER " into
your path, blocking your advance." CR>)>
		<RFALSE>)
	       (<AND ,CORD-SEVERED?
		     <IN? ,MAINTENANCE-MAN ,HERE>
		     <FSET? ,MAINTENANCE-MAN ,PERSON>
		     <NOT <IN? ,FLOOR-WAX ,HERE>>>
		<THIS-IS-IT ,MAINTENANCE-MAN>
		<TELL
CTHE ,MAINTENANCE-MAN S " lurches toward you" ", grasping and panting. There is
no way to go around him." CR>
		<RFALSE>)
	       (ELSE
		<INF-EAST-EXIT ,HERE>)>>

<ROUTINE INF-EAST-EXIT (L)
	 <COND (<EQUAL? .L ,INF-1>
		,INF-2)
	       (<EQUAL? .L ,INF-2>
		,INF-3)
	       (<EQUAL? .L ,INF-3>
		,INF-4)
	       (<EQUAL? .L ,INF-4>
		,INF-5)
	       (<EQUAL? .L ,INF-5>
		<COND (<EQUAL? ,P-WALK-DIR ,P?NORTH>
		       ,NUTRITION-BLDG)
		      (ELSE
		       ,CHEMISTRY-BLDG)>)>>

<ROUTINE INF-F (RARG "AUX" L)
	 <COND (<RARG? LOOK>
		<TELL
"The so-called infinite corridor runs from east to west in the main
campus building.">
		<COND (<HERE? ,INF-1>
		       <TELL " This is the west end.">)
		      (<HERE? ,INF-2 ,INF-3 ,INF-4>
		       <TELL " The corridor extends both ways from here.">)
		      (<HERE? ,INF-5>
		       <TELL " This is the east end.">)>
		<COND (<HERE? ,INF-2 ,INF-4>
		       <TELL
" Many closed and locked offices are to the north and south.">)
		      (<HERE? ,INF-1>
		       <TELL
" Side corridors lead north and south, and a set of doors leads west into
the howling blizzard.">)
		      (<HERE? ,INF-3>
		       <TELL
" A stairway leads up, and a door leads out to the Great Court.">)
		      (<HERE? ,INF-5>
		       <TELL
" The corridor branches north and south here.">)>
		<CRLF>)
	       (<RARG? END>
		<COND (<AND <NOT <IN? ,FLOOR-WAXER ,HERE>>
			    <VERB? WALK LOOK>> 
		       <TELL CR
S "There is a ""largish machine ">
		       <COND (<NOT ,CORD-SEVERED?>
			      <TELL "being operated ">)>
		       <TELL ,DOWN-THE-HALL>
		       <FLOOR-WAXER-DIRECTION>
		       <CRLF>)>)
	       (<RARG? ENTER>
		<SETG DOOR-WARNING <>>
		<COND (<EQUAL? ,OHERE ,INF-1 ,INF-2 ,INF-3 ,INF-4 ,INF-5>)
		      (<AND <NOT <FSET? ,HERE ,TOUCHBIT>>
			    <NOT <QUEUE I-WAXER-MOVES 10 T>>>
		       T)
		      (<AND <IN? ,MAINTENANCE-MAN ,HERE>
			    <FSET? ,MAINTENANCE-MAN ,PERSON>>
		       <QUEUE I-MAINT-ATTACK -1>)>)>>

<ROUTINE FLOOR-WAXER-DIRECTION ("AUX" L)
	 <SET L <LOC ,FLOOR-WAXER>>
	 <COND (<OR <HERE? ,INF-1>
		    <AND <HERE? ,INF-2>
			 <EQUAL? .L ,INF-3 ,INF-4 ,INF-5>>
		    <AND <HERE? ,INF-3>
			 <EQUAL? .L ,INF-4 ,INF-5>>
		    <AND <HERE? ,INF-4>
			 <EQUAL? .L ,INF-5>>>
		<TELL "east.">)
	       (ELSE
		<TELL "west.">)>>

<OBJECT GLOBAL-MAINTENANCE-MAN
	(IN LOCAL-GLOBALS)
	(DESC "maintenance man")
	(SYNONYM MAN)
	(ADJECTIVE MAINTENANCE)
	(FLAGS PERSON)
	(GENERIC GENERIC-MAINTENANCE-MAN-F)
	(ACTION GLOBAL-MAINTENANCE-MAN-F)>

<ROUTINE GENERIC-MAINTENANCE-MAN-F ()
	 <COND (<EQUAL? <META-LOC ,MAINTENANCE-MAN> ,HERE>
		,MAINTENANCE-MAN)
	       (ELSE
		,GLOBAL-MAINTENANCE-MAN)>>

<ROUTINE GLOBAL-MAINTENANCE-MAN-F ()
	 <COND (<VERB? EXAMINE FIND>
		<COND (<LOC ,MAINTENANCE-MAN>
		       <MAINTENANCE-MAN-F>)
		      (ELSE
		       <YOU-SEE-NO ,MAINTENANCE-MAN>)>)
	       (<AND <P? POUR * GLOBAL-MAINTENANCE-MAN>
		     <HERE? ,GREAT-DOME>
		     <IN? ,MAINTENANCE-MAN ,INF-3>>
		<RFALSE>)
	       (<NOT <ABSTRACT-VERB?>>
		<TELL "He's not here, but he might be soon!" CR>
		<COND (<VERB? TELL>
		       <END-QUOTE>)
		      (ELSE <RTRUE>)>)>>

<OBJECT MAINTENANCE-MAN
	(IN FLOOR-WAXER)
	(DESC "maintenance man")
	(SYNONYM MAN)
	(ADJECTIVE MAINTENANCE)
	(FLAGS PERSON)
	(GENERIC GENERIC-MAINTENANCE-MAN-F)
	(ACTION MAINTENANCE-MAN-F)>

<ROUTINE MAINTENANCE-MAN-F ("AUX" W)
	 <COND (<WINNER? ,MAINTENANCE-MAN>
		<COND (<NOT <EQUAL? <META-LOC ,MAINTENANCE-MAN> ,HERE>>
		       <TELL "He" ,IS-DOWN-THE-HALL>)
		      (ELSE
		       <COND (,CORD-SEVERED?
			      <TELL
"He snarls at you angrily.">)
			     (ELSE
			      <TELL
"He replies in a language you do not recognize.">)>
		       <TELL " The words are
guttural and jarring." CR>)>
		<END-QUOTE>) 
	       (<VERB? EXAMINE>
		<COND (,CORD-SEVERED?
		       <TELL
CTHE ,MAINTENANCE-MAN " is very annoyed with you." CR>)
		      (ELSE
		       <TELL
"He looks tired, bored, almost zombie-like." CR>)>)
	       (<VERB? SHOW GIVE>
		<TELL
"He doesn't react." CR>)
	       (<OR <VERB? ATTACK KILL>
		    <P? THROW * ,MAINTENANCE-MAN>>
		<COND (<NOT <VERB? THROW>>
		       <SET W ,PRSI>)
		      (ELSE
		       <SET W ,PRSO>)>
		<COND (<OR <VERB? THROW> <EQUAL? .W ,AXE>>
		       <MOVE .W <META-LOC ,MAINTENANCE-MAN>>)>
		<COND (<EQUAL? .W <> ,HANDS>
		       <TELL
,YOU-CANT "hurt him with your hands!" CR>)
		      (ELSE
		       <TELL CTHE .W " ">
		       <COND (<IN? ,MAINTENANCE-MAN ,FLOOR-WAXER>
			      <COND (<VERB? THROW>
				     <TELL
S "misses by a mile""!" CR>)
				    (ELSE
				     <TELL
"can't reach him in " THE ,FLOOR-WAXER "!" CR>)>)
			     (<QUEUED? I-MAINT-DISSOLVES>
			      <TELL
S "misses by a mile"" as " THE ,MAINTENANCE-MAN " slips again!" CR>)
			     (<EQUAL? .W ,AXE>
			      <COND (<VERB? THROW>
				     <TELL
"sails through the air, end over end, and makes a direct hit in">)
				    (ELSE
				     <TELL
"chops into">)>
			      <TELL
" his chest, where it sticks. Ed Ames would be proud. The force of the
blow staggers him a
bit. He looks down at the axe with a certain perplexity, then pulls it
free, the wound making a sickening sucking sound." CR>)
			     (<EQUAL? .W ,SMOOTH-STONE>
			      <TELL
"hits him right between the eyes. He falls to the ground,
stunned. There is now what looks like a large burn mark on his forehead.
He ignores it and rises." CR>)
			     (<EQUAL? .W ,NITROGEN>
			      <TELL
"makes a good show, but none actually gets on him." CR>)
			     (<FSET? .W ,WEAPONBIT>
			      <COND (<OR <VERB? THROW> <EQUAL? .W ,AXE>>
				     <TELL
"sails toward him, but he bats it">)
				    (ELSE
				     <TELL
"is pushed">)>
			      <TELL " contemptuously aside,
barely slowing his advance." CR>)
			     (ELSE
			      <TELL
"does about as much damage as a piece of thistledown." CR>)>)>)
	       (<VERB? WALK-AROUND>
		<COND (,CORD-SEVERED?
		       <TELL
,YOU-CANT "evade him." CR>)>)>>

<GLOBAL WAX-WEST? <>>

<ROUTINE I-WAXER-MOVES ("AUX" (L <LOC ,FLOOR-WAXER>) NL TMP)
	 <QUEUE I-WAXER-MOVES 5>
	 <COND (<AND ,WAX-WEST? <EQUAL? .L ,INF-1>>
		<SETG WAX-WEST? <>>)
	       (<AND <NOT ,WAX-WEST?> <EQUAL? .L ,INF-5>>
		<SETG WAX-WEST? T>)>
	 <COND (,WAX-WEST?
		<COND (<AND <EQUAL? .L ,INF-3>
			    <HERE? ,GREAT-DOME ,TOP-OF-DOME
				   ,DOME-ROOF ,ON-DOME>>
		       <SETG WAX-WEST? <>>
		       <RFALSE>)
		      (<HERE? .L>
		       <SETG WAX-WEST? <>>
		       <TELL CR
CTHE ,FLOOR-WAXER " continues waxing a section of floor nearby. "
CTHE ,MAINTENANCE-MAN " operating it stares at you suspiciously." CR>
		       <RTRUE>)>
		<COND (<EQUAL? .L ,INF-2>
		       <SET NL ,INF-1>)
		      (<EQUAL? .L ,INF-3>
		       <SET NL ,INF-2>)
		      (<EQUAL? .L ,INF-4>
		       <SET NL ,INF-3>)
		      (<EQUAL? .L ,INF-5>
		       <SET NL ,INF-4>)>)
	       (ELSE
		<COND (<EQUAL? .L ,INF-4>
		       <SET NL ,INF-5>)
		      (<EQUAL? .L ,INF-3>
		       <SET NL ,INF-4>)
		      (<EQUAL? .L ,INF-2>
		       <SET NL ,INF-3>)
		      (<EQUAL? .L ,INF-1>
		       <SET NL ,INF-2>)>)>
	 <MOVE ,FLOOR-WAXER .NL>
	 <COND (<EQUAL? .NL ,INF-1> <SET TMP ,POWER-CORD>)
	       (ELSE <SET TMP ,GLOBAL-FLOOR-WAXER>)>
	 <PUT-GLOBAL ,INF-1 0 .TMP>
	 <COND (<EQUAL? .NL ,INF-1 ,INF-2> <SET TMP ,POWER-CORD>)
	       (ELSE <SET TMP ,GLOBAL-FLOOR-WAXER>)>
	 <PUT-GLOBAL ,INF-2 0 .TMP>
	 <COND (<EQUAL? .NL ,INF-4 ,INF-5> <SET TMP ,POWER-CORD>)
	       (ELSE <SET TMP ,GLOBAL-FLOOR-WAXER>)>
	 <PUT-GLOBAL ,INF-4 0 .TMP>
	 <COND (<EQUAL? .NL ,INF-5> <SET TMP ,POWER-CORD>)
	       (ELSE <SET TMP ,GLOBAL-FLOOR-WAXER>)>
	 <PUT-GLOBAL ,INF-5 0 .TMP>
	 <COND (<HERE? .NL>
		<TELL CR
CTHE ,FLOOR-WAXER ", approaching from the ">
		<COND (,WAX-WEST? <TELL "east">)
		      (ELSE <TELL "west">)>
		<TELL ", is now here." CR>)
	       (<HERE? .L>
		<TELL CR
CTHE ,FLOOR-WAXER " waxes away to the ">
		<COND (,WAX-WEST? <TELL "west">)
		      (ELSE <TELL "east">)>
		<TELL ,PERIOD>)>>

<ROUTINE CHANGE-ADJECTIVE (OBJ P "OPT" (NEW 0)
			   "AUX" (G <GETPT .OBJ ,P?ADJECTIVE>))
	 <COND (.G <PUTB .G .P .NEW>)>>

<ROUTINE PUT-GLOBAL (OBJ P VAL "AUX" (G <GETPT .OBJ ,P?GLOBAL>))
	 <COND (.G <PUTB .G .P .VAL>)>>

<OBJECT GLOBAL-FLOOR-WAXER
	(IN LOCAL-GLOBALS)
	(DESC "floor waxer")
	(SYNONYM WAXER POLISHER MACHINE)
	(ADJECTIVE FLOOR LARGE NOISY)
	(FLAGS NDESCBIT VEHBIT SURFACEBIT ONBIT OPENBIT CONTBIT SEARCHBIT)
	(GENERIC GENERIC-FLOOR-WAXER-F)
	(ACTION GLOBAL-FLOOR-WAXER-F)>

<ROUTINE GENERIC-FLOOR-WAXER-F ()
	 <COND (<IN? ,FLOOR-WAXER ,HERE> ,FLOOR-WAXER)
	       (ELSE ,GLOBAL-FLOOR-WAXER)>>

<ROUTINE GLOBAL-FLOOR-WAXER-F ()
	 <COND (<VERB? WALK-TO>
		<COND (<HERE? ,INF-1>
		       <DO-WALK ,P?EAST>)
		      (<HERE? ,INF-2>
		       <COND (<IN? ,FLOOR-WAXER ,INF-1>
			      <DO-WALK ,P?WEST>)
			     (ELSE <DO-WALK ,P?EAST>)>)
		      (<HERE? ,INF-3>
		       <COND (<OR <IN? ,FLOOR-WAXER ,INF-1>
				  <IN? ,FLOOR-WAXER ,INF-2>>
			      <DO-WALK ,P?WEST>)
			     (ELSE <DO-WALK ,P?EAST>)>)
		      (<HERE? ,INF-4>
		       <COND (<IN? ,FLOOR-WAXER ,INF-5>
			      <DO-WALK ,P?EAST>)
			     (ELSE <DO-WALK ,P?WEST>)>)
		      (ELSE
		       <DO-WALK ,P?WEST>)>)
	       (<HOSTILE-VERB?>
		<TELL "It" ,IS-DOWN-THE-HALL>)
	       (ELSE
		<FLOOR-WAXER-F>)>>

<GLOBAL IS-DOWN-THE-HALL "'s down the hall, not here.|">

<OBJECT FLOOR-WAXER
	(IN INF-2)
	(DESC "floor waxer")
	(SYNONYM WAXER POLISHER MACHINE)
	(ADJECTIVE FLOOR LARGE NOISY)
	(FLAGS VEHBIT SURFACEBIT POWERBIT OPENBIT CONTBIT SEARCHBIT)
	(DESCFCN FLOOR-WAXER-DESC)
	(CONTFCN FLOOR-WAXER-F)
	(GENERIC GENERIC-FLOOR-WAXER-F)
	(ACTION FLOOR-WAXER-F)>

<ROUTINE FLOOR-WAXER-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?> <RTRUE>)
	       (ELSE
		<COND (<IN? ,MAINTENANCE-MAN ,FLOOR-WAXER>
		       <TELL
"A " 'MAINTENANCE-MAN " is here, riding a " 'FLOOR-WAXER ".">)
		      (ELSE
		       <TELL
"A disabled " 'FLOOR-WAXER " looms nearby.">)>
		<RFATAL>)>>

<ROUTINE FLOOR-WAXER-F ("OPT" (RARG <>))
	 <COND (<RARG? BEG>
		<COND (<AND <VERB? WALK>
			    <EQUAL? ,P-WALK-DIR ,P?DOWN>>
		       <PERFORM ,V?DISEMBARK>
		       <RTRUE>)
		      (<VERB? WALK LAMP-OFF LAMP-ON STOP>
		       <TELL
CTHE ,POWER-CORD " is severed. It's not going anywhere." CR>)>)
	       (<RARG? CONTAINER>
		<COND (<AND <VERB? TAKE>
			    <NOT <IN? ,WINNER ,FLOOR-WAXER>>>
		       <CANT-REACH-THAT>
		       <RTRUE>)>)
	       (<RARG? <>>
		<COND (<VERB? EXAMINE>
		       <COND (<PRSO? ,GLOBAL-FLOOR-WAXER>
			      <TELL
,YOU-CANT "see it too clearly, but it looks like a large waxing
machine." CR>)
			     (ELSE
			      <TELL
"It's a large " 'FLOOR-WAXER ", big enough to ride in">
			      <COND (<IN? ,MAINTENANCE-MAN ,FLOOR-WAXER>
				     <TELL
", and in fact there is " A ,MAINTENANCE-MAN " riding it">)>
			      <TELL
". It actually looks sort of like a small bulldozer. ">
			      <COND (,CORD-SEVERED?
				     <TELL
"The severed remnant of " THE ,POWER-CORD " graces one end.">)
				    (ELSE
				     <TELL
"A " 'POWER-CORD " connects it to the wall.">)>
			      <CRLF>)>)
		      (<VERB? LISTEN>
		       <COND (,CORD-SEVERED?
			      <TELL "It's very quiet." CR>)
			     (ELSE
			      <TELL
"It makes a ghastly whirring, whining sound.">
			      <COND (<IN? ,FLOOR-WAXER ,HERE>
				     <TELL
" This close, it's almost unbearable.">)>
			      <CRLF>)>)
		      (<VERB? BOARD>
		       <COND (<PRSO? ,GLOBAL-FLOOR-WAXER>
			      <TELL
"It's not here!" CR>)
			     (<IN? ,MAINTENANCE-MAN ,PRSO>
			      <TELL CTHE ,MAINTENANCE-MAN>
			      <COND (,CORD-SEVERED?
				     <TELL
" catches you with a surprisingly strong punch as
you try to climb aboard. You fall to the floor, taken aback." CR>)
				    (ELSE
				     <TELL
" prevents you. He says something that probably
means \"No riders, buddy\" (freely translated)." CR>)>)>)
		      (<VERB? UNPLUG>
		       <NEW-PRSO ,POWER-CORD>
		       <RTRUE>)
		      (<VERB? LAMP-OFF STOP>
		       <TELL
"You'd have to be riding in it to turn it off." CR>)
		      (<VERB? LOOK-UNDER>
		       <TELL
"You see a nice, shiny floor." CR>)
		      (<HOSTILE-VERB?>
		       <TELL
"The waxer is pretty sturdy. These things have been waxing the floors
here for decades." CR>)
		      (<VERB? WALK-AROUND>
		       <COND (<NOT ,CORD-SEVERED?>
			      <TELL
,YOU-CANT "evade it." CR>)>)>)>>

<OBJECT WALL-SOCKET
	(IN INF-3)
	(DESC "wall socket")
	(SYNONYM SOCKET)
	(ADJECTIVE WALL ELECTRIC)
	(DESCFCN WALL-SOCKET-DESC)>

<ROUTINE WALL-SOCKET-DESC (RARG OBJ "AUX" L)
	 <COND (<RARG? OBJDESC?> <RTRUE>)
	       (ELSE
		<TELL
S "There is a ""wall socket on one wall, and a heavy-duty " 'POWER-CORD
" is plugged into it. The cord ">
		<COND (,CORD-SEVERED?
		       <TELL "terminates in a severed stump">)
		      (ELSE
		       <TELL "leads ">
		       <SET L <LOC ,FLOOR-WAXER>>
		       <COND (<EQUAL? .L ,HERE>
			      <TELL "to a large " 'FLOOR-WAXER>)
			     (<EQUAL? .L ,INF-1 ,INF-2>
			      <TELL "away to the west">)
			     (<EQUAL? .L ,INF-4 ,INF-5>
			      <TELL "away to the east">)>)>
		<TELL ".">)>>

<OBJECT POWER-CORD
	(IN LOCAL-GLOBALS)
	(DESC "power cord")
	(SYNONYM CORD PLUG)
	(ADJECTIVE POWER ELECTRIC)
	(FLAGS NDESCBIT)
	(ACTION POWER-CORD-F)>

<GLOBAL CORD-SEVERED? <>>

<ROUTINE POWER-CORD-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
CTHE ,POWER-CORD>
		<COND (<NOT ,CORD-SEVERED?> <TELL " connects">)
		      (ELSE <TELL ", now a mere stub, formerly connected">)>
		<TELL " a wall socket ">
		<COND (<HERE? ,INF-1 ,INF-2>
		       <TELL ,DOWN-THE-HALL "east ">)
		      (<HERE? ,INF-3>
		       <TELL S "on the wall here"" ">)
		      (ELSE
		       <TELL ,DOWN-THE-HALL "west ">)>
		<TELL "with " THE ,FLOOR-WAXER "." CR>)
	       (<VERB? TAKE UNPLUG MOVE PRY>
		<TELL
"You pull at " THE ,POWER-CORD ", but it won't come loose!" CR>)
	       (<VERB? FOLLOW>
		<TELL
CTHE ,POWER-CORD " goes from a wall socket ">
		<COND (<HERE? ,INF-1 ,INF-2>
		       <TELL "to the east">)
		      (<HERE? ,INF-3>
		       <TELL S "on the wall here">)
		      (ELSE
		       <TELL "to the west">)>
		<TELL " to " A ,FLOOR-WAXER " which is ">
		<COND (<IN? ,FLOOR-WAXER ,HERE>
		       <TELL "here.">)
		      (ELSE
		       <TELL "to the ">
		       <FLOOR-WAXER-DIRECTION>)>
		<COND (,CORD-SEVERED?
		       <TELL " Of course, the cord is severed.">)>
		<CRLF>)
	       (<P? (CUT MUNG ATTACK) POWER-CORD>
		<COND (<PRSI? <> ,HANDS>
		       <TELL
"You'll need more than your hands to sever this cord!" CR>)
		      (,CORD-SEVERED?
		       <TELL
,YOUVE-ALREADY "sliced it once! Trying to make salami?" CR>)
		      (<PRSI? ,AXE>
		       <SETG CORD-SEVERED? T>
		       <DEQUEUE I-WAXER-MOVES>
		       <QUEUE I-MAINT-ATTACK 2>
		       <TELL
"The axe crashes against the floor, and " THE ,POWER-CORD " severs! The
whine of " THE ,FLOOR-WAXER " slows, and " THE ,MAINTENANCE-MAN " jerks to
alertness." CR>)
		      (ELSE
		       <TELL
"You hit the cord with " THE ,PRSI ", but it has no effect." CR>)>)
	       (<VERB? REPAIR>
		<COND (,CORD-SEVERED?
		       <TELL
"It's beyond repair." CR>)>)>>

<GLOBAL DOWN-THE-HALL "down the hall to the ">

<ROUTINE SEE-MM? ()
	 <COND (<IN? ,MAINTENANCE-MAN ,HERE> <RTRUE>)
	       (<HERE? ,INF-1 ,INF-2 ,INF-3 ,INF-4 ,INF-5>
		<RTRUE>)
	       (<AND <HERE? ,GREAT-DOME ,TOP-OF-DOME>
		     <IN? ,MAINTENANCE-MAN ,INF-3>>
		<RTRUE>)>>

<ROUTINE MAINT-DESCENDS ("OPT" (INT? <>))
	 <QUEUE I-MAINT-ATTACK -1>
	 <MOVE ,MAINTENANCE-MAN <LOC ,FLOOR-WAXER>>
	 <COND (<SEE-MM?>
		<COND (.INT? <CRLF>)>
		<TELL
CTHE ,MAINTENANCE-MAN ", growling foul-sounding imprecations, descends
from " THE ,FLOOR-WAXER " and ">
		<COND (.INT? <TELL "heads towards you.">)
		      (ELSE <TELL "blocks your way.">)>
		<COND (<IN? ,FLOOR-WAX <LOC ,MAINTENANCE-MAN>>
		       <SETG SEEN-MM-SLIP? T>
		       <TELL
" But almost immediately, he slips on the floor wax.">)>
		<CRLF>)>>

<GLOBAL SEEN-MM-SLIP? <>>

<GLOBAL MAINT-SCORE 5>

<ROUTINE I-MAINT-ATTACK ("AUX" L TMP TMP1 (MM-WAITS? <>))
	 <COND (<IN? ,MAINTENANCE-MAN ,FLOOR-WAXER>
		<MAINT-DESCENDS T>)
	       (<IN? ,FLOOR-WAX <LOC ,MAINTENANCE-MAN>>
		<QUEUE I-MAINT-DISSOLVES 4 T>
		<SETG SCORE <+ ,SCORE ,MAINT-SCORE>>
		<SETG MAINT-SCORE 0>
		<COND (<SEE-MM?>
		       <TELL CR
CTHE ,MAINTENANCE-MAN> <COND (,SEEN-MM-SLIP?
			      <TELL
" continues slipping, falling, standing, and so on.">)
			     (ELSE
			      <SETG SEEN-MM-SLIP? T>
			      <TELL
" reaches the wax and immediately slips and falls.">)>
		       <TELL
" He reminds you of a badly made windup toy." CR>)>)
	       (ELSE
		<SET L <LOC ,MAINTENANCE-MAN>>
		<COND (<IN? ,MAINTENANCE-MAN ,HERE>
		       <TELL CR
CTHE ,MAINTENANCE-MAN " stares with maniacal intensity at your throat.">)
		      (ELSE
		       <COND (<NOT <HERE? ,INF-1 ,INF-2 ,INF-3 ,INF-4 ,INF-5>>
			      <SET MM-WAITS? T>
			      <SETG MAINT-ATTACK-COUNT 5>)>
		       <COND (<HERE? ,GREAT-DOME ,TOP-OF-DOME ,DOME-ROOF
				     ,ON-DOME>
			      <COND (<EQUAL? .L ,INF-5>
				     <MOVE ,MAINTENANCE-MAN ,INF-4>)
				    (<EQUAL? .L ,INF-4>
				     <MOVE ,MAINTENANCE-MAN ,INF-3>)>)
			     (ELSE
			      <COND (<EQUAL? .L ,INF-5>
				     <MOVE ,MAINTENANCE-MAN ,INF-4>)
				    (<EQUAL? .L ,INF-4>
				     <MOVE ,MAINTENANCE-MAN ,INF-3>)
				    (<EQUAL? .L ,INF-3>
				     <MOVE ,MAINTENANCE-MAN ,INF-2>)
				    (<EQUAL? .L ,INF-2>
				     <MOVE ,MAINTENANCE-MAN ,INF-1>)>)>
		       <COND (<HERE? ,GREAT-DOME ,TOP-OF-DOME>
			      <COND (<EQUAL? .L ,INF-3>
				     <MM-WAITS-PATIENTLY "below">
				     <RTRUE>)
				    (ELSE
				     <RFALSE>)>)
			     (<HERE? ,MASS-AVE>
			      <COND (<EQUAL? .L ,INF-1>
				     <MM-WAITS-PATIENTLY "inside">
				     <RTRUE>)
				    (ELSE
				     <RFALSE>)>)
			     (.MM-WAITS?
			      <COND (<EQUAL? .L
					     ,ENGINEERING-BLDG
					     ,AERO-LOBBY>
				     <MM-WAITS-PATIENTLY "in the corridor">
				     <RTRUE>)
				    (ELSE
				     <RFALSE>)>)
			     (ELSE
			      <TELL CR
CTHE ,MAINTENANCE-MAN S " lurches toward you" " with surprising speed.">)>)>
		<SET L <LOC ,MAINTENANCE-MAN>>
		<COND (<AND <IN? ,MAINTENANCE-MAN ,HERE>
			    <IN? ,FLOOR-WAX ,HERE>>
		       <SETG SEEN-MM-SLIP? T>
		       <TELL
" Just as he is about to grab you he slips on the wax. His hand whips
by, inches from your throat, and he drops to the floor, screaming in
frustration." CR>)
		      (<AND <IN? ,FLOOR-WAX .L>
			    <SEE-MM?>>
		       <SETG SEEN-MM-SLIP? T>
		       <TELL
" He encounters the floor wax, slips, and drops to the floor, screaming
in frustration." CR>)
		      (<G? <SETG MAINT-ATTACK-COUNT <+ ,MAINT-ATTACK-COUNT 1>>
			   4>
		       <COND (<NOT <HERE? ,GREAT-DOME ,TOP-OF-DOME ,ON-DOME
					  ,DOME-ROOF ,MASS-AVE>>
			      <DEQUEUE I-MAINT-ATTACK>
			      <JIGS-UP
" He grabs you by the throat and lifts you off the ground with one hand.
The hand feels very cold. Just as you
expire, you realize you have never seen him blink.">)>)
		      (<IN? ,MAINTENANCE-MAN ,HERE>
		       <CRLF>
		       <RTRUE>)
		      (ELSE
		       <COND (<AND <SET TMP <GETP ,HERE ,P?SIZE>>
				   <SET TMP1 <GETP .L ,P?SIZE>>>
			      <SET TMP <- .TMP1 .TMP>>
			      <TELL " He is ">
			      <COND (<EQUAL? .TMP 1>
				     <TELL "nearly upon you.">)
				    (ELSE
				     <COND (<EQUAL? .TMP 2>
					    <TELL "some ways down">)
					   (<EQUAL? .TMP 3>
					    <TELL "quite a way down">)
					   (<EQUAL? .TMP 4>
					    <TELL "at the far end of">)>
				     <TELL " the corridor.">)>)>
		       <CRLF>)>)>>

<ROUTINE MM-WAITS-PATIENTLY (WHERE)
	 <TELL CR
CTHE ,MAINTENANCE-MAN " waits patiently " .WHERE "." CR>>

<GLOBAL MAINT-ATTACK-COUNT 0>

<ROUTINE I-MAINT-DISSOLVES ()
	 <REMOVE ,MAINTENANCE-MAN>
	 <DEQUEUE I-MAINT-ATTACK>
	 <COND (<HERE? ,INF-1 ,INF-2 ,INF-3 ,INF-4 ,INF-5>
		<TELL CR
CTHE ,MAINTENANCE-MAN " appears to shorten and almost dissolve. There is a
great commotion, as though he is undergoing a convulsion of some sort,
and then he appears to explode into a crowd of small squealing creatures.
These, seeing you, scuttle off in the opposite direction and disappear." CR>)>>

<OBJECT PLASTIC-CONTAINER
	(IN INF-1)
	(DESC "plastic container")
	(SYNONYM CONTAINER LABEL)
	(ADJECTIVE PLASTIC)
	(FLAGS TAKEBIT CONTBIT READBIT SEARCHBIT OPENABLE)
	(CAPACITY 30)
	(SIZE 15)
	(ACTION PLASTIC-CONTAINER-F)
	(TEXT "\"Frobozz Magic Floor Wax (and Dessert Topping)\"")>

<ROUTINE PLASTIC-CONTAINER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a plain plastic container with something written on it. ">
		<LOOK-IN-CONTAINER>)
	       (<VERB? OPEN>
		<COND (<NOT <FSET? ,PLASTIC-CONTAINER ,OPENBIT>>
		       <FSET ,PLASTIC-CONTAINER ,OPENBIT>
		       <TELL
"You pull off the seal and open the container, revealing a smelly,
viscous liquid." CR>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,PLASTIC-CONTAINER ,OPENBIT>
		       <TELL
"The container can't be resealed." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<LOOK-IN-CONTAINER>)
	       (<VERB? POUR>
		<COND (<NOT <FSET? ,PLASTIC-CONTAINER ,OPENBIT>>
		       <TELL "The container isn't open." CR>)
		      (<IN? ,FLOOR-WAX ,PRSO>
		       <NEW-PRSO ,FLOOR-WAX>
		       <RTRUE>)
		      (ELSE <V-POUR>)>)
	       (<VERB? FILL>
		<CANT-FILL-IT>)>>

<ROUTINE LOOK-IN-CONTAINER ()
	 <COND (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL-OPEN-CLOSED ,PRSO>
		<RTRUE>)
	       (<FIRST? ,PRSO>
		<DESCRIBE-SENT ,PRSO>)
	       (ELSE
		<TELL "It appears to be empty.">)>
	 <CRLF>>

<ROUTINE CANT-FILL-IT ()
	 <TELL ,YOU-CANT>
	 <COND (,PRSI
		<TELL
"get " THE ,PRSI " into the container." CR>)
	       (ELSE
		<TELL
"fill " THE ,PRSO ,PERIOD>)>>

<OBJECT FLOOR-WAX
	(IN PLASTIC-CONTAINER)
	(DESC "floor wax")
	(SYNONYM WAX TOPPING LIQUID)
	(ADJECTIVE FLOOR DESSERT SMELLY VISCOUS)
	(FLAGS NOABIT TRYTAKEBIT TAKEBIT TOUCHBIT)
	(DESCFCN FLOOR-WAX-DESC)
	(ACTION FLOOR-WAX-F)>

<ROUTINE FLOOR-WAX-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?>
		<COND (<IN? <LOC ,FLOOR-WAX> ,ROOMS>
		       <RTRUE>)>)
	       (ELSE
		<TELL
S "The floor here is ""covered with slippery, messy floor wax.">)>>

<ROUTINE FLOOR-WAX-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
,IT-SEEMS-TO-BE "floor wax." CR>)
	       (<VERB? TAKE>
		<TELL
"It's a liquid, not a solid." CR>)
	       (<AND <VERB? STEP-ON>
		     <IN? ,FLOOR-WAX ,HERE>>
		<TELL
"It's pretty slippery, all right. You can't walk on it very easily." CR>)
	       (<OR <P? PUT HANDS>
		    <VERB? RUB>>
		<TELL
"It feels like floor wax. It's very slippery." CR>)
	       (<VERB? SMELL>
		<TELL
"It smells very pungent." CR>)
	       (<VERB? PUT>
		<COND (<OR <PRSI? ,GROUND>
			   <FSET? ,PRSI ,CONTBIT>>
		       <NEW-VERB ,V?POUR>
		       <RTRUE>)>)
	       (<VERB? POUR DROP>
		<COND (<IN? ,PRSO ,PLASTIC-CONTAINER>
		       <COND (<AND ,PRSI
				   <OR <HELD? ,PRSI>
				       <AND <FSET? ,PRSI ,CONTBIT>
					    <GETP ,PRSI ,P?CAPACITY>>>>
			      <TELL
"Without a funnel, you are doomed to failure. It'll end up all over
everything." CR>)
			     (ELSE
			      <MOVE ,FLOOR-WAX ,HERE>
			      <COND (<NOT <PRSI? ,GROUND ,CORRIDOR 
						 ,GLOBAL-MAINTENANCE-MAN
						 <>>>
				     <TELL
"You pour it all over " THE ,PRSI ", and of course it pours right
off onto the floor.">)
				    (ELSE
				     <COND (<HERE? ,TOP-OF-DOME
						   ,GREAT-DOME>
					    <MOVE ,FLOOR-WAX ,INF-3>
					    <TELL
"The wax cascades down onto the corridor floor below, like Quasimodo's
molten lead.">)
					   (ELSE
					    <TELL
"It pours out and spreads like ants at a picnic.">)>)>
			      <COND (<NOT <FSET? ,HERE ,OUTSIDE>>
				     <TELL " The floor is now
covered from wall to wall with slippery floor wax.">)>
			      <COND (<IN? ,MAINTENANCE-MAN <LOC ,FLOOR-WAX>>
				     <SETG SEEN-MM-SLIP? T>
				     <TELL
" " CTHE ,MAINTENANCE-MAN ", attempting to get closer to you, enters the
waxed part of the floor. He begins to slip and slide, barely able
to maintain his balance, much less advance.">)>
			      <CRLF>)>)
		      (ELSE
		       <TELL
"There is no more wax to pour." CR>)>)>>

<OBJECT EMERGENCY-CABINET
	(IN INF-4)
	(DESC "emergency cabinet")
	(SYNONYM CABINET GLASS SIGN WINDOW)
	(ADJECTIVE EMERGENCY)
	(FLAGS CONTBIT TRANSBIT READBIT AN SEARCHBIT OPENABLE)
	(CAPACITY 100)
	(DESCFCN EMERGENCY-CABINET-DESC)
	(ACTION EMERGENCY-CABINET-F)
	(TEXT "\"In case of emergency, break glass.\"")>

<ROUTINE EMERGENCY-CABINET-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?> <RTRUE>)
	       (ELSE
		<TELL
S "There is a ">
		<COND (<FSET? .OBJ ,RMUNGBIT> <TELL "formerly ">)>
		<TELL "glass-fronted emergency cabinet here.">
		<COND (<FSET? .OBJ ,RMUNGBIT> <RTRUE>)
		      (ELSE <RFATAL>)>)>>

<ROUTINE EMERGENCY-CABINET-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's one of those little cabinets you see in institutional buildings that
usually contains a fire hose and a fire axe. ">
		<COND (<IN? ,AXE ,PRSO>
		       <TELL
"This one seems to only have an axe. ">)>
		<TELL "It ">
		<COND (<FSET? ,PRSO ,RMUNGBIT>
		       <TELL "had">)
		      (ELSE
		       <TELL "has">)>
		<TELL " a transparent
window">
		<COND (<FSET? ,PRSO ,RMUNGBIT>
		       <TELL
" but apparently some vandal smashed it">)>
		<TELL ". There is writing on the cabinet." CR>)
	       (<VERB? OPEN>
		<COND (<NOT <FSET? ,PRSO ,RMUNGBIT>>
		       <TELL
"You should read the sign." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<TELL
"Inside the cabinet you see ">
		<DESCRIBE-REST ,EMERGENCY-CABINET>
		<TELL ,PERIOD>)
	       (<P? (MUNG ATTACK) ,EMERGENCY-CABINET>
		<COND (<FSET? ,EMERGENCY-CABINET ,RMUNGBIT>
		       <TELL
"The cabinet is already smashed." CR>)
		      (<PRSI? <> ,HANDS>
		       <COND (<NOT <FSET? ,GLOVES ,WEARBIT>>
			      <TELL
"You hit at the glass with your hands, but you can't hit hard
enough to break it: you might cut yourself on the glass." CR>)
			     (ELSE
			      <FSET ,EMERGENCY-CABINET ,OPENBIT>
			      <FSET ,EMERGENCY-CABINET ,RMUNGBIT>
			      <TELL
"Wearing the heavy gloves, you confidently smash the glass with a
blow of your hands!" CR>)>)
		      (<FSET? ,PRSI ,WEAPONBIT>
		       <COND (<NOT <FSET? ,EMERGENCY-CABINET ,RMUNGBIT>>
			      <FSET ,EMERGENCY-CABINET ,OPENBIT>
			      <FSET ,EMERGENCY-CABINET ,RMUNGBIT>
			      <TELL
"The glass smashes with a satisfying crash!" CR>)>)
		      (<PRSI? ,PLASTIC-CONTAINER>
		       <TELL
"The light plastic bounces off the cabinet." CR>)
		      (ELSE
		       <TELL
"The glass survives unscathed." CR>)>)>>

<OBJECT AXE
	(IN EMERGENCY-CABINET)
	(DESC "fire axe")
	(SYNONYM AXE AX)
	(ADJECTIVE FIRE)
	(FLAGS TRYTAKEBIT TAKEBIT WEAPONBIT)
	(SIZE 10)>

<ROOM NUTRITION-BLDG
      (IN ROOMS)
      (DESC "Fruits and Nuts")
      (LDESC 
"This is the central corridor of the
Nutrition Building. The main building is south, and a stairway leads
down.")
      (SOUTH TO INF-5)
      (DOWN TO BROWN-TUNNEL)
      (FLAGS ONBIT)>

<ROOM BROWN-TUNNEL
      (IN ROOMS)
      (DESC "Cluttered Passage")
      (LDESC 
"This cluttered passage leads southeast. It is full of apparently discarded
electronic equipment, old rusty file cabinets, and other detritus. A stairway
also leads up.")
      (UP TO NUTRITION-BLDG)
      (SE TO BROWN-BASEMENT)
      (FLAGS ONBIT)
      (THINGS <PSEUDO (ELECTRIC EQUIPMENT RANDOM-PSEUDO)
		      (FILE CABINET RANDOM-PSEUDO)
		      (<> DETRITUS RANDOM-PSEUDO)>)>

<ROOM AERO-LOBBY
      (IN ROOMS)
      (DESC "Aero Lobby")
      (DOWN TO AERO-STAIRS)
      (SOUTH TO INF-1)
      (FLAGS ONBIT)
      (ACTION AERO-LOBBY-F)>

<ROUTINE AERO-LOBBY-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
,THE-LOBBY "Aeronautical Engineering Building. Stairs
lead down and a corridor heads south towards the main building." CR>)>>

<ROOM GREAT-DOME
      (IN ROOMS)
      (DESC "Great Dome")
      (DOWN TO INF-3)
      (UP "There is no stairway.")
      (FLAGS ONBIT)
      (GLOBAL TENTACLE GLOBAL-FLOOR-WAXER GLOBAL-MAINTENANCE-MAN)
      (ACTION GREAT-DOME-F)>

<ROUTINE GREAT-DOME-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"Here a walkway circles the base of a huge ornate dome. Below is the
Infinite Corridor.">
		<COND (<NOT <FSET? ,DOME-LADDER ,TOUCHBIT>>
		       <TELL
" From stories of Tech Exploring trips, you recall that there is supposed to
be a ladder here.">
		       <COND (<NOT <FSET? ,TENTACLE ,INVISIBLE>>
			      <TELL
" On the other hand, there is a shiny rope-like thing hanging near
where the ladder used to be, and leading upward.">)>)>
		<COND (<IN? ,FLOOR-WAXER ,INF-3>
		       <TELL
" Below you, in the corridor, you can see " A ,FLOOR-WAXER>
		       <COND (<NOT ,CORD-SEVERED?>
			      <TELL
", busily waxing the floor">)>
		       <TELL ".">)>
		<CRLF>)
	       (<RARG? BEG>
		<COND (<AND <VERB? WALK>
			    <EQUAL? ,P-WALK-DIR ,P?UP>
			    <HERE? ,LADDER-BOTTOM?>>
		       <PERFORM ,V?CLIMB-UP ,DOME-LADDER>
		       <RTRUE>)>)>>

<OBJECT TENTACLE
	(IN LOCAL-GLOBALS)
	(DESC "ropy strand")
	(SYNONYM ROPE STRAND TENTACLE)
	(ADJECTIVE ROPY STICKY WET)
	(FLAGS NDESCBIT)
	(ACTION TENTACLE-F)>

<ROUTINE TENTACLE-WETNESS ()
	 <TELL
"It's wet, and when you touch it, some of the wetness sticks to your ">
	 <COND (<FSET? ,GLOVES ,WEARBIT>
		<TELL "gloves">)
	       (ELSE
		<TELL "hands, and stings">)>>

<ROUTINE TENTACLE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The strand is wet and glistening. It extends upward into the dome,
leading to a narrow catwalk." CR>)
	       (<VERB? TAKE RUB>
		<TENTACLE-WETNESS>
		<TELL ". The strand twitches a little when you touch it." CR>)
	       (<VERB? CLIMB-UP CLIMB-FOO>
		<COND (<HERE? ,GREAT-DOME>
		       <COND (<FSET? ,GLOVES ,WEARBIT>
			      <TELL
"The wet stuff on the strand sticks to the gloves, but doesn't otherwise
affect you. You have a little trouble climbing up to the catwalk, but
grab the rail just before your strength gives out. You heave yourself
up onto the catwalk." CR CR>
			      <GOTO ,TOP-OF-DOME>)
			     (ELSE
			      <TELL
S "You start to climb " "up the strand, but the glistening wet stuff begins
to burn your hands. You get a few feet up before the pain is too much.
You drop back to the floor." CR>)>)>)>>

<ROOM TOP-OF-DOME
      (IN ROOMS)
      (DESC "Top of Dome")
      (OUT TO DOME-ROOF IF DOME-DOOR IS OPEN)
      (NORTH TO DOME-ROOF IF DOME-DOOR IS OPEN)
      (FLAGS ONBIT)
      (GLOBAL TENTACLE DOME-DOOR GLOBAL-MAINTENANCE-MAN
	      DOME GLOBAL-FLOOR-WAXER)
      (VALUE 5)
      (ACTION TOP-OF-DOME-F)>

<ROUTINE TOP-OF-DOME-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
"Inside the great dome, near the top, a metal catwalk is precariously perched.
There is no way further up, but a small metal door is set in the side of
the dome.">
		<COND (<FSET? ,DOME-DOOR ,OPENBIT>
		       <TELL
" Frigid wind and snow blow through the open door.">)>
		<CRLF>)
	       (<RARG? BEG>
		<COND (<VERB? WALK>
		       <COND (<AND <EQUAL? ,P-WALK-DIR ,P?UP>
				   <HERE? ,LADDER-BOTTOM?>>
			      <PERFORM ,V?CLIMB-UP ,DOME-LADDER>
			      <RTRUE>)
			     (<AND <EQUAL? ,P-WALK-DIR ,P?DOWN>
				   <HERE? ,LADDER-TOP?>>
			      <PERFORM ,V?CLIMB-DOWN ,DOME-LADDER>
			      <RTRUE>)>)>)
	       (<RARG? ENTER>
		<COND (<EQUAL? ,OHERE ,DOME-ROOF>
		       <EXIT-FROM-COLD>)
		      (<NOT <FSET? ,TENTACLE ,INVISIBLE>>
		       <FSET ,TENTACLE ,INVISIBLE>
		       <TELL
"You stand up on the catwalk, catching your breath for a moment.
Your eyes stray along the strand you climbed. It trails along the
catwalk, where it joins something large and squishy squatting at
the far side. A single, bright-blue eye opens in the squishy mass,
and the tentacle (for that's what it is) retracts. The mass almost
flows through the spaces in the catwalk railing and drops to the
floor fifteen feet below. Before you can react, it's gone." CR CR>)>)>>

<OBJECT CATWALK
	(IN TOP-OF-DOME)
	(DESC "catwalk")
	(SYNONYM CATWALK EDGE SIDE RAILING)
	(ADJECTIVE METAL)
	(FLAGS NDESCBIT)>

<OBJECT DOME-LADDER
	(IN TOP-OF-DOME)
	(DESC "wooden ladder")
	(SYNONYM LADDER)
	(ADJECTIVE WOODEN)
	(SIZE 120)
	(FLAGS TAKEBIT)
	(DESCFCN DOME-LADDER-DESC)
	(ACTION DOME-LADDER-F)>

<GLOBAL LADDER-TOP? <>>
<GLOBAL LADDER-BOTTOM? <>>

<ROUTINE DOME-LADDER-DESC ("OPT" RARG OBJ)
	 <COND (<RARG? OBJDESC?> <RTRUE>)
	       (ELSE
		<COND (<NOT <FSET? ,DOME-LADDER ,TOUCHBIT>>
		       <TELL
"Where the pulpy mass was squatting, a wooden ladder lies on the catwalk.">)
		      (ELSE
		       <TELL "A wooden ladder ">
		       <COND (<HERE? ,LADDER-TOP?>
			      <TELL "leads down from">)
			     (<HERE? ,LADDER-BOTTOM?>
			      <TELL "leads up from">)
			     (ELSE
			      <TELL "rests">)>
		       <TELL " here.">)>)>>

<ROUTINE DOME-LADDER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"There is the same wet stuff on the ladder as on the tentacle." CR>)
	       (<VERB? RUB>
		<TENTACLE-WETNESS>
		<TELL ,PERIOD>)
	       (<VERB? TAKE>
	        <COND (<EQUAL? <ITAKE> T>
		       <SETG LADDER-TOP? <>>
		       <SETG LADDER-BOTTOM? <>>
		       <TELL
"It's a heavy ladder, but you manage to take it." CR>)
		      (ELSE <RTRUE>)>)
	       (<VERB? RAISE LAMP-ON>
		<FSET ,DOME-LADDER ,TOUCHBIT>
		<COND (<EQUAL? ,LADDER-TOP? ,TOP-OF-DOME>
		       <COND (<HERE? ,TOP-OF-DOME>
			      <MOVE ,DOME-LADDER ,HERE>
			      <SETG LADDER-TOP? <>>
			      <SETG LADDER-BOTTOM? <>>
			      <TELL
"With a great effort, the ladder being quite heavy (it's a Type I), you
pull the ladder up and lay it on the catwalk." CR>)
			     (ELSE
			      <TELL
"The ladder is already set up." CR>)>)
		      (<HERE? ,GREAT-DOME>
		       <SETG LADDER-TOP? ,TOP-OF-DOME>
		       <SETG LADDER-BOTTOM? ,GREAT-DOME>
		       <MOVE ,DOME-LADDER ,HERE>
		       <TELL
"You raise the ladder, leaning it against the catwalk above." CR>)
		      (<HERE? ,ELEVATOR-PIT>
		       <COND (<AND <FSET? ,ELEVATOR-DOOR-B ,OPENBIT>
				   <NOT <FIRST? ,ELEVATOR-DOOR-B>>>
			      <TELL
,YOU-CANT "raise a ladder and hold the doors open at the same time!" CR>)
			     (ELSE
			      <ONLY-A-FEW-FEET>)>)
		      (ELSE
		       <TELL
"There isn't much here to climb up to." CR>)>)
	       (<OR <VERB? LOWER>
		    <P? PUT-ON * CATWALK>>
		<FSET ,DOME-LADDER ,TOUCHBIT>
		<COND (<HERE? ,TOP-OF-DOME>
		       <COND (<NOT ,LADDER-TOP?>
			      <MOVE ,DOME-LADDER ,HERE>
			      <SETG LADDER-TOP? ,TOP-OF-DOME>
			      <SETG LADDER-BOTTOM? ,GREAT-DOME>
			      <TELL
"You lower the ladder to the walkway below. It's just the right
length to climb down." CR>)
			     (ELSE
			      <TELL
,YOU-CANT "lower it from here." CR>)>)
		      (<HERE? ,CS-BASEMENT>
		       <ONLY-A-FEW-FEET>)
		      (<NOT ,LADDER-TOP?>
		       <TELL
"It's already taken down." CR>)
		      (ELSE
		       <SETG LADDER-TOP? <>>
		       <SETG LADDER-BOTTOM? <>>
		       <TELL "Lowered." CR>)>)
	       (<VERB? CLIMB-FOO>
		<COND (<HERE? ,LADDER-BOTTOM?>
		       <NEW-VERB ,V?CLIMB-UP>
		       <RTRUE>)
		      (<HERE? ,LADDER-TOP?>
		       <NEW-VERB ,V?CLIMB-DOWN>
		       <RTRUE>)
		      (ELSE <LADDER-NOT-UP>)>)
	       (<VERB? CLIMB-UP>
		<COND (<EQUAL? ,LADDER-BOTTOM? ,HERE>
		       <TELL
,YOU-SCRAMBLE-UP "ladder." CR CR>
		       <MOVE ,DOME-LADDER ,LADDER-TOP?>
		       <GOTO ,LADDER-TOP?>)
		      (<EQUAL? ,LADDER-TOP? ,HERE>
		       <LADDER-EXTENDS "down" "up">)
		      (ELSE
		       <LADDER-NOT-UP>)>)
	       (<VERB? CLIMB-DOWN>
		<COND (<EQUAL? ,LADDER-TOP? ,HERE>
		       <TELL
"You scramble down the ladder." CR CR>
		       <MOVE ,DOME-LADDER ,LADDER-BOTTOM?>
		       <GOTO ,LADDER-BOTTOM?>)
		      (<EQUAL? ,LADDER-BOTTOM? ,HERE>
		       <LADDER-EXTENDS "up" "down">)
		      (ELSE <LADDER-NOT-UP>)>)
	       (<VERB? WALK-UNDER>
		<COND (<EQUAL? ,LADDER-BOTTOM? ,HERE>
		       <TELL
"You trepidatiously walk under the ladder. Nothing seems to happen." CR>)
		      (ELSE
		       <TELL
"There's no ladder set up here." CR>)>)>>

<ROUTINE LADDER-EXTENDS (U D)
	 <TELL
"The ladder extends " .U " from here, not " .D "." CR>>

<ROUTINE ONLY-A-FEW-FEET ()
	 <TELL
"It's only a few feet ">
	 <COND (<HERE? ,ELEVATOR-PIT> <TELL "up">)
	       (ELSE <TELL "down">)>
	 <TELL ". You don't need a ladder for that!" CR>>

<ROUTINE LADDER-NOT-UP ()
	 <COND (<HELD? ,DOME-LADDER>
		<TELL
"Climbing it while holding it would be a neat trick." CR>)
	       (ELSE
		<TELL
"The ladder doesn't go anywhere yet." CR>)>>

<OBJECT GLOVES
	(IN TEMPORARY-BASEMENT)
	(DESC "pair of electrician's gloves")
	(SYNONYM GLOVES GLOVE)
	(ADJECTIVE WORK RUBBER ELECTRIC)
	(FLAGS TAKEBIT)
	(ACTION GLOVES-F)>

<ROUTINE GLOVES-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a pair of electrician's rubber gloves. They look well used but
serviceable." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL
"They're kind of dirty inside, but there's nothing nasty hidden there." CR>)
	       (<OR <P? PUT-ON HAND GLOVES>
		    <P? PUT-ON GLOVES HAND>>
		<TELL
"It's much too big." CR>)
	       (<OR <VERB? WEAR>
		    <P? PUT-ON HANDS GLOVES>
		    <P? PUT-ON GLOVES HANDS>>
		<COND (<EQUAL? <IWEAR> T>
		       <TELL
"You put on the gloves. They're a little big, but not really such
a bad fit at all." CR>)
		      (ELSE <RTRUE>)>)>>

<OBJECT DOME-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "door")
	(SYNONYM DOOR)
	(ADJECTIVE SMALL METAL)
	(FLAGS NDESCBIT DOORBIT OPENABLE)
	(ACTION DOME-DOOR-F)>

<ROUTINE DOME-DOOR-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a small metal door, the same color as the dome." CR>)
	       (<VERB? THROUGH>
		<COND (<HERE? ,TOP-OF-DOME>
		       <DO-WALK ,P?OUT>)
		      (ELSE <DO-WALK ,P?IN>)>)
	       (<AND <VERB? OPEN>
		     <NOT <FSET? ,DOME-DOOR ,OPENBIT>>>
		<FSET ,DOME-DOOR ,OPENBIT>
		<TELL
"You open the door, and freezing air, blowing snow, and howling wind
enter and whip around you." CR>)
	       (<AND <VERB? CLOSE>
		     <FSET? ,DOME-DOOR ,OPENBIT>>
		<FCLEAR ,DOME-DOOR ,OPENBIT>
		<TELL
"You close the door, shutting out the blizzard." CR>)>>

<ROOM DOME-ROOF
      (IN ROOMS)
      (DESC "Roof of Great Dome")
      (LDESC
"You are perched precariously on the roof of the Great Dome. A set of
narrow indentations in the dome provides a dangerous route to the very
tip-top of the dome.")
      (IN TO TOP-OF-DOME IF DOME-DOOR IS OPEN)
      (SOUTH TO TOP-OF-DOME IF DOME-DOOR IS OPEN)
      (UP TO ON-DOME)
      (GLOBAL DOME-DOOR DOME)
      (FLAGS ONBIT OUTSIDE)
      (ACTION DOME-ROOF-F)>

<ROUTINE DOME-ROOF-F (RARG)
	 <COND ;(<RARG? LOOK>
		<TELL
 CR>)
	       (<RARG? ENTER>
		<COND (<EQUAL? ,OHERE ,TOP-OF-DOME>
		       <EXIT-TO-COLD>)>)>>

<ROUTINE EXIT-TO-COLD ()
	 <QUEUE I-FREEZE-TO-DEATH 2 T>
	 <TELL
"You enter the freezing, biting cold of the blizzard." CR CR>>

<ROOM ON-DOME
      (IN ROOMS)
      (DESC "On the Great Dome")
      (LDESC
"This is the very top of the Great Dome, a favorite place for Tech
fraternities to install cows, Volkswagen Beetles, giant birthday candles,
and other bizarre objects. The top is flat, round, and about five feet
in diameter. It's very windy, which has kept the snow from
accumulating here. The only way off is down.")
      (DOWN TO DOME-ROOF)
      (FLAGS ONBIT OUTSIDE)
      (GLOBAL DOME)
      (ACTION ON-DOME-F)>

<GLOBAL YOU-SCRAMBLE-UP "You scramble up ">

<ROUTINE ON-DOME-F (RARG)
	 <COND ;(<RARG? LOOK>
		<TELL
 CR>)
	       (<RARG? ENTER>
		<TELL
,YOU-SCRAMBLE-UP "icy surface of the dome, almost slipping a few
times, but finally you make it to the top." CR CR>)
	       (<RARG? BEG>
		<COND (<AND <VERB? WALK>
			    <NOT <EQUAL? ,P-WALK-DIR ,P?DOWN>>>
		       <TELL
"There is nowhere to go but down." CR>)
		      (ELSE <ROOF-BEGS>)>)>>

<OBJECT BRONZE-PLUG
	(IN ON-DOME)
	(DESC "bronze plug")
	(FDESC "In the exact center of the flat area is a bronze plug.")
	(SYNONYM PLUG)
	(ADJECTIVE CYLINDRICAL BRONZE)
	(FLAGS TAKEBIT TRYTAKEBIT WEAPONBIT)
	(ACTION BRONZE-PLUG-F)>

<ROUTINE BRONZE-PLUG-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a cylindrical bronze plug about two inches in diameter">
		<COND (<NOT <FSET? ,PRSO ,TOUCHBIT>>
		       <TELL
". It is set in the center of the flat part of the dome.">)
		      (ELSE
		       <TELL " and one inch high.">)>
		<CRLF>)
	       (<AND <VERB? TAKE>
		     <NOT <FSET? ,PRSO ,RMUNGBIT>>>
		<PERFORM ,V?PRY ,PRSO ,HANDS>
		<RTRUE>)
	       (<VERB? RAISE MOVE PRY OPEN>
		<COND (<FSET? ,BRONZE-PLUG ,RMUNGBIT>
		       <TELL ,YOUVE-ALREADY "removed it." CR>)
		      (<EQUAL? <ITAKE> T>
		       <FSET ,BRONZE-PLUG ,RMUNGBIT>
		       <MOVE ,SECRET-HOLE ,HERE>
		       <TELL
"You pry the plug out of its socket, revealing a cylindrical hole about
the same diameter but somewhat deeper. ">
		       <COND (<NOT <FSET? ,NOTE ,TOUCHBIT>>
			      <TELL
S "There is a ""piece of paper in the hole.">)
			     (<FIRST? ,SECRET-HOLE>
			      <DESCRIBE-SENT ,SECRET-HOLE>)
			     (ELSE
			      <TELL "The hole is empty.">)>
		       <CRLF>)
		      (ELSE <RTRUE>)>)
	       (<P? PUT BRONZE-PLUG SECRET-HOLE>
		<FCLEAR ,BRONZE-PLUG ,RMUNGBIT>
		<REMOVE ,SECRET-HOLE>
		<MOVE ,BRONZE-PLUG ,HERE>
		<TELL
"You insert the plug in the hole." CR>)>>

<OBJECT SECRET-HOLE
	(DESC "cylindrical hole")
	(SYNONYM HOLE)
	(ADJECTIVE CYLINDRICAL)
	(CAPACITY 5)
	(FLAGS CONTBIT OPENBIT SEARCHBIT)>

<OBJECT NOTE
	(IN SECRET-HOLE)
	(DESC "piece of paper")
	(SYNONYM PAPER NOTE)
	(ADJECTIVE PIECE SUICIDE)
	(FLAGS TAKEBIT READBIT)
	(VALUE 5)
	(ACTION NOTE-F)>

<ROUTINE NOTE-F ()
	 <COND (<VERB? EXAMINE READ>
		<COND (<NOT <HELD? ,NOTE>>
		       <MOVE ,NOTE ,WINNER>
		       <TAKING-FIRST ,NOTE>)>
		<FSET ,NOTE ,RMUNGBIT>
		<TELL
"You unroll the piece of paper and read the shaky handwriting:|
|
\"I can no longer face
what I've been doing. I can't sleep, I start at the slightest noise,
and even dulling my senses with alcohol or drugs is no longer enough.
I refuse to participate in what he is doing any more. Either he is
insane, or I am insane, or (and this is what I fear most) the universe
itself is insane. I have only one final warning: I am the only suicide,
but I will not be the final death.\"|
|
The name signed to it is ">
		<COND (<OR <FSET? ,SIGNUP ,RMUNGBIT>
			   ,REMEMBERED-STUDENT?>
		       <TELL
"that of the Alchemy Department graduate student.">)
		      (ELSE
		       <QUEUE I-REMEMBER-STUDENT 5>
		       <TELL
"oddly familiar.">)>
		<CRLF>)>>
