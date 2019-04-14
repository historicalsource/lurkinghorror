"VERBS for
			    The Lurking Horror
	(c) Copyright 1986 Infocom, Inc. All Rights Reserved."

;"stuff to try to save space"

<GLOBAL PERIOD		".|">
<GLOBAL REFERRING	"I don't see what you're referring to.">
<GLOBAL I-DONT-THINK-THAT "I don't think that ">
<GLOBAL IT-ALREADY-IS	"It already is.|">
;<GLOBAL DOESNT-FIT	"It doesn't fit.|">
<GLOBAL IT-LOOKS-LIKE	"It looks like ">
<GLOBAL IT-SEEMS-TO-BE	"It seems to be ">
<GLOBAL IT-IS-ALREADY	"It's already ">
<GLOBAL ITS-NOT-TIED	"It's not tied to anything.|">
<GLOBAL TOO-DARK	"It's too dark to see!|">
;<GLOBAL LOOK-AROUND-YOU	"Look around you.|">
<GLOBAL NOTHING-HAPPENS "Nothing happens.|">
<GLOBAL TAKEN		"Taken.|">
<GLOBAL GOOD-TRICK	"That would be a good trick.|">
<GLOBAL WASTE-OF-TIME	"That would be a waste of time.|">
<GLOBAL THERE-IS-NOTHING "There is nothing ">
<GLOBAL NO-ROOM		"There's no room.">
<GLOBAL THERES-NOTHING-TO "There's nothing to ">
<GLOBAL ALREADY-IN-IT	"You're already in it.">
<GLOBAL YOURE-IN-IT	"You're in it!|">
<GLOBAL YOUVE-ALREADY	"You've already ">
<GLOBAL YOU-ARE		"You already are">
<GLOBAL YOU-HAVE	"You already have ">
<GLOBAL YOU-ARE-NOW	"You are now ">
<GLOBAL YOU-ARENT	"You aren't ">
<GLOBAL YOU-CANT	"You can't ">
<GLOBAL YOU-CANT-SEE	"You can't see ">
<GLOBAL YOU-FIND-NOTHING "You find nothing">
<GLOBAL YOU-HAVE-TO	"You'll have to ">

;<ROUTINE DONT-HAVE-THAT ()
	 <TELL ,YOU-DONT-HAVE "that" ,PERIOD>>

<ROUTINE TO-A-PRSO? ()
	 <HOW-DO-YOU> <A-PRSO?>>

<ROUTINE CANT-GO ()
	 <TELL ,YOU-CANT "go that way." CR>>

<ROUTINE NOT-HOLDING (OBJ)
	 <THIS-IS-IT .OBJ>
	 <TELL ,YOU-ARENT "holding " THE .OBJ ,PERIOD>>

<ROUTINE ITS-EMPTY ()
	 <TELL CTHE ,PRSO " is empty" ,PERIOD>>

<ROUTINE ITS-ALREADY-X (X)
	 <TELL ,IT-IS-ALREADY .X ,PERIOD>>

<ROUTINE ALREADY-OPEN ()
	 <ITS-ALREADY-X "open">>

<ROUTINE ALREADY-CLOSED ()
	 <ITS-ALREADY-X "closed">>

<ROUTINE WITH-PRSI? ()
	 <TELL "With "><A-PRSI?>>

<ROUTINE TELL-OPEN-CLOSED ("OPTIONAL" (OBJ <>))
	 <COND (.OBJ <TELL CTHE .OBJ>)
	       (ELSE
		<SET OBJ ,PRSO>
		<TELL THE ,PRSO>)>
	 <IS-ARE .OBJ>
	 <TELL " ">
	 <OPEN-CLOSED .OBJ>>

<ROUTINE OPEN-CLOSED (OBJ)
	 <COND (<FSET? .OBJ ,OPENBIT>
		<TELL "open">)
	       (ELSE
		<TELL "closed">)>
	 <TELL ,PERIOD>>

<ROUTINE THE-PRSO () <TELL THE ,PRSO ,PERIOD>>

<ROUTINE A-PRSO () <TELL A ,PRSO ,PERIOD>>

<ROUTINE A-PRSO? () <TELL A ,PRSO "?" CR>>

<ROUTINE THE-PRSI () <TELL THE ,PRSI ,PERIOD>>

;<ROUTINE A-PRSI () <TELL A ,PRSI ,PERIOD>>

<ROUTINE A-PRSI? () <TELL A ,PRSI "?" CR>>

<ROUTINE YOU-CANT-X-THAT (STR)
	 <TELL ,YOU-CANT .STR " that!" CR>>

<ROUTINE YOU-CANT-X-PRSO (STR)
	 <TELL ,YOU-CANT .STR " ">
	 <COND (,PRSO <TELL THE ,PRSO>)
	       (ELSE <TELL "that">)>
	 <TELL ,PERIOD>>

;<ROUTINE YOU-CANT-X-PRSI (STR)
	 <TELL ,YOU-CANT .STR " ">
	 <COND (,PRSI <TELL THE ,PRSI>)
	       (ELSE <TELL "that">)>
	 <TELL ,PERIOD>>

<ROUTINE UNINTERESTED (OBJ)
	 <COND (<EQUAL? .OBJ ,ME>
		<TELL-YUKS>)
	       (ELSE
		<TELL CTHE .OBJ>
		<IS-ARE .OBJ>
		<TELL " uninterested." CR>)>>

<ROUTINE IS-ARE (OBJ)
	 <COND (<PLURAL? .OBJ> <TELL " are">)
	       (ELSE <TELL " is">)>>

<ROUTINE PLURAL? (OBJ)
	 <EQUAL? .OBJ ,RATS ,STUDENTS ,ELEVATOR-DOOR
		 ,ELEVATOR-DOOR-B ,ELEVATOR-DOOR-1 ,ELEVATOR-DOOR-2
		 ,ELEVATOR-DOOR-3 ,STEAM-PIPES ,GLOBAL-URCHINS
		 ,STUDENTS ,URCHINS>>

<ROUTINE CANT-REACH-THAT ()
	 <YOU-CANT-X-THAT "reach">>

;"end of space saving stuff"

;"subtitle game commands"

<GLOBAL VERBOSITY 1>

<GLOBAL DESCRIPTIONS " descriptions">

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSITY 2>
	 <TELL "Verbose" ,DESCRIPTIONS ,PERIOD CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSITY 1>
	 <TELL "Brief" ,DESCRIPTIONS ,PERIOD>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG VERBOSITY <>>
	 <TELL "Super-brief" ,DESCRIPTIONS ,PERIOD>>

<ROUTINE V-DIAGNOSE ()
	 <TELL "You are ">
	 <COND (<L? ,AWAKE 0>
		<TELL "wide awake">)
	       (T
		<TELL <GET ,TIRED-TELL ,AWAKE>>)>
	 <TELL ", and are in ">
	 <COND (<G? ,FREEZE-COUNT 2>
		<COND (<G? ,FREEZE-COUNT 3>
		       <TELL "imminent ">)>
		<TELL "danger of freezing to death">)
	       (ELSE
		<TELL "good health">
		<COND (<NOT <ZERO? ,FREEZE-COUNT>>
		       <TELL " but getting cold">)>)>
	 <TELL ,PERIOD>>

<GLOBAL TIRED-TELL
       <PTABLE
	"beginning to tire"
	"feeling tired"
	"getting more and more tired"
	"worn out"
	"dead tired"
	"so tired you can barely concentrate"
	"moving on your last reserves of strength"
	"practically asleep"
	"barely able to keep your eyes open"
	"about to keel over from exhaustion">>

<ROUTINE V-INVENTORY ()
	 <SETG D-BIT <- ,WEARBIT>>
	 <COND (<NOT <DESCRIBE-CONTENTS ,WINNER
					<>
					<+ ,D-ALL? ,D-PARA?>>>
		<TELL "You are empty-handed.">)>
	 <SETG D-BIT ,WEARBIT>
	 <DESCRIBE-CONTENTS ,WINNER
			    <>
			    <+ ,D-ALL? ,D-PARA?>>
	 <SETG D-BIT <>>
	 <CRLF>>

<ROUTINE V-QUIT ("OPTIONAL" (ASK? T) "AUX" SCOR)
	 %<DEBUG-CODE <TELL-C-INTS>>
	 <V-SCORE>
	 <COND (<OR <AND .ASK?
			 <TELL
S "Do you wish to ""leave the game">
			 <YES?>>
		    <NOT .ASK?>>
		<QUIT>)
	       (T
		<TELL ,OKAY>)>>

<ROUTINE V-RESTART ()
	 %<DEBUG-CODE <TELL-C-INTS>>
	 <V-SCORE T>
	 <TELL S "Do you wish to ""restart">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL ,FAILED>)>>

<GLOBAL OKAY "Okay.|">

<GLOBAL FAILED "Failed.|">

<ROUTINE FINISH ()
	 <USL>
	 <CRLF>
	 %<DEBUG-CODE <TELL-C-INTS>>
	 <V-SCORE>
	 <CRLF>
	 <TELL
"Would you like to restart the game from the beginning, restore a saved
game position, or end this session of the game?" CR>
	 <REPEAT ()
		 <TELL
"(Type RESTART, RESTORE, or QUIT):|
>">
		 <READ ,P-INBUF ,P-LEXV>
		 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?RESTAR>
			<RESTART>
			<TELL ,FAILED>)
		       (<EQUAL? <GET ,P-LEXV 1> ,W?RESTOR>
			<COND (<RESTORE>
			       <TELL ,OKAY>)
			      (T
			       <TELL ,FAILED>)>)
		       (<EQUAL? <GET ,P-LEXV 1> ,W?QUIT ,W?Q>
			<QUIT>)>>>

<ROUTINE YES? ()
	 <PRINTI "?|
