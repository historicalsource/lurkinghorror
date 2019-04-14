"MISC for
			    The Lurking Horror
	(c) Copyright 1986 Infocom, Inc. All Rights Reserved."

<DEFINE DEBUG-CODE ('X "OPTIONAL" ('Y T))
	<COND (,ZDEBUGGING? .X)(ELSE .Y)>>

;"tell macro and friends"

<TELL-TOKENS (CRLF CR)		<CRLF>
	     (NUM N) *		<PRINTN .X>
	     (CHAR CHR C) *	<PRINTC .X>
	     S *:STRING		<PRINT .X>
	     D ,PRSO		<DPRINT-PRSO>
	     D ,PRSI		<DPRINT-PRSI>	
	     D *		<DPRINT .X>
	     CD ,PRSO		<CDPRINT-PRSO>
	     CD ,PRSI		<CDPRINT-PRSI>
	     CD *		<CDPRINT .X>
	     THE ,PRSO		<THE-PRINT-PRSO>
	     THE ,PRSI		<THE-PRINT-PRSI>
	     THE *		<THE-PRINT .X>
	     CTHE ,PRSO		<CTHE-PRINT-PRSO>
	     CTHE ,PRSI		<CTHE-PRINT-PRSI>
	     CTHE *		<CTHE-PRINT .X>
	     (A AN) ,PRSO	<PRINTA-PRSO>
	     (A AN) ,PRSI	<PRINTA-PRSI>
	     (A AN) *		<PRINTA .X>>

<ROUTINE CTHE-PRINT-PRSO ()
	 <THE-PRINT ,PRSO T>>

<ROUTINE CTHE-PRINT-PRSI ()
	 <THE-PRINT ,PRSI T>>

<ROUTINE CTHE-PRINT (O)
	 <THE-PRINT .O T>>

<ROUTINE THE-PRINT-PRSO ()
	 <THE-PRINT ,PRSO>>

<ROUTINE THE-PRINT-PRSI ()
	 <THE-PRINT ,PRSI>>

<ROUTINE THE-PRINT (O "OPTIONAL" (CAP? <>))
	 <DPRINT .O .CAP? <NOT <FSET? .O ,NOTHEBIT>>>>

<ROUTINE PRINTA-PRSO ()
	 <PRINTA ,PRSO>>

<ROUTINE PRINTA-PRSI ()
	 <PRINTA ,PRSI>>

<ROUTINE PRINTA (O)
	 <COND (<FSET? .O ,THE> <PRINTI "the ">)
	       (<NOT <FSET? .O ,NOABIT>>
		<COND (<FSET? .O ,AN> <PRINTI "an ">)
		      (ELSE <PRINTI "a ">)>)>
	 <IPRINT .O>>

;<ROUTINE CDPRINT-PRSO ()
	 <DPRINT ,PRSO T>>

;<ROUTINE CDPRINT-PRSI ()
	 <DPRINT ,PRSI T>>

;<ROUTINE CDPRINT (O)
	 <DPRINT .O T>>

<ROUTINE DPRINT (O "OPTIONAL" (CAP? <>) (THE? <>) "AUX" S)
	 <COND (<OR .THE? <FSET? .O ,THE>>
		<COND (.CAP? <PRINTI "The ">)
		      (T <PRINTI "the ">)>)>
	 <IPRINT .O>>

<ROUTINE IPRINT (O)
	 <COND (<AND <EQUAL? .O ,PSEUDO-OBJECT>
		     <NOT ,P-MERGED>
		     <EQUAL? .O ,PRSO ,PRSI>>
		<THING-PRINT ,PSEUDO-PRSO ;"<EQUAL? .O ,PRSO>">)
	       (<EQUAL? .O ,INTNAME>
		<PRINTB ,P-NAME>)
	       (ELSE
		<PRINTD .O>)>>

