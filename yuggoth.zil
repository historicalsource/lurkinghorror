"YUGGOTH for
			   The Lurking Horror
	(c) Copyright 1986 Infocom, Inc. All Rights Reserved."

<ROUTINE I-YUGGOTH ()
	 <COND (<HERE? ,YUGGOTH>
		<TELL CR
"From below, a low noise begins, and slowly builds. You feel yourself drawn
downward by the noise." CR CR>
		<GOTO ,BOWL-ROOM>
		<RFATAL>)
	       (<HERE? ,BOWL-ROOM>
		<TELL CR
"The crowd around you begins to sway and groan. They are expecting
something. You are drawn forward by the noise." CR CR>
		<GOTO ,PLATFORM-ROOM>
		<RFATAL>)>>

<ROOM YUGGOTH
      (IN ROOMS)
      (DESC "Place")
      (LDESC
"This is a place. Things move about on a broken, rocky surface.
Harsh sounds split the air. Something sticky grabs at your feet.
There is no color, everything is drained of brightness, dull and
lifeless. A path descends into a shallow bowl of black basalt.")
      (DOWN TO BOWL-ROOM)
      (FLAGS ONBIT)
      (ACTION RANDOM-YUGGOTH-F)>

<ROUTINE RANDOM-YUGGOTH-F (RARG)
	 <COND (<RARG? ENTER>
		<QUEUE I-YUGGOTH 2>)>>

<ROOM BOWL-ROOM
      (IN ROOMS)
      (DESC "Basalt Bowl")
      (LDESC
"You are at the bottom of a deeply cut, smooth basalt bowl. Dimly seen
shapes crowd you on all sides. Ahead, in the focus of the movement, is
a rock platform.")
      (UP TO YUGGOTH)
      (IN TO PLATFORM-ROOM)
      (DOWN TO PLATFORM-ROOM)
      (GLOBAL PLATFORM)
      (FLAGS ONBIT)
      (ACTION RANDOM-YUGGOTH-F)>

<ROOM PLATFORM-ROOM
      (IN ROOMS)
      (DESC "At Platform")
      (LDESC
"You stand before a low rock platform, more like an afterthought of
piled rocks or a glacial moraine than a work of artifice. You are
pushed against the pile by the crowd around you.")
      (FLAGS ONBIT)
      (GLOBAL PLATFORM)
      (ACTION PLATFORM-ROOM-F)>

<ROUTINE PLATFORM-ROOM-F (RARG)
	 <COND ;(<RARG? LOOK>
		<TELL
 CR>)
	       (<RARG? BEG>
		<COND (<VERB? WALK>
		       <COND (<EQUAL? ,P-WALK-DIR ,P?UP>
			      <TELL
"You are prevented, as the crowd holds you back." CR>)
			     (ELSE
			      <TELL
"The crowding is such that you can barely move, much less walk." CR>)>)
		      (<P? LISTEN (<> NOISE)>
		       <TELL
"It sounds like supplication." CR>)
		      (<AND <P? SMELL <>>
			    <IN? ,LURKER ,HERE>>
		       <NEW-PRSO ,LURKER>
		       <RTRUE>)
		      (<OR <P? (DROP PUT THROW) SMOOTH-STONE>
			   <P? ATTACK * SMOOTH-STONE>>
		       <TELL
"You can't. You go through the motions, but the stone doesn't leave your
hand." CR>)>)>>

<OBJECT PLATFORM
	(IN LOCAL-GLOBALS)
	(DESC "platform")
	(SYNONYM PLATFORM ROCKS PILE)
	(ADJECTIVE BASALT)
	(FLAGS NDESCBIT VEHBIT SURFACEBIT)
	(ACTION PLATFORM-F)>

<ROUTINE PLATFORM-F ()
	 <COND (<VERB? WALK-TO THROUGH BOARD>
		<COND (<HERE? ,BOWL-ROOM>
		       <DO-WALK ,P?IN>)
		      (ELSE
		       <DO-WALK ,P?UP>)>)
	       (<VERB? EXAMINE LOOK-UNDER LOOK-BEHIND>
		<TELL
"The platform is made of the same rocks as the surrounding terrain.
In fact, you can't tell whether it is natural or constructed." CR>)>>

<OBJECT SMOOTH-STONE
	(IN PLATFORM-ROOM)
	(DESC "smooth stone")
	(SYNONYM STONE)
	(ADJECTIVE SMOOTH SHINY SMALL)
	(FLAGS TAKEBIT SEARCHBIT OPENBIT CONTBIT WEAPONBIT)
	(VALUE 5)
	(DESCFCN SMOOTH-STONE-DESC)
	(ACTION SMOOTH-STONE-F)>

<ROUTINE SMOOTH-STONE-DESC (RARG OBJ)
	 <COND (<RARG? OBJDESC?>
		<COND (<NOT <FSET? ,SMOOTH-STONE ,TOUCHBIT>>
		       <RTRUE>)>)
	       (<NOT <FSET? ,SMOOTH-STONE ,TOUCHBIT>>
		<COND (<HERE? ,INNER-LAIR>
		       <TELL
"The stone sits on a hummock of mud. From here it appears to have a crack
in it.">)
		      (ELSE
		       <TELL
"One small stone stands out in the pile, smooth, shiny, and glowing with a blazing
light.">)>)>>

<ROUTINE SMOOTH-STONE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a ">
		<COND (<AND <HERE? ,INNER-LAIR>
			    <NOT <FSET? ,SMOOTH-STONE ,TOUCHBIT>>>
		       <TELL "cracked">)
		      (ELSE
		       <TELL "smooth, shiny">)>
		<TELL " piece of what might be obsidian. Scratched on it
is a symbol." CR>)
	       (<AND <VERB? TAKE>
		     <IN? ,PRSO ,HERE>>
		<COND (<HERE? ,PLATFORM-ROOM>
		       <QUEUE I-COOL 20 T>
		       <QUEUE I-LURKER-APPEARS -1>
		       <RFALSE>)
		      (<AND <HERE? ,BROWN-ROOF ,INSIDE-DOME>
			    <IN? ,FLIER ,HERE>>
		       <TELL
"The noisome creature jabs at you with its razor beak, but appears
unwilling to approach the stone." CR>)
		      (<AND <HERE? ,INNER-LAIR>
			    <NOT <FSET? ,SMOOTH-STONE ,TOUCHBIT>>>
		       <TELL
"You pick up the stone. It has a long jagged crack that almost breaks
it in half. As you pick it up, you feel it bump to one side. Then, as
you are holding it in your hand, something pushes its way out through
the crack, breaking the stone into two pieces. Something small, pale,
and damp blinks its watery eyes at you. It hisses, gaining strength,
and spreads membranous wings. It takes to the air, at first clumsily, then
with increased assurance, and disappears into the gloom. One eerie
cry drifts back to where you stand." CR CR>
		       <TELL
"Something rises out of the mud, slowly straightening.
The hacker, mud-covered and weak, staggers
to his feet. \"Can I have my key back?\" he asks." CR>
		       <FINISH>)>)
	       (<VERB? DROP>
		<COND (<IN? ,FLIER ,HERE>
		       <MOVE ,SMOOTH-STONE ,HERE>
		       <TELL
"The shape becomes agitated, screeching and cawing as it approaches the
stone." CR>)>)
	       (<AND <VERB? KICK MOVE RUB>
		     <NOT <HELD? ,PRSO>>
		     <IN? ,FLIER ,HERE>>
		<TELL
,YOU-CANT "get close enough." CR>)
	       (<P? RUB SMOOTH-STONE>
		<TELL
"The stone is smooth and ">
		<COND (<NOT <ZERO? ,END-CNT>> <TELL "warm">)
		      (ELSE <TELL "cool">)>
		<TELL "." CR>)
	       (<P? ATTACK * SMOOTH-STONE>
		<COND (<PRSO? ,FLIER-SHAPE>
		       <MOVE ,SMOOTH-STONE ,HERE>
		       <TELL
"The stone crashes against the wall of the dome. The shape
screams, a hissing fit of anger and frustration." CR>)
		      (<PRSO? ,FLIER>
		       <TELL
"The stone hits the dark beast, and appears to go completely through
it as though the creature was made of air. ">
		       <COND (<HERE? ,INSIDE-DOME>
			      <MOVE ,SMOOTH-STONE ,HERE>
			      <MOVE ,FLIER ,BROWN-ROOF>
			      <QUEUE I-FLIER 3> ;"time to get outside"
			      <TELL
"The stone tumbles onto the floor. The creature, hissing vilely,
retreats." CR>)
			     (<HERE? ,BROWN-ROOF>
			      <OBJ-OFF-ROOF ,SMOOTH-STONE>)>)>)
	       (<VERB? OPEN>
		<TELL-YUKS>)>>

<ROUTINE OBJ-OFF-ROOF (OBJ)
	 <MOVE .OBJ ,COURTYARD>
	 <TELL
CTHE .OBJ " disappears over the south edge of the building">
	 <COND (<IN? ,FLIER ,HERE>
		<TELL ", and the creature ">
		<COND (<EQUAL? .OBJ ,SMOOTH-STONE>
		       <SCORE-OBJECT ,FLIER>
		       <MOVE ,FLIER ,GLOBAL-OBJECTS>
		       <TELL
"follows it, screaming frustration into the storm." CR>)
		      (ELSE
		       <TELL
"watches it fall with cunning attention." CR>)>)
	       (ELSE <TELL "." CR>)>>

<OBJECT STONE-SYMBOL
	(IN SMOOTH-STONE)
	(DESC "carved symbol")
	(SYNONYM SYMBOL)
	(ADJECTIVE STONE SCRATCH CARVED STRANGE INCOMPREHENSIBLE)
	(FLAGS NDESCBIT)
	(SIZE 0)
	(GENERIC GENERIC-SYMBOL-F)
	(ACTION STONE-SYMBOL-F)>

<ROUTINE STONE-SYMBOL-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
,SYMBOL-APPEARS "carved into the " 'SMOOTH-STONE ", perhaps with a claw. ">
		<TELL-SYMBOL ,SMOOTH-STONE>
		<CRLF>)
	       (<VERB? RUB>
		<TELL
"The symbol is rough." CR>)>>

<GLOBAL YUGGOTH-COUNT 0>

<ROUTINE I-LURKER-APPEARS ()
	 <CRLF>
	 <COND (<EQUAL? <SETG YUGGOTH-COUNT <+ ,YUGGOTH-COUNT 1>> 1>
		<MOVE ,LURKER ,HERE>
		<TELL
"Suddenly, the dimness becomes darkness, and the crowd around you explodes
with excitement. You are jostled and shoved from all sides. A low keening
begins, building into a deafening, almost mechanical chant. The darkness
before you compacts and deepens." CR>)
	       (<EQUAL? ,YUGGOTH-COUNT 2>
		<TELL
"The darkness before you, now visible, is a creature. It towers over the
now-silent crowd. The thing jerks this way and that, spraying a foul
ichor. Its palps twitch expectantly, then pound impatiently against the
rock. You can feel the " 'SMOOTH-STONE " vibrating in your hand." CR>)
	       (<EQUAL? ,YUGGOTH-COUNT 3>
		<TELL
"The thing now turns, sensing the presence of the stone. It quests almost
blindly for it, then those surrounding you thrust you forward. The thing
stoops, its mandibles grasping you. You are lifted towards its gaping
maw. The stench and the sounds issuing from it are overwhelming, and
you fall unconscious." CR CR>
		<DEQUEUE I-LURKER-APPEARS>
		<COND (<IN? ,CHAIR ,TERMINAL-ROOM>
		       <MOVE ,CHAIR ,HERE>
		       <MOVE ,PLAYER ,CHAIR>)>
		<MOVE ,ODD-PAPER ,GLOBAL-OBJECTS>
		<GOTO ,TERMINAL-ROOM>
		<ROB ,FROB ,PLAYER>
		<RTRUE>)>>

<OBJECT LURKER
	(DESC "thing")
	(SYNONYM CREATURE THING DARKNESS DARK)
	(ADJECTIVE VISIBLE)
	(FLAGS NDESCBIT PERSON)
	(GENERIC GENERIC-CREATURE-F)
	(ACTION LURKER-F)>

<ROUTINE GENERIC-CREATURE-F ()
	 ,LURKER>

<ROUTINE LURKER-F ()
	 <COND (<WINNER? ,LURKER>
		<TELL
,NO-RESPONSE " You are not even sure that you produced any sound
when you spoke." CR>
		<END-QUOTE>)
	       (<VERB? EXAMINE>
		<COND (<G? ,YUGGOTH-COUNT 1>
		       <TELL
"It is large, smooth and yet scaly. It has too many limbs,
and they are not in the right places. To look at it gives you a
headache." CR>)
		      (ELSE
		       <TELL
"You see a visible darkness, in a shape not easily grasped." CR>)>)
	       (<VERB? SMELL>
		<TELL
"The thing gives off a charnel stench." CR>)>>