(Y is affirmative): >">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE> <RTRUE>)
	       (T
		<TELL ,FAILED>)>>

<ROUTINE V-SAVE ("AUX" X)
	 <PUTB ,OOPS-INBUF 1 0>
	 <SET X <SAVE>>
	 <COND (<ZERO? .X>
	        <TELL ,FAILED>)
	       (ELSE
		<TELL ,OKAY>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 <TELL
"Your score is " N ,SCORE " of a possible 100, in " N ,MOVES " move">
	 <COND (<NOT <1? ,MOVES>> <TELL "s">)>
	 <TELL ". Graded on the curve, you are in the class of "
	       <GET ,RANKINGS </ ,SCORE 10>>>
	 <TELL ,PERIOD>
	 ,SCORE>

<GLOBAL RANKINGS
	<PTABLE
	 "Freshman"		;"0"
	 "Sophomore"		;"10"
	 "Junior"		;"20"
	 "Senior"		;"30"
	 "Graduate Student"	;"40"
	 "Post-doc Student"	;"50"
	 "Assistant Professor"	;"60"
	 "Professor"		;"70"
	 "Department Head"	;"80"
	 "Dean of Engineering"	;"90"
	 "President of the Institute" ;"100">>

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL
"Start of a transcript of " ,LURKING-HORROR ,PERIOD>
	<V-VERSION>>

<ROUTINE V-UNSCRIPT ()
	<TELL "End of transcript" ,PERIOD>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<GLOBAL LURKING-HORROR "THE LURKING HORROR">

<ROUTINE V-VERSION ()
	 <TELL
,LURKING-HORROR "|
An Interactive Horror|
Copyright (c) 1987 by Infocom, Inc. All rights reserved.|"
,LURKING-HORROR " is a trademark of Infocom, Inc.|
Release ">
	 <PRINTN <BAND <GET 0 1> *3777*>>
	 <TELL " / Serial number ">
	 <DO (CNT 18 23)
	     <PRINTC <GETB 0 .CNT>>>
	 <CRLF>>

<ROUTINE V-$VERIFY ()
	 <COND (<AND <PRSO? ,INTNUM>
		     <EQUAL? ,P-NUMBER 1066>>
		<TELL N ,SERIAL CR>)
	       (,PRSO
		<TELL ,NOT-RECOGNIZED CR>)
	       (ELSE
		<TELL "Verifying..." CR>
		<COND (<VERIFY> <TELL "The disk is correct." CR>)
		      (T <TELL CR "** Disk Failure **" CR>)>)>>
^\L

;"subtitle real verbs"

<ROUTINE V-WAKE ()
	 <COND (<PRSO? ,ROOMS>
		<NEW-PRSO ,ME>
		<RTRUE>)
	       (T
		<TELL
,I-DONT-THINK-THAT THE ,PRSO " is sleeping." CR>)>>

<ROUTINE V-ANSWER ()
	 <TELL "Nobody is awaiting your answer." CR>
	 <END-QUOTE>>

"V-ASK-ABOUT -- transform into PRSO, TELL ME ABOUT PRSI"

<ROUTINE PRE-ASK-ABOUT ("AUX" P)
	 <COND (<AND <NOT ,PRSI>
		     <SET P <FIND-IN ,HERE ,PERSON>>>
		<PERFORM-PRSA .P ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ASK-ABOUT ()
	 <COND (<PRSO? ,ME>
		<NEW-VERB ,V?TELL>
		<RTRUE>)
	       (<FSET? ,PRSO ,PERSON>
		<NEW-WINNER-PRSO ,V?TELL-ME-ABOUT ,PRSI>
		<RTRUE>)
	       (T
		<NEW-VERB ,V?TELL>
		<RTRUE>)>>

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <MAP-CONTENTS (W .WHERE)
		       (END <RFALSE>)
		 <COND (<AND <FSET? .W .WHAT> <VISIBLE? .W>>
			<RETURN .W>)>>>

"V-ASK-FOR -- transform into PRSO, GIVE PRSI TO ME"

<ROUTINE PRE-ASK-FOR ()
	 <PRE-ASK-ABOUT>>

<ROUTINE V-ASK-FOR ()
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?TAKE ,PRSI>
		<RTRUE>)
	       (<FSET? ,PRSO ,PERSON>
		<NEW-WINNER-PRSO ,V?GIVE ,PRSI ,ME>
		<RTRUE>)
	       (T
		<TELL
"It's unlikely that " THE ,PRSO " will oblige." CR>)>>

<ROUTINE V-ATTACK ()
	 <IKILL "attack">>

<ROUTINE V-BITE ()
	 <HACK-HACK "Biting">>

<ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<COND (<EQUAL? .AV ,PRSO>
		       <TELL ,YOU-ARE ,PERIOD>)
		      (<AND <FSET? .AV ,VEHBIT>
			    <HELD? ,PRSO .AV>>
		       <TELL ,YOU-HAVE-TO "leave " THE .AV " first" ,PERIOD>)
		      (T
		       <RFALSE>)>)
	       (T
		<TELL ,YOU-CANT "get into " THE ,PRSO "!" CR>)>
	 <RFATAL>>

<ROUTINE YOU-ARE-IN (AV)
	 <TELL ,YOU-ARE
	       <COND (<FSET? .AV ,SURFACEBIT> " on ")
		     (ELSE " in ")>
	       THE .AV "!" CR>>

<ROUTINE V-BOARD ("AUX" AV)
	 <TELL ,YOU-ARE-NOW "in ">
	 <THE-PRSO>
	 <MOVE ,WINNER ,PRSO>
	 %<DEBUG-CODE <D-APPLY "Get in" <GETP ,PRSO ,P?ACTION> ,M-ENTER>
		      <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>>
	 <RTRUE>>

<ROUTINE V-BURN ()
	 <COND (<NOT ,PRSI>
		<TELL "Your blazing gaze is insufficient." CR>)
	       (T
		<WITH-PRSI?>)>>

<ROUTINE V-CHASTISE ()
	 <TELL
"Use prepositions instead: LOOK AT the object, LOOK INSIDE it,
LOOK UNDER it, etc." CR>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?DOWN>)
	       (T
		<TELL ,WASTE-OF-TIME>)>>

<ROUTINE V-CLIMB-FOO ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (T
		<TELL ,WASTE-OF-TIME>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<AND <FSET? ,PRSO ,VEHBIT>
		     <FSET? ,PRSO ,SURFACEBIT>>
		<NEW-VERB ,V?BOARD>
		<RTRUE>)
	       (T
		<TELL ,YOU-CANT "climb onto "><A-PRSO>)>>

<ROUTINE V-CLIMB-OVER ()
	 <YOU-CANT-X-THAT "do">>

<ROUTINE V-CLIMB-UP ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (T
		<TELL ,WASTE-OF-TIME>)>>

<ROUTINE V-CLOSE ()
	 <COND (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
		     <FSET? ,PRSO ,OPENABLE>>
		<TELL CTHE ,PRSO " is already closed." CR>)
	       (<OR <FSET? ,PRSO ,SURFACEBIT>
		    <AND <NOT <FSET? ,PRSO ,CONTBIT>>
			 <NOT <FSET? ,PRSO ,DOORBIT>>>>
		<TELL "There's no way to close "><THE-PRSO>)
	       (<FSET? ,PRSO ,PERSON>
		<TELL "Huh?" CR>)
	       (<NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Closed">
		       <IN-DARK?>)
		      (T
		       <ALREADY-CLOSED>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<CLOSE-A-DOOR>)
	       (T
		<YOU-CANT-X-THAT "close">)>>

<ROUTINE CLOSE-A-DOOR ()
	 <COND (<FSET? ,PRSO ,OPENBIT>
		<OKAY-THE-PRSO-IS-NOW "closed">
		<FCLEAR ,PRSO ,OPENBIT>)
	       (T
		<ALREADY-CLOSED>)>>

<ROUTINE IN-DARK? ("OPT" (DIE? <>) "AUX" OLIT)
	 <SET OLIT ,LIT>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND .OLIT <NOT ,LIT>>
		<TELL
", leaving you in the dark." CR>
		<COND (.DIE?
		       <CRLF>
		       <TELL "Not alone, however. ">
		       <JIGS-UP ;"this string is a duplicate of one in GOTO"
"One should never assume the dark is safe.
Something just grabbed you from behind and dragged you
off to its lair.">)
		      (ELSE <RTRUE>)>)
	       (ELSE <TELL ,PERIOD>)>>

<ROUTINE OKAY-THE-PRSO-IS-NOW (STR)
	 <TELL "Okay, " THE ,PRSO " is now " .STR ,PERIOD>>

<ROUTINE V-COMPARE-MANY ()
	 <COND (<EQUAL? <GET ,P-PRSO 0> 2>
		<SETG P-MULT <>>
		<PERFORM ,V?COMPARE <GET ,P-PRSO 1> <GET ,P-PRSO 2>>
		<RFATAL>)
	       (ELSE
		<TELL "You can only compare two things." CR>)>>

<ROUTINE V-WASTE-OF-TIME ()
	 <TELL ,WASTE-OF-TIME>>

<ROUTINE V-COMPARE ()
	 <COND (<AND <PRSO? RAT-SYMBOL STONE-SYMBOL CARVING-SYMBOL TATTOO CARTON>
		     <PRSI? RAT-SYMBOL STONE-SYMBOL CARVING-SYMBOL TATTOO CARTON>>
		<TELL
"Allowing for the different media in which the symbols are executed,
they are identical." CR>)
	       (ELSE
		<TELL ,WASTE-OF-TIME>)>>

;<ROUTINE V-COUNT ()
	 <TELL ,WASTE-OF-TIME>>

<ROUTINE V-CROSS ()
	 <YOU-CANT-X-THAT "cross">>

<ROUTINE V-CURSE ()
	 <TELL
"Language like that was until recently grounds for probation!" CR>>

<ROUTINE V-CUT ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<NEW-VERB ,V?KILL>
		<RTRUE>)
	       (<OR <NOT ,PRSI> <NOT <FSET? ,PRSI ,WEAPONBIT>>>
		<COND (<OR <NOT ,PRSI> <INTRINSIC? ,PRSI>>
		       <TELL "Your body">)
		      (ELSE
		       <TELL CTHE ,PRSI>)>
		<TELL
" has an inadequate \"cutting edge.\"" CR>)
	       (T
		<TO-A-PRSO?>)>>