<COND (<GASSIGNED? ZILCH>
<DEFINE PE (F I)
	<COND (<TYPE? .I LIST>
	       <FORM .F !.I>)
	      (ELSE
	       <FORM .F .I>)>>

<DEFMAC P? ('V "OPT" ('O '*) ('I '*) ('W '*) "AUX" (L ()))
	<COND (<N==? .I '*>
	       <SET L (<PE PRSI? .I> !.L)>)>
	<COND (<N==? .O '*>
	       <SET L (<PE PRSO? .O> !.L)>)>
	<COND (<N==? .V '*>
	       <SET L (<PE VERB? .V> !.L)>)>
	<COND (<N==? .W '*>
	       <SET L (<PE WINNER? .W> !.L)>)>
	<COND (<EMPTY? <REST .L>>
	       <1 .L>)
	      (ELSE <FORM AND !.L>)>>

<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB ',PRSA .ATMS>>

<DEFMAC CONTEXT? ("ARGS" ATMS)
	<MULTIFROB '.RARG .ATMS>>

<SETG RARG? ,CONTEXT?>

<DEFMAC WINNER? ("ARGS" ATMS)
	<MULTIFROB ',WINNER .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB ',PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB ',PRSI .ATMS>>

<DEFMAC HERE? ("ARGS" ATMS)
	<MULTIFROB ',HERE .ATMS>>

<SETG ROOM? ,HERE?>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM SP) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REST
		 <PUTREST
		  .O
		  <SET O
		       (<REPEAT
			 ((LL <FORM EQUAL? .X>)
			  (L <REST .LL>))
			 <COND (<OR <EMPTY? .ATMS>
				    <==? <LENGTH <REST .LL 2>> 3>>
				<RETURN!- .LL>)>
			 <SET ATM <NTH .ATMS 1>>
			 <PUTREST
			  .L
			  <SET L
			       (<COND
				 (<TYPE? .ATM ATOM>
				  <SET SP <SPNAME .ATM>>
				  <MAKE-GVAL
				   <COND (<==? .X ',PRSA>
					  <PARSE <STRING "V?" .SP>>)
					 (<==? .X '.RARG>
					  <COND (<AND <G? <LENGTH .SP> 2>
						      <==? <1 .SP> !\M>
						      <==? <2 .SP> !\->>
						 .ATM)
						(ELSE
						 <PARSE
						  <STRING "M-" .SP>>)>)
					 (ELSE .ATM)>>)
				 (ELSE .ATM)>)>>
			 <SET ATMS <REST .ATMS>>>)>>>>>)
