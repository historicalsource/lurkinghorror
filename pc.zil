"PC for
			   The Lurking Horror
	(c) Copyright 1986 Infocom, Inc. All Rights Reserved."

<OBJECT ASSIGNMENT
	(IN PLAYER)
	(DESC "assignment")
	(SYNONYM ASSIGNMENT)
	(FLAGS AN READBIT TAKEBIT)
	(SIZE 1)
	(ACTION ASSIGNMENT-F)>

<ROUTINE ASSIGNMENT-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"Laser printed on creamy bond paper, the assignment is due tomorrow.
It's from your freshman course in \"The Classics in the Modern Idiom,\"
better known as \"21.014.\" It reads, in part: \"Twenty pages on modern
analogues of Xenophon's 'Anabasis.'\" You're not sure whether this refers
to the movie \"The Warriors\" or \"Alien,\" but this is the last
assignment you need to complete in this course this term. You wonder,
yet again, why a technical school requires you to endure this sort of
stuff." CR>)>>

<OBJECT CHAIR
	(IN TERMINAL-ROOM)
	(FDESC
"Nearby is one of those ugly molded plastic chairs.")
	(DESC "chair")
	(SYNONYM CHAIR)
	(ADJECTIVE MOLDED PLASTIC UGLY)
	(FLAGS TAKEBIT VEHBIT SEARCHBIT CONTBIT OPENBIT FURNITURE SURFACEBIT)
	(SIZE 100)
	(ACTION CHAIR-F)>