;<ROUTINE V-DIG ()
	 <TELL ,WASTE-OF-TIME>>

<ROUTINE V-DISEMBARK ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND (<OR <NOT ,PRSO>
		    <PRSO? ,ROOMS>>
		<COND (<AND .AV <FSET? .AV ,VEHBIT>>
		       <NEW-PRSO .AV>
		       <RTRUE>)
		      ;(<FSET? ,HERE ,RWATERBIT>
		       <DO-WALK ,P?UP>)
		      (ELSE
		       <TELL ,YOU-ARENT "in anything." CR>)>)
	       (<AND .AV
		     <FSET? .AV ,VEHBIT>>
		<COND (<AND <NOT <EQUAL? .AV ,PRSO>>
			    <NOT <HELD? .AV ,PRSO>>>
		       <YOU-ARE-IN .AV>
		       <RFATAL>)
		      (T
		       <MOVE ,WINNER <LOC ,PRSO>> ;"for vehicle in vehicle"
		       <TELL ,YOU-ARE-NOW "on your feet." CR>)>)
	       (<LOC ,PRSO>
		<NEW-VERB ,V?TAKE>
		<RTRUE>)
	       (ELSE
		<TELL "It's not in anything." CR>)>>

<ROUTINE V-DRINK ("AUX" S)
	 <YOU-CANT-X-THAT "drink">>

<ROUTINE V-DRINK-FROM ("AUX" X)
	 <COND ;(<PRSO? ,WATER>
		<PERFORM ,V?DRINK ,PRSO>
		<RTRUE>)
	       (T
		<TO-A-PRSO?>)>>

<ROUTINE PRE-DROP ()
	 <COND (<OR <AND <PRSO? ,ROOMS ,CABLE>
			 ,ON-CABLE?>
		    <PRSO? <LOC ,WINNER>>>
		<NEW-VERB ,V?DISEMBARK>
		<RTRUE>)>>

<ROUTINE V-DROP ()
	 <COND (<PRSO? ,ROOMS>
		<TELL ,YOU-ARENT "hanging from anything." CR>)
	       (<IDROP>
		<TELL "Dropped." CR>)
	       (ELSE <RTRUE>)>>

<ROUTINE V-EAT ("AUX" H)
	 <COND (<AND <GETPT ,PRSO ,P?HEAT>
		     <FSET? ,PRSO ,FOODBIT>>
		<TELL "It tastes " <HEAT ,PRSO> ,PERIOD>)
	       (ELSE
		<TELL
"The food here is terrible, but this is ridiculous!" CR>)>>

<ROUTINE V-ENTER ("AUX" VEHICLE)
	 <COND (<IN? ,PENTAGRAM ,HERE>
		<PERFORM ,V?BOARD ,PENTAGRAM>
		<RTRUE>)
	       (<GETPT ,HERE ,P?IN>
		<DO-WALK ,P?IN>)
	       (ELSE
		<V-WALK-AROUND>)>>

<ROUTINE PRE-EXAMINE ()
	 <COND (<NOT ,LIT>
		<TELL ,TOO-DARK>)
	       (<FSET? ,PRSO ,SLIMEBIT>
		<TELL "First, it's covered with slime. ">
		<RFALSE>)>>

<ROUTINE V-EXAMINE ("AUX" H)
	 <COND (<AND <FSET? ,PRSO ,READBIT>
		     <GETP ,PRSO ,P?TEXT>>
		<NEW-VERB ,V?READ>
		<RTRUE>)
	       (<FSET? ,PRSO ,DOORBIT>
		<V-LOOK-INSIDE>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <V-LOOK-INSIDE>)
		      (T
		       <TELL S "It's closed.|">)>)
	       (<GETPT ,PRSO ,P?HEAT>
		<TELL "It looks " <HEAT ,PRSO> ,PERIOD>)
	       (T
		<PRSO-NOTHING-SPECIAL>)>>

<ROUTINE PRSO-NOTHING-SPECIAL ()
	 <TELL S "You see nothing special about ">
	 <THE-PRSO>>

<ROUTINE V-EXIT ()
	 <COND (<AND ,PRSO <FSET? ,PRSO ,VEHBIT>>
		<NEW-VERB ,V?DISEMBARK>
		<RTRUE>)
	       (<GETPT ,HERE ,P?OUT>
		<DO-WALK ,P?OUT>)
	       (ELSE
		<V-WALK-AROUND>)>>

<ROUTINE V-FILL ()
	 <COND (<NOT ,PRSI>
		<TELL
,THERES-NOTHING-TO "fill it with" ,PERIOD>)
	       (T
		<TELL-YUKS>)>>

<ROUTINE V-FIND ("OPT" (WHERE <>) "AUX" L)
	 <COND (<INTRINSIC? ,PRSO>
		<TELL
"Nearby, I'm sure">)
	       (<IN? ,PRSO ,PLAYER>
		<TELL "You have it">)
	       (<OR <IN? ,PRSO ,HERE>
		    <PRSO? ,PSEUDO-OBJECT>>
		<TELL "Right in front of you">)
	       (<OR <IN? ,PRSO ,LOCAL-GLOBALS>
		    <IN? ,PRSO ,GLOBAL-OBJECTS>>
		<TELL "It could be lurking right behind you">)
	       (ELSE
		<SET L <LOC ,PRSO>>
		<COND (<AND <EQUAL? .L ,URCHIN>
			    <VISIBLE? .L>>
		       <TELL "Maybe an urchin ripped it off">)
		      (<AND <FSET? .L ,PERSON>
			    <VISIBLE? .L>>
		       <TELL "I think " THE .L " has it">)
		      (<ACCESSIBLE? ,PRSO>
		       <TELL "It's in " THE .L>)
		      (.WHERE
		       <TELL "Beats me">)
		      (T
		       <TELL ,YOU-HAVE-TO "do that yourself">)>)>
	 <TELL ,PERIOD>>

<ROUTINE V-FOLLOW ()
	 <COND (<AND ,PRSO <IN? ,PRSO ,HERE>>
		<TELL CTHE ,PRSO " is right here!" CR>)
	       (T
		<TELL ,WASTE-OF-TIME>)>>

<ROUTINE PRE-GIVE ()
	 <COND (<AND <WINNER? ,PLAYER>
		     <NOT <HELD? ,PRSO>>
		<TELL
,YOU-HAVE-TO "get it first." CR>)>>

<ROUTINE V-GIVE ()
	 <COND (<NOT <FSET? ,PRSI ,PERSON>>
		<TELL ,YOU-CANT "give " A ,PRSO " to " A ,PRSI "!" CR>)
	       (T
		<UNINTERESTED ,PRSI>)>>

<ROUTINE V-HELLO ("AUX" OWINNER)
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,PERSON>
		       <NEW-WINNER-PRSO ,PRSA>
		       <RTRUE>)
		      (T
		       <TELL
"Serious college students never say \"Hello\" to "><A-PRSO>)>)
	       (T
		<TELL "Cheery, aren't you?" CR>)>>

<ROUTINE V-HELP ()
	 <COND (,PRSO
		<TELL
CTHE ,PRSO S " doesn't appear to ""want help." CR>)
	       (<IN? ,PC ,HERE>
		<PERFORM ,V?PUSH ,HELP-KEY>
		<RTRUE>)
	       (ELSE
		<TELL
"If you're really stuck, you can order maps and InvisiClues Hint
Booklets using the order form that came in your package." CR>)>>

<ROUTINE V-HIDE ()
	 <COND (<NOT ,PRSO>
		<TELL "There's no place to hide here." CR>
		<RFATAL>)
	       (<AND ,PRSI <FSET? ,PRSI ,PERSON>>
		<UNINTERESTED ,PRSI>)
	       (<NOT ,PRSI>
		<TELL ,WASTE-OF-TIME> ;"useless")>>

<ROUTINE V-HIDE-FROM ()
	 <TELL ,YOU-HAVE-TO "decide where." CR>>

<ROUTINE V-KICK ()
	 <HACK-HACK "Kicking">>

<ROUTINE V-KILL ()
	 <IKILL "kill">>

<ROUTINE IKILL (STR)
	 <COND (<NOT ,PRSO>
		<TELL ,THERES-NOTHING-TO .STR " here." CR>)>
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL
"Pounding on a door is of little use." CR>)
	       (<NOT <FSET? ,PRSO ,PERSON>>
		<TO-A-PRSO?>)
	       (<OR <PRSI? <> ,HANDS>
		    <NOT <FSET? ,PRSI ,WEAPONBIT>>>
		<TELL
"Trying to " .STR " " THE ,PRSO " with ">
		<COND (<NOT <PRSI? <> ,HANDS>>
		       <TELL A ,PRSI>)
		      (ELSE <TELL "your bare hands">)>
		<TELL " is suicidal." CR>)
	       (<NOT <IN? ,PRSI ,WINNER>>
		<NOT-HOLDING ,PRSI>)
	       (T
		<NOT-TRAINED>)>>

<ROUTINE NOT-TRAINED ()
	 <TELL
"You miss. (Now you know why few technical schools make it to the
Rose Bowl.)" CR>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Nobody's home." CR>)
	       (T
		<TELL "Why knock on "> <A-PRSO?>)>>

<ROUTINE V-KISS ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<UNINTERESTED ,PRSO>)
	       (ELSE <TELL-YUKS>)>>

