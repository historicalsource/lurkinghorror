"HACKER for
			   The Lurking Horror
	(c) Copyright 1986 Infocom, Inc. All Rights Reserved."

<OBJECT HACKER
	(IN TERMINAL-ROOM)
	(DESC "hacker")
	(SYNONYM HACKER YOURSELF)
	(FLAGS SEARCHBIT PERSON OPENBIT CONTBIT)
	(DESCFCN HACKER-DESC)
	(CONTFCN HACKER-F)
	(ACTION HACKER-F)>

<ROUTINE HACKER-DESC ("OPT" RARG OBJ)
	 <COND (<RARG? OBJDESC?> <RTRUE>)
	       (ELSE
		<COND (<HERE? ,TERMINAL-ROOM>
		       <TELL
"Sitting at a terminal is a hacker whom you recognize.">)
		      (ELSE
		       <TELL
"A muddy, scratched-up hacker stands tiredly here.">)>
		<RFATAL>)>>

<GLOBAL TOTALLY-UNRESPONSIVE "He is totally unresponsive.|">

<ROUTINE HACKER-F ("OPT" (RARG <>) "AUX" H)
	 <COND (<RARG? CONTAINER>
		<COND (<VERB? TAKE MOVE>
		       <COND (<G? ,LAIR-CNT 6>
			      <TELL
"You don't want to get that close to him." CR>)
			     (ELSE
			      <TELL
"\"Hey! No snarfage, loser!\" You determine that this means, \"Stop!\"" CR>)>)>)
	       (<WINNER? ,HACKER>
		<COND (<G? ,LAIR-CNT 6>
		       <TELL
"The hacker replies, \"Meld!\"" CR>)
		      (<VERB? HELP>
		       <COND (<HERE? ,TERMINAL-ROOM>
			      <TELL "\"Be patient!\"" CR>)
			     (<FSET? ,SMOOTH-STONE ,TOUCHBIT>
			      <PERFORM ,V?TELL-ME-ABOUT ,PROGRAM>
			      <RTRUE>)
			     (ELSE
			      <TELL
"\"Help? I'm not a T.A. I've got work to do.\"" CR>)>)
		      (<P? WHO LOVECRAFT>
		       <NEW-VERB ,V?WHAT>
		       <RTRUE>)
		      (<VERB? TELL-ME-ABOUT WHAT>
		       <COND (<PRSO? ,HACKER>
			      <TELL
"He's reluctant to boast." CR>)
			     (<PRSO? ,KEYRING ,KEY-1 ,KEY-2 ,KEY-3 ,KEY-4>
			      <COND (<GETPT ,MASTER-KEY ,P?VALUE>
				     <FSET ,MASTER-KEY ,TOUCHBIT>
				     <MOVE ,MASTER-KEY ,KEYRING>)>
			      <TELL
"\"I've accumulated a few keys over the years. I'm a licensed locksmith,
which helps. I can get into any room at Tech.\" He pulls the keyring
out on its chain, and shows off a key you hadn't noticed before. \"This is
a master key,\" he says." CR>)
			     (<PRSO? ,CHINESE-FOOD ,SNACK>
			      <TELL
"\"Yeah! I'd love some yummy Chinese food. Szechuan style. Ummm!\"" CR>)
			     (<PRSO? ,MASTER-KEY>
			      <COND (<IN? ,MASTER-KEY ,GLOBAL-OBJECTS>
				     <TELL S
"\"Who said anything about any master keys?\" he asks suspiciously.|">)
				    (ELSE
				     <THIS-IS-IT ,MASTER-KEY>
				     <TELL
"\"That's one of my best keys. It's a Tech master key. Not that it really
opens every door at Tech, but I'd say three out of five, at least. Naturally,
some labs are off-limits even to this key.\"" CR>)>)
			     (<PRSO? ,STUDENTS>
			      <TELL
"\"Missing students? I knew one of them slightly. Not the sort who would
go away, you know? He was sort of hackeresque, not dumb for an undergrad,
either. Not the type to disappear.\"" CR>)
			     (<PRSO? ,PROGRAM ,PC ,MENU-BOX ,YAK-WINDOW
				     ,HELP-KEY>
			      <COND (<ZERO? ,HACKER-HELP>
				     <TELL
"\"You should consult the documentation.\" He's preoccupied with his
own debugging." CR>)
				    (<QUEUED? I-HACKER-HELPS>
				     <TELL
"\"I'm looking at it. Be patient. This isn't some little micro. We're
on a hairy OS on a hairy net.\"" CR>)
				    (ELSE
				     <TELL
"\"I already looked at it. The bug is fixed in the sources. Your paper
is gone, unless those Alchemy chompers have a copy.\"" CR>)>)
			     (<PRSO? ,LOVECRAFT>
			      <TELL
"\"Wasn't he a fantasy author?\"" CR>)
			     (<PRSO? ,SMOOTH-STONE>
			      <TELL
"\"I've never seen one like that. Pretty tasteful, I'd say.\"" CR>)
			     (<PRSO? ,GLOBAL-URCHINS>
			      <TELL
"\"There are always urchins around. I remember one or two who became
hackers.\"" CR>)
			     (<PRSO? ,REPEATER ,INPUT-CABLE ,INPUT-SOCKET>
			      <TELL
"\"I'll fix it!\"" CR>) 
			     (ELSE
			      <TELL
"The hacker studiously ignores you, loath to admit there is something he
doesn't know about." CR>)>)
		      (<VERB? FOLLOW>
		       <COND (<HERE? ,INNER-LAIR>
			      <TELL "\"I'm here, aren't I?\"" CR>)
			     (ELSE
			      <TELL
"\"I haven't got time. I have new versions of the system, the assembler,
the editor, and the debugger to finish hacking.\"" CR>)>)
		      (<P? GIVE * ME>
		       <COND (<NOT <IN? ,CARTON ,HACKER>>
			      <QUEUE I-FOOD-HINT 2>)>
		       <COND (<PRSO? ,HELP-KEY>
			      <PERFORM ,V?HELP>
			      <RTRUE>)
			     (<PRSO? ,KEYRING>
			      <TELL
"\"Well, I can't give you ">
			      <COND (<IN? ,CARTON ,HACKER>
				     <TELL "all ">)>
			      <TELL "my keys, I need them.\" He fondles his
keyring proudly." CR>)
			     (<PRSO? ,MASTER-KEY>
			      <COND (<IN? ,MASTER-KEY ,GLOBAL-OBJECTS>
				     <TELL S
"\"Who said anything about any master keys?\" he asks suspiciously.|">)
				    (<IN? ,CARTON ,HACKER>
				     <HACKER-LOANS-KEY>)
				    (ELSE
				     <TELL
"\"Fat chance! This is a master key! What have you done for me
lately?\"" CR>)>)
			     (<PRSO? ,KEY-1 ,KEY-2 ,KEY-3 ,KEY-4>
			      <TELL
"\"Those are boring old keys. They don't open anything interesting.\"" CR>)
			     (ELSE
			      <TELL "\"I don't have that.\"" CR>)>)
		      (<VERB? TRADE>
		       <COND (<AND <PRSO? ,CHINESE-FOOD ,CARTON ,MASTER-KEY>
				   <PRSO? ,CHINESE-FOOD ,CARTON ,MASTER-KEY>>
			      <SETG HACKER-TRADE? T>
			      <TELL
"\"You give me the food first.\"" CR>)
			     (ELSE
			      <TELL
"\"That's not a good trade.\"" CR>)>)
		      (<VERB? HELLO>
		       <TELL
"\"Greetingage.\"">
		       <COND (<HERE? ,TERMINAL-ROOM>
			      <TELL " He turns back to his hacking.">)>
		       <CRLF>)
		      (ELSE
		       <TELL "\"Mumble. Frotz.\"" CR>)>)
	       (<VERB? EXAMINE>
		<COND (<HERE? ,INNER-LAIR>
		       <COND (<G? ,LAIR-CNT 6>
			      <TELL
"He looks vacant-eyed and dangerous." CR>)
			     (ELSE
			      <TELL
"He's muddy, wet, and tired looking." CR>)>)
		      (ELSE
		       <TELL "The hacker ">
		       <COND (<AND <NOT <ZERO? ,HACKER-HELP>>
				   <QUEUED? I-HACKER-HELPS>>
			      <TELL "is ">
			      <COND (<EQUAL? ,HACKER-HELP 1>
				     <TELL "star">)
				    (ELSE <TELL "sitt">)>
			      <TELL "ing at your terminal">
			      <COND (<G? ,HACKER-HELP 1>
				     <TELL ", typing furiously">)>
			      <TELL ". Every so
often, he pauses briefly and twirls a lock of his hair. He is also
humming under his breath.">)
			     (ELSE
			      <TELL
"sits comfortably on an office chair facing a terminal table,
or perhaps it's just a pile of old listings as tall as a terminal table.
He is typing madly, using just two fingers, but achieves
speeds that typists using all ten fingers only dream of. He is apparently
debugging a large assembly language program, as the screen of his terminal
looks like a spray of completely random characters.">)>
		       <TELL " The hacker is dressed
in blue jeans, an old work shirt, and what might once have been running
shoes. Hanging from his belt is an enormous ring of keys. He is in need
of a bath." CR>)>)
	       (<VERB? THANK>
		<COND (<G? ,LAIR-CNT 6>
		       <TELL "It doesn't impress him." CR>)
		      (<OR <HELD? ,MASTER-KEY>
			   <NOT <ZERO? ,HACKER-HELP>>>
		       <TELL
"He blushes." CR>)>)
	       (<VERB? LISTEN>
		<COND (<G? ,LAIR-CNT 6>
		       <TELL
"He sounds like an insincere Moonie." CR>)
		      (ELSE
		       <TELL
"He is humming something. It sounds classical, perhaps Bach?" CR>)>)
	       (<VERB? SMELL>
		<TELL
"Either the hacker, his clothing, or both are in need of cleaning." CR>)
	       (<P? TELL-ABOUT HACKER>
		<COND (<G? ,LAIR-CNT 6>
		       <TELL
"He doesn't appear to be listening." CR>)
		      (<PRSI? ,PROGRAM ,PC>
		       <COND (,HACKER-HELP
			      <TELL
"He listens, more or less. The impression he gives is that non-hackers
don't know anything about the bugs they cause." CR>)
			     (ELSE
			      <TELL
"The hacker isn't too interested, and doesn't bother to get up and
investigate more closely. He mumbles something about sending him a
bug message, and returns to his work." CR>)>)
		      (<IN? ,PRSI ,PLAYER>
		       <PERFORM ,V?SHOW ,PRSI ,HACKER>
		       <RTRUE>)
		      (ELSE
		       <TELL
"The hacker shows little interest in your remarks." CR>)>)
	       (<VERB? SHOW>
		<COND (<G? ,LAIR-CNT 6>
		       <TELL ,TOTALLY-UNRESPONSIVE>)
		      (<FSET? ,PRSO ,FOODBIT>
		       <TELL
"\"Winnage! I could do with some of that.\"" CR>)
		      (<PRSO? ,SMOOTH-STONE>
		       <TELL
"\"Odd-looking thing. Are you a rock-jock?\"" CR>)
		      (<PRSO? ,HAND>
		       <TELL
"\"Mondo grosso!\"" CR>)
		      (<PRSO? ,DEAD-RAT>
		       <TELL
"\"I have enough of those in my basement. Get rid of it!\"" CR>)
		      (ELSE
		       <TELL
"He more or less grunts at you, but shows little interest in " THE ,PRSO
,PERIOD>)>)
	       (<VERB? GIVE>
		<COND (<G? ,LAIR-CNT 6>
		       <TELL ,TOTALLY-UNRESPONSIVE>)
		      (<AND <PRSO? ,CARTON ,CHINESE-FOOD>
			    <IN? ,CHINESE-FOOD ,CARTON>>
		       <DEQUEUE I-FOOD-HINT>
		       <SET H <GETP ,CHINESE-FOOD ,P?HEAT>>
		       <COND (<FSET? ,CHINESE-FOOD ,RMUNGBIT>
			      <REMOVE ,CARTON>
			      <TELL
"\"Ouch! This is ridiculous! You've overcooked it. Look at those
poor shrimp! It's ruined, chomper!\" He throws it away." CR>)
			     (<G=? .H 12>
			      <MOVE ,CARTON ,HACKER>
			      <REMOVE ,CHINESE-FOOD>
			      ;<SCORE-OBJECT ,CHINESE-FOOD>
			      <TELL
"\"Ah! Serious food!\" He plunges into the food with all the delicacy
and table manners of a shark at a feeding frenzy. Soon a satisfied
expression appears on his face. ">
			      <COND (,HACKER-TRADE?
				     <HACKER-LOANS-KEY>)
				    (ELSE
				     <TELL
"\"Now, what was it you were wanting?\" he asks." CR>)>)
			     (ELSE
			      <TELL
"\"Yuck! This is">
			      <COND (<ZERO? .H> <TELL " cold">)
				    (ELSE
				     <TELL "n't warm enough">)>
			      <TELL "!\" He
thrusts it back into your hands." CR>)>)
		      (<AND <PRSO? ,SNACK>
			    <NOT <FSET? ,SNACK ,RMUNGBIT>>>
		       <MOVE ,SNACK ,HACKER>
		       <TELL
"\"Hey, thanks!\" He stuffs it down in no time.">
		       <AFTER-HACKER-EATS>)
		      (<PRSO? ,COKE>
		       <TELL
"\"I only drink Diet Coke,\" he complains.">
		       <AFTER-HACKER-EATS>)
		      (ELSE
		       <TELL
"\"No thanks, keep it for now.\"" CR>)>)
	       (<HOSTILE-VERB?>
		<COND (<VERB? THROW>
		       <MOVE ,PRSO ,HERE>
		       <TELL "Thrown. ">)>
		<COND (<G? ,LAIR-CNT 6>
		       <TELL
"He is unharmed. \"It is peaceful within,\" he remarks." CR>)
		      (ELSE
		       <TELL
"The hacker retreats. \"I know karate!\" he says, somewhat
unconvincingly." CR>)>)>>

<ROUTINE AFTER-HACKER-EATS ()
	 <COND (<NOT <IN? ,CARTON ,HACKER>>
		<TELL
" \"I could really do with some Chinese food, though.\"">)>
	 <CRLF>>

<GLOBAL HACKER-TRADE? <>>

<ROUTINE HACKER-LOANS-KEY ()
	 <SETG HACKER-TRADE? <>>
	 <MOVE ,MASTER-KEY ,PLAYER>
	 <SCORE-OBJECT ,MASTER-KEY>
	 <TELL
"\"Well, I suppose I could loan you " THE ,MASTER-KEY " for a while. Just
don't get into trouble, okay? I'll find you later, when I'm done with all this,
and get it back.\" He hands you the key." CR>>

<ROUTINE I-FOOD-HINT ()
	 <COND (<OR <NOT ,FOOD-COUNT>
		    <NOT <HERE? <LOC ,HACKER>>>>
		<RFALSE>)
	       (ELSE
		<COND (<G? <SETG FOOD-COUNT <+ ,FOOD-COUNT 1>>
			   <GET ,FOOD-HINTS 0>>
		       <SETG FOOD-COUNT <>>
		       <RFALSE>)
		      (ELSE
		       <QUEUE I-FOOD-HINT 2>
		       <TELL CR
"The hacker turns to you and says, \"" <GET ,FOOD-HINTS ,FOOD-COUNT>
"\"" CR>)>)>>

<GLOBAL FOOD-COUNT:FIX 1>

<GLOBAL FOOD-HINTS
	<LTABLE (PURE)
"I could stand a little snack, though."
"I don't know where I can get something to eat, what with all the snow."
"I'd hate to leave, with the machines so empty. On the other hand, I'm
seriously starving."
"Why don't you see if you can cons up some food? Then I might be able
to do something for you.">>

<OBJECT KEYRING
	(IN HACKER)
	(DESC "keyring")
	(SYNONYM KEYRING RING KEYCHAIN)
	(ADJECTIVE YOUR KEY)
	(FLAGS NDESCBIT TAKEBIT CONTBIT SURFACEBIT OPENBIT)
	(CONTFCN HACKER-F)
	(ACTION KEYRING-F)>

<ROUTINE KEYRING-F ()
	 <FSET ,KEYRING ,SEARCHBIT>
	 <COND (<VERB? EXAMINE>
		<TELL
"Hanging from the hacker's belt is a watchman's keyring. The large and almost
full ring is connected by an extensible chain to a reel attached to the
hacker's belt. It is difficult to lose such a keyring. ">
		<AMONG-THE-KEYS>)
	       (<VERB? TAKE>
		<TELL ,HACKER-PREVENTS "Chomp!\" he says." CR>)
	       (<VERB? LOOK-INSIDE>
		<AMONG-THE-KEYS>)>>

<GLOBAL HACKER-PREVENTS "The hacker prevents you. \"">

<ROUTINE AMONG-THE-KEYS ()
	 <TELL
"There are multitudinous keys hanging on the keyring. Among them are ">
	 <DESCRIBE-REST ,KEYRING>
	 <TELL ,PERIOD>>

<OBJECT KEY-1
	(IN KEYRING)
	(DESC "red aluminum Yale key")
	(SYNONYM KEY KEYS)
	(ADJECTIVE YOUR RED ALUMINUM METAL YALE)
	(FLAGS TAKEBIT)
	(GENERIC GENERIC-KEY-F)>

<OBJECT KEY-2
	(IN KEYRING)
	(DESC "green aluminum Yale key")
	(SYNONYM KEY KEYS)
	(ADJECTIVE YOUR GREEN ALUMINUM METAL YALE)
	(FLAGS TAKEBIT)
	(GENERIC GENERIC-KEY-F)>

<OBJECT KEY-3
	(IN KEYRING)
	(DESC "green brass Yale key")
	(SYNONYM KEY KEYS)
	(ADJECTIVE YOUR GREEN BRASS METAL YALE)
	(FLAGS TAKEBIT)
	(GENERIC GENERIC-KEY-F)>

<OBJECT KEY-4
	(IN KEYRING)
	(DESC "green aluminum Medeco key")
	(SYNONYM KEY KEYS)
	(ADJECTIVE YOUR GREEN ALUMINUM METAL MEDECO)
	(FLAGS TAKEBIT)
	(GENERIC GENERIC-KEY-F)>

<ROUTINE GENERIC-KEY-F ()
	 <COND (<ACCESSIBLE? ,KEYRING>
		,KEYRING)>>

<OBJECT MASTER-KEY
	(IN GLOBAL-OBJECTS)
	(DESC "master key")
	(SYNONYM KEY)
	(ADJECTIVE MASTER)
	(FLAGS TAKEBIT TRYTAKEBIT)
	(VALUE 5)
	(ACTION MASTER-KEY-F)
	(GENERIC GENERIC-KEY-F)>

<ROUTINE MASTER-KEY-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <NOT <IN? ,MASTER-KEY ,GLOBAL-OBJECTS>>>
		<TELL
"The key appears to be a master key. There is no indication of what locks
it might fit, however." CR>)
	       (<AND <VERB? TAKE>
		     <IN? ,MASTER-KEY ,GLOBAL-OBJECTS>>
		<TELL
"You haven't seen any master key." CR>)>>

<OBJECT CARTON
	(IN REFRIGERATOR)
	(DESC "cardboard carton")
	(SYNONYM CARTON SYMBOL)
	(ADJECTIVE CARDBOARD STRANGE SCRAWLED INCOMPREHENSIBLE)
	(FLAGS READBIT TRYTAKEBIT TAKEBIT SEARCHBIT FOODBIT CONTBIT OPENABLE)
	(CAPACITY 10)
	(GENERIC GENERIC-SYMBOL-F)
	(ACTION CARTON-F)>

<ROUTINE CARTON-F ()
	 <COND (<OR <EQUAL? ,W?SYMBOL <GET ,P-NAMW 0>>
		    <EQUAL? ,W?SYMBOL <GET ,P-NAMW 1>>>
		<CARTON-SYMBOL-F>)
	       (<VERB? EXAMINE>
		<TELL
"This is a cardboard carton with an incomprehensible symbol scrawled on
the top." CR>)
	       (<VERB? READ>
		<CARTON-SYMBOL-F>)
	       (<AND <VERB? SMELL>
		     <IN? ,CHINESE-FOOD ,CARTON>>
		<NEW-PRSO ,CHINESE-FOOD>
		<RTRUE>)
	       (<AND <VERB? RUB>
		     <IN? ,CHINESE-FOOD ,CARTON>
		     <G? <GETP ,CHINESE-FOOD ,P?HEAT> 8>>
		<TELL
"The carton feels warm." CR>)
	       (<VERB? EAT>
		<TELL
"You might find the contents more agreeable than the carton itself." CR>)>>

<ROUTINE CARTON-SYMBOL-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
S "It doesn't look like ""Chinese, English, or any other language you know. ">
		<TELL-SYMBOL ,CARTON>
		<CRLF>)>>

<OBJECT CHINESE-FOOD
	(IN CARTON)
	(DESC "Chinese food")
	(SYNONYM FOOD SHRIMP)
	(ADJECTIVE CHINESE SZECHUAN)
	(FLAGS NOABIT TAKEBIT TRYTAKEBIT FOODBIT)
	;(VALUE 5)
	(HEAT 0)
	(ACTION CHINESE-FOOD-F)>

<ROUTINE HEAT (OBJ "AUX" (H <GETP .OBJ ,P?HEAT>))
	 <COND (<G=? .H 20> "radioactive")
	       (<G=? .H 16> "volcanic")
	       (<G=? .H 12> "hot")
	       (<G=? .H 8> "warm")
	       (<G=? .H 4> "lukewarm")
	       (ELSE "cold")>>

<ROUTINE CHINESE-FOOD-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a carton of " <HEAT ,CHINESE-FOOD> " Szechuan shrimp. Lovely red peppers
poke out of the sauce." CR>)
	       (<AND <VERB? TAKE>
		     <NOT ,PRSI>>
		<COND (<IN? ,PRSO ,CARTON>
		       <TELL
"If you take it out, it will spill
all over you. Why not take the carton instead?" CR>)>)
	       (<AND <P? PUT ,CHINESE-FOOD>
		     <IN? ,CHINESE-FOOD ,CARTON>>
		<NEW-PRSO ,CARTON>
		<RTRUE>)
	       (<VERB? EAT TASTE>
		<TELL
"It's very (chemically) hot, spicy, and " <HEAT ,CHINESE-FOOD> ".">
		<COND (<VERB? EAT>
		       <REMOVE ,CHINESE-FOOD>
		       <TELL
" You immediately want to drink something to wash it down.">)>
		<CRLF>)>>

<OBJECT COKE
	(IN REFRIGERATOR)
	(DESC "two liter bottle of Classic Coke")
	(SYNONYM COKE COCA-COLA CAP)
	(ADJECTIVE TWO LITER BOTTLE CLASSIC)
	(FLAGS TAKEBIT FOODBIT OPENABLE)
	(SIZE 5)
	(HEAT 0)
	(ACTION COKE-F)>

<ROUTINE COKE-F ("AUX" SIZ TIRE)
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a">
		<SET SIZ <GETP ,COKE ,P?SIZE>>
		<COND (<EQUAL? .SIZ 1> <TELL "n empty">)
		      (<EQUAL? .SIZ 2> <TELL " nearly empty">)
		      (<EQUAL? .SIZ 3> <TELL " partly full">)
		      (<EQUAL? .SIZ 4> <TELL " partly empty">)
		      (<EQUAL? .SIZ 5> <TELL " full">)>
		<TELL
" two-liter bottle of ">
		<COND (<G? .SIZ 1> <TELL <HEAT ,COKE> " ">)>
		<TELL "Classic Coke." CR>)
	       (<VERB? TASTE>
		<TELL "Tastes like the real thing." CR>)
	       (<VERB? DRINK>
		<COND (<G? <SET SIZ <GETP ,COKE ,P?SIZE>> 1>
		       <PUTP ,COKE ,P?SIZE <SET SIZ <- .SIZ 1>>>
		       <COND (<SET TIRE <QUEUED? I-TIRED>>
			      <COND (<G? ,AWAKE -1>
				     <SETG AWAKE <- ,AWAKE 1>>
				     <SETG FUMBLE-NUMBER <+ ,FUMBLE-NUMBER 1>>
				     <SETG LOAD-ALLOWED <+ ,LOAD-ALLOWED 10>>)>
			      <SET SIZ <+ <GET .TIRE ,C-TICK> 200>>
			      <PUT .TIRE ,C-TICK .SIZ>)>
		       <TELL
"Delicious! Contains caffeine, one of the four basic food groups. Too
bad they make it with fructose these days, instead of sucrose. You feel
much more alert and awake now." CR>)
		      (ELSE
		       <TELL
"The bottle is empty." CR>)>)
	       (<VERB? OPEN CLOSE>
		<TELL
"You fiddle with the cap for a while. What fun! Much better than working
on your paper." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL
,IT-LOOKS-LIKE "the inside of a Coke bottle." CR>)
	       (<AND <VERB? SHAKE>
		     <G? <SET SIZ <GETP ,COKE ,P?SIZE>> 1>>
		<TELL
"The Coke fizzes up." CR>)
	       (<P? POUR COKE>
		<COND (<EQUAL? <SET SIZ <GETP ,COKE ,P?SIZE>> 1>
		       <TELL
"There is none left in the bottle." CR>)
		      (ELSE
		       <PUTP ,COKE ,P?SIZE 1>
		       <TELL
"You pour the Coke on ">
		       <COND (,PRSI <TELL THE ,PRSI>)
			     (ELSE <TELL "the ground">)>
		       <TELL ", wasting it." CR>)>)>>

<OBJECT SNACK
	(IN KITCHEN-COUNTER)
	(DESC "package of Funny Bones")
	(SYNONYM PACKAGE FOOD BONES WRAPPER)
	(ADJECTIVE FUNNY SNACK JUNK)
	(FLAGS TAKEBIT FOODBIT READBIT OPENABLE)
	(HEAT 0)
	(TEXT "\"Funny Bones\"")
	(ACTION SNACK-F)>

<ROUTINE SNACK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is a">
		<COND (<FSET? ,SNACK ,RMUNGBIT>
		       <TELL "n empty">)
		      (<FSET? ,SNACK ,OPENBIT>
		       <TELL "n open">
		       <COND (<GETP ,SNACK ,P?HEAT>
			      <TELL ", " <HEAT ,SNACK>>)>)>
		<TELL
" " 'SNACK ", a snack food made with peanut butter
and chocolate cake." CR>)
	       (<VERB? OPEN>
		<COND (<NOT <FSET? ,SNACK ,OPENBIT>>
		       <FSET ,SNACK ,OPENBIT>
		       <TELL
"You open the package, revealing yummy junk food inside." CR>)>)
	       (<VERB? EAT>
		<COND (<FSET? ,SNACK ,RMUNGBIT>
		       <TELL
"You already did. " S "There's nothing " "left but the wrapper." CR>
		       <RTRUE>)
		      (ELSE
		       <TELL
"You ">
		       <COND (<NOT <FSET? ,SNACK ,OPENBIT>>
			      <FSET ,SNACK ,OPENBIT>
			      <TELL "tear open the package and ">)>
		       <COND (<G? <GETP ,SNACK ,P?HEAT> 12>
			      <TELL
"discover that they are too hot to eat." CR>)
			     (ELSE
			      <FSET ,SNACK ,RMUNGBIT>
			      <TELL
"devour the delicious food-like substance." CR>)>)>)>>

<OBJECT MICROWAVE
	(IN KITCHEN)
	(DESC "microwave oven")
	(SYNONYM OVEN)
	(ADJECTIVE MICROWAVE OVEN)
	(FLAGS NDESCBIT SEARCHBIT CONTBIT TRANSBIT OPENABLE)
	(CAPACITY 30)
	(ACTION MICROWAVE-F)>

<ROUTINE MICROWAVE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The microwave oven hangs over the kitchen counter. It
has more complicated controls than your pc. There is an LED
readout above the controls. The microwave is ">
		<COND (<QUEUED? I-MICROWAVE>
		       <TELL "on." CR>)
		      (ELSE
		       <TELL "off and it's ">
		       <OPEN-CLOSED ,MICROWAVE>)>)
	       (<VERB? LAMP-ON>
		<PUT ,P-ADJW 0 ,W?START>
		<PERFORM ,V?PUSH ,CONTROLS>
		<RTRUE>)
	       (<VERB? LAMP-OFF>
		<PUT ,P-ADJW 0 ,W?STOP>
		<PERFORM ,V?PUSH ,CONTROLS>
		<RTRUE>)
	       (<VERB? UNPLUG>
		<CANT-GET-TO-PLUG>)
	       (<VERB? OPEN>
		<COND (<NOT <FSET? ,MICROWAVE ,OPENBIT>>
		       <FSET ,MICROWAVE ,OPENBIT>
		       <TELL CTHE ,MICROWAVE>
		       <COND (<QUEUED? I-MICROWAVE>
			      <DEQUEUE I-MICROWAVE>
			      <TELL " shuts off, and">)>
		       <TELL " is now open." CR>)>)
	       (<VERB? CLOSE>
		<CLOSE-A-DOOR>)>>

<OBJECT READOUT
	(IN KITCHEN)
	(DESC "display")
	(SYNONYM READOUT DISPLAY)
	(ADJECTIVE LED)
	(FLAGS NDESCBIT)
	(ACTION READOUT-F)>

<ROUTINE READOUT-F ("AUX" SEC)
	 <COND (<VERB? EXAMINE READ>
		<TELL
"The display is currently displaying ">
		<COND (<ZERO? ,MICROWAVE-TIMER>
		       <TELL "the current time">)
		      (ELSE
		       <TELL N </ ,MICROWAVE-TIMER 60> ":">
		       <COND (<L? <SET SEC <MOD ,MICROWAVE-TIMER 60>> 10>
			      <TELL "0">)>
		       <TELL N .SEC>)>
		<TELL " and the word \""
		      <GET ,MICROWAVE-TEMPS ,MICROWAVE-TEMP>
		      ".\"" CR>)>>

<GLOBAL MICROWAVE-TIMER 0>
<GLOBAL MICROWAVE-TBL <TABLE 0 0 0 0>>
<GLOBAL MICROWAVE-TEMP 0>
<GLOBAL MICROWAVE-TEMPS
	<TABLE (PURE) "off" "warm" "low" "medium" "high">>

<OBJECT CONTROLS
	(IN KITCHEN)
	(DESC "microwave controls")
	(SYNONYM CONTROL BUTTON TIMER)
	(ADJECTIVE INTNUM WM LO MED HIGH START STOP CLEAR)
	(FLAGS NDESCBIT NOABIT)
	(ACTION CONTROLS-F)>

<ADJ-SYNONYM HIGH HI>

<ROUTINE CONTROLS-F ("AUX" ADJ N)
	 <COND (<VERB? EXAMINE READ>
		<TELL
"There are controls labelled 0 to 9, WM, LO, MED, HI, START, CLEAR, and
STOP. ">
		<TELL-TIMER>)
	       (<P? TURN * ,INTNUM>
		<CLEAR-MICROWAVE-TBL>
		<SETG MICROWAVE-TIMER ,P-NUMBER>
		<COND (<G? ,MICROWAVE-TIMER 3600>
		       <TELL
,YOU-CANT "set it for that long a time." CR>
		       <RTRUE>)
		      (ELSE
		       <TELL-TIMER>)>)
	       (<VERB? RUB PUSH TYPE ENTER>
		<COND (<NOT <SET ADJ <GET ,P-ADJW 0>>>)
		      (<EQUAL? .ADJ ,W?INTNUM>
		       <COND (<G? ,P-NUMBER 9>
			      <COND (,P-TIME?
				     <TELL
"Why don't you try setting the timer to that?" CR>)
				    (ELSE
				     <TELL
S "There's no number " "\"" N ,P-NUMBER "\" on the control panel!" CR>)>)
			     (ELSE
			      <PUT ,MICROWAVE-TBL 3 <GET ,MICROWAVE-TBL 2>>
			      <PUT ,MICROWAVE-TBL 2 <GET ,MICROWAVE-TBL 1>>
			      <PUT ,MICROWAVE-TBL 1 <GET ,MICROWAVE-TBL 0>>
			      <PUT ,MICROWAVE-TBL 0 ,P-NUMBER>
			      <SETG MICROWAVE-TIMER
				    <+ <GET ,MICROWAVE-TBL 0>
				       <* <GET ,MICROWAVE-TBL 1> 10>
				       <* <GET ,MICROWAVE-TBL 2> 60>
				       <* <GET ,MICROWAVE-TBL 3> 600>>>
			      <TELL-TIMER>)>)
		      (<EQUAL? .ADJ ,W?START>
		       <COND (<QUEUED? I-MICROWAVE>
			      <TELL
"It's already started." CR>)
			     (<OR <FSET? ,MICROWAVE ,OPENBIT>
				  <ZERO? ,MICROWAVE-TIMER>>
			      <TELL "Nothing happens, as there's ">
			      <COND (<NOT <ZERO? ,MICROWAVE-TIMER>>
				     <TELL
"a safety interlock engaged when the door is open." CR>)
				    (<ZERO? ,MICROWAVE-TIMER>
				     <TELL
"no time set on it yet." CR>)>)
			     (ELSE
			      <COND (<ZERO? ,MICROWAVE-TEMP>
				     <SETG MICROWAVE-TEMP 4>)>
			      <CLEAR-MICROWAVE-TBL>
			      <QUEUE I-MICROWAVE -1>
			      <TELL
"The microwave starts up. The timer begins counting down." CR>)>)
		      (<EQUAL? .ADJ ,W?STOP>
		       <COND (<QUEUED? I-MICROWAVE>
			      <CLEAR-MICROWAVE-TBL>
			      <DEQUEUE I-MICROWAVE>
			      ;<HEAT-CONTENTS ,MICROWAVE>
			      <TELL ,MICROWAVE-STOPS>
			      <TELL-HEAT 0>)
			     (ELSE
			      <ITS-ALREADY-X "off">)>)
		      (<EQUAL? .ADJ ,W?CLEAR>
		       <COND (<QUEUED? I-MICROWAVE>
			      <TELL ,NOTHING-HAPPENS>)
			     (ELSE
			      <CLEAR-MICROWAVE-TBL>
			      <SETG MICROWAVE-TIMER 0>
			      <TELL
"The timer clears to zero." CR>)>)
		      (<EQUAL? .ADJ ,W?WM ,W?LO ,W?MED ,W?HIGH ,W?HI>
		       <COND (<QUEUED? I-MICROWAVE>
			      <TELL ,NOTHING-HAPPENS>)
			     (<EQUAL? .ADJ ,W?WM> <TELL-HEAT 1>)
			     (<EQUAL? .ADJ ,W?LO> <TELL-HEAT 2>)
			     (<EQUAL? .ADJ ,W?MED> <TELL-HEAT 3>)
			     (ELSE <TELL-HEAT 4>)>)
		      (ELSE
		       <TELL
"Which button?" CR>)>)>>

<ROUTINE CLEAR-MICROWAVE-TBL ()
	 <PUT ,MICROWAVE-TBL 0 0>
	 <PUT ,MICROWAVE-TBL 1 0>
	 <PUT ,MICROWAVE-TBL 2 0>
	 <PUT ,MICROWAVE-TBL 3 0>>

<GLOBAL HEAT-TABLE
	<LTABLE SMOOTH-STONE 0 DEAD-RAT 0 HAND 0
		CHINESE-FOOD 0 COKE 0 SNACK 0>>

<ROUTINE I-COOL ("AUX" (CNT 0) (L <GET ,HEAT-TABLE 0>) OBJ H (Q? <>)
		 MICROWAVE-RUNNING?)
	 <SET MICROWAVE-RUNNING? <QUEUED? I-MICROWAVE>>
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .L>
			<COND (.Q?
			       <QUEUE I-COOL 2>)>
			<RETURN>)>
		 <SET OBJ <GET ,HEAT-TABLE .CNT>>
		 <SET CNT <+ .CNT 1>>
		 <COND (<ZERO? <GET ,HEAT-TABLE .CNT>>
			<SET Q? T>
			<PUT ,HEAT-TABLE .CNT ,MOVES>)>
		 <COND (<AND <IN? .OBJ ,MICROWAVE>
			     .MICROWAVE-RUNNING?>
			<SET Q? T>)
		       (<NOT <ZERO? <SET H <GETP .OBJ ,P?HEAT>>>>
			<COND (<G? <- ,MOVES <GET ,HEAT-TABLE .CNT>> 3>
			       <PUT ,HEAT-TABLE .CNT ,MOVES>
			       <PUTP .OBJ ,P?HEAT <SET H <- .H 1>>>)>
			<COND (<NOT <ZERO? .H>>
			       <SET Q? T>)>)>>>

<ROUTINE HEAT-CONTENTS (WHAT TIM "AUX" H)
	 <MAP-CONTENTS (M .WHAT)
		 <COND (<GETPT .M ,P?HEAT>
			<QUEUE I-COOL 2 T>
			<SET H <+ <GETP .M ,P?HEAT> ,MICROWAVE-TEMP>>
			<COND (<L? .TIM 0>
			       <SET H
				    <+ .H
				       </ .TIM
					  </ 60 ,MICROWAVE-TEMP>>>>)>
			<PUTP .M ,P?HEAT .H>
			<COND (<AND <EQUAL? .M ,HAND>
				    <FSET? .M ,PERSON>>
			       <SETG ANIMATION-COUNT 0>
			       <FCLEAR .M ,PERSON>
			       <COND (<HERE? ,KITCHEN>
				      <TELL CR
"The hand scrabbles frantically around inside " THE <LOC ,HAND> ", and
then at last lies still." CR>)>)
			      (<AND <EQUAL? .M ,CHINESE-FOOD>
				    <G? .H 20>>
			       <FSET .M ,RMUNGBIT>)>)
		       (ELSE
			<HEAT-CONTENTS .M .TIM>)>>>

;<GLOBAL FOOD-SCORE 5>

<ROUTINE I-MICROWAVE ()
	 <SETG MICROWAVE-TIMER <- ,MICROWAVE-TIMER 60>>
	 <HEAT-CONTENTS ,MICROWAVE ,MICROWAVE-TIMER>
	 <COND (<L=? ,MICROWAVE-TIMER 0>
		<SETG MICROWAVE-TIMER 0>
		<DEQUEUE I-MICROWAVE>)>
	 <COND (<HERE? ,KITCHEN>
		<CRLF>
		<COND (<ZERO? ,MICROWAVE-TIMER>
		       ;"%<IFSOUND <SOUNDS ,S-BEEP>>"
		       <TELL ,MICROWAVE-STOPS>)>
		<TELL-TIMER>)>>

<GLOBAL MICROWAVE-STOPS "The microwave stops. ">

<ROUTINE TELL-TIMER ()
	 <TELL
"The timer display now reads " N </ ,MICROWAVE-TIMER 60> ":">
	 <COND (<L? <MOD ,MICROWAVE-TIMER 60> 10>
		<TELL "0">)>
	 <TELL N <MOD ,MICROWAVE-TIMER 60> ,PERIOD>>

<ROUTINE TELL-HEAT (N)
	 <SETG MICROWAVE-TEMP .N>
	 <TELL
"The bottom of the display now reads \"" <GET ,MICROWAVE-TEMPS .N> ".\"" CR>>

<OBJECT KITCHEN-COUNTER
	(IN KITCHEN)
	(DESC "kitchen counter")
	(SYNONYM COUNTER)
	(ADJECTIVE KITCHEN)
	(FLAGS NDESCBIT OPENBIT CONTBIT SEARCHBIT SURFACEBIT)
	(CAPACITY 200)>

<OBJECT REFRIGERATOR
	(IN KITCHEN)
	(DESC "refrigerator")
	(SYNONYM REFRIGERATOR FRIDGE SIGN)
	(ADJECTIVE REFRIGERATOR FRIDGE)
	(FLAGS NDESCBIT SEARCHBIT CONTBIT OPENABLE READBIT)
	(CAPACITY 200)
	(ACTION REFRIGERATOR-F)>

<ROUTINE REFRIGERATOR-F () 
	 <COND (<VERB? EXAMINE READ>
		<COND (<EQUAL? <GET ,P-NAMW 0> ,W?SIGN>
		       <TELL "\"Everything in this fridge must have a
name and date on it!\" (The sign has neither.)" CR>)
		      (ELSE
		       <TELL
"This is a medium-sized refrigerator whose door is ">
		       <COND (<FSET? ,PRSO ,OPENBIT>
			      <TELL "open">)
			     (ELSE <TELL "closed">)>
		       <TELL ". There is a sign on the front." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<FSET? ,REFRIGERATOR ,OPENBIT>
		       <TELL
"The interior of the refrigerator is appalling. There are soggy
lunch bags, ancient sandwiches and other less identifiable items">
		       <COND (<FIRST? ,REFRIGERATOR>
			      <TELL
". More appetizingly, you see ">
			      <DESCRIBE-REST ,REFRIGERATOR>)>
		       <TELL ,PERIOD>)
		      (ELSE
		       <TELL
,YOU-HAVE-TO "open it to look in it." CR>)>)
	       (<VERB? UNPLUG>
		<CANT-GET-TO-PLUG>)>>

<ROUTINE CANT-GET-TO-PLUG ()
	 <TELL ,YOU-CANT "get to the plug." CR>>

<ROOM KITCHEN
	(IN ROOMS)
	(DESC "Kitchen")
	(LDESC
"This is a filthy kitchen. The exit is to the east. On the wall near a
counter are a refrigerator and a microwave.")
	(EAST TO CS-2ND)
	(FLAGS RLANDBIT ONBIT)
	;(ACTION KITCHEN-F)>

;<ROUTINE KITCHEN-F (RARG)
	 <COND (<RARG? LOOK>
		<TELL
 CR>)>>