<ROUTINE CHAIR-F ("OPT" (RARG <>))
	 <COND (<RARG? BEG>
		<COND (<QUEUED? I-COMPULSION> <RFALSE>)
		      (<VERB? WALK>
		       <MOVE ,WINNER <LOC ,CHAIR>>
		       <TELL "First, you arise from the chair." CR>)
		      (<P? SIT CHAIR>
		       <TELL ,YOU-ARE ,PERIOD>)
		      (<P? (STAND DISEMBARK) CHAIR>
		       <MOVE ,WINNER <LOC ,CHAIR>>
		       <TELL "You get out of the chair." CR>)>)
	       (<RARG? <>>
		<COND (<VERB? EXAMINE>
		       <TELL
"It's a molded plastic chair, a cheap knock-off of a designer
chair, and even more uncomfortable." CR>)
		      (<AND <VERB? TAKE>
			    <IN? ,HACKER ,CHAIR>>
		       <TELL "It's in use." CR>)
		      (<VERB? SIT BOARD>
		       <COND (<IN? ,HACKER ,CHAIR>
			      <TELL
"The hacker is already using it." CR>
			      <RTRUE>)
			     (ELSE
			      <COND (<HELD? ,CHAIR>
				     <MOVE ,CHAIR <LOC ,WINNER>>)>
			      <MOVE ,WINNER ,CHAIR>
			      <TELL
,YOU-ARE-NOW "sitting in the chair." CR>)>)>)>>

<OBJECT OUTLET
	(IN LOCAL-GLOBALS)
	(DESC "outlet")
	(SYNONYM OUTLET SOCKET)
	(ADJECTIVE ELECTRIC WALL)
	(FLAGS NDESCBIT AN)>

<GLOBAL PC-UNPLUGGED? <>>

<OBJECT HELP-KEY
	(IN PC)
	(DESC "HELP key")
	(SYNONYM HELP KEY)
	(ADJECTIVE HELP)
	(FLAGS NDESCBIT READBIT)
	(ACTION HELP-KEY-F)
	(TEXT "It says \"HELP\" in reassuring blue letters.")>

<ROUTINE HELP-KEY-F ()
	 <COND (<MOUSE-VERB?>
		<COND (<NOT <FSET? ,PC ,POWERBIT>>
		       <TELL
"Well," ,LC-NOTHING-HAPPENS " Perhaps you should turn on the computer?" CR>
		       <RTRUE>)>
		<TELL
"You push the friendly-looking HELP key. A spritely little box appears
on the screen, which reads: \"">
		<COND (<NOT ,LOGGED-IN?>
		       <TELL "You should ">
		       <COND (<NOT ,USERNAME?>
			      <TELL
"\"LOGIN your-user-id\" and then ">)>
		       <TELL
"\"PASSWORD your-password\".">)
		      (<IN? ,MORE-BOX ,PC>
		       <TELL "Please">
		       <COND (<NOT ,READ-PAGE?>
			      <TELL
" read the page on the screen and then">)>
		       <TELL " click the MORE box.">)
		      (<IN? ,YAK-WINDOW ,PC>
		       <TELL
"Please click the box representing the file you wish to edit or view.
I notice that one file is marked as urgent, so you should probably click
its box.">)
		      (<IN? ,MENU-BOX ,PC>
		       <TELL
"You should click the menu box, as you previously set it up as an urgent
task.">)
		      (ELSE
		       <TELL
"I can't help you at this point.">)>
		<TELL "\"" CR>)>>

<OBJECT MOUSE
	(IN PC)
	(DESC "mouse")
	(SYNONYM MOUSE)
	(FLAGS NDESCBIT)
	(ACTION MOUSE-F)>

<ROUTINE MOUSE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a plastic pointing device." CR>)
	       (<VERB? TAKE>
		<TELL
"It's attached to the computer." CR>)
	       (<VERB? MOVE>
		<TELL
"It rolls smoothly." CR>)
	       (<AND <MOUSE-VERB?>
		     <PRSO? MOUSE>>
		<COND (,PRSI
		       <PERFORM ,V?CLICK ,PRSI>
		       <RTRUE>)
		      (ELSE
		       <TELL
,YOU-HAVE-TO "click something with the mouse." CR>)>)
	       (<AND <MOUSE-VERB?>
		     <PRSI? MOUSE>>
		<PERFORM ,V?CLICK ,PRSO>
		<RTRUE>)>>

<OBJECT PC
	(IN TERMINAL-ROOM)
	(DESC "pc")
	(FDESC
"A really whiz-bang pc is right inside the door.")
	(SYNONYM PC COMPUTER SCREEN TERMINAL)
	(ADJECTIVE PERSONAL MY MONITOR)
	(FLAGS TAKEBIT TRYTAKEBIT OPENBIT CONTBIT SEARCHBIT SURFACEBIT)
	(SIZE 30)
	(ACTION PC-F)>

<GLOBAL COMPUTER-POWERS "The computer powers ">

<ROUTINE PC-F ("AUX" TMP)
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? <GET ,P-NAMW 0> ,W?SCREEN>
		       <NEW-VERB ,V?READ>
		       <RTRUE>)
		      (ELSE
		       <TELL
"This is a beyond-state-of-the-art personal computer. It has a
1024 by 1024 pixel color monitor, a mouse, an attached hard disk,
and a local area network connection. Fortunately, one of its features
is a prominent HELP key.">
		       <COND (<NOT <FSET? ,PC ,POWERBIT>>
			      <TELL S " It is currently ""turned off.">)
			     (<FIRST? ,PC>
			      <TELL
" On the screen you see " A <FIRST? ,PC> ".">)>
		       <CRLF>)>)
	       (<AND <VERB? LISTEN>
		     <FSET? ,PC ,POWERBIT>>
		<TELL "It hums contentedly." CR>)
	       (<VERB? TAKE>
		<COND (<QUEUED? I-HACKER-HELPS>
		       <NEW-VERB ,V?UNPLUG>
		       <RTRUE>)
		      (<EQUAL? <ITAKE> T>
		       <TELL
"You take it">
		       <COND (<NOT ,PC-UNPLUGGED?>
			      <TELL ", ">
			      <COND (<FSET? ,PC ,POWERBIT>
				     <INIT-PC>
				     <TELL
"turning it off and ">)>
			      <SETG PC-UNPLUGGED? T>
			      <TELL
"unplugging it first">)>
		       <TELL ,PERIOD>)
		      (ELSE <RTRUE>)>)
	       (<P? (PUT PUT-ON) * PC>
		<NO-GOOD-SURFACE>)
	       (<VERB? READ>
		<COND (<AND <QUEUED? I-HACKER-HELPS>
			    <L? ,HACKER-HELP 3>>
		       <TELL
S "There's nothing ""recognizable on the screen." CR>
		       <RTRUE>)>
		<SET TMP
		     <COND (<IN? ,ODD-PAPER ,PC> ,ODD-PAPER)
			   ;(<IN? ,REAL-PAPER ,PC> ,REAL-PAPER)
			   (<IN? ,MENU-BOX ,PC> ,MENU-BOX)
			   (<IN? ,MORE-BOX ,PC> ,MORE-BOX)
			   (<IN? ,YAK-WINDOW ,PC> ,YAK-WINDOW)>>
		<COND (.TMP
		       <NEW-PRSO .TMP>
		       <RTRUE>)
		      (ELSE
		       <TELL
S "There's nothing ""to read on the screen now." CR>)>)
	       (<VERB? LAMP-ON>
		<COND (,PC-UNPLUGGED?
		       <TELL
"It's unplugged. You should plug it in first." CR>)
		      (<NOT <FSET? ,PC ,POWERBIT>>
		       <FSET ,PC ,POWERBIT>
		       <TELL
,COMPUTER-POWERS "up, goes through a remarkably fast self-check,
and greets you, requesting " ,LOGIN-PLEASE " The only sound you hear is
a very low hum." CR>)
		      (ELSE
		       <TELL
"It's on. Maybe you didn't notice." CR>)>)
	       (<VERB? PLUG-IN>
		<COND (,PC-UNPLUGGED?
		       <SETG PC-UNPLUGGED? <>>
		       <TELL
"You plug in the computer." CR>)
		      (ELSE <TELL ,IT-ALREADY-IS>)>)
	       (<VERB? UNPLUG>
		<COND (,PC-UNPLUGGED?
		       <TELL ,IT-ALREADY-IS>
		       <RTRUE>)
		      (<QUEUED? I-HACKER-HELPS>
		       <TELL S
"The hacker stops you. \"You'll mung the bits, chomper!\"|">)
		      (ELSE
		       <INIT-PC>
		       <SETG PC-UNPLUGGED? T>
		       <TELL
"Okay, it's unplugged now." CR>)>)
	       (<VERB? LAMP-OFF>
		<COND (<QUEUED? I-HACKER-HELPS>
		       <TELL S
"The hacker stops you. \"You'll mung the bits, chomper!\"|">)
		      (<FSET? ,PC ,POWERBIT>
		       <INIT-PC>
		       <COMPUTER-POWERS-OFF>)
		      (ELSE
		       <ITS-ALREADY-X "off">)>)
	       (<VERB? READ>
		<COND (<IN? ,ODD-PAPER ,PC>
		       <NEW-PRSO ,ODD-PAPER>
		       <RTRUE>)>)
	       (<AND <VERB? SIT-AT>
		     <IN? ,CHAIR ,HERE>>
		<PERFORM ,V?SIT ,CHAIR>
		<RTRUE>)>>

<ROUTINE COMPUTER-POWERS-OFF ()
	 <FCLEAR ,PRSO ,POWERBIT>
	 <TELL
,COMPUTER-POWERS "off. It no longer makes a sound." CR>>

<ROUTINE INIT-PC ()
	 <FCLEAR ,PC ,POWERBIT>
	 <SETG LOGGED-IN? <>>
	 <SETG USERNAME? <>>
	 <REMOVE ,MENU-BOX>
	 <REMOVE ,MORE-BOX>
	 <MOVE ,YAK-WINDOW ,GLOBAL-OBJECTS>
	 <COND (<NOT <IN? ,ODD-PAPER ,GLOBAL-OBJECTS>>
		<REMOVE ,ODD-PAPER>)>>

<OBJECT INTNAME
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTNAME)
	(FLAGS NDESCBIT)>

<SYNTAX LOGIN OBJECT = V-LOGIN>
<SYNTAX LOGIN ON OBJECT = V-LOGIN>
<SYNTAX LOGIN AS OBJECT = V-LOGIN>
<SYNTAX PASSWORD OBJECT = V-PASSWORD>

<GLOBAL LOGGED-IN? <>>
<GLOBAL USERNAME? <>>

<ROUTINE CANT-USE-COMPUTER? ("AUX" (COMP <>))
	 <COND (<ACCESSIBLE? ,PC> <SET COMP ,PC>)
	       (<ACCESSIBLE? ,LOVECRAFT> <SET COMP ,LOVECRAFT>)
	       (ELSE
		<TELL "Login on what?" CR>
		<RTRUE>)>
	 <COND (<POWER-ON-FIRST? .COMP> <RTRUE>)
	       (<EQUAL? .COMP ,LOVECRAFT>
		<TELL S "\"Unable to boot because: No disk inserted. Please
insert a dismountable disk.\"" CR>
		<RTRUE>)>>

<ROUTINE V-LOGIN ()
	 <COND (<CANT-USE-COMPUTER?> <RTRUE>)
	       (<AND <PRSO? ,INTNAME>
		     <EQUAL? ,P-NAME ,W?XYZZY>>
		<SETG USERNAME? ,W?XYZZY>)
	       (ELSE
		<SETG USERNAME? T>)>
	 <TELL
,COMPUTER-RESPONDS "PASSWORD PLEASE:\"" CR>>

<GLOBAL COMPUTER-RESPONDS "The computer responds \"">

<ROUTINE POWER-ON-FIRST? (COMP)
	 <COND (<NOT <FSET? .COMP ,POWERBIT>>
		<TELL
"It would help if you turned on the computer first." CR>
		<RTRUE>)>>

<ROUTINE V-PASSWORD ()
	 <COND (<CANT-USE-COMPUTER?> <RTRUE>)
	       (<AND <PRSO? ,INTNAME>
		     <EQUAL? ,P-NAME ,W?PLUGH>
		     <EQUAL? ,USERNAME? ,W?XYZZY>>
		<SETG LOGGED-IN? T>
		<MOVE ,MENU-BOX ,PC>
		<TELL
,COMPUTER-RESPONDS "Good evening. You're here awfully late.\" It
displays a list of pending tasks, one of which is in blinking
red letters, with large arrows pointing to it. The task reads \"Classics
Paper,\" some particularly ominous words next to it say \"DUE
TOMORROW!\" and more reassuringly, a menu box next to that
reads " <GETP ,MENU-BOX ,P?TEXT> CR>)
	       (ELSE
		<SETG USERNAME? <>>
		<SETG LOGGED-IN? <>>
		<TELL
,COMPUTER-RESPONDS "INVALID LOGIN\" and then " ,LOGIN-PLEASE CR>)>>

<GLOBAL LOGIN-PLEASE "\"LOGIN PLEASE:\".">

<OBJECT MENU-BOX
	(DESC "menu box")
	(SYNONYM BOX PAPER LIST)
	(ADJECTIVE EDIT MENU CLASSIC RED)
	(FLAGS NDESCBIT READBIT)
	(ACTION MENU-BOX-F)
	(TEXT
"\"Edit Classics Paper.\"")>

<ROUTINE MOUSE-VERB? ()
	 <VERB? PUSH RUB CLICK POINT EDIT ATTACK>>

<ROUTINE MENU-BOX-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The most immediate thing you see is the red menu box that refers to
an urgent task." CR>)
	       (<MOUSE-VERB?>
		<REMOVE ,MENU-BOX>
		<MOVE ,YAK-WINDOW ,PC>
		<TELL
"The menu box is replaced by the YAK text editor and menu boxes
listing the titles of your files. The one for your paper is highlighted in a
rather urgent-looking shade of red." CR>)>>

<OBJECT YAK-WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "YAK editor")
	(SYNONYM WINDOW PAPER BOX)
	(ADJECTIVE MENU YAK EDITOR FORMATTER CLASSIC RED URGENT)
	(FLAGS NDESCBIT READBIT)
	(GENERIC GENERIC-PAPER-F)
	(ACTION YAK-WINDOW-F)
	(TEXT
"\"YAK 5.3\"")>

<ROUTINE GENERIC-PAPER-F ()
	 <COND (<IN? ,YAK-WINDOW ,PC> ,YAK-WINDOW)
	       (ELSE ,ODD-PAPER)>>

<ROUTINE YAK-WINDOW-F ()
	 <COND (<IN? ,YAK-WINDOW ,GLOBAL-OBJECTS>
		<COND (<NOT <ABSTRACT-VERB?>>
		       <YOU-SEE-NO ,YAK-WINDOW>)>)
	       (<VERB? EXAMINE READ>
		<COND (<EQUAL? <GET ,P-NAMW 0> ,W?BOX ,W?SCREEN>
		       <TELL
"There's one for your paper." CR>)
		      (ELSE
		       <TELL
,YOU-HAVE-TO "touch the box for it first." CR>)>)
	       (<MOUSE-VERB?>
		<MOVE ,YAK-WINDOW ,GLOBAL-OBJECTS>
		<MOVE ,MORE-BOX ,PC>
		<SETG READ-PAGE? <>>
		<TELL
"You click the box for your paper, and">
		<COND (<NOT <FSET? ,ODD-PAPER ,TOUCHBIT>>
		       <MOVE ,ODD-PAPER ,PC>
		       <TELL
" the box grows reassuringly until
it fills most of the screen. Unfortunately, the text that fills it
bears no resemblance to your paper. The title is the same, but after
that, there is something different, very different." CR>)
		      (ELSE
		       <TELL
,LC-NOTHING-HAPPENS " \"Your paper is lost!\" reminds the hacker." CR>)>)>>

<OBJECT MORE-BOX
	(DESC "more box")
	(SYNONYM BOX)
	(ADJECTIVE MORE)
	(FLAGS READBIT NDESCBIT)
	(ACTION MORE-BOX-F)>

<ROUTINE MORE-BOX-F ()
	 <COND (<VERB? READ>
		<TELL "It says \"MORE\" in a subdued typeface." CR>)
	       (<MOUSE-VERB?>
		<COND (<NOT ,READ-PAGE?>
		       <TELL
"You haven't read the page yet. You probably shouldn't touch the MORE
box until then." CR>)
		      (ELSE
		       <TELL
"You touch the MORE box, and a new page appears." CR>)>)>>

<OBJECT ODD-PAPER
	(DESC "classics paper")
	(SYNONYM PAPER TEXT PAGE)
	(ADJECTIVE MY STRANGE ODD CLASSIC)
	(FLAGS READBIT NDESCBIT)
	(GENERIC GENERIC-PAPER-F)
	(ACTION ODD-PAPER-F)>

<GLOBAL ALREADY-DISPLAYED
"It's already displayed. It hasn't changed, either.|">

<ROUTINE ODD-PAPER-F ()
	 <COND (<IN? ,ODD-PAPER ,GLOBAL-OBJECTS>
		<COND (<NOT <ABSTRACT-VERB?>>
		       <TELL "It's been lost!" CR>)>)
	       (<MOUSE-VERB?>
		<TELL ,ALREADY-DISPLAYED>)
	       (<VERB? READ EXAMINE>
		<SETG READ-PAGE? T>
		<COND (<QUEUE I-COMPULSION 2 T>
		       <SETG COMPCNT 1>
		       <TELL <GET ,COMPDESCS ,COMPCNT> CR CR
"As you look at it more closely, you
find it hard to focus on the screen, but impossible to look away. Your
finger strays toward the \"MORE\" box..." CR>)
		      (ELSE
		       <TELL
"You click the \"MORE\" box and read what appears." CR>)>)>>

<GLOBAL READ-PAGE? <>>

<GLOBAL COMPCNT 0>

<ROUTINE I-COMPULSION ()
	 <FSET ,ODD-PAPER ,TOUCHBIT>
	 <COND (<G? <SETG COMPCNT <+ ,COMPCNT 1>> <GET ,COMPDESCS 0>>
		<TELL CR "You faint, and when you awaken..." CR CR>
		<DEQUEUE I-COMPULSION>
		<REMOVE ,MORE-BOX>
		<MOVE ,MENU-BOX ,PC>
		<COND (<NOT <IN? ,PLAYER ,HERE>>
		       <MOVE ,PLAYER ,HERE>)>
		<ROB ,PLAYER ,FROB>
		<GOTO ,YUGGOTH>)
	       (ELSE
		<QUEUE I-COMPULSION 1>
		<SETG READ-PAGE? T>
		<TELL CR <GET ,COMPDESCS ,COMPCNT> CR>)>>

<GLOBAL COMPDESCS <LTABLE (PURE)
"The paper appears to be a facsimile overlaid with occasional typescript.
The text is mostly in a sort of \"Olde English\" you've never seen before.
What you read is a combination of incomprehensible gibberish, latinate
pseudowords, debased Hebrew and Arabic scripts, and an occasional
disquieting phrase in English."

"The second page is much like the first, but around the edges, not when
you look at it straight, it's almost readable. There is something about
a \"summoning,\" or a \"visitor.\""

"The third page is in the same script as the first, but laid out
like a poem. There are woodcut illustrations
which are queasily disturbing.|
|
There is a translation, or notes for one, typed
between the lines of the poem:|
|
\"He returns, he is called back (?)|
The loyal ones (acolytes?) make a sacrifice|
Those who survive will meet him (be absorbed? eaten?)|
They will live, yet die|
Forever will be (is?) nothing to them (to him?)|
|
\"His place (lair? burrow?) must be prepared|
His food (offerings?) must be prepared|
Call him forth (invite him?) with great power|
Only an acceptable (tasteful?) sacrifice will call him forth|
He will be grateful (satiated?)\"|
|
The rest is even more fragmentary."

"The fourth page is a
photograph. You try to recoil from the screen, but cannot. Fascinated
and repelled at the same time, you wonder: is that a mouth, and what
is in it?">>

<OBJECT PROGRAM
	(IN LOCAL-GLOBALS)
	(DESC "program")
	(SYNONYM PROGRAM BUG PROBLEM)
	(ADJECTIVE ASSEMBLY)
	(FLAGS NDESCBIT)>