<ROUTINE V-LAMP-OFF ()
	 <TO-A-PRSO?> ;"flashlight is only light source">

<ROUTINE V-LAMP-ON ()
	 <TO-A-PRSO?>>

<ROUTINE V-LEAN-ON ()
	 <TELL "Tired?" CR>>

<ROUTINE V-LEAP ()
	 <COND (<AND ,PRSO <IN? ,PRSO ,HERE>>
		<V-SKIP>)
	       (<HERE? CS-ROOF ON-DOME>
		<JIGS-UP
"It was a long way down. It was quick, though.">)
	       (T
		<TELL ,GOOD-TRICK>)>>

<ROUTINE V-LEAVE ()
	 <DO-WALK ,P?OUT>>

<ROUTINE V-LISTEN ()
	 <COND (<HERE? ,YUGGOTH ,BOWL-ROOM ,PLATFORM-ROOM>
		<TELL
"The sounds here are harsh and discordant." CR>)
	       (<HERE? ,CAVE-ALTAR ,CAVE-ROOM>
		<I-PANEL-NOISES T>)
	       (<AND ,PRSO <NOT <PRSO? ,NOISE>>>
		<TELL
"At the moment, " THE ,PRSO " is as quiet as a graveyard." CR>)
	       (<AND <IN-TUNNEL? ,RATS>
		     <IN-TUNNEL? ,WINNER>>
		<TELL ,RATS-CHITTERING>)
	       (<PROB 90>
		<TELL
"You hear nothing unsettling." CR>)
	       (ELSE
		<TELL
"You hear a very odd noise, sort of like breathing." CR>)>>

<ROUTINE V-LOCK ()
	 <TELL CTHE ,PRSO " doesn't have a lock." CR>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM <G? ,VERBOSITY 1>>
		<COND (,VERBOSITY <DESCRIBE-OBJECTS>)>)>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS>)>>

<ROUTINE V-LOOK-BEHIND ()
	 <COND (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
		     <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <OR <FSET? ,PRSO ,CONTBIT>
			 <FSET? ,PRSO ,DOORBIT>>>
		<INSPECTION-REVEALS ,PRSO>)
	       (ELSE
		<TELL ,THERE-IS-NOTHING "behind "><THE-PRSO>)>>

<ROUTINE V-LOOK-DOWN ()
	 <COND (<NOT ,LIT>
		<TELL ,TOO-DARK>)
	       (<PRSO? <> ,ROOMS ,GLOBAL-HOLE>
		<COND (<GLOBAL-IN? ,GLOBAL-HOLE ,HERE>
		       <PERFORM ,V?LOOK-INSIDE ,GLOBAL-HOLE>)
		      (ELSE
		       <PERFORM ,V?EXAMINE ,GROUND>)>
		<RTRUE>)
	       (ELSE
		<PRSO-NOTHING-SPECIAL>)>>

<ROUTINE WHAT-CONTENTS ()
	 <COND (<NOT <DESCRIBE-CONTENTS ,PRSO>>
		<TELL "nothing">
		<COND (<IN? ,PLAYER ,PRSO>
		       <TELL " (other than you)">)>)>
	 <TELL ,PERIOD>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<PRSO-NOTHING-SPECIAL>)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<TELL "On " THE ,PRSO " is ">
		<WHAT-CONTENTS>)
	       (<FSET? ,PRSO ,DOORBIT>
		<THIS-IS-IT ,PRSO>
		<TELL "All you can tell is that ">
		<TELL-OPEN-CLOSED>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<PRSO? <LOC ,WINNER>>
		       <MOVE ,PLAYER ,ROOMS>
		       <TELL "Aside from you, there's ">
		       <WHAT-CONTENTS>
		       <MOVE ,PLAYER ,PRSO>)
		      (<SEE-INSIDE? ,PRSO>
		       <TELL CTHE ,PRSO " contains ">
		       <WHAT-CONTENTS>)
		      (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <FIRST? ,PRSO>>
		       <NEW-VERB ,V?OPEN>
		       <RTRUE>)
		      (T
		       <THIS-IS-IT ,PRSO>
		       <TELL "It seems ">
		       <TELL-OPEN-CLOSED>)>)
	       (T
		<YOU-CANT-X-PRSO "look inside">)>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<HELD? ,PRSO>
		<TELL "You're already holding it!" CR>)
	       (T
		<TELL ,THERE-IS-NOTHING "there." CR>)>>

<ROUTINE V-LOWER ()
	 <HACK-HACK "Lowering">>

<ROUTINE V-LOWER-INTO ()
	 <V-LOWER>>

<ROUTINE V-MELT ()
	 <WITH-PRSI?>>

<ROUTINE V-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL
"You're holding it. Are you planning to juggle it?" CR>)
	       (<AND <FSET? ,PRSO ,TAKEBIT>
		     <NOT <FSET? ,PRSO ,PERSON>>>
		<V-TURN-OVER>)
	       (T
		<YOU-CANT-X-PRSO "move">)>>

<ROUTINE HOSTILE-VERB? ()
	 <VERB? ATTACK BITE CUT KICK KILL MUNG RUB PUSH MOVE THROW>>

"verbs which don't require object to exist/be nearby"

<ROUTINE ABSTRACT-VERB? ()
	 <VERB? ASK-ABOUT ASK-FOR FIND
		TELL-ME-ABOUT TELL-ABOUT WHAT WHERE>>

"verbs with no object or which don't require touching their object."

<ROUTINE PASSIVE-VERB? ()
	 <OR <ABSTRACT-VERB?>
	     <VERB? COMPARE COUNT CURSE DIE DISEMBARK
		    EXAMINE HELLO LISTEN LOOK-BEHIND LOOK-DOWN
		    LOOK-INSIDE LOOK-UNDER POINT READ REPLY
		    SAY SCARE SHOW TELL THANK
		    WAIT WAIT-FOR WALK WAVE-AT YAWN
		    YELL>>>

<ROUTINE V-MUNG ()
	 <HACK-HACK "Trying to break">>

<ROUTINE PRE-OPEN ()
	 <COND (<AND <IN? ,PRSO ,MICROWAVE>
		     <NOT <FSET? ,MICROWAVE ,OPENBIT>>>
		<YOU-CANT-X-THAT "get to">)
	       (<OR <FSET? ,PRSO ,PERSON>
		    <PRSO? ,DEAD-RAT ,HAND>>
		<TELL "What a grisly idea." CR>)
	       (<AND ,PRSI
		     <NOT <PRSI? ,FORKLIFT>>
		     <NOT <HELD? ,PRSI>>>
		<NOT-HOLDING ,PRSI>)>>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<AND <FSET? ,PRSO ,OPENBIT>
		     <FSET? ,PRSO ,OPENABLE>>
		<TELL CTHE ,PRSO " is already open." CR>)
	       (<OR <AND <NOT <FSET? ,PRSO ,CONTBIT>>
		         <NOT <FSET? ,PRSO ,DOORBIT>>>
		    <FSET? ,PRSO ,SURFACEBIT>>
		<TO-A-PRSO?>)
	       (<NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>
		<COND (<NOT <FSET? ,PRSO ,OPENBIT>>
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,PRSO ,TOUCHBIT>
		       <COND (<OR <NOT <FIRST? ,PRSO>>
				  <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Opened." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <OKAY-THE-PRSO-IS-NOW "open">
			      <TELL .STR CR>)
			     (T
			      <TELL "Opening ">
			      <TELL THE ,PRSO " reveals ">
			      <WHAT-CONTENTS>)>)>)
	       (T ;"door"
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <ALREADY-OPEN>)
		      (<FSET? ,PRSO ,LOCKED>
		       <TELL "It's locked." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <OKAY-THE-PRSO-IS-NOW "open">)>)>>

;<ROUTINE V-PAY ()
	 <COND (<NOT ,PRSI>
		<TELL "Pay with what?" CR>
		<RTRUE>)
	       (T
		<WITH-PRSI?>)>>

<ROUTINE V-PICK ()
	 <YOU-CANT-X-THAT "pick">>

;<ROUTINE V-PLAY ()
         <TELL "How peculiar!" CR>>

<ROUTINE V-PLUG ()
	 <V-TURN> ;"no effect">

<ROUTINE V-POINT ()
	 <TELL "It may be dangerous to point." CR>>

<ROUTINE V-POUR-FROM ()
	 <COND (<IN? ,PRSO ,PRSI>
		<PERFORM ,V?POUR ,PRSO>
		<RTRUE>)
	       (ELSE
		<TELL "It's not in that!" CR>)>>

<ROUTINE PRE-POUR ()
	 <COND (<EQUAL? ,PRSO ,PRSI>
		<TELL-YUKS>)>>

<ROUTINE V-POUR ()
	 <COND (<AND <FSET? ,PRSO ,CONTBIT>
		     <HELD? ,PRSO>>
		<EMPTY-ALL ,PRSO ,PRSI>)
	       (ELSE
		<YOU-CANT-X-THAT "pour">)>>

<ROUTINE EMPTY-ALL (FROM TO "AUX" F N R (1ST? <>))
	 <MAP-CONTENTS (F N .FROM)
		       <COND (<FSET? .F ,TAKEBIT>
			      <SET 1ST? T>
			      <TELL D .F ": ">
			      <SET R
				   <COND (.TO
					  <PERFORM ,V?PUT .F .TO>)
					 (ELSE
					  <PERFORM ,V?DROP .F>)>>
			      <COND (<EQUAL? .R ,M-FATAL> <RTRUE>)>)>>
	 <COND (<NOT .1ST?> <TELL CTHE .FROM " is empty." CR>)>
	 <RTRUE>>

;<ROUTINE V-PUMP ()
	 <TELL "It's not clear how." CR>>

<ROUTINE V-PUSH ()
	 <HACK-HACK "Pushing">>