(ELSE
 <DEFINE P? (V "OPT" (O '*) (I '*) (W '*) "AUX" (L <>))
	 <AND <OR <==? .W '*> <WINNER? .W>>
	      <OR <==? .V '*> <VERB? .V>>
	      <OR <==? .O '*> <PRSO? .O>>
	      <OR <==? .I '*> <PRSI? .I>>>>

 <DEFINE VERB? ("TUPLE" ATMS)
	 <MAPF <>
	       <FUNCTION (A "AUX" ATM)
		    <COND (<TYPE? .A ATOM>
			   <COND (<SET ATM
				       <LOOKUP <STRING "V?" <SPNAME .A>>
					       <MOBLIST INITIAL>>>
				  <COND (<EQUAL? ,PRSA ,.ATM>
					 <MAPLEAVE T>)>)
				 (ELSE
				  <ERROR NOT-A-VERB? .A>)>)
			  (<EQUAL? ,PRSA .A>
			   <MAPLEAVE T>)>>
	       .ATMS>>
 <DEFINE CONTEXT? ("TUPLE" ATMS)
 	 <MAPF <>
	       <FUNCTION (A "AUX" ATM)
		    <COND (<TYPE? .A ATOM>
			   <COND (<AND <G? <LENGTH <SET ATM <SPNAME .A>>> 2>
				       <==? <1 .ATM> !\M>
				       <==? <2 .ATM> !\->>
				  <COND (<EQUAL? .RARG ,.ATM>
					 <MAPLEAVE T>)>)
				 (<SET ATM
				       <LOOKUP <STRING "M-" <SPNAME .A>>
					       <MOBLIST INITIAL>>>
				  <COND (<EQUAL? .RARG ,.ATM>
					 <MAPLEAVE T>)>)
				 (ELSE
				  <ERROR NOT-A-CONTEXT? .A>)>)
			  (<EQUAL? .RARG .A>
			   <MAPLEAVE T>)>>
	       .ATMS>>
 <SETG RARG? ,CONTEXT?>
 <DEFINE WINNER? ("TUPLE" ATMS)
	 <MULTIFROB ,WINNER .ATMS>>
 <DEFINE PRSO? ("TUPLE" ATMS)
	 <MULTIFROB ,PRSO .ATMS>>
 <DEFINE PRSI? ("TUPLE" ATMS)
	 <MULTIFROB ,PRSI .ATMS>>
 <DEFINE HERE? ("TUPLE" ATMS)
	 <MULTIFROB HERE .ATMS>>
 <SETG ROOM? ,HERE?>
 <DEFINE MULTIFROB (X ATMS) 
	 <MAPF <>
	       <FUNCTION (A)
		    <COND (<TYPE? .A ATOM> <SET A ,.A>)>
		    <COND (<EQUAL? .X .A>
			   <MAPLEAVE T>)>>
	       .ATMS>>)>

<COND (<GASSIGNED? ZILCH>
<DEFMAC BSET ('OBJ "ARGS" BITS)
	<MULTIBITS FSET .OBJ .BITS>>

<DEFMAC BCLEAR ('OBJ "ARGS" BITS)
	<MULTIBITS FCLEAR .OBJ .BITS>>

<DEFMAC BSET? ('OBJ "ARGS" BITS)
	<MULTIBITS FSET? .OBJ .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS
		   "AUX" (OT <COND (<==? .X FSET?> <FORM OR>)
				   (ELSE <FORM PROG ()>)>)
		         (OO <COND (<LENGTH? .OT 1> .OT)
				   (ELSE <REST .OT>)>)
			 (O .OO)
			 ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- .OT>)>
		<SET ATM <NTH .ATMS 1>>
		<SET ATMS <REST .ATMS>>
		<PUTREST .O
			 <SET O
			      (<FORM .X
				     .OBJ
				     <COND (<TYPE? .ATM FORM> .ATM)
					   (ELSE <MAKE-GVAL .ATM>)>>)>>>>)
(ELSE
<DEFINE BSET (OBJ "TUPLE" BITS)
	<MULTIBITS ,FSET .OBJ .BITS>>

<DEFINE BCLEAR (OBJ "TUPLE" BITS)
	<MULTIBITS ,FCLEAR .OBJ .BITS>>

<DEFINE BSET? (OBJ "TUPLE" BITS)
	<MAPF <>
	      <FUNCTION (A)
		   <COND (<FSET? .OBJ ,.A> <MAPLEAVE T>)>>
	      .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS) 
	<MAPF <>
	      <FUNCTION (A)
		   <APPLY!- .X .OBJ ,.A>>
	      .ATMS>>)>

<DEFMAC RFATAL ()
	'<RETURN ,M-FATAL>>

<COND (<GASSIGNED? ZILCH>
       <DEFMAC PROB ('BASE?)
	       <FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>)
      (ELSE
       <DEFINE PROB (BASE?)
	       <NOT <L? .BASE? <RANDOM 100>>>>)>

<ROUTINE PICK-ONE (FROB
		   "AUX" (L <GET .FROB 0>) (CNT <GET .FROB 1>) RND MSG RFROB)
	 <SET L <- .L 1>>
	 <SET FROB <REST .FROB 2>>
	 <SET RFROB <REST .FROB <* .CNT 2>>>
	 <SET RND <RANDOM <- .L .CNT>>>
	 <SET MSG <GET .RFROB .RND>>
	 <PUT .RFROB .RND <GET .RFROB 1>>
	 <PUT .RFROB 1 .MSG>
	 <SET CNT <+ .CNT 1>>
	 <COND (<==? .CNT .L> <SET CNT 0>)>
	 <PUT .FROB 0 .CNT>
	 .MSG>

<ROUTINE RANDOM-ELEMENT (FROB)
	 <GET .FROB <RANDOM <GET .FROB 0>>>>



;"former MAIN.ZIL stuff"

<GLOBAL P-WON <>>

<CONSTANT M-FATAL 2>

<CONSTANT M-BEG 1>
<CONSTANT M-END 2>
<CONSTANT M-ENTER 3>
<CONSTANT M-LEAVE 4>
<CONSTANT M-LOOK 5>
<CONSTANT M-FLASH 6>
<CONSTANT M-OBJDESC 7>
<CONSTANT M-CONTAINER 8>

<ROUTINE GO () 
	 <PUT-GLOBAL ,TOMB 0 0>
	 <PUT-GLOBAL ,TOMB 1 0>
	 ;"put interrupts on clock chain"
	 <SETG CLOCK-HAND <REST ,C-TABLE ,C-TABLELEN>>
	 <QUEUE I-URCHIN 10>
	 <QUEUE I-TIRED 200>
	 ;"set up and go"
	 <SETG P-HIM-OBJECT ,HACKER>
	 <SETG P-IT-OBJECT ,PC>
	 <SETG WINNER ,PLAYER>
	 <SETG HERE ,TERMINAL-ROOM>
	 <SETG LIT <LIT? ,HERE>>
	 <USL>
	 <TELL
"You've waited until the last minute again. This time it's the end of
the term, so all the TechNet terminals in the dorm are occupied.
So, off you go to the old Comp Center. Too bad it's the worst storm of
the winter (Murphy's Law, right?), and you practically froze to death
slogging over here from the dorm. Not to mention jumping at every
shadow, what with all the recent disappearances. Time to find a free
machine, get to work, and write that twenty page paper." CR CR>
	 <V-VERSION>
	 <CRLF>
	 <V-LOOK>
	 <MAIN-LOOP>>    

<ROUTINE MAIN-LOOP ("AUX" TRASH)
	 <REPEAT ()
		 <SET TRASH <MAIN-LOOP-1>>>>

<GLOBAL WAS-IT? <>>
<GLOBAL WAS-HIM? <>>

<GLOBAL PERFORM-DEPTH 0> ;"number recursive calls to perform"

<ROUTINE MAIN-LOOP-1 ("AUX" ICNT OCNT NUM (CNT 0) (OBJ <>) TBL
		      (V <>) (PTBL T) OBJ1 TMP ONUM)
     <COND (<SETG P-WON <PARSER>>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	    <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	    <SETG WAS-IT? <OBJECT-SUBSTITUTE ,IT ,P-IT-OBJECT>>
	    <SETG WAS-HIM? <OBJECT-SUBSTITUTE ,HIM ,P-HIM-OBJECT>>
	    <SET ONUM <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
	    <SET NUM
		 <COND (<OR <ZERO? .OCNT>
			    <AND <ZERO? .ICNT>
				 <EQUAL? .ONUM 2>>>
			0)
		       (<G? .OCNT 1>
			<SET TBL ,P-PRSO>
			<COND (<ZERO? .ICNT> <SET OBJ <>>)
			      (T <SET OBJ <GET ,P-PRSI 1>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET PTBL <>>
			<SET TBL ,P-PRSI>
			<SET OBJ <GET ,P-PRSO 1>>
			.ICNT)
		       (T 1)>>
	    <COND (<AND <NOT .OBJ> <1? .ICNT>>
		   <SET OBJ <GET ,P-PRSI 1>>)>
	    <SETG PERFORM-DEPTH 0>
	    <COND (<EQUAL? ,PRSA ,V?WALK> <SET V <PERFORM-PRSA ,PRSO>>)
		  (<ZERO? .NUM>
		   <COND (<ZERO? .ONUM>
			  <SET V <PERFORM-PRSA>>
			  <SETG PRSO <>>)
			 (<NOT ,LIT>
			  <TELL ,TOO-DARK>
			  <END-QUOTE>)
			 (T
			  <TELL "There isn't anything to ">
			  <SET TMP <GET ,P-ITBL ,P-VERBN>>
			  <COND (<VERB? TELL>
				 <TELL "talk to">)
				(<OR ,P-OFLAG ,P-MERGED>
				 <PRINTB <GET .TMP 0>>)
				(T
				 <WORD-PRINT <GETB .TMP 2>
					     <GETB .TMP 3>>)>
			  <TELL "!" CR>
			  <SET V <>>
			  <END-QUOTE>)>)
		  (T
		   <SETG P-NOT-HERE 0>
		   <SETG P-MULT <>>
		   <COND (<G? .NUM 1> <SETG P-MULT 1>)>
		   <SET TMP <>>
		   <SET CNT 0>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
				  <COND (<G? ,P-NOT-HERE 0>
					 <TELL "The ">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE .NUM>>
						<TELL "other ">)>
					 <TELL "object">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
						<TELL "s">)>
					 <TELL " that you mentioned ">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
						<TELL "are">)
					       (T <TELL "is">)>
					 <TELL "n't here." CR>)
					(<NOT .TMP>
					 <TELL ,REFERRING CR>)>
				  <RETURN>)

(T ;"REFORMATTED AREA"
 <COND (.PTBL <SET OBJ1 <GET ,P-PRSO .CNT>>)
       (T <SET OBJ1 <GET ,P-PRSI .CNT>>)>
 <SETG PRSO <COND (.PTBL .OBJ1) (T .OBJ)>>
 <SETG PRSI <COND (.PTBL .OBJ) (T .OBJ1)>>
 <COND (<OR <G? .NUM 1>
	    <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0> ,W?ALL>>
	<COND (<MULTIPLE-EXCEPTION? .OBJ1> <AGAIN>)
	      (<VERB? COMPARE-MANY>)
	      (T
	       <COND (<EQUAL? .OBJ1 ,IT>
		      <TELL D ,P-IT-OBJECT>)
		     (ELSE
		      <TELL D .OBJ1>)>
	       <TELL ": ">)>)>
 <SET TMP T>
 <SETG PSEUDO-PRSO <COND (<PRSO? ,PSEUDO-OBJECT>)>>
 <SET V <PERFORM-PRSA ,PRSO ,PRSI>>
 <COND (<EQUAL? .V ,M-FATAL> <RETURN>)>
 <COND (,P-MULT <SETG P-MULT <+ ,P-MULT 1>>)>) ;"END REFORMATTING"

				 >>)>
	    <COND (<NOT <EQUAL? .V ,M-FATAL>>
		   <COND (<GAME-VERB?> T)
			 (<LOC ,WINNER>
			  <SET V
			       %<DEBUG-CODE
				 <D-APPLY "End"
					  <GETP <LOC ,WINNER> ,P?ACTION>
					  ,M-END>
				 <APPLY <GETP <LOC ,WINNER> ,P?ACTION>
					,M-END>>>)>)>
	    <COND (<EQUAL? .V ,M-FATAL>
		   <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     <COND (,P-WON
	    %<DEBUG-CODE
	      <COND (<VERB? $DEBUG>
		     <AGAIN>)>>
	    <COND (<GAME-VERB?> T)
		  (T
		   <SET V <CLOCKER>>)>
	    <SETG PRSA <>>
	    <SETG PRSO <>>
	    <SETG PRSI <>>)>>

<ROUTINE OBJECT-SUBSTITUTE (OBJ VAR "AUX" (TMP <>) (CNT 0) ICNT OCNT)
	 <COND (<AND .VAR <ACCESSIBLE? .VAR>>
		<SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
		<SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
		<REPEAT ()
			<COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
			       <RETURN>)
			      (T
			       <COND (<EQUAL? <GET ,P-PRSI .CNT> .OBJ>
				      <PUT ,P-PRSI .CNT .VAR>
				      <SET TMP T>
				      <RETURN>)>)>>
		<SET CNT 0>
		<REPEAT ()
			<COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
			       <RETURN>)
			      (T
			       <COND (<EQUAL? <GET ,P-PRSO .CNT> .OBJ>
				      <PUT ,P-PRSO .CNT .VAR>
				      <SET TMP T>
				      <RETURN>)>)>>
		.TMP)>>

<GLOBAL PSEUDO-PRSO <>> ;"T IF ORIGINAL PRSO WAS PSEUDO-OBJECT"

<ROUTINE GAME-VERB? ()
	 <COND (<AND <VERB? TELL> ,P-CONT> <RTRUE>)
	       (<AND <VERB? HELP>
		     <NOT ,PRSO>
		     <NOT <IN? ,PC ,HERE>>>
		<RTRUE>)
	       (<VERB? QUIT VERSION BRIEF SUPER-BRIEF VERBOSE
		       $VERIFY RESTART SAVE RESTORE SCRIPT UNSCRIPT
		       $RANDOM $COMMAND $RECORD $UNRECORD SCORE
		       TIME>
		<RTRUE>)>>

"MULTIPLE-EXCEPTION? -- return true if an object found by all should not
be included when the crunch comes."

<ROUTINE MULTIPLE-EXCEPTION? (OBJ1 "AUX" (L <LOC .OBJ1>))
	 <COND (<EQUAL? .OBJ1 ,NOT-HERE-OBJECT>
		<SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     ,PRSI
		     <NOT <IN? ,PRSO ,PRSI>>>
		;"TAKE X FROM Y and x not in y"
		<RTRUE>)
	       (<NOT <ACCESSIBLE? .OBJ1>>
		;"can't get at object"
		<RTRUE>)
	       (<EQUAL? ,P-GETFLAGS ,P-ALL>
		;"cases for ALL"
		<COND (<AND ,PRSI
			    <PRSO? ,PRSI>>
		       ;"VERB ALL and prso = prsi"
		       <RTRUE>)
		      (<AND <VERB? TAKE> <NOT ,PRSI>>
		       <COND (<OR <AND <NOT <EQUAL? .L ,WINNER ,HERE ,PRSI>>
				       <NOT <EQUAL? .L <LOC ,WINNER>>>
				       <NOT <FSET? .L ,SURFACEBIT>>
				       <NOT <FSET? .L ,SEARCHBIT>>>
				  <AND <NOT <FSET? .OBJ1 ,TAKEBIT>>
				       <NOT <FSET? .OBJ1 ,TRYTAKEBIT>>>>
			      ;"TAKE ALL and object not accessible or takeable"
			      <RTRUE>)
			     (<OR <FSET? .L ,PERSON>
				  <FSET? <LOC .L> ,PERSON>>
			      ;"TAKE ALL held by a person (use TAKE ALL FROM)"
			      <RTRUE>)
			     (<HELD? ,PRSO>
			      ;"TAKE ALL and one object has others in it"
			      <RTRUE>)
			     (<AND <PRSO? DOME-LADDER>
				   <OR ,LADDER-TOP? ,LADDER-BOTTOM?>>
			      ;"TAKE ALL and ladder set up"
			      <RTRUE>)
			     (<AND <PRSO? CHAIN CHAIN-1 CHAIN-2>
				   <OR ,CHAIN-HOOKED? ,CHAIN-LOOPED?>
				   <NOT <EQUAL? .L
						,ELEVATOR-PIT ,CS-BASEMENT>>>
			      ;"TAKE ALL and chain looped or hooked"
			      <RTRUE>)
			     (<AND <PRSO? PADLOCK>
				   ,PADLOCK-ON?>
			      ;"TAKE ALL and padlock locked"
			      <RTRUE>)>)
		      (<VERB? DROP GIVE>
		       <COND (<NOT <IN? .OBJ1 ,WINNER>>
			      ;"GIVE/DROP ALL and object not held"
			      <RTRUE>)
			     (<FSET? .OBJ1 ,WEARBIT>
			      ;"GIVE/DROP ALL and object worn"
			      <RTRUE>)>)
		      (<AND <VERB? PUT>
			    <NOT <IN? ,PRSO ,WINNER>>
			    <HELD? ,PRSO ,PRSI>>
		       ;"PUT ALL IN X and object already in x"
		       <RTRUE>)>)>>

;<ROUTINE SAVE-INPUT (TBL "AUX" (OFFS 0) CNT TMP)
	 <SET CNT <+ <GETB ,P-LEXV <SET TMP <* 4 ,P-INPUT-WORDS>>>
		     <GETB ,P-LEXV <+ .TMP 1>>>>
	 <COND (<EQUAL? .CNT 0> ;"failed"
		<RFALSE>)>
	 <SET CNT <- .CNT 1>>
	 <REPEAT ()
		 <COND (<EQUAL? .OFFS .CNT>
			<PUTB .TBL .OFFS 0>
			<RETURN>)
		       (T
			<PUTB .TBL .OFFS <GETB ,P-INBUF <+ .OFFS 1>>>)>
		 <SET OFFS <+ .OFFS 1>>>
	 <RTRUE>>

;<ROUTINE RESTORE-INPUT (TBL "AUX" CHR)
	 <REPEAT ()
		 <COND (<EQUAL? <SET CHR <GETB .TBL 0>> 0>
			<RETURN>)
		       (T
			<PRINTC .CHR>
			<SET TBL <REST .TBL>>)>>>

<GLOBAL P-MULT <>>

<GLOBAL P-NOT-HERE 0>


<GLOBAL WHAT-DO-YOU-WANT-TO "What do you want to ">

<ROUTINE FAKE-ORPHAN ("AUX" TMP)
	 <ORPHAN ,P-SYNTAX <>>
	 <TELL ,WHAT-DO-YOU-WANT-TO>
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <COND (<EQUAL? .TMP 0>
		<TELL "tell">)
	       (<ZERO? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		<PUTB ,P-VTBL 2 0>)>
	 <SETG P-OFLAG T>
	 <SETG P-WON <>>
	 <PREP-PRINT
	     <GETB ,P-SYNTAX ,P-SPREP1>>
	 <TELL "?" CR>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" (V <>) OA OO OI CNT)
	 <SETG PERFORM-DEPTH <+ ,PERFORM-DEPTH 1>>
	 %<DEBUG-CODE
	   <COND (,ZDEBUG
		  <TELL "[Perform: ">
		  %<COND (<GASSIGNED? ZILCH> '<TELL N .A>)
			 (T '<PRINT <SPNAME <NTH ,ACTIONS <+ <* .A 2> 1>>>>)>
		  <COND (.O
			 <COND (<AND <EQUAL? .A ,V?WALK>
				     ,P-WALK-DIR>
				<TELL "/" N .O>)
			       (ELSE
				<TELL "/" D .O>)>)>
		  <COND (.I <TELL "/" D .I>)>
		  <TELL "]" CR>)>>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<SETG PRSA .A>
	<COND (<EQUAL? ,IT .I .O>
	       <COND (<NOT .I>
		      <FAKE-ORPHAN>)
		     (T
		      <TELL ,REFERRING CR>)>
	       <RFATAL>)>
	<COND (<AND .I
		    <NOT <VERB? WALK>>
		    <NOT <EQUAL? .I ,NOT-HERE-OBJECT>>>
	       <THIS-IS-IT .I>)>
	<COND (<AND .O
		    <NOT <VERB? WALK>>
		    <NOT <EQUAL? .O ,NOT-HERE-OBJECT>>>
	       <THIS-IS-IT .O>)>
	<SETG PRSO .O>
	<SETG PRSI .I>
	<COND (<AND <NOT <EQUAL? .A ,V?WALK>>
		    <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V
			 %<DEBUG-CODE
			   <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>
			   <APPLY ,NOT-HERE-OBJECT-F>>>>
	       ;<SETG P-WON <>>)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <COND (<AND <NOT <VERB? TELL-ABOUT SGIVE SSHOW SRUB SPUT-ON>>
			   <SET V
				%<DEBUG-CODE
				  <DD-APPLY "Actor" ,WINNER
					    <GETP ,WINNER ,P?ACTION>>
				  <APPLY <GETP ,WINNER ,P?ACTION>>>>>)
		     (<AND <LOC ,WINNER>
			   <NOT <EQUAL? <LOC ,WINNER> ,HERE>>
			   <SET V
				%<DEBUG-CODE
				  <D-APPLY "Begin"
					   <GETP <LOC ,WINNER> ,P?ACTION>
					   ,M-BEG>
				  <APPLY <GETP <LOC ,WINNER> ,P?ACTION>
					 ,M-BEG>>>>)
		     (<SET V
			   %<DEBUG-CODE
			     <D-APPLY "Begin"
				      <GETP ,HERE ,P?ACTION>
				      ,M-BEG>
			     <APPLY <GETP ,HERE ,P?ACTION>
				    ,M-BEG>>>)
		     (<SET V
			   %<DEBUG-CODE
			     <D-APPLY "Preaction"
				      <GET ,PREACTIONS .A>>
			     <APPLY <GET ,PREACTIONS .A>>>>)
		     (<AND .I
			   <SET V
				%<DEBUG-CODE
				  <D-APPLY "PRSI" <GETP .I ,P?ACTION>>
				  <APPLY <GETP .I ,P?ACTION>>>>>)
		     (<AND .O
			   <NOT <EQUAL? .A ,V?WALK>>
			   <LOC .O>
			   <GETP <LOC .O> ,P?CONTFCN>
			   <SET V
				%<DEBUG-CODE
				  <D-APPLY "Container"
					   <GETP <LOC .O> ,P?CONTFCN>
					   ,M-CONTAINER>
				  <APPLY <GETP <LOC .O> ,P?CONTFCN>
					 ,M-CONTAINER>>>>)
		     (<AND .O
			   <NOT <EQUAL? .A ,V?WALK>>
			   <SET V
				%<DEBUG-CODE
				  <D-APPLY "PRSO"
					   <GETP .O ,P?ACTION>>
				  <APPLY <GETP .O ,P?ACTION>>>>>)
		     (<SET V
			   %<DEBUG-CODE
			     <D-APPLY <>
				      <GET ,ACTIONS .A>>
			     <APPLY <GET ,ACTIONS .A>>>>)>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

%<COND (,ZDEBUGGING?
	<COND (<GASSIGNED? ZILCH>
	       <ROUTINE II-APPLY (STR FCN)
			<COND (,ZDEBUG
			       <TELL "[I- " N <* .FCN 2> " ">)>
			<D-APPLY .STR .FCN>>)
	      (ELSE
	       <ROUTINE II-APPLY (STR FCN)
			<D-APPLY <COND (<TYPE? .FCN ATOM> <SPNAME .FCN>)
				       (ELSE .STR)>
				 .FCN>>)>)>

%<DEBUG-CODE
  <ROUTINE DD-APPLY (STR OBJ FCN)
	   <COND (,ZDEBUG <TELL "[" D .OBJ "=]">)>
	   <D-APPLY .STR .FCN>>>

%<DEBUG-CODE
  <ROUTINE D-APPLY (STR FCN "OPTIONAL" (FOO <>) "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       <COND (,ZDEBUG
		      <COND (<NOT .STR>
			     <TELL "[Action:]" CR>)
			    (T <TELL "[" .STR ": ">)>)>
	       <SET RES
		    <COND (.FOO <APPLY .FCN .FOO>)
			  (T <APPLY .FCN>)>>
	       %<DEBUG-CODE
		 <COND (<AND ,ZDEBUG .STR>
			<COND (<EQUAL? .RES ,M-FATAL>
			       <TELL "Fatal]" CR>)
			      (<NOT .RES>
			       <TELL "Not handled]" CR>)
			      (T <TELL "Handled]" CR>)>)>>
	       .RES)>>>

;"former CLOCK.ZIL stuff"

<GLOBAL CLOCK-WAIT <>>

<GLOBAL C-TABLE <ITABLE 13 <> <>>>

<CONSTANT C-INTLEN 4>	;"length of an interrupt entry in bytes"
<CONSTANT C-RTN 0>	;"word offset of routine name"
<CONSTANT C-TICK 1>	;"word offset of count"

<CONSTANT C-TABLELEN 52>	;"length of interrupt table in bytes"
<GLOBAL C-INTS 52>		;"start of queued interrupts in bytes"
%<DEBUG-CODE <GLOBAL C-MAXINTS 52>>

<ROUTINE DEQUEUE (RTN "AUX" TIM)
	 <COND (<SET RTN <QUEUED? .RTN>>
		<SET TIM <GET .RTN ,C-TICK>>
		<PUT .RTN ,C-RTN 0>
		.TIM)>>

<ROUTINE QUEUED? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E> <RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<ZERO? <GET .C ,C-TICK>>
			       <RFALSE>)
			      (T <RETURN .C>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

"this version of QUEUE automatically enables as well"

"QUEUE routine when fresh?:t means only queue if not currently queued"

<ROUTINE QUEUE (RTN TICK "OPT" (I? <>) "AUX" C E (INT <>))
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<COND (.INT
			       <SET C .INT>)
			      (ELSE
			       %<DEBUG-CODE
				 <COND (<L? ,C-INTS ,C-INTLEN>
					<TELL
					  "[**Too many interrupts!**]" CR>)>>
			       <SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			       %<DEBUG-CODE
				 <COND (<L? ,C-INTS ,C-MAXINTS>
					<SETG C-MAXINTS ,C-INTS>)>>
			       <SET INT <REST ,C-TABLE ,C-INTS>>)>
			<PUT .INT ,C-RTN .RTN>
			<RETURN>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (.I? <RFALSE>)
			      (ELSE
			       <SET INT .C>
			       <RETURN>)>)
		       (<ZERO? <GET .C ,C-RTN>>
			<SET INT .C>)>
		 <SET C <REST .C ,C-INTLEN>>>
	 <COND (%<COND (<GASSIGNED? ZILCH>
			'<G? .INT ,CLOCK-HAND>)
		       (ELSE
			'<L=? <LENGTH .INT> <LENGTH ,CLOCK-HAND>>)>
		<SET TICK <- <+ .TICK 3>>>)>
	 <PUT .INT ,C-TICK .TICK>
	 .INT>

<GLOBAL CLOCK-HAND <>>

<ROUTINE CLOCKER ("AUX" E TICK RTN (FLG <>) (Q? <>) OWINNER)
	 <COND (,CLOCK-WAIT <SETG CLOCK-WAIT <>> <RFALSE>)>
	 <SETG CLOCK-HAND <REST ,C-TABLE ,C-INTS>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET OWINNER ,WINNER>
	 <SETG WINNER ,PLAYER>
	 <REPEAT ()
		 <COND (<EQUAL? ,CLOCK-HAND .E>
			<SETG CLOCK-HAND .E>
			<SETG MOVES <+ ,MOVES 1>>
			<SETG WINNER .OWINNER>
			<RETURN .FLG>)
		       (<NOT <ZERO? <GET ,CLOCK-HAND ,C-RTN>>>
			<SET TICK <GET ,CLOCK-HAND ,C-TICK>>
			<COND (<L? .TICK -1>
			       <PUT ,CLOCK-HAND ,C-TICK <- <- .TICK> 3>>
			       <SET Q? ,CLOCK-HAND>)
			      (<NOT <ZERO? .TICK>>
			       <COND (<G? .TICK 0>
				      <SET TICK <- .TICK 1>>
				      <PUT ,CLOCK-HAND ,C-TICK .TICK>)>
			       <COND (<NOT <ZERO? .TICK>>
				      <SET Q? ,CLOCK-HAND>)>
			       <COND (<NOT <G? .TICK 0>>
				      <SET RTN
					   %<COND (<GASSIGNED? ZILCH>
						   '<GET ,CLOCK-HAND ,C-RTN>)
						  (ELSE
						   '<NTH ,CLOCK-HAND
							 <+ <* ,C-RTN 2>
							    1>>)>>
				      <COND (<ZERO? .TICK>
					     <PUT ,CLOCK-HAND ,C-RTN 0>)>
				      <COND (%<COND
					       (,ZDEBUGGING?
						'<II-APPLY "Int" .RTN>)
					       (ELSE
						'<APPLY .RTN>)>
					     <SET FLG T>)>
				      <COND (<AND <NOT .Q?>
						  <NOT
						   <ZERO?
						    <GET ,CLOCK-HAND
							 ,C-RTN>>>>
					     <SET Q? T>)>)>)>)>
		 <SETG CLOCK-HAND <REST ,CLOCK-HAND ,C-INTLEN>>
		 <COND (<NOT .Q?>
			<SETG C-INTS <+ ,C-INTS ,C-INTLEN>>)>>>

<DEFINE PSEUDO ("TUPLE" V)
	<MAPF ,PLTABLE
	      <FUNCTION (OBJ)
		   <COND (<N==? <LENGTH .OBJ> 3>
			  <ERROR BAD-THING .OBJ>)>
		   <MAPRET <COND (<NTH .OBJ 1>
				  <VOC <SPNAME <NTH .OBJ 1>> ADJECTIVE>)>
			   <COND (<NTH .OBJ 2>
				  <VOC <SPNAME <NTH .OBJ 2>> NOUN>)>
			   ;<3 .OBJ>>>
	      .V>>

<ROUTINE PERFORM-PRSA ("OPT" (O <>) (I <>))
	 <PERFORM ,PRSA .O .I>>

<ROUTINE NEW-VERB (V)
	 <PERFORM .V ,PRSO ,PRSI>>

<ROUTINE SWAP-VERB (V)
	 <PERFORM .V ,PRSI ,PRSO>>

<ROUTINE NEW-PRSO (O)
	 <PERFORM-PRSA .O ,PRSI>>

<ROUTINE NEW-PRSI (I)
	 <PERFORM-PRSA ,PRSO .I>>

<ROUTINE NEW-WINNER-PRSO (A "OPT" (O <>) (I <>) "AUX" OW)
	 <SET OW ,WINNER>
	 <SETG WINNER ,PRSO>
	 <PERFORM .A .O .I>
	 <SETG WINNER .OW>>

<ROUTINE REDIRECT (FROM TO "AUX" O I)
	 <SET O <COND (<PRSO? .FROM> .TO) (ELSE ,PRSO)>>
	 <SET I <COND (<PRSI? .FROM> .TO) (ELSE ,PRSI)>>
	 <PERFORM-PRSA .O .I>
	 <RTRUE>>