<ROUTINE V-PUSH-TO ()
	 <YOU-CANT-X-THAT "push things to">>

<ROUTINE PRE-PUT ("AUX" (L <LOC ,PRSO>))
	 <COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <NOT <FSET? ,PRSO ,TAKEBIT>>>
		<TELL "Nice try." CR>)
	       (<AND <VERB? PUT>
		     <FSET? ,PRSO ,WEAPONBIT>
		     <FSET? ,PRSI ,PERSON>>
		<SWAP-VERB ,V?ATTACK>
		<RTRUE>)
	       (<IN? ,PRSO ,PRSI>
		<TAKE-OUT-FIRST ,PRSO ,PRSI>)
	       (<IN? ,PRSI ,PRSO>
		<TAKE-OUT-FIRST ,PRSI ,PRSO>)
	       (<FSET? .L ,PERSON> <RFALSE>)
	       (<AND <FSET? .L ,CONTBIT>
		     <NOT <FSET? .L ,OPENBIT>>>
		<TAKE-OUT-FIRST ,PRSO .L>)
	       (<PRSO? ,ELIXIR ,FLOOR-WAX ,NITROGEN>
		<NEW-VERB ,V?POUR>
		<RTRUE>)>>

<ROUTINE TAKE-OUT-FIRST (OBJ CONT)
	 <TELL
"You should take " THE .OBJ " ">
	 <COND (<EQUAL? .CONT ,HAND>
		<TELL "off">)
	       (ELSE <TELL "out">)>
	 <TELL " " THE .CONT " first." CR>>

<ROUTINE V-PUT ("AUX" W)
	 <COND (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,DOORBIT>>
		     <NOT <FSET? ,PRSI ,CONTBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>
		     <NOT <FSET? ,PRSI ,VEHBIT>>>
		<YOU-CANT-X-THAT "do">
		<RTRUE>)
	       (<EQUAL? ,PRSI ,POOL>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<INSPECTION-REVEALS ,PRSI>)
	       (<PRSI? ,PRSO>
		<TO-A-PRSO?>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "I think ">
		<TELL THE ,PRSO " is already in ">
		<THE-PRSI>)
	       (<AND <FSET? <SET W <LOC ,PRSI>> ,PERSON>
		     <NOT <EQUAL? .W ,WINNER>>>
		<TELL
"Don't you think you should ask " THE .W " first?" CR>)
	       (<OR <AND <PRSO? ,AXE ,BOLT-CUTTER ,CROWBAR>
			 <PRSI? ,MICROWAVE>>
		    <PRSO-TOO-BIG?>>
		<TELL ,NO-ROOM CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <NOT <EQUAL? <ITAKE> T>>>
		<RTRUE>)
	       (T
		<FCLEAR ,PRSO ,WEARBIT>
		<MOVE ,PRSO ,PRSI>
		<COND (<PRSI? ,FLASK>
		       <FCLEAR ,PRSO ,SLIMEBIT>)>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

<ROUTINE PRSO-TOO-BIG? ()
	 <COND (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<RTRUE>)
	       (ELSE <RFALSE>)>>

<ROUTINE INSPECTION-REVEALS (OBJ)
	 <THIS-IS-IT .OBJ>
	 <TELL "Inspection reveals that " THE .OBJ " isn't open." CR>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL ,YOU-CANT "be sure what's lurking there." CR>>

<ROUTINE V-PUT-ON ()
	 <COND (<PRSI? ,ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<PRSI? ,GROUND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T
		<NO-GOOD-SURFACE>)>>

<ROUTINE NO-GOOD-SURFACE ()
	 <TELL "There's no good surface on ">
	 <THE-PRSI>>

<ROUTINE V-PUT-UNDER ()
         <YOU-CANT-X-THAT "put anything under">>

<ROUTINE V-RAISE ()
	 <HACK-HACK "Lifting">>

<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <COND (<OR <NOT <FSET? ,PRSO ,CONTBIT>>
		    <FSET? ,PRSO ,PERSON>>
		<TO-A-PRSO?>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "It's not open." CR>)
	       (<OR <NOT <SET OBJ <FIRST? ,PRSO>>>
		    <FSET? .OBJ ,INVISIBLE>
		    <NOT <FSET? .OBJ ,TAKEBIT>>>
		<ITS-EMPTY>)
	       (T
		<TELL
S "You feel something " "in " THE ,PRSO "!" CR>
		<RTRUE>)>>

<ROUTINE PRE-READ ()
	 <COND (<NOT ,LIT>
		<TELL ,YOU-CANT "read in the dark." CR>)
	       (<AND ,PRSI <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<HOW-DO-YOU> <A-PRSI?>)>>

<ROUTINE HOW-DO-YOU ()
	 <TELL "How do you do that with ">>

<ROUTINE V-READ ()
	 <COND (<AND <FSET? ,PRSO ,READBIT>
		     <GETP ,PRSO ,P?TEXT>>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
               (T
                <TO-A-PRSO?>)>>

<ROUTINE V-REPLY ()
	 <TELL "You are ignored." CR>
	 <END-QUOTE>>

<ROUTINE PRE-SRUB ()
	 <SWAP-VERB ,V?RUB>
	 <RTRUE>>

<ROUTINE V-SRUB ()
	 <RTRUE>>

<ROUTINE V-RUB ("AUX" H)
	 <COND (<GETPT ,PRSO ,P?HEAT>
		<TELL "It's " <HEAT ,PRSO> ,PERIOD>)
	       (<PRSO? ,AIR>
		<TELL "It's ">
		<COND (<FSET? ,HERE ,OUTSIDE>
		       <TELL "cold." CR>)
		      (ELSE
		       <TELL "warm." CR>)>)
	       (ELSE
		<HACK-HACK "Fiddling with">)>>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<SET V <FIND-IN ,HERE ,PERSON>>
		<TELL "You must address " THE .V " directly." CR>
		<END-QUOTE>)
	       (<EQUAL? <GET ,P-LEXV ,P-CONT> ,W?HELLO>
		<SETG QUOTE-FLAG <>>
		<RTRUE>)
	       (T
		<PERFORM ,V?TELL ,ME>
		<END-QUOTE>)>>

<ROUTINE V-SEARCH ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL
CTHE ,PRSO " refuses." CR>)
	       (ELSE
		<TELL ,THERE-IS-NOTHING "there" ,PERIOD>)>>

;<ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL "Why would you send for ">
		<A-PRSO?>)
	       (T
		<TELL-YUKS>)>>

<ROUTINE PRE-SGIVE ()
	 <SWAP-VERB ,V?GIVE>
	 <RTRUE>>

<ROUTINE V-SGIVE ()
	 <RTRUE>>

<ROUTINE V-SHAKE ("AUX" X)
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL "Be real." CR>)
	       ;(<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL ,YOU-CANT "take it; thus, you can't shake it!" CR>)
	       (T
		<TELL "There's no point in shaking that." CR>)>>

<ROUTINE V-SHARPEN ()
	 <TELL "You'll never sharpen anything with that!" CR>>

<ROUTINE V-SHOOT ()
	 <TELL
"This explains why you aren't in ROTC." CR>>

<ROUTINE V-SHOW ()
	 <COND (<FSET? ,PRSI ,PERSON>
		<UNINTERESTED ,PRSI>)
	       (ELSE <TELL-YUKS>)>>

<ROUTINE V-SIT ()
	 <COND (<AND <P? SIT ROOMS>
		     <IN? ,CHAIR ,HERE>>
		<NEW-PRSO ,CHAIR>
		<RTRUE>)
	       (ELSE
		<TELL ,WASTE-OF-TIME>)>>

<ROUTINE V-SKIP ()
	 <TELL "Not as fun as skipping class." CR>>

<ROUTINE V-SLEEP ("OPTIONAL" (FORCE? <>))
	 <COND (<AND <NOT .FORCE?> <EQUAL? ,AWAKE -1>>
		<TELL
"You try to sleep, but you can't relax." CR>)
	       (<QUEUED? I-FREEZE-TO-DEATH>
		<TELL
"You would freeze to death before you woke." CR>)
	       (T
		<TELL
"You've been up for a long time, and it was turning into an
all-nighter. You can use the rest. You
stretch out as best you can. You toss and turn fitfully,
sleeping only in snatches." CR CR "You dream of " <RANDOM-ELEMENT ,DREAMS>
			    CR CR>
		<JIGS-UP
"Your dream ends, and another begins. Something clawed and fanged grabs
you, and you try to wake, but you already are!">
		<RFATAL>)>>

<GLOBAL DREAMS
	<LTABLE (PURE)	 
"being late for class. First you can't find the classroom, 
and when you finally find it you realize they're giving an exam."

"standing on the roof of the Brown Building, looking down at the ground.
You lose your balance..."

"a dark curtain, blown gently in a breeze you don't feel. You try to
rip it aside, but you can't, because you know what's behind it."

"being pursued. You trip, slip, fall, and can't
make headway. It's not coming very fast, but you can't get away.">>

<ROUTINE LIKE-A-PRSO (V)
	 <TELL "It " .V " just like " A ,PRSO "." CR>>

<ROUTINE V-SMELL ()
	 <COND (,PRSO
		<LIKE-A-PRSO "smells">)
	       (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM-PRSA <LOC ,WINNER>>
		<RTRUE>)
	       (ELSE
		<TELL
"There's no noticeable smell here." CR>)>>

;<ROUTINE V-SPAY ()
	 <SWAP-VERB ,V?PAY>
	 <RTRUE>>

;<ROUTINE V-SPIN ()
	 <YOU-CANT-X-THAT "spin">>

<ROUTINE PRE-SSHOW ()
	 <SWAP-VERB ,V?SHOW>
	 <RTRUE>>

<ROUTINE V-SSHOW ()
	 <RTRUE>>

<ROUTINE V-STAND ()
	 <COND (<PRSO? <> ,ROOMS>
		<COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		       <PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		       <RTRUE>)
		      (T
		       <TELL ,YOU-ARE " standing." CR>)>)
	       (ELSE 
		<HACK-HACK "Holding up">)>>

;<ROUTINE V-STAND-ON ()
	 <TELL ,WASTE-OF-TIME>>

<ROUTINE V-SWING ()
	 <COND (<NOT ,PRSI>
		<TELL "Whoosh!" CR>)
	       (T
		<SWAP-VERB ,V?ATTACK>
		<RTRUE>)>>

<ROUTINE V-SWIM ()
	 <TELL-YUKS>>

<ROUTINE PRE-TAKE ()
	 <COND (<IN? ,PRSO ,WINNER>
		<TELL ,YOU-HAVE "it." CR>)
	       (<AND <NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		     <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>
		     <NOT <PRSO? ,REPEATER-COVER ,PADLOCK>>>
		<CANT-REACH-THAT>
		<RTRUE>)
	       (,PRSI
		<COND (<PRSI? ,WALL-SOCKET ,ROD ,HOOK> <RFALSE>)
		      (<PRSO? ,ME>
		       <PERFORM ,V?DROP ,PRSI>
		       <RTRUE>)
		      (<AND <NOT <PRSI? <LOC ,PRSO>>>
			    <OR <AND <PRSI? ,HOOK>
				     <NOT <EQUAL? ,PRSO ,CHAIN-HOOKED?>>>
				<AND <PRSI? ,ROD>
				     <NOT <EQUAL? ,PRSO ,CHAIN-LOOPED?>>>>>
		       <TELL "But ">
		       <TELL THE ,PRSO " isn't in ">
		       <THE-PRSI>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<PRSO? <LOC ,WINNER>>
		<TELL "You are ">
		<COND (<FSET? ,PRSO ,PERSON> <TELL "being carried by">)
		      (<FSET? ,PRSO ,SURFACEBIT> <TELL "on">)
		      (ELSE <TELL "in">)>
		<TELL " it!" CR>)>>

"return true if prso or prsi is inaccessible from vehicle and verb requires
access to it.  e.g.,
  >EXAMINE obj-outside-vehicle => rfalse
  >TAKE obj-outside-vehicle => rtrue"

<ROUTINE NOT-REACHABLE? ()
	 <COND (<PASSIVE-VERB?> <RFALSE>)>
	 <COND (<NOT-IN-VEHICLE? ,PRSO> <RETURN ,PRSO>)
	       (<NOT-IN-VEHICLE? ,PRSI> <RETURN ,PRSI>)>>

<ROUTINE CANT-REACH-FROM-VEHICLE (O)
	 <TELL
,YOU-CANT "reach " THE .O " from within " THE <LOC ,WINNER> "." CR>>

<ROUTINE NOT-IN-VEHICLE? (PP "AUX" (V <LOC ,WINNER>))
	 <COND (<OR <NOT .PP>
		    <EQUAL? .PP .V ,ROOMS>
		    <INTRINSIC? .PP>
		    <HELD? .PP>
		    <EQUAL? <META-LOC .PP> .V>>
		<RFALSE>)
	       (ELSE <RTRUE>)>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<TELL ,TAKEN>)>>

<ROUTINE V-TAKE-OFF ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<NEW-VERB ,V?DISEMBARK>
		<RTRUE>)
	       (<FSET? ,PRSO ,WEARBIT>
		<FCLEAR ,PRSO ,WEARBIT>
		<TELL
"You're no longer wearing " THE ,PRSO ,PERIOD>)
	       (ELSE
		<NEW-VERB ,V?TAKE>
		<RTRUE>)>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       ;<COND (<IN? <LOC ,WINNER> ,ROOMS>
			      <SETG HERE <LOC ,WINNER>>)>)
		      (T
		       <TELL
"Hmmm ... " THE ,PRSO " waits for you to say something." CR>)>
		<RTRUE>)
	       (T
		<YOU-CANT-X-PRSO "talk to">
		<END-QUOTE>)>>

<ROUTINE V-THANK ()
	 <COND (<NOT ,PRSO>
		<TELL "You're welcome, I guess." CR>)
	       (<FSET? ,PRSO ,PERSON>
		<UNINTERESTED ,PRSO>)
	       (T
		<TO-A-PRSO?>)>>

<ROUTINE V-THROUGH ("AUX" M)
	<COND (<PRSO? ,ROOMS>
	       <DO-WALK ,P?IN>)
	      (<PRSO? ,INTNAME>
	       <NEW-VERB ,V?TYPE>
	       <RTRUE>)
	      (<FSET? ,PRSO ,VEHBIT>
	       <NEW-VERB ,V?BOARD>
	       <RTRUE>)
	      (<AND <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,OPENBIT>>
	       <DO-WALK ,P?IN>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL
"You hit your head against " THE ,PRSO " as you attempt this feat." CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "That would involve quite a contortion!" CR>)
	      (T
	       <TELL-YUKS>)>>

<ROUTINE V-THROW ()
	 <COND (<AND ,PRSI
		     <FSET? ,PRSI ,PERSON>>
	        <COND (<IN? ,PRSO ,WINNER>
		       <COND (<IDROP>
			      <NOT-TRAINED>)>)
		      (ELSE
		       <SWAP-VERB ,V?ATTACK>
		       <RTRUE>)>)
	       (<AND ,PRSI
		     <NOT <PRSI? PSEUDO-OBJECT>>
		     <FSET? ,PRSO ,WEAPONBIT>>
		<SWAP-VERB ,V?ATTACK>
		<RTRUE>)
	       (<AND ,PRSI
		     <NOT <FSET? ,PRSI ,DOORBIT>>
		     <FSET? ,PRSI ,CONTBIT>
		     <GETP ,PRSI ,P?CAPACITY>>
		<NEW-VERB ,V?PUT>
		<RTRUE>)
	       (<IDROP>
		<TELL "Thrown." CR>)>>

<ROUTINE V-THROW-OFF ()
	 <YOU-CANT-X-THAT "throw anything off">>

<ROUTINE V-TIE ()
	 <TO-A-PRSO?>>

<ROUTINE V-TIE-UP ()
	 <TO-A-PRSO?>>

<ROUTINE V-TIME ("AUX" X)
	 <TELL "It seems like three o'clock in the morning." CR>>

<ROUTINE V-TORTURE ()
	 <TELL "An appalling idea!" CR>>

<ROUTINE V-TURN () ;"used by others"
	 <TELL "This has no effect." CR>>

<ROUTINE V-TURN-OVER ()
	 <TELL "Moving " THE ,PRSO " reveals nothing." CR>>

<ROUTINE V-TURN-AROUND ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM ,V?LOOK-BEHIND ,ME>
		<RTRUE>)
	       (<FSET? ,PRSO ,PERSON>
		<TELL
"I wouldn't do that, " THE ,PRSO " might get dizzy." CR>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL
,YOU-CANT "turn " THE ,PRSO " around." CR>)
	       (ELSE
		<TELL
"Turning " THE ,PRSO " around gives you a new perspective on it, but
reveals no new information." CR>)>>

<ROUTINE V-UNLOCK ()
	 <COND (<AND <FSET? ,PRSO ,DOORBIT>
		     <PRSI? ,MASTER-KEY>>
		<TELL
"The key fits perfectly in the lock, but the lock doesn't turn.
The master key doesn't work on this lock." CR>)
	       (ELSE
		<V-LOCK>)>>

<ROUTINE V-UNTIE ()
	 <TO-A-PRSO?>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 <COND (<NOT ,P-WALK-DIR>
		<NEW-VERB ,V?WALK-TO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<SET PTS <PTSIZE .PT>>
		<COND (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,UEXIT>
		       <SET RM <GETB .PT ,REXIT>>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<NOT <SET RM <APPLY <GET .PT ,FEXITFCN>>>>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <SET RM <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <CANT-GO>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <SET OBJ <GETB .PT ,DEXITOBJ>>
		       <COND (<FSET? .OBJ ,OPENBIT>
			      <SET RM <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)
			     (T
			      <TELL-OPEN-CLOSED .OBJ>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)>)>
		<COND (<IN? ,FLOOR-WAX ,HERE>
		       <TELL
"You slip and slide on the wax. It's like walking on wet ice. You can
barely keep upright, but ">
		       <COND (<AND ,CORD-SEVERED?
				   <IN? ,MAINTENANCE-MAN ,HERE>
				   <FSET? ,MAINTENANCE-MAN ,PERSON>>
			      <TELL
"it's worse for the maintenance man. His gait
is so jerky that each time he takes a step he
falls! His persistence is impressive, but you slip (literally)
by before he can grab you.">)
			     (ELSE
			      <TELL
"you manage to lose your balance in just the
right way to keep going.">)>
		       <TELL CR CR>)
		      (,ON-CABLE?
		       <COND (<NOT <PRSO? ,P?DOWN>>
			      <TELL
"You go hand-over-hand along the cable.">
			      <COND (<NOT <GLOBAL-IN? ,CABLE .RM>>
				     <SETG ON-CABLE? <>>
				     <TELL
" You reach the end, drop, and continue on.">)>
			      <COND (,RATS-HERE
				     <MOVE ,RATS ,HERE>
				     <TELL " The rats follow, red eyes
staring upward. Some of the bolder ones leap at your feet, and one hits
with a thump.">)>
			      <TELL CR CR>)>)>
		<GOTO .RM>)
	       (T
		<CANT-GO>
		<RFATAL>)>>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Please use compass directions instead." CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<AND ,PRSO
		     <OR <IN? ,PRSO ,HERE>
			 <GLOBAL-IN? ,PRSO ,HERE>>>
		<TELL "It's here!" CR>)
	       (T
		<V-WALK-AROUND>)>>

<ROUTINE V-WAIT ("AUX" (NUM 3))
	 <COND (<PRSO? ,INTNUM>
		<COND (<G? ,P-NUMBER 100>
		       <TELL "Too long!" CR>)
		      (T
		       <SET NUM ,P-NUMBER>)>)>
	 <TELL "Time passes..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0>
			<RETURN>)
		       (<CLOCKER>
			<RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<PRSO? INTNUM>
		<NEW-VERB ,V?WAIT>
		<RTRUE>)
	       (<EQUAL? <LOC ,PRSO> ,HERE ,WINNER>
		<TELL "It's already here!" CR>)
	       (T
		<TELL "You may well wait quite a while." CR>)>>

<ROUTINE V-WAVE ()
	 <HACK-HACK "Waving">>

<ROUTINE V-WAVE-AT ()
	 <TELL
CTHE ,PRSO>
	 <IS-ARE ,PRSO>
	 <TELL "n't likely to respond." CR>>

<ROUTINE V-WEAR ()
	 <COND (<FSET? ,PRSO ,WEARBIT>
		<TELL ,YOU-ARE ,PERIOD>)
	       (ELSE
		<YOU-CANT-X-PRSO "wear">)>>

<ROUTINE V-WHAT ()
	 <TELL "An excellent question." CR>>

<ROUTINE V-WHERE ()
	 <COND (<NOT ,PRSO>
		<COND (,P-IT-OBJECT
		       <NEW-PRSO ,P-IT-OBJECT>
		       <RTRUE>)
		      (ELSE
		       <TELL "Why?" CR>)>)
	       (ELSE
		<V-FIND T>)>>

<ROUTINE V-WHO ()
	 <COND (<NOT ,PRSO> <V-WHAT>)
	       (<FSET? ,PRSO ,PERSON>
		<NEW-VERB ,V?WHAT>
		<RTRUE>)
	       (T
		<TELL "That's not a person!" CR>)>>

<ROUTINE V-YAWN ()
	 <V-LEAN-ON>>

<ROUTINE V-YELL ()
	 <TELL "The scream echoes back to you, subtly changed." CR>>

;"subtitle object manipulation"

<CONSTANT FUMBLE-MAX 9>

<GLOBAL FUMBLE-NUMBER 9>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL-YUKS>)>
		<RFALSE>)
	       (<IN? ,PRSO ,WINNER>
		<TELL ,YOU-HAVE "it" ,PERIOD>
		<RFALSE>)
	       (<AND <PRSO? ,CHAIN-1 ,CHAIN-2>
		     <HELD? ,CHAIN>>
		<REMOVE ,PRSO>
		<RTRUE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <COND (<FIRST? ,PLAYER>
			      <TELL "Your load is too heavy">)
			     (T
			      <TELL "It's a little too heavy">)>
		       <COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
			      <TELL
", especially in light of your exhaustion.">)
			     (T
			      <TELL ".">)>
		       <CRLF>)>
		<RFATAL>)
	       (<G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		<COND (.VB
		       <TELL
"You're holding too many things and can't quite get them all arranged
to take it as well." CR>)>
		<RFATAL>)
	       (T
		<COND (<FSET? ,PRSO ,SLIMEBIT>
		       <QUEUE I-SLIME-OBJECT 1>)>
		<SCORE-OBJECT>
		<MOVE ,PRSO ,WINNER>
		<FCLEAR ,PRSO ,WEARBIT>
		<FCLEAR ,PRSO ,NDESCBIT>
		<RTRUE>)>>

<ROUTINE SCORE-OBJECT ("OPTIONAL" (OBJ <>))
	 <COND (<NOT .OBJ>
		<SET OBJ ,PRSO>
		<COND (<FSET? .OBJ ,TOUCHBIT> <RTRUE>)>)>
	 <COND (<GETPT .OBJ ,P?VALUE>
		<SETG SCORE <+ ,SCORE <GETP .OBJ ,P?VALUE>>>
		<PUTP .OBJ ,P?VALUE 0>)>
	 <FSET .OBJ ,TOUCHBIT>>

<ROUTINE IDROP ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL ,YOU-ARENT "carrying ">
		<THE-PRSO>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<THIS-IS-IT ,PRSO>
		<TELL-OPEN-CLOSED <LOC ,PRSO>>
		<RFALSE>)
	       (T
		<FCLEAR ,PRSO ,WEARBIT>
		<MOVE ,PRSO <LOC ,WINNER>>
		<RTRUE>)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <MAP-CONTENTS (X .OBJ)
		       (END <RETURN .CNT>)
	      <COND (<AND <EQUAL? .X ,HAND>
			  <FSET? ,HAND ,PERSON>>)
		    (<FSET? .X ,WEARBIT>)
		    (ELSE
		     <SET CNT <+ .CNT 1>>)>>>

;"WEIGHT: Gets sum of SIZEs of supplied object, recursing to nth level."

<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<AND <EQUAL? .OBJ ,HAND>
		     <FSET? ,HAND ,PERSON>>
		T)
	       (<NOT <FSET? .OBJ ,WEARBIT>>
		<MAP-CONTENTS (CONT .OBJ)
			      <SET WT <+ .WT <WEIGHT .CONT>>>>
		<+ .WT <GETP .OBJ ,P?SIZE>>)>>

^\L

;"subtitle movement"

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

;<ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<EQUAL? <GET .TBL .CNT> .ITM>
			<COND (<EQUAL? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

<GLOBAL OHERE <>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T) "AUX" OLIT)
	 <SETG OHERE .RM>
	 %<DEBUG-CODE <D-APPLY "Leave" <GETP ,HERE ,P?ACTION> ,M-LEAVE>
		      <APPLY <GETP ,HERE ,P?ACTION> ,M-LEAVE>>
	 <SETG OHERE ,HERE>
	 <SET OLIT ,LIT>
	 <COND (<NOT <IN? <LOC ,WINNER> ,ROOMS>>
		<MOVE <LOC ,WINNER> .RM>)
	       (ELSE
		<MOVE ,WINNER .RM>)>
	 <SETG HERE .RM>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND <NOT .OLIT>
		     <NOT ,LIT>
		     <PROB 80>>
		<JIGS-UP ;"this string is a duplicate of one in FLASHLIGHT-F"
"One should never assume the dark is safe.
Something just grabbed you from behind and dragged you
off to its lair.">
		<RTRUE>)>
	 %<DEBUG-CODE <D-APPLY "Enter" <GETP ,HERE ,P?ACTION> ,M-ENTER>
		      <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>>
	 <COND (<NOT <EQUAL? ,HERE .RM>>
		<RTRUE>)
	       (.V?
		<V-FIRST-LOOK>)>
	 <COND (,LIT <SCORE-OBJECT .RM>)>
	 <RTRUE>>

\

;"subtitle death and stuff"

<ROUTINE JIGS-UP ("OPTIONAL" (DESC <>) (FROB? <>))
	 <SETG WINNER ,PLAYER>
	 <COND (.DESC <TELL .DESC>)>
	 <TELL "|
|    ****  You have ">
	 <COND (.FROB? <TELL "changed">)
	       (ELSE <TELL "died">)>
	 <TELL "  ****|
|">
	 <COND (.FROB?
		<TELL
"Sometimes, during your future existence, you remember your old life.
At these times, you wish you had died instead." CR>)
	       (ELSE
		<TELL
"At first, you think \"Maybe it was all just a bad dream,\" but no such
luck. It appears to be for real. That's too bad, although
something gnawing on your " <RANDOM-ELEMENT ,PARTS> " thinks it's pretty
wonderful, or at least fairly tasty." CR>)>
	 <FINISH>>

<GLOBAL PARTS <LTABLE (PURE) "fingertips" "toes" "nose" "ears" "tongue">>

<ROUTINE ROB (FROM TO "OPTIONAL" (IGNORE <>)
	      "AUX" (F <FIRST? .FROM>) N (1ST? <>))
	 <REPEAT ()
		 <COND (.F
			<SET N <NEXT? .F>>
			<COND (<AND <EQUAL? .TO ,URCHIN>
				    <EQUAL? .F ,VAT ,HAND ,CHAIN ,FLOOR-WAX
					    ,DOME-LADDER ,MANHOLE-COVER
					    ,PLASTIC-CONTAINER ,CHAIR ,PC
					    ,LOVECRAFT>>
			       T)
			      (<AND <FSET? .F ,TAKEBIT>
				    <FSET? .F ,TOUCHBIT>
				    <NOT <EQUAL? .F .IGNORE>>> 
			       <SET 1ST? T>
			       <COND (.TO <MOVE .F .TO>)
				     (ELSE <REMOVE .F>)>)>
			<SET F .N>)
		       (T
			<RETURN>)>>
	 .1ST?>

^\L

;"subtitle useful utility routines"

<ROUTINE THIS-IS-IT (OBJ)
	 <COND (<NOT <EQUAL? .OBJ ,IT ,HIM>>
		<COND (<EQUAL? .OBJ ,HACKER ,MAINTENANCE-MAN ,PROFESSOR
			       ,URCHIN>
		       <COND (<NOT ,WAS-HIM?>
			      <SETG P-HIM-OBJECT .OBJ>)>)
		      (<NOT ,WAS-IT?>
		       <SETG P-IT-OBJECT .OBJ>)>)>>

<ROUTINE INTRINSIC? (OBJ)
	 <EQUAL? .OBJ ,ME ,HANDS ,HEAD ,EYES ,FEET>>

<ROUTINE ACCESSIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player TOUCH object?"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT .L>
		<RFALSE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE <LOC ,WINNER>>>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER ,HERE <LOC ,WINNER>>
		<RTRUE>)
	       (<AND <FSET? .L ,OPENBIT>
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player SEE object"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<ACCESSIBLE? .OBJ>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
		<RTRUE>)(T
		<RFALSE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ>
			<RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (T
			<SET OBJ <LOC .OBJ>>)>>>

<ROUTINE HELD? (OBJ "OPTIONAL" (WHO <>))
	 ;"is object carried, or in something carried, by player?"
	 <COND (<NOT .WHO> <SET WHO ,PLAYER>)>
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<IN? .OBJ .WHO>
		<RTRUE>)
	       (<IN? .OBJ ,ROOMS>
		<RFALSE>)
	       (<IN? .OBJ ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (T
		<HELD? <LOC .OBJ> .WHO>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND .OBJ
	      <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT>
	          <FSET? .OBJ ,OPENBIT>>>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TEE)
	 <COND (<AND .OBJ2
		     <SET TEE <GETPT .OBJ2 ,P?GLOBAL>>>
		<ZMEMQB .OBJ1 .TEE <- <PTSIZE .TEE> 1>>)>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

;<ROUTINE SOAK-STUFF (OBJ "OPTIONAL" (RECURSE? T)
		     "AUX" (F <FIRST? .OBJ>) (1ST? T))
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN <NOT .1ST?>>)
		       (<SOAK-OBJ? .F>
			<SET 1ST? <>>)
		       (<AND <NOT .RECURSE?>
			     <EQUAL? .F ,PLAYER>>
			T)
		       (<AND <FSET? .F ,CONTBIT>
			     <FSET? .F ,OPENBIT>
			     <FIRST? .F>>
			<COND (<SOAK-STUFF .F>
			       <SET 1ST? <>>)>)>
		 <SET F <NEXT? .F>>>>

;<ROUTINE SOAK-OBJ? (F)
	 <COND (<FSET? .F ,RMUNGBIT> <RFALSE>)>>

<ROUTINE HACK-HACK (STR)
	 <TELL .STR " " THE ,PRSO " has no effect." CR>>

<ROUTINE TELL-YUKS ()
	 <TELL <PICK-ONE ,YUKS> CR>>

<CONSTANT YUKS
	  <LTABLE 0
		  "Not likely!"
		  "That would never work!"
		  "You can't be serious."
		  "You won't get a passing grade for that idea!">>

<ROUTINE PRE-PRY ()
	 <COND (<AND ,PRSI
		     <NOT <INTRINSIC? ,PRSI>>
		     <NOT <HELD? ,PRSI>>
		     <NOT <IN? ,WINNER ,PRSI>>
		     <NOT <FSET? ,PRSI ,VEHBIT>>>
		<NOT-HOLDING ,PRSI>)>>

<ROUTINE V-PRY ()
	 <V-TURN>>

<ROUTINE V-BURY ()
	 <TELL
"You can never tell what will happen to something you bury." CR>>

<ROUTINE V-YES ()
	 <TELL "That was a rhetorical question." CR>>

<ROUTINE V-NO ()
	 <V-YES>>

<ROUTINE V-BUY ()
	 <UNINTERESTED ,PRSI>>

<ROUTINE PRE-SSELL ()
	 <SWAP-VERB ,V?SELL>
	 <RTRUE>>

<ROUTINE V-SSELL () <RTRUE>>

<ROUTINE V-SELL ()
	 <UNINTERESTED ,PRSI>>

<ROUTINE PRE-TELL-ABOUT ()
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?TELL-ME-ABOUT ,PRSI>
		<RTRUE>)>>

<ROUTINE V-TELL-ABOUT ()
	 <COND (<HELD? ,PRSI>
		<SWAP-VERB ,V?SHOW>
		<RTRUE>)
	       (<ACCESSIBLE? ,PRSI>
		<NEW-VERB ,V?ASK-ABOUT>
		<RTRUE>)
	       (ELSE
		<UNINTERESTED ,PRSO>)>>

<ROUTINE V-TELL-ME-ABOUT ()
	 <COND (<WINNER? ,PLAYER>
		<MENTAL-COLLAPSE>)
	       (ELSE
		<UNINTERESTED ,WINNER>)>>

<ROUTINE V-TRADE ()
	 <COND (<AND ,PRSI <FSET? ,PRSI ,PERSON>>
		<UNINTERESTED ,PRSI>)
	       (<AND <WINNER? ,PLAYER>
		     ,PRSI
		     <NOT <FSET? ,PRSO ,PERSON>>>
		<COND (<IN? ,HACKER ,HERE>
		       <SETG WINNER ,HACKER>
		       <NEW-VERB ,PRSA>
		       <SETG WINNER ,PLAYER>
		       <RTRUE>)
		      (ELSE
		       <TELL
"No one here is interested in trading." CR>)>)
	       (ELSE
		<V-BARGAIN>)>>

<ROUTINE V-ERASE ()
	 <TELL-YUKS>>

<ROUTINE V-ADMIRE ()
	 <TELL "Your taste is unusual." CR>>

<ROUTINE V-BARGAIN ()
	 <TELL "What are you, an M.B.A. student?" CR>>

<ROUTINE V-REPAIR ()
	 <COND (<FSET? ,PRSO ,RMUNGBIT>
		<TELL "You don't know how." CR>)
	       (ELSE
		<TELL CTHE ,PRSO " isn't broken." CR>)>>

<ROUTINE V-LOOK-UP ()
	 <COND (<PRSO? ,ROOMS>
		<TELL "Don't get a sore neck." CR>)
	       (ELSE
		<NEW-VERB ,V?WHAT>
		<RTRUE>)>>

<ROUTINE V-PLUG-IN ()
	 <YOU-CANT-X-THAT "plug in">>

<ROUTINE V-UNPLUG ()
	 <YOU-CANT-X-THAT "unplug">>

<ROUTINE V-EDIT ()
	 <YOU-CANT-X-THAT "edit">>

<ROUTINE V-CLICK ()
	 <TELL ,NOTHING-HAPPENS>>

<ROUTINE V-WALK-UNDER ()
	 <TELL "Only a snake could get under " A ,PRSO "!" CR>>

<ROUTINE V-SCARE ()
	 <TELL "I don't think you scared " THE ,PRSO " very much." CR>>

<ROUTINE V-TYPE ()
	 <COND (<CANT-USE-COMPUTER?> <RTRUE>)
	       (<NOT ,USERNAME?>
		<NEW-VERB ,V?LOGIN>
		<RTRUE>)
	       (<NOT ,LOGGED-IN?>
		<NEW-VERB ,V?PASSWORD>
		<RTRUE>)
	       (ELSE
		<TELL "Nothing interesting happens, ">
		<COND (<FSET? ,PC ,POWERBIT>
		       <TELL
"except that a yellow smiling face appears
in a small box next to the legend \"Sorry, Syntax Error. Hope you have a
nice day anyway.\"" CR>)
		      (ELSE
		       <TELL
"as the computer is powered off." CR>)>)>>

<ROUTINE V-WEDGE ()
	 <TELL ,YOU-CANT "wedge open " A ,PRSO " with " A ,PRSI ,PERIOD>>

<ROUTINE PRE-SWEDGE ()
	 <SWAP-VERB ,V?WEDGE>
	 <RTRUE>>

<ROUTINE V-SWEDGE ()
	 <RTRUE>>

<ROUTINE V-PUT-BETWEEN ()
	 <TELL ,YOU-CANT "put " A ,PRSO " between " A ,PRSI ,PERIOD>>

<ROUTINE V-TASTE ()
	 <TELL "It tastes exactly as you'd expect " A ,PRSO " to taste,
only worse." CR>>

<ROUTINE V-DIE ()
	 <PERFORM ,V?KILL ,ME>
	 <RTRUE>>

<ROUTINE V-HACK ()
	 <TELL
"Your use of such jargon is unconvincing." CR>>

<ROUTINE V-COOK ()
	 <TELL
"Most people cook things in ovens." CR>>

<ROUTINE V-DRIVE-ON ()
	 <COND (<FSET? ,PRSI ,PERSON>
		<TELL CTHE ,PRSI " moves out of the way." CR>)
	       (ELSE
		<TELL ,GOOD-TRICK>)>>

<ROUTINE V-DRIVE-TO ()
	 <COND (<AND <IN? ,WINNER ,PRSO>
		     <PRSI? INTDIR>>
		<DO-WALK ,P-DIRECTION>)
	       (ELSE
		<TELL ,GOOD-TRICK>)>>

<ROUTINE V-STEP-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<NEW-VERB ,V?BOARD>
		<RTRUE>)
	       (ELSE
		<TELL ,WASTE-OF-TIME>)>>

<ROUTINE V-STOP ()
	 <TELL ,NOTHING-HAPPENS>>

<ROUTINE V-RELEASE ()
	 <NEW-VERB ,V?DROP>
	 <RTRUE>>

<ROUTINE V-PUSH-DOWN ()
	 <COND (<AND <PRSO? ,ROOMS>
		     <GLOBAL-IN? ,DOWN-BUTTON ,HERE>>
		<PERFORM ,V?PUSH ,DOWN-BUTTON>
		<RTRUE>)
	       (ELSE
		<NO-BUTTON ,DOWN-BUTTON>)>>

<ROUTINE NO-BUTTON (OBJ)
	 <TELL "There's no " D .OBJ " here." CR>>

<ROUTINE V-PUSH-UP ()
	 <COND (<AND <PRSO? ,ROOMS>
		     <GLOBAL-IN? ,UP-BUTTON ,HERE>>
		<PERFORM ,V?PUSH ,UP-BUTTON>
		<RTRUE>)
	       (ELSE
		<NO-BUTTON ,UP-BUTTON>)>>

<ROUTINE V-PRAY ()
	 <TELL "You get an empty feeling." CR>>

<ROUTINE PRE-SPUT-ON ()
	 <SWAP-VERB ,V?PUT-ON>
	 <RTRUE>>

<ROUTINE V-SPUT-ON ()
	 <RTRUE>>
