"PARSER for
			   The Lurking Horror
	(c) Copyright 1986 Infocom, Inc. All Rights Reserved."

"Parser global variable convention: All parser globals will begin
with 'P-'. Local variables are not restricted in any way."

<SETG SIBREAKS ".,\"">

<GLOBAL WINNER <>>	;"agent of the action"
<GLOBAL PRSA <>>	;"the verb"
<GLOBAL PRSO <>>	;"the first object"
<GLOBAL PRSI <>>	;"the second object"

"useful globals"

<GLOBAL P-IT-OBJECT <>>

<GLOBAL P-HIM-OBJECT <>>

<GLOBAL LAST-PSEUDO-LOC <>>

<GLOBAL P-ACT <>>	;"gets action associated with the verb"

<GLOBAL P-NAME <>>

<GLOBAL P-OFLAG <>>	;"T if last input was an orphan"

<GLOBAL P-MERGED <>>	;"T if this input was merged with an orphan"

<GLOBAL P-ACLAUSE <>>

<GLOBAL P-NCN 0>	;"how many noun clauses we've seen"

<GLOBAL QUOTE-FLAG <>>	;"T if we're in quoted text (or winner,verb)"

<GLOBAL P-END-ON-PREP <>> ;"T if the sentence ended on a prep."

<GLOBAL P-AND <>>	;"T if seen an AND in a noun clause"

<GLOBAL P-ONEOBJ <>>



"tables and globals for looking at the input"

<GLOBAL P-CONT <>>	;"offset of more to parse, <> if done"
<GLOBAL P-LEN 0>	;"saves number of words left to be examined"

<CONSTANT P-LEXWORDS 1>	;"Byte offset to # of entries in LEXV"
<CONSTANT P-LEXSTART 1>	;"Word offset to start of LEXV entries"
<CONSTANT P-LEXELEN 2>	;"Number of words per LEXV entry"
<CONSTANT P-WORDLEN 4>	;"number of bytes per LEXV entry"

<GLOBAL P-LEXV
	<ITABLE 59 (LEXV) 0 #BYTE 0 #BYTE 0>>
<GLOBAL AGAIN-LEXV
	<ITABLE 59 (LEXV) 0 #BYTE 0 #BYTE 0>>
<GLOBAL RESERVE-LEXV
	<ITABLE 59 (LEXV) 0 #BYTE 0 #BYTE 0>>
<GLOBAL RESERVE-PTR <>>

<GLOBAL P-INBUF
	<ITABLE 120 (BYTE LENGTH) 0>> ;"INBUF - Input buffer for READ"
<GLOBAL OOPS-INBUF
	<ITABLE 120 (BYTE LENGTH) 0>>

"table and offsets for oops info"

<GLOBAL OOPS-TABLE <TABLE <> <> <> <>>>
<CONSTANT O-PTR 0>	;"word pointer to unknown token in P-LEXV"
<CONSTANT O-START 1>	;"word pointer to sentence start in P-LEXV"
<CONSTANT O-LENGTH 2>	;"byte length of unparsed tokens in P-LEXV"
<CONSTANT O-END 3>	;"byte pointer to first free byte in OOPS-INBUF"

"offsets in words"

<CONSTANT P-PSOFF 4> ;"Offset to parts of speech byte"
<CONSTANT P-P1OFF 5> ;"Offset to first part of speech"

<CONSTANT P-P1BITS 3> ;"First part of speech bit mask in PSOFF byte"

"p-itbl -- state of the parse is stored here"

<GLOBAL P-ITBL <TABLE 0 0 0 0 0 0 0 0 0 0>>
<GLOBAL P-VTBL <TABLE 0 #BYTE 0 #BYTE 0>>

"p-otbl -- just like p-itbl, for saving orphaned parses"

<GLOBAL P-OTBL <TABLE 0 0 0 0 0 0 0 0 0 0>>
<GLOBAL P-OVTBL <TABLE 0 #BYTE 0 #BYTE 0>>

"offsets in p-itbl and p-otbl"

<CONSTANT P-ITBLLEN 9>	;"length of p-itbl in words"
<CONSTANT P-VERB 0>	;"the action (act?foo)"
<CONSTANT P-VERBN 1>	;"lexv entries for it"
<CONSTANT P-PREP1 2>	;"first noun clause preposition"
<CONSTANT P-PREP1N 3>	;"word for it"
<CONSTANT P-PREP2 4>	;"second noun clause preposition"
<CONSTANT P-PREP2N 5>	;"word for it"
<CONSTANT P-NC1 6>	;"start of first noun clause"
<CONSTANT P-NC1L 7>	;"end of first noun clause"
<CONSTANT P-NC2 8>	;"start of second noun clause"
<CONSTANT P-NC2L 9>	;"end of second noun clause"



"PARSER -- Grovel down the input finding the verb, prepositions, and
noun clauses. If the input is <direction> or <walk> <direction>, fall
out immediately setting PRSA to ,V?WALK and PRSO to <direction>.
Otherwise, perform all required orphaning, syntax checking, and noun
clause lookup."

<ROUTINE PARSER ("AUX" (PTR ,P-LEXSTART) WRD (VAL 0) (VERB <>) (OF-FLAG <>)
		       OWINNER OMERGED LEN (DIR <>) (NW 0) (LW 0) (CNT -1))
	<REPEAT ()
		<COND (<G? <SET CNT <+ .CNT 1>> ,P-ITBLLEN> <RETURN>)
		      (T
		       <COND (<NOT ,P-OFLAG>
			      <PUT ,P-OTBL .CNT <GET ,P-ITBL .CNT>>)>
		       <PUT ,P-ITBL .CNT 0>)>>
	<SET OWINNER ,WINNER>
	<SET OMERGED ,P-MERGED>
	<SETG P-ADVERB <>>
	<SETG P-MERGED <>>
	<SETG P-END-ON-PREP <>>
	<PUT ,P-PRSO ,P-MATCHLEN 0>
	<PUT ,P-PRSI ,P-MATCHLEN 0>
	<PUT ,P-BUTS ,P-MATCHLEN 0>
	<COND (<AND <NOT ,QUOTE-FLAG> <N==? ,WINNER ,PLAYER>>
	       <SETG WINNER ,PLAYER>
	       <COND (<NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		      <SETG HERE <LOC ,WINNER>>)>
	       <SETG LIT <LIT? ,HERE>>)>
	<COND (,RESERVE-PTR
	       <SET PTR ,RESERVE-PTR>
	       <STUFF ,RESERVE-LEXV ,P-LEXV>
	       <COND (<AND ,VERBOSITY <EQUAL? ,PLAYER ,WINNER>>
		      <CRLF>)>
	       <SETG RESERVE-PTR <>>
	       <SETG P-CONT <>>)
	      (,P-CONT
	       <SET PTR ,P-CONT>
	       <COND (<AND ,VERBOSITY <EQUAL? ,PLAYER ,WINNER>>
		      <CRLF>)>
	       <SETG P-CONT <>>)
	      (T
	       <SETG WINNER ,PLAYER>
	       <SETG QUOTE-FLAG <>>
	       <COND (<NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		      <SETG HERE <LOC ,WINNER>>)>
	       <SETG LIT <LIT? ,HERE>>
	       <COND (,VERBOSITY <CRLF>)>
	       <TELL ">">
	       <READ ,P-INBUF ,P-LEXV>)>
	<SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>>
	<COND (<ZERO? ,P-LEN>
	       <BEG-PARDON>
	       <RFALSE>)>
	<COND (<EQUAL? <SET WRD <GET ,P-LEXV .PTR>> ,W?OOPS ,W?O>
	       <COND (<EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
			      ,W?PERIOD ,W?COMMA>
		      <SET PTR <+ .PTR ,P-LEXELEN>>
		      <SETG P-LEN <- ,P-LEN 1>>)>
	       <COND (<NOT <G? ,P-LEN 1>>
		      <TELL "I can't help your clumsiness." CR>
		      <RFALSE>)
		     (<GET ,OOPS-TABLE ,O-PTR>
		      <COND (<AND <G? ,P-LEN 2>
				  <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					  ,W?QUOTE>>
			     <TELL
"Sorry, you can't correct mistakes in quoted text." CR>
			     <RFALSE>)
			    (<G? ,P-LEN 2>
			     <TELL
"Warning: only the first word after OOPS is used." CR>)>
		      <PUT ,AGAIN-LEXV <GET ,OOPS-TABLE ,O-PTR>
			   <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>
		      <SETG WINNER .OWINNER> ;"maybe fix oops vs. chars.?"
		      <INBUF-ADD <GETB ,P-LEXV <+ <* .PTR ,P-LEXELEN> 6>>
				 <GETB ,P-LEXV <+ <* .PTR ,P-LEXELEN> 7>>
				 <+ <* <GET ,OOPS-TABLE ,O-PTR> ,P-LEXELEN> 3>>
		      <STUFF ,AGAIN-LEXV ,P-LEXV>
		      <SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>>
		      <SET PTR <GET ,OOPS-TABLE ,O-START>>
		      <INBUF-STUFF ,OOPS-INBUF ,P-INBUF>)
		     (T
		      <PUT ,OOPS-TABLE ,O-END <>>
		      <TELL "There was no word to replace!" CR>
		      <RFALSE>)>)
	      (T
	       <COND (<NOT <EQUAL? .WRD ,W?AGAIN ,W?G>>
		      <SETG P-NUMBER 0>)>
	       <PUT ,OOPS-TABLE ,O-END <>>)>
	<COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?AGAIN ,W?G>
	       <COND (<ZERO? <GETB ,OOPS-INBUF 1>>
		      <BEG-PARDON>
		      <RFALSE>)
		     (,P-OFLAG
		      <TELL "It's difficult to repeat fragments." CR>
		      <RFALSE>)
		     (<NOT ,P-WON>
		      <TELL "That would just repeat a mistake." CR>
		      <RFALSE>)
		     (<G? ,P-LEN 1>
		      <COND (<OR <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					,W?PERIOD ,W?COMMA ,W?THEN>
				 <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					,W?AND>>
			     <SET PTR <+ .PTR <* 2 ,P-LEXELEN>>>
			     <PUTB ,P-LEXV ,P-LEXWORDS
				   <- <GETB ,P-LEXV ,P-LEXWORDS> 2>>)
			    (T
			     <TELL "I couldn't understand that sentence." CR>
			     <RFALSE>)>)
		     (T
		      <SET PTR <+ .PTR ,P-LEXELEN>>
		      <PUTB ,P-LEXV ,P-LEXWORDS
			    <- <GETB ,P-LEXV ,P-LEXWORDS> 1>>)>
	       <COND (<G? <GETB ,P-LEXV ,P-LEXWORDS> 0>
		      <STUFF ,P-LEXV ,RESERVE-LEXV>
		      <SETG RESERVE-PTR .PTR>)
		     (T
		      <SETG RESERVE-PTR <>>)>
	       ;<SETG P-LEN <GETB ,AGAIN-LEXV ,P-LEXWORDS>>
	       <SETG WINNER .OWINNER>
	       <SETG P-MERGED .OMERGED>
	       <INBUF-STUFF ,OOPS-INBUF ,P-INBUF>
	       <STUFF ,AGAIN-LEXV ,P-LEXV>
	       <SET CNT -1>
	       <SET DIR ,AGAIN-DIR>
	       <REPEAT ()
		<COND (<IGRTR? CNT ,P-ITBLLEN> <RETURN>)
		      (T <PUT ,P-ITBL .CNT <GET ,P-OTBL .CNT>>)>>)
	      (T
	       <STUFF ,P-LEXV ,AGAIN-LEXV>
	       <INBUF-STUFF ,P-INBUF ,OOPS-INBUF>
	       <PUT ,OOPS-TABLE ,O-START .PTR>
	       <PUT ,OOPS-TABLE ,O-LENGTH <* 4 ,P-LEN>>
	       <SET LEN
		    <* 2 <+ .PTR <* ,P-LEXELEN <GETB ,P-LEXV ,P-LEXWORDS>>>>>
	       <PUT ,OOPS-TABLE ,O-END <+ <GETB ,P-LEXV <- .LEN 1>>
					  <GETB ,P-LEXV <- .LEN 2>>>>
	       <SETG RESERVE-PTR <>>
	       <SET LEN ,P-LEN>
	       ;<SETG P-DIR <>>
	       <SETG P-NCN 0>
	       <SETG P-GETFLAGS 0>
	       <REPEAT ()
		<COND (<L? <SETG P-LEN <- ,P-LEN 1>> 0>
		       <SETG QUOTE-FLAG <>>
		       <RETURN>)
		      (<SET WRD <KNOWN-WORD? .PTR .VERB>>
		       <COND (<ZERO? ,P-LEN> <SET NW 0>)
			     (T <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>)>
		       <COND (<AND <EQUAL? .WRD ,W?TO>
				   <EQUAL? .VERB ,ACT?TELL ,ACT?ASK>
				   ;"next clause added 8/20/84 by JW to
				     enable TELL MY NAME TO BEAST"
				   <NOT <ZERO?
					 <WT? .NW ,PS?VERB ,P1?VERB>>>>
			      <PUT ,P-ITBL ,P-VERB ,ACT?TELL>
			      <SET WRD ,W?QUOTE>)
			     (<AND <EQUAL? .WRD ,W?THEN>
				   <G? ,P-LEN 0>
				   <NOT .VERB>
				   <NOT ,QUOTE-FLAG>>
			      <COND (<EQUAL? .LW 0 ,W?PERIOD>
				     <SET WRD ,W?THE>)
				    (ELSE
				     <PUT ,P-ITBL ,P-VERB ,ACT?TELL>
				     <PUT ,P-ITBL ,P-VERBN 0>
				     <SET WRD ,W?QUOTE>)>)>
		       <COND (<EQUAL? .WRD ,W?THEN ,W?PERIOD ,W?QUOTE>
			      <COND (<EQUAL? .WRD ,W?QUOTE>
				     <COND ;"Following clause added for
					     WRITE 'FOO' ON CUBE"
				           (<AND <EQUAL? <GET ,P-LEXV .PTR>
							 ,W?QUOTE>
						 <OR <NOT <EQUAL?
							    .VERB
							    ,ACT?TELL
							    ,ACT?SAY>>
						     <NOT <EQUAL? ,WINNER
								  ,PLAYER>>>>
					    <YOU-CANT-X-THAT "use quotes like">
					    <RFALSE>)
					   (,QUOTE-FLAG
					    <SETG QUOTE-FLAG <>>)
					   (T <SETG QUOTE-FLAG T>)>)>
			      <OR <ZERO? ,P-LEN>
				  <SETG P-CONT <+ .PTR ,P-LEXELEN>>>
			      <PUTB ,P-LEXV ,P-LEXWORDS ,P-LEN>
			      <RETURN>)>
		       <COND (<AND ,P-OFLAG
				   <ZERO? .VERB>
				   <EQUAL? .WRD ,W?UP ,W?DOWN>
				   <EQUAL? <GET ,P-OTBL ,P-VERB>
					   ,ACT?PUSH>
				   <EQUAL? <GET <GET ,P-OTBL ,P-NC1> 0>
					   ,W?CALL ,W?BUTTON ,W?ARROW>>
			      <COND (<EQUAL? .WRD ,W?UP>
				     <SET WRD ,W?UP-ARROW>)
				    (<EQUAL? .WRD ,W?DOWN>
				     <SET WRD ,W?DOWN-ARROW>)>
			      <CHANGE-LEXV .PTR .WRD>)>
		       <COND (<AND <NOT <ZERO? <SET VAL
						    <WT? .WRD
							 ,PS?DIRECTION
							 ,P1?DIRECTION>>>>
				   <EQUAL? .VERB <> ,ACT?WALK ;,ACT?FLY>
				   <OR <EQUAL? .LEN 1>
				       <AND <EQUAL? .LEN 2>
					    <EQUAL? .VERB ,ACT?WALK ;,ACT?FLY>>
				       <AND <EQUAL? .NW
					            ,W?THEN
					            ,W?PERIOD
					            ,W?QUOTE>
					    <NOT <L? .LEN 2>>>
				       <AND ,QUOTE-FLAG
					    <EQUAL? .LEN 2>
					    <EQUAL? .NW ,W?QUOTE>>
				       <AND <G? .LEN 2>
					    <EQUAL? .NW ,W?COMMA ,W?AND>>>>
			      <SET DIR .VAL>
			      <COND (<EQUAL? .NW ,W?COMMA ,W?AND>
				     <CHANGE-LEXV <+ .PTR ,P-LEXELEN>
						  ,W?THEN>)>
			      <COND (<NOT <G? .LEN 2>>
				     <SETG QUOTE-FLAG <>>
				     <RETURN>)>)
			     (<AND <NOT <ZERO?
					  <SET VAL <WT? .WRD
							,PS?VERB ,P1?VERB>>>>
				   <NOT .VERB>>
			      <SET VERB .VAL>
			      <PUT ,P-ITBL ,P-VERB .VAL>
			      <PUT ,P-ITBL ,P-VERBN ,P-VTBL>
			      <PUT ,P-VTBL 0 .WRD>
			      <PUTB ,P-VTBL 2 <GETB ,P-LEXV
						    <SET CNT
							 <+ <* .PTR 2> 2>>>>
			      <PUTB ,P-VTBL 3 <GETB ,P-LEXV <+ .CNT 1>>>)
			     (<OR <NOT <ZERO? <SET VAL <WT? .WRD ,PS?PREPOSITION 0>>>>
				  <EQUAL? .WRD ,W?ALL ,W?ONE ,W?BOTH>
				  <NOT <ZERO? <WT? .WRD ,PS?ADJECTIVE>>>
				  <NOT <ZERO? <WT? .WRD ,PS?OBJECT>>>>
			      <COND (<AND <G? ,P-LEN 1>
					  <EQUAL? .NW ,W?OF>
					  <ZERO? .VAL>
					  <NOT <EQUAL? .WRD
						       ,W?ALL ,W?ONE ,W?A>>
					  <NOT <EQUAL? .WRD
						       ,W?BOTH>>>
				     <SET OF-FLAG T>)
				    (<AND <NOT <ZERO? .VAL>>
				          <OR <ZERO? ,P-LEN>
					      <EQUAL? .NW ,W?THEN ,W?PERIOD>>>
				     <SETG P-END-ON-PREP T>
				     <COND (<L? ,P-NCN 2>
					    <PUT ,P-ITBL ,P-PREP1 .VAL>
					    <PUT ,P-ITBL ,P-PREP1N .WRD>)>)
				    (<EQUAL? ,P-NCN 2>
				     <TELL
"There were too many nouns in that sentence." CR>
				     <RFALSE>)
				    (T
				     <COND (<AND <NOT <ZERO? .VAL>>
						 <EQUAL? .WRD
							 ,W?UP ,W?DOWN ,W?U
							 ,W?D>
						 <EQUAL? .NW
							 ,W?BUTTON ,W?ARROW>>
					    <SET VAL <>>)>
				     <SETG P-NCN <+ ,P-NCN 1>>
				     <SETG P-ACT .VERB>
				     <OR <SET PTR <CLAUSE .PTR .VAL .WRD>>
					 <RFALSE>>
				     <COND (<L? .PTR 0>
					    <SETG QUOTE-FLAG <>>
					    <RETURN>)>)>)
			     (<EQUAL? .WRD ,W?OF>
			      <COND (<OR <NOT .OF-FLAG>
					 <EQUAL? .NW ,W?PERIOD ,W?THEN>>
				     <CANT-USE .PTR>
				     <RFALSE>)
				    (T
				     <SET OF-FLAG <>>)>)
			     (<NOT <ZERO? <WT? .WRD ,PS?BUZZ-WORD>>>)
			     (<AND <EQUAL? .VERB ,ACT?TELL>
				   <NOT <ZERO? <WT? .WRD ,PS?VERB ,P1?VERB>>>
				   ;"Next expr added to fix FORD, TELL ME WHY"
				   ;"NOT taken out of said expr to fix fix"
				   <EQUAL? ,WINNER ,PLAYER>>
			      <TELL
"Please consult your manual for the correct way to talk to characters." CR>
			      <RFALSE>)
			     (T
			      <CANT-USE .PTR>
			      <RFALSE>)>)
		      (T
		       <UNKNOWN-WORD .PTR>
		       <RFALSE>)>
		<SET LW .WRD>
		<SET PTR <+ .PTR ,P-LEXELEN>>>)>
	<PUT ,OOPS-TABLE ,O-PTR <>>
	<COND (.DIR
	       <SETG PRSA ,V?WALK>
	       <SETG PRSO .DIR>
	       <SETG P-OFLAG <>>
	       <SETG P-WALK-DIR .DIR>
	       <SETG AGAIN-DIR .DIR>)
	      (ELSE
	       <COND (,P-OFLAG <ORPHAN-MERGE>)>
	       <SETG P-WALK-DIR <>>
	       <SETG AGAIN-DIR <>>
	       <COND (<AND <SYNTAX-CHECK>
			   <SNARF-OBJECTS>
			   <MANY-CHECK>
			   <TAKE-CHECK>>
		      T)>)>>

<ROUTINE BEG-PARDON ()
	 <TELL "I beg your pardon?" CR>>

<ROUTINE KNOWN-WORD? (PTR "OPTIONAL" (VERB <>) "AUX" (WRD <>) (NWRD <>))
	 <COND (<SET WRD <GET ,P-LEXV .PTR>>
		<COND ;(<EQUAL? .WRD ,W?XYZZY ,W?PLUGH>
		       <SETG P-NAME .WRD>
		       <SET NWRD ,W?INTNAME>)
		      (<EQUAL? .WRD ,W?EVERYTHING ,W?BOTH>
		       <SET NWRD ,W?ALL>)
		      (<EQUAL? .WRD ,W?A>
		       <SET NWRD ,W?ONE>)>)
	       (<OR <SET WRD <INPUT-EQUAL? .PTR ,LOGIN-ID ,W?XYZZY>>
		    <SET WRD <INPUT-EQUAL? .PTR ,PASSWORD-STRING ,W?PLUGH>>>
		<SETG P-NAME .WRD>
		<SET NWRD ,W?INTNAME>)
	       (<SET NWRD <NUMBER? .PTR>>)
	       (<EQUAL? .VERB ,ACT?TYPE ,ACT?LOGIN ,ACT?PASSWORD>
		<SETG P-NAME .WRD>
		<SET NWRD ,W?INTNAME>)>
	 <COND (.NWRD
		<CHANGE-LEXV .PTR .NWRD>
		<SET WRD .NWRD>)>
	 .WRD>

<ROUTINE INPUT-EQUAL? (PTR TBL WRD "AUX" LEX LPTR (CNT 0) CMAX)
	 <SET LEX <REST ,P-LEXV <* .PTR 2>>>
	 <SET CMAX <GETB .TBL 0>>
	 <COND (<EQUAL? .CMAX <GETB .LEX 2>>
		<SET LPTR <GETB .LEX 3>> 
		<REPEAT ()
			<COND (<IGRTR? CNT .CMAX> <RETURN .WRD>)
			      (<EQUAL? <GETB ,P-INBUF .LPTR>
				       <GETB .TBL .CNT>>
			       <SET LPTR <+ .LPTR 1>>)
			      (ELSE <RFALSE>)>>)>>

<CONSTANT LOGIN-ID <TABLE (PURE LENGTH STRING) "872325412">>
<CONSTANT PASSWORD-STRING <TABLE (PURE LENGTH STRING) "uhlersoth">>

<ROUTINE CHANGE-LEXV (PTR WRD)
	 <PUT ,P-LEXV .PTR .WRD>
	 <PUT ,AGAIN-LEXV .PTR .WRD>>

<GLOBAL P-WALK-DIR <>>
<GLOBAL AGAIN-DIR <>>

"For AGAIN purposes, put contents of one LEXV table into another."

<ROUTINE STUFF (SRC DEST "OPTIONAL" (MAX 29) "AUX" (PTR ,P-LEXSTART) (CTR 1)
		BPTR)
	 <PUTB .DEST 0 <GETB .SRC 0>>
	 <PUTB .DEST 1 <GETB .SRC 1>>
	 <REPEAT ()
		 <PUT .DEST .PTR <GET .SRC .PTR>>
		 <SET BPTR <+ <* .PTR 2> 2>>
		 <PUTB .DEST .BPTR <GETB .SRC .BPTR>>
		 <SET BPTR <+ <* .PTR 2> 3>>
		 <PUTB .DEST .BPTR <GETB .SRC .BPTR>>
		 <SET PTR <+ .PTR ,P-LEXELEN>>
		 <COND (<IGRTR? CTR .MAX>
			<RETURN>)>>>

"Put contents of one INBUF into another"
<ROUTINE INBUF-STUFF (SRC DEST "AUX" CNT)
	 <SET CNT <- <GETB .SRC 0> 1>>
	 <REPEAT ()
		 <PUTB .DEST .CNT <GETB .SRC .CNT>>
		 <COND (<DLESS? CNT 0> <RETURN>)>>>

"Put the word in the positions specified from P-INBUF to the end of
OOPS-INBUF, leaving the appropriate pointers in AGAIN-LEXV"

<ROUTINE INBUF-ADD (LEN BEG SLOT "AUX" DBEG (CTR 0) TMP)
	 <COND (<SET TMP <GET ,OOPS-TABLE ,O-END>>
		<SET DBEG .TMP>)
	       (T
		<SET DBEG <+ <GETB ,AGAIN-LEXV
				   <SET TMP <GET ,OOPS-TABLE ,O-LENGTH>>>
			     <GETB ,AGAIN-LEXV <+ .TMP 1>>>>)>
	 <PUT ,OOPS-TABLE ,O-END <+ .DBEG .LEN>>
	 <REPEAT ()
		 <PUTB ,OOPS-INBUF
		       <+ .DBEG .CTR>
		       <GETB ,P-INBUF <+ .BEG .CTR>>>
		 <SET CTR <+ .CTR 1>>
		 <COND (<EQUAL? .CTR .LEN> <RETURN>)>>
	 <PUTB ,AGAIN-LEXV .SLOT .DBEG>
	 <PUTB ,AGAIN-LEXV <- .SLOT 1> .LEN>>

"Check whether word pointed at by PTR is the correct part of speech.
   The second argument is the part of speech (,PS?<part of speech>). The
   3rd argument (,P1?<part of speech>), if given, causes the value
   for that part of speech to be returned."

<ROUTINE WT? (PTR BIT "OPTIONAL" (B1 5) "AUX" (OFFS ,P-P1OFF) TYP)
	 <COND (<BTST <SET TYP <GETB .PTR ,P-PSOFF>> .BIT>
		<COND (<G? .B1 4> <RTRUE>)
		      (<EQUAL? .BIT ,PS?OBJECT> 1)
		      (T
		       <SET TYP <BAND .TYP ,P-P1BITS>>
		       <COND (<NOT <EQUAL? .TYP .B1>> <SET OFFS <+ .OFFS 1>>)>
		       <GETB .PTR .OFFS>)>)
	       (<EQUAL? .BIT ,PS?ADJECTIVE>
		<COND (<EQUAL? .PTR ,W?UP ,W?U>
		       <WT? ,W?UP-ARROW ,PS?ADJECTIVE .B1>)
		      (<EQUAL? .PTR ,W?DOWN ,W?D>
		       <WT? ,W?DOWN-ARROW ,PS?ADJECTIVE .B1>)
		      (ELSE <RFALSE>)>)>>

"Scan through a noun clause, leave a pointer to its starting location"

<ROUTINE CLAUSE (PTR VAL WRD "AUX" OFF NUM (ANDFLG <>) (1ST? T) NW (LW 0))
	 <SET OFF <* <- ,P-NCN 1> 2>>
	 <COND (<NOT <EQUAL? .VAL 0>>
		<PUT ,P-ITBL <SET NUM <+ ,P-PREP1 .OFF>> .VAL>
		<PUT ,P-ITBL <+ .NUM 1> .WRD>
		<SET PTR <+ .PTR ,P-LEXELEN>>)
	       (T <SETG P-LEN <+ ,P-LEN 1>>)>
	 <COND (<ZERO? ,P-LEN> <SETG P-NCN <- ,P-NCN 1>> <RETURN -1>)>
	 <PUT ,P-ITBL <SET NUM <+ ,P-NC1 .OFF>> <REST ,P-LEXV <* .PTR 2>>>
	 <COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?THE ,W?A ,W?AN>
		<PUT ,P-ITBL .NUM <REST <GET ,P-ITBL .NUM> 4>>)>
	 <REPEAT ()
		 <COND (<L? <SETG P-LEN <- ,P-LEN 1>> 0>
			<PUT ,P-ITBL <+ .NUM 1> <REST ,P-LEXV <* .PTR 2>>>
			<RETURN -1>)>
		 <COND (<SET WRD <KNOWN-WORD? .PTR>>
			<COND (<ZERO? ,P-LEN> <SET NW 0>)
			      (T <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>)>
			<COND (<AND <EQUAL? .WRD ,W?QUOTE>
				    <NOT <EQUAL? ,P-ACT ,ACT?TELL ,ACT?SAY>>>
			       <COND ;(<QUOTED-PHRASE .PTR ,P-ACT>
				      <SET PTR <+ .PTR ,P-LEXELEN>>
				      <AGAIN>)
				     (ELSE <RFALSE>)>)
			      (<EQUAL? .WRD ,W?AND ,W?COMMA>
			       <SET ANDFLG .WRD>)
			      (<EQUAL? .WRD ,W?ALL ,W?ONE ,W?BOTH>
			       <COND (<EQUAL? .NW ,W?OF>
				      <SETG P-LEN <- ,P-LEN 1>>
				      <SET PTR <+ .PTR ,P-LEXELEN>>)>)
			      (<OR <EQUAL? .WRD ,W?THEN ,W?PERIOD>
				   <AND <NOT <ZERO? <WT? .WRD ,PS?PREPOSITION>>>
					<GET ,P-ITBL ,P-VERB>
					;"ADDED 4/27 FOR TURTLE,UP"
					<NOT .1ST?>>>
			       <SETG P-LEN <+ ,P-LEN 1>>
			       <PUT ,P-ITBL
				    <+ .NUM 1>
				    <REST ,P-LEXV <* .PTR 2>>>
			       <RETURN <- .PTR ,P-LEXELEN>>)
			      ;"This next clause was 2 clauses further down"
			      ;"This attempts to fix EDDIE, TURN ON COMPUTER"
			      (<AND <EQUAL? .ANDFLG ,W?COMMA>
				    <EQUAL? <GET ,P-ITBL ,P-VERB> 0>>
			       <SET PTR <- .PTR 4>>
			       <CHANGE-LEXV <+ .PTR 2> ,W?THEN>
			       <SETG P-LEN <+ ,P-LEN 2>>)
			      (<NOT <ZERO? <WT? .WRD ,PS?OBJECT>>>
			       <COND ;"First clause added 1/10/84 to fix
				      'verb AT synonym OF synonym' bug"
				(<AND <G? ,P-LEN 0>
				      <EQUAL? .NW ,W?OF>
				      <NOT <EQUAL? .WRD ,W?ALL ,W?ONE>>>
				 T)
				;"next clause makes 'give troll red book'
				      have only one noun clause. careful!"
				(<AND <NOT <ZERO? <WT? .WRD
						       ,PS?ADJECTIVE
						       ,P1?ADJECTIVE>>>
				      <NOT <EQUAL? .NW 0>>
				      <OR <WT? .NW ,PS?OBJECT>
					  <WT? .NW ,PS?ADJECTIVE>>>)
				(<AND <NOT .ANDFLG>
				      <NOT <EQUAL? .NW ,W?BUT ,W?EXCEPT>>
				      <NOT <EQUAL? .NW ,W?AND ,W?COMMA>>>
				 <PUT ,P-ITBL
				      <+ .NUM 1>
				      <REST ,P-LEXV <* <+ .PTR 2> 2>>>
				 <RETURN .PTR>)
				(T <SET ANDFLG <>>)>)
			      ;"next clause replaced by following on from games
			       with characters"
			      ;(<AND <OR ,P-MERGED
					 ,P-OFLAG
					 <NOT <EQUAL? <GET ,P-ITBL ,P-VERB> 0>>>
				     <OR <WT? .WRD ,PS?ADJECTIVE>
					 <WT? .WRD ,PS?BUZZ-WORD>>>)
			      (<OR <NOT <ZERO? <WT? .WRD ,PS?ADJECTIVE>>>
				   <NOT <ZERO? <WT? .WRD ,PS?BUZZ-WORD>>>>)
			      (<NOT <ZERO? <WT? .WRD ,PS?PREPOSITION>>> T)
			      (T
			       <CANT-USE .PTR>
			       <RFALSE>)>)
		       (T <UNKNOWN-WORD .PTR> <RFALSE>)>
		 <SET LW .WRD>
		 <SET 1ST? <>>
		 <SET PTR <+ .PTR ,P-LEXELEN>>>>

<ROUTINE NUMBER? (PTR "AUX" CNT BPTR CHR (SUM 0))
	 <SETG P-TIME? <>>
	 <SETG P-MINUTES 0>
	 <SET CNT <GETB <REST ,P-LEXV <* .PTR 2>> 2>>
	 <SET BPTR <GETB <REST ,P-LEXV <* .PTR 2>> 3>>
	 <REPEAT ()
		 <COND (<L? <SET CNT <- .CNT 1>> 0> <RETURN>)
		       (T
			<SET CHR <GETB ,P-INBUF .BPTR>>
			<COND (<EQUAL? .CHR %<ASCII !\:>>
			       <SETG P-TIME? T>
			       <SETG P-MINUTES <* .SUM 60>>
			       <SET SUM 0>)
			      (<AND <L? .CHR 58> <G? .CHR 47>>
			       <COND (<G? .SUM 6553>
				      <SET SUM 10000>
				      <RETURN>)>
			       <SET SUM <+ <* .SUM 10> <- .CHR 48>>>)
			      (T <RFALSE>)>
			<SET BPTR <+ .BPTR 1>>)>>
	 <SETG P-NUMBER .SUM>
	 <COND (,P-TIME?
		<SETG P-NUMBER <+ ,P-MINUTES ,P-NUMBER>>)>
	 ,W?INTNUM>

<GLOBAL P-TIME? <>>	;"t if reading a time"
<GLOBAL P-MINUTES 0>	;"number to left of : in a time"
<GLOBAL P-NUMBER 0>	;"actual number found (NUMBER? substitutes INTNUM)"



<ROUTINE ORPHAN-MERGE ("AUX" (CNT -1) TEMP VERB BEG END
		       (ADJ <>) (ADJB <>) (VRB <>) (NOUN <>) ADJE WRD) 
   <SETG P-OFLAG <>>
   <COND (<SET WRD <GET <GET ,P-ITBL ,P-VERBN> 0>>
	  <COND (<EQUAL? <WT? .WRD ,PS?VERB ,P1?VERB>
			 <GET ,P-OTBL ,P-VERB>>
		 <SET VRB T>)>
	  <COND (<WT? .WRD ,PS?ADJECTIVE>
		 <SET ADJ T>)>
	  <COND (<WT? .WRD ,PS?OBJECT>
		 <SET NOUN T>)>)>
   <COND (<AND <NOT .VRB> ;"convert apparent verb into noun clause"
	       <NOT .ADJ>
	       <WT? .WRD ,PS?OBJECT ,P1?OBJECT>
	       <EQUAL? ,P-NCN 0>>
	  <PUT ,P-ITBL ,P-VERB 0>
	  <PUT ,P-ITBL ,P-VERBN 0>
	  <PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
	  <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>
	  <SETG P-NCN 1>)>
   <COND (<AND <NOT <ZERO? <SET VERB <GET ,P-ITBL ,P-VERB>>>>
	       <NOT .ADJ>
	       <NOT .VRB>
	       <NOT <EQUAL? .VERB <GET ,P-OTBL ,P-VERB>>>>
	  <RFALSE>)
	 (<EQUAL? ,P-NCN 2> <RFALSE>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC1> 1>
	  <COND (<EQUAL? <GET ,P-ITBL ,P-PREP1>
			 0
			 <GET ,P-OTBL ,P-PREP1>>
		 <COND (.ADJ
			<PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>>
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>
			<COND (<ZERO? ,P-NCN> <SETG P-NCN 1>)>)>
		 <PUT ,P-OTBL ,P-NC1 <GET ,P-ITBL ,P-NC1>>
		 <PUT ,P-OTBL ,P-NC1L <GET ,P-ITBL ,P-NC1L>>)
		(T <RFALSE>)>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC2> 1>
	  <COND (<EQUAL? <GET ,P-ITBL ,P-PREP1>
			 <>
			 <GET ,P-OTBL ,P-PREP2>>
		 <COND (<OR .ADJ
			    <AND <ZERO? ,P-NCN> .NOUN>>
			<PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>>
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>)>
		 <PUT ,P-OTBL ,P-NC2 <GET ,P-ITBL ,P-NC1>>
		 <PUT ,P-OTBL ,P-NC2L <GET ,P-ITBL ,P-NC1L>>
		 <SETG P-NCN 2>)
		(T <RFALSE>)>)
	 (,P-ACLAUSE
	  <COND (<AND <NOT <EQUAL? ,P-NCN 1>> <NOT .ADJ>>
		 <SETG P-ACLAUSE <>>
		 <RFALSE>)
		(T
		 <SET BEG <GET ,P-ITBL ,P-NC1>>
		 <COND (.ADJ
			<SET BEG <REST ,P-LEXV 2>>
			<PUT ,P-ITBL ,P-NC1 .BEG>
			<SET ADJ <>>)>
		 <SET END <GET ,P-ITBL ,P-NC1L>>
		 <REPEAT ()
			 <COND (<EQUAL? .BEG .END>
				<COND (.ADJB <CLAUSE-WIN .ADJB .ADJE> <RETURN>)
				      (T
				       <SETG P-ACLAUSE <>>
				       <RFALSE>)>)>
			 <SET WRD <GET .BEG 0>>
			 <COND (<OR <EQUAL? .WRD ,W?ALL ,W?ONE> 
				    <BTST <GETB .WRD ,P-PSOFF> ,PS?ADJECTIVE>>
				<COND (<NOT .ADJB> <SET ADJB .BEG>)>
				<SET ADJE <REST .BEG ,P-WORDLEN>>)
			       (<AND <BTST <GETB .WRD ,P-PSOFF> ,PS?OBJECT>
				     <EQUAL? <+ .BEG ,P-WORDLEN> .END>>
				<COND (<AND ,P-ANAM
					    <NOT <EQUAL? .WRD ,P-ANAM>>>
				       <SETG P-ANAM <>>
				       <SET ADJB <GET ,P-ITBL ,P-NC1>>
				       <SET ADJE .END>)>)>
			 <SET BEG <REST .BEG ,P-WORDLEN>>
			 <COND (<EQUAL? .END 0>
				<SET END .BEG>
				<SETG P-NCN 1>
				<PUT ,P-ITBL ,P-NC1 <BACK .BEG 4>>
				<PUT ,P-ITBL ,P-NC1L .BEG>)>>)>)>
   <PUT ,P-VTBL 0 <GET ,P-OVTBL 0>>
   <PUTB ,P-VTBL 2 <GETB ,P-OVTBL 2>>
   <PUTB ,P-VTBL 3 <GETB ,P-OVTBL 3>>
   <PUT ,P-OTBL ,P-VERBN ,P-VTBL>
   <PUTB ,P-VTBL 2 0>
   ;<AND <NOT <EQUAL? <GET ,P-OTBL ,P-NC2> 0>> <SETG P-NCN 2>>
   <REPEAT ()
	   <COND (<G? <SET CNT <+ .CNT 1>> ,P-ITBLLEN>
		  <SETG P-MERGED T>
		  <RTRUE>)
		 (T <PUT ,P-ITBL .CNT <GET ,P-OTBL .CNT>>)>>
   T>

<ROUTINE CLAUSE-WIN ("OPT" (ADJB <>) (ADJE <>)) 
	<COND (.ADJB
	       <PUT ,P-ITBL ,P-VERB <GET ,P-OTBL ,P-VERB>>)>
	<PUT ,P-CCTBL ,CC-BEG ,P-ACLAUSE>
	<PUT ,P-CCTBL ,CC-END <+ ,P-ACLAUSE 1>>
	<PUT ,P-CCTBL ,CC-IBEG .ADJB>
	<PUT ,P-CCTBL ,CC-IEND .ADJE>
	<COND (<EQUAL? ,P-ACLAUSE ,P-NC1>
	       <PUT ,P-CCTBL ,CC-CLAUSE ,P-OCL1>)
	      (ELSE
	       <PUT ,P-CCTBL ,CC-CLAUSE ,P-OCL2>)>
	<CLAUSE-COPY ,P-OTBL ,P-OTBL>
	<AND <NOT <EQUAL? <GET ,P-OTBL ,P-NC2> 0>> <SETG P-NCN 2>>
	<SETG P-ACLAUSE <>>
	<RTRUE>>

"Print undefined word in input.
   PTR points to the unknown word in P-LEXV"

<ROUTINE WORD-PRINT (CNT BUF)
	 <REPEAT ()
		 <COND (<DLESS? CNT 0> <RETURN>)
		       (ELSE
			<PRINTC <GETB ,P-INBUF .BUF>>
			<SET BUF <+ .BUF 1>>)>>>

<ROUTINE UNKNOWN-WORD (PTR "AUX" BUF)
	<PUT ,OOPS-TABLE ,O-PTR .PTR>
	<TELL "I don't know the word \"">
	<WORD-PRINT <GETB <REST ,P-LEXV <SET BUF <* .PTR 2>>> 2>
		    <GETB <REST ,P-LEXV .BUF> 3>>
	<TELL ".\"" CR>
	<SETG QUOTE-FLAG <>>
	<SETG P-OFLAG <>>>

<ROUTINE CANT-USE (PTR "AUX" BUF)
	<TELL "You used the word \"">
	<WORD-PRINT <GETB <REST ,P-LEXV <SET BUF <* .PTR 2>>> 2>
		    <GETB <REST ,P-LEXV .BUF> 3>>
	<TELL "\" in a way that I don't understand." CR>
	<SETG QUOTE-FLAG <>>
	<SETG P-OFLAG <>>>

" Perform syntax matching operations, using P-ITBL as the source of
  the verb and adjectives for this input. Returns false if no
  syntax matches, and does it's own orphaning. If return is true,
  the syntax is saved in P-SYNTAX."

<GLOBAL P-SYNTAX 0>	;"where the actual syntax found is saved"
<GLOBAL P-SLOCBITS 0>	;"location bits (where to look)"

"definition of a syntax"

<CONSTANT P-SYNLEN 8>	;"length in bytes"
<CONSTANT P-SBITS 0>
<CONSTANT P-SPREP1 1>
<CONSTANT P-SPREP2 2>
<CONSTANT P-SFWIM1 3>
<CONSTANT P-SFWIM2 4>
<CONSTANT P-SLOC1 5>
<CONSTANT P-SLOC2 6>
<CONSTANT P-SACTION 7>
<CONSTANT P-SONUMS 3>

<ROUTINE SYNTAX-CHECK
	("AUX" SYN LEN NUM OBJ (DRIVE1 <>) (DRIVE2 <>) PREP VERB TMP)
	<COND (<ZERO? <SET VERB <GET ,P-ITBL ,P-VERB>>>
	       <TELL "There was no verb in that sentence!" CR>
	       <RFALSE>)>
	<SET SYN <GET ,VERBS <- 255 .VERB>>>
	<SET LEN <GETB .SYN 0>>
	<SET SYN <REST .SYN>>
	<REPEAT ()
		<SET NUM <BAND <GETB .SYN ,P-SBITS> ,P-SONUMS>>
		<COND (<G? ,P-NCN .NUM> T)
		      (<AND <NOT <L? .NUM 1>>
			    <ZERO? ,P-NCN>
			    <OR <ZERO? <SET PREP <GET ,P-ITBL ,P-PREP1>>>
				<EQUAL? .PREP <GETB .SYN ,P-SPREP1>>>>
		       <SET DRIVE1 .SYN>)
		      (<EQUAL? <GETB .SYN ,P-SPREP1> <GET ,P-ITBL ,P-PREP1>>
		       <COND (<AND <EQUAL? .NUM 2> <EQUAL? ,P-NCN 1>>
			      <SET DRIVE2 .SYN>)
			     (<EQUAL? <GETB .SYN ,P-SPREP2>
				      <GET ,P-ITBL ,P-PREP2>>
			      <SYNTAX-FOUND .SYN>
			      <RTRUE>)>)>
		<COND (<DLESS? LEN 1>
		       <COND (<OR .DRIVE1 .DRIVE2> <RETURN>)
			     (T
			      <TELL ,NOT-RECOGNIZED CR>
			      <RFALSE>)>)
		      (T <SET SYN <REST .SYN ,P-SYNLEN>>)>>
	<COND (<AND .DRIVE1
		    <SET OBJ
			 <GWIM <GETB .DRIVE1 ,P-SFWIM1>
			       <GETB .DRIVE1 ,P-SLOC1>
			       <GETB .DRIVE1 ,P-SPREP1>>>>
	       <PUT ,P-PRSO ,P-MATCHLEN 1>
	       <PUT ,P-PRSO 1 .OBJ>
	       <SYNTAX-FOUND .DRIVE1>)
	      (<AND .DRIVE2
		    <SET OBJ
			 <GWIM <GETB .DRIVE2 ,P-SFWIM2>
			       <GETB .DRIVE2 ,P-SLOC2>
			       <GETB .DRIVE2 ,P-SPREP2>>>>
	       <PUT ,P-PRSI ,P-MATCHLEN 1>
	       <PUT ,P-PRSI 1 .OBJ>
	       <SYNTAX-FOUND .DRIVE2>)
	      (<EQUAL? .VERB ,ACT?FIND ;,ACT?WHAT>
	       <TELL "I can't answer that question." CR>
	       <RFALSE>)
	      (<NOT <EQUAL? ,WINNER ,PLAYER>>
	       <TELL
"I don't understand. What are you referring to?" CR>
	       <RFALSE>)
	      (T
	       <ORPHAN .DRIVE1 .DRIVE2>
	       <TELL ,WHAT-DO-YOU-WANT-TO>
	       <SET TMP <GET ,P-OTBL ,P-VERBN>>
	       <COND (<EQUAL? .TMP 0>
		      <TELL "tell">)
		     (<ZERO? <GETB ,P-VTBL 2>>
		      <PRINTB <GET .TMP 0>>)
		     (T
		      <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		      <PUTB ,P-VTBL 2 0>)>
	       <COND (.DRIVE2
		      <TELL " ">
		      <THING-PRINT T T>)>
	       <SETG P-OFLAG T>
	       <PREP-PRINT <COND (.DRIVE1 <GETB .DRIVE1 ,P-SPREP1>)
				 (T <GETB .DRIVE2 ,P-SPREP2>)>>
	       <TELL "?" CR>
	       <RFALSE>)>>

<GLOBAL NOT-RECOGNIZED "That sentence isn't one I recognize.">


<ROUTINE ORPHAN (D1 D2 "AUX" (CNT -1))
	<COND (<NOT ,P-MERGED>
	       <PUT ,P-OCL1 ,P-MATCHLEN 0>
	       <PUT ,P-OCL2 ,P-MATCHLEN 0>)>
	<PUT ,P-OVTBL 0 <GET ,P-VTBL 0>>
	<PUTB ,P-OVTBL 2 <GETB ,P-VTBL 2>>
	<PUTB ,P-OVTBL 3 <GETB ,P-VTBL 3>>
	<REPEAT ()
		<COND (<IGRTR? CNT ,P-ITBLLEN> <RETURN>)
		      (T <PUT ,P-OTBL .CNT <GET ,P-ITBL .CNT>>)>>
	<COND (<EQUAL? ,P-NCN 2>
	       <PUT ,P-CCTBL ,CC-BEG ,P-NC2>
	       <PUT ,P-CCTBL ,CC-END ,P-NC2L>
	       <PUT ,P-CCTBL ,CC-CLAUSE ,P-OCL2>
	       <PUT ,P-CCTBL ,CC-IBEG <>>
	       <PUT ,P-CCTBL ,CC-IEND <>>
	       <CLAUSE-COPY ,P-ITBL ,P-OTBL>)>
	<COND (<NOT <L? ,P-NCN 1>>
	       <PUT ,P-CCTBL ,CC-BEG ,P-NC1>
	       <PUT ,P-CCTBL ,CC-END ,P-NC1L>
	       <PUT ,P-CCTBL ,CC-CLAUSE ,P-OCL1>
	       <PUT ,P-CCTBL ,CC-IBEG <>>
	       <PUT ,P-CCTBL ,CC-IEND <>>
	       <CLAUSE-COPY ,P-ITBL ,P-OTBL>)>
	<COND (.D1
	       <PUT ,P-OTBL ,P-PREP1 <GETB .D1 ,P-SPREP1>>
	       <PUT ,P-OTBL ,P-NC1 1>)
	      (.D2
	       <PUT ,P-OTBL ,P-PREP2 <GETB .D2 ,P-SPREP2>>
	       <PUT ,P-OTBL ,P-NC2 1>)>>

;<ROUTINE ORPHAN-VERB (WRD ACT)
	 <PUT ,P-VTBL 0 .WRD>
	 <PUT ,P-OTBL ,P-VERB .ACT>
	 <PUT ,P-OTBL ,P-VERBN ,P-VTBL>
	 <PUT ,P-OTBL ,P-PREP1 0>
	 <PUT ,P-OTBL ,P-PREP1N 0>
	 <PUT ,P-OTBL ,P-PREP2 0>
	 <PUT ,P-OTBL 5 0>
	 <PUT ,P-OTBL ,P-NC1 1>
	 <PUT ,P-OTBL ,P-NC1L 0>
	 <PUT ,P-OTBL ,P-NC2 0>
	 <PUT ,P-OTBL ,P-NC2L 0>
	 <SETG P-OFLAG T>>

<ROUTINE THING-PRINT (PRSO? "OPTIONAL" (THE? <>) "AUX" BEG END)
	 <COND (.PRSO?
		<SET BEG <GET ,P-ITBL ,P-NC1>>
		<SET END <GET ,P-ITBL ,P-NC1L>>)
	       (ELSE
		<SET BEG <GET ,P-ITBL ,P-NC2>>
		<SET END <GET ,P-ITBL ,P-NC2L>>)>
	 <BUFFER-PRINT .BEG .END .THE?>>

<ROUTINE BUFFER-PRINT (BEG END CP "AUX" (NOSP T) WRD (1ST? T) (PN <>) (Q? <>))
	 <REPEAT ()
		<COND (<EQUAL? .BEG .END> <RETURN>)
		      (T
		       <SET WRD <GET .BEG 0>>
		       <COND (<EQUAL? .WRD ,W?COMMA>
			      <TELL ", ">)
			     (.NOSP <SET NOSP <>>)
			     (ELSE <TELL " ">)>
		       <COND (<EQUAL? .WRD ,W?PERIOD ,W?COMMA>
			      <SET NOSP T>)
			     (<EQUAL? .WRD ,W?ME>
			      <PRINTD ,ME>
			      <SET PN T>)
			     (<EQUAL? .WRD ,W?INTNUM>
			      <PRINTN ,P-NUMBER>
			      <SET PN T>)
			     (T
			      <COND (<AND .1ST? <NOT .PN> .CP>
				     <TELL "the ">)>
			      <COND (<OR ,P-OFLAG ,P-MERGED>
				     <PRINTB .WRD>)
				    (<AND <EQUAL? .WRD ,W?IT>
					  <ACCESSIBLE? ,P-IT-OBJECT>>
				     <PRINTD ,P-IT-OBJECT>)
				    (<AND <EQUAL? .WRD ,W?HIM>
					  <ACCESSIBLE? ,P-HIM-OBJECT>>
				     <PRINTD ,P-HIM-OBJECT>)
				    (T
				     <WORD-PRINT <GETB .BEG 2>
						 <GETB .BEG 3>>)>
			      <SET 1ST? <>>)>)>
		<SET BEG <REST .BEG ,P-WORDLEN>>>>

;<ROUTINE PRINTW (WRD "AUX" TBL)
	 <COND (<SET TBL <ZMEMQ .WRD ,LONG-WORD-TABLE>>
		<TELL <GET .TBL 1>>)
	       (ELSE <PRINTB .WRD>)>>

;<ROUTINE CAPITALIZE (PTR)
	 <COND (<OR ,P-OFLAG ,P-MERGED>
		<PRINTW <GET .PTR 0>>)
	       (T
		<PRINTC <- <GETB ,P-INBUF <GETB .PTR 3>> 32>>
		<WORD-PRINT <- <GETB .PTR 2> 1> <+ <GETB .PTR 3> 1>>)>>

<ROUTINE PREP-PRINT (PREP "AUX" WRD)
	<COND (<NOT <ZERO? .PREP>>
	       <TELL " ">
	       <COND (<EQUAL? .PREP ,PR?THROUGH>
		      <TELL "through">)
		     (T
		      <SET WRD <PREP-TO-WORD .PREP>>
		      <PRINTB .WRD>)>)>>


"CLAUSE-COPY"

<GLOBAL P-CCTBL <TABLE 0 0 0 0 0>>

;"pointers used by CLAUSE-COPY (source/destination beginning/end pointers)"
<CONSTANT CC-BEG 0>	;"slot in source to start from"
<CONSTANT CC-END 1>	;"slot in source to end at"
<CONSTANT CC-CLAUSE 2>	;"which orphan table to use"
<CONSTANT CC-IBEG 3>	;"insertion beginning (from lexv)"
<CONSTANT CC-IEND 4>	;"insertion ending"

"do something about duplicate words in clause?"

<ROUTINE CLAUSE-COPY (SRC DEST
		      "AUX" (IBEG <>) IEND OCL BEG END BB EE OBEG CNT B E)
	<SET BB <GET ,P-CCTBL ,CC-BEG>>
	<SET EE <GET ,P-CCTBL ,CC-END>>
	<SET OCL <GET ,P-CCTBL ,CC-CLAUSE>>
	<SET IBEG <GET ,P-CCTBL ,CC-IBEG>>
	<SET IEND <GET ,P-CCTBL ,CC-IEND>>
	<SET BEG <GET .SRC .BB>>
	<SET END <GET .SRC .EE>>
	<SET OBEG <GET .OCL ,P-MATCHLEN>>
	<REPEAT ()
		<COND (<EQUAL? .BEG .END>
		       <COND (<AND .IBEG <NOT ,P-ANAM>>
			      <CLAUSE-SUBSTRUC .IBEG .IEND>)>
		       <RETURN>)>
		<COND (<AND .IBEG
			    <EQUAL? ,P-ANAM <GET .BEG 0>>>
		       <CLAUSE-SUBSTRUC .IBEG .IEND>)>
		<CLAUSE-ADD <GET .BEG 0>>
		<SET BEG <REST .BEG ,P-WORDLEN>>>
	<COND (<AND <G? .OBEG 0>
		    <G? <SET CNT <- <GET .OCL ,P-MATCHLEN> .OBEG>> 0>>
	       <PUT .OCL ,P-MATCHLEN 0>
	       <SET OBEG <+ .OBEG 1>>
	       <REPEAT ()
		       <CLAUSE-ADD <GET .OCL .OBEG> T>
		       <COND (<ZERO? <SET CNT <- .CNT 2>>>
			      <RETURN>)>
		       <SET OBEG <+ .OBEG 2>>>
	       <SET OBEG 0>)>
	<PUT .DEST
	     .BB
	     <REST .OCL <+ <* .OBEG ,P-LEXELEN> 2>>>
	<PUT .DEST
	     .EE
	     <REST .OCL
		   <+ <* <GET .OCL ,P-MATCHLEN> ,P-LEXELEN> 2>>>>

<ROUTINE CLAUSE-SUBSTRUC (B E)
	 <REPEAT ()
		 <COND (<EQUAL? .B .E> <RETURN>)>
		 <CLAUSE-ADD <GET .B 0>>
		 <SET B <REST .B ,P-WORDLEN>>>>

<ROUTINE CLAUSE-ADD (WRD "OPT" (CHECK? <>) "AUX" OCL PTR)
	<SET OCL <GET ,P-CCTBL ,CC-CLAUSE>>
	<SET PTR <GET .OCL ,P-MATCHLEN>>
	<COND (<AND .CHECK? <NOT <ZERO? .PTR>> <ZMEMQ .WRD .OCL>>
	       <RFALSE>)
	      (ELSE
	       <SET PTR <+ .PTR 2>>
	       <PUT .OCL <- .PTR 1> .WRD>
	       <PUT .OCL .PTR 0>
	       <PUT .OCL ,P-MATCHLEN .PTR>)>>



<ROUTINE PREP-TO-WORD (PREP "AUX" (CNT 2) SIZE)
	 <SET SIZE <GET ,PREPOSITIONS 0>>
	 <REPEAT ()
		 <COND (<DLESS? SIZE 0> <RFALSE>)
		       (<EQUAL? <GET ,PREPOSITIONS .CNT> .PREP>
			<RETURN <GET ,PREPOSITIONS <- .CNT 1>>>)
		       (ELSE
			<SET CNT <+ .CNT 2>>)>>>

<ROUTINE SYNTAX-FOUND (SYN)
	<SETG P-SYNTAX .SYN>
	<SETG PRSA <GETB .SYN ,P-SACTION>>>

<GLOBAL P-GWIMBIT 0>

<ROUTINE GWIM (GBIT LBIT PREP "AUX" OBJ)
	<COND (<EQUAL? .GBIT ,RLANDBIT>
	       <RETURN ,ROOMS>)>
	<SETG P-GWIMBIT .GBIT>
	<SETG P-SLOCBITS .LBIT>
	<PUT ,P-MERGE ,P-MATCHLEN 0>
	<COND (<GET-OBJECT ,P-MERGE <>>
	       <SETG P-GWIMBIT 0>
	       <COND (<EQUAL? <GET ,P-MERGE ,P-MATCHLEN> 1>
		      <SET OBJ <GET ,P-MERGE 1>>
		      <TELL "(">
		      <COND (<AND <NOT <ZERO? .PREP>>
				  <NOT ,P-END-ON-PREP>>
			     <PRINTB <SET PREP <PREP-TO-WORD .PREP>>>
			     <COND (<EQUAL? .PREP ,W?OUT>
				    <TELL " of">)>
			     <TELL " ">
			     <COND (<EQUAL? .OBJ ,HANDS>
				    <TELL D .OBJ>)
				   (ELSE
				    <TELL THE .OBJ>)>
			     <TELL ")" CR>)
			    (ELSE
			     <TELL D .OBJ ")" CR>)>
		      .OBJ)>)
	      (T <SETG P-GWIMBIT 0> <RFALSE>)>>

<ROUTINE SNARF-OBJECTS ("AUX" OPTR IPTR L)
	 <PUT ,P-BUTS ,P-MATCHLEN 0>
	 <COND (<NOT <EQUAL? <SET IPTR <GET ,P-ITBL ,P-NC2>> 0>>
		<SETG P-SLOCBITS <GETB ,P-SYNTAX ,P-SLOC2>>
		<OR <SNARFEM .IPTR <GET ,P-ITBL ,P-NC2L> ,P-PRSI> <RFALSE>>)>
	 <COND (<NOT <EQUAL? <SET OPTR <GET ,P-ITBL ,P-NC1>> 0>>
		<SETG P-SLOCBITS <GETB ,P-SYNTAX ,P-SLOC1>>
		<OR <SNARFEM .OPTR <GET ,P-ITBL ,P-NC1L> ,P-PRSO> <RFALSE>>)>
	 <COND (<NOT <ZERO? <GET ,P-BUTS ,P-MATCHLEN>>>
		<SET L <GET ,P-PRSO ,P-MATCHLEN>>
		<COND (.OPTR <SETG P-PRSO <BUT-MERGE ,P-PRSO>>)>
		<COND (<AND .IPTR
			    <OR <NOT .OPTR>
				<EQUAL? .L <GET ,P-PRSO ,P-MATCHLEN>>>>
		       <SETG P-PRSI <BUT-MERGE ,P-PRSI>>)>)>
	 <RTRUE>>

%<DEBUG-CODE
  <ROUTINE TELL-LIST (TBL NUM "AUX" (CNT 1))
	   <COND (<ZERO? .NUM> <TELL "<>">)
		 (ELSE
		  <REPEAT ()
			  <PRINTD <GET .TBL .CNT>>
			  <SET CNT <+ .CNT 1>>
			  <COND (<G? .CNT .NUM> <RETURN>)>
			  <PRINTI ", ">>)>>>


<ROUTINE BUT-MERGE (TBL "AUX" LEN BUTLEN (CNT 1) (MATCHES 0) OBJ NTBL)
	<SET LEN <GET .TBL ,P-MATCHLEN>>
	<PUT ,P-MERGE ,P-MATCHLEN 0>
	<REPEAT ()
		<COND (<DLESS? LEN 0> <RETURN>)
		      (<ZMEMQ <SET OBJ <GET .TBL .CNT>> ,P-BUTS>)
		      (T
		       <PUT ,P-MERGE <+ .MATCHES 1> .OBJ>
		       <SET MATCHES <+ .MATCHES 1>>)>
		<SET CNT <+ .CNT 1>>>
	<PUT ,P-MERGE ,P-MATCHLEN .MATCHES>
	<SET NTBL ,P-MERGE>
	<SETG P-MERGE .TBL>
	.NTBL>

"ADJ/NOUN COMBINATION"

<GLOBAL P-NAM <>>
<GLOBAL P-ADJT <ITABLE 5 0>>
<GLOBAL P-ADJNT <ITABLE 5 0>>

"AMBIGUOUS ADJ/NOUN COMBINATION"

<GLOBAL P-ANAM <>>
;<GLOBAL P-AADJNT <ITABLE 5 0>>

"PSEUDO-OBJECT ADJ-NOUN COMBINATION"

<GLOBAL P-PNAM <>>
;<GLOBAL P-PADJNT <ITABLE 5 0>>

<GLOBAL P-ADVERB <>>

<GLOBAL P-PRSO <ITABLE 80 <>>>

<GLOBAL P-PRSI <ITABLE 80 <>>>

<GLOBAL P-BUTS <ITABLE 80 <>>>

<GLOBAL P-MERGE <ITABLE 80 <>>>

<GLOBAL P-OCL1 <ITABLE NONE 40>>
<GLOBAL P-OCL2 <ITABLE NONE 40>>

<GLOBAL P-MATCHLEN 0>

<GLOBAL P-GETFLAGS 0>

<CONSTANT P-ALL 1>

<CONSTANT P-ONE 2>

<CONSTANT P-INHIBIT 4>


<ROUTINE SNARFEM (PTR EPTR TBL "AUX" (BUT <>) LEN WV WRD NW (WAS-ALL <>))
   <SETG P-AND <>>
   <COND (<EQUAL? ,P-GETFLAGS ,P-ALL>
	  <SET WAS-ALL T>)>
   <SETG P-GETFLAGS 0>
   <PUT .TBL ,P-MATCHLEN 0>
   <SET WRD <GET .PTR 0>>
   <REPEAT ()
	   <COND (<EQUAL? .PTR .EPTR>
		  <SET WV <GET-OBJECT <OR .BUT .TBL>>>
		  <COND (.WAS-ALL <SETG P-GETFLAGS ,P-ALL>)>
		  <RETURN .WV>)
		 (T
		  <COND (<==? .EPTR <REST .PTR ,P-WORDLEN>>
			 <SET NW 0>)
			(T <SET NW <GET .PTR ,P-LEXELEN>>)>
		  <COND (<EQUAL? .WRD ,W?ALL ,W?BOTH>
			 <SETG P-GETFLAGS ,P-ALL>
			 <COND (<EQUAL? .NW ,W?OF>
				<SET PTR <REST .PTR ,P-WORDLEN>>)>)
			(<EQUAL? .WRD ,W?BUT ,W?EXCEPT>
			 <OR <GET-OBJECT <OR .BUT .TBL>> <RFALSE>>
			 <SET BUT ,P-BUTS>
			 <PUT .BUT ,P-MATCHLEN 0>)
			(<EQUAL? .WRD ,W?A ,W?ONE>
			 <COND (<ZERO? <GET ,P-ADJT 0>> ;<NOT ,P-ADJ>
				<SETG P-GETFLAGS ,P-ONE>
				<COND (<EQUAL? .NW ,W?OF>
				       <SET PTR <REST .PTR ,P-WORDLEN>>)>)
			       (T
				<SETG P-NAM ,P-ONEOBJ>
				<OR <GET-OBJECT <OR .BUT .TBL>> <RFALSE>>
				<AND <ZERO? .NW> <RTRUE>>)>)
			(<AND <EQUAL? .WRD ,W?AND ,W?COMMA>
			      <NOT <EQUAL? .NW ,W?AND ,W?COMMA>>>
			 <SETG P-AND T>
			 <OR <GET-OBJECT <OR .BUT .TBL>> <RFALSE>>
			 T)
			(<NOT <ZERO? <WT? .WRD ,PS?BUZZ-WORD>>>)
			(<EQUAL? .WRD ,W?AND ,W?COMMA>)
			(<EQUAL? .WRD ,W?OF>
			 <COND (<ZERO? ,P-GETFLAGS>
				<SETG P-GETFLAGS ,P-INHIBIT>)>)
			(<NOT <ZERO?
			       <SET WV
				    <WT? .WRD
					 ,PS?ADJECTIVE ,P1?ADJECTIVE>>>>
			 <NEW-ADJ .WV .WRD>)
			(<WT? .WRD ,PS?OBJECT ,P1?OBJECT>
			 <SETG P-NAM .WRD>
			 <SETG P-ONEOBJ .WRD>)>)>
	   <COND (<NOT <EQUAL? .PTR .EPTR>>
		  <SET PTR <REST .PTR ,P-WORDLEN>>
		  <SET WRD .NW>)>>>

"add an adjective value and name to the adjective table"

<ROUTINE NEW-ADJ ("OPT" (WV <>) (WRD <>) "AUX" N)
	 <COND (<NOT .WV>
		<SETG P-NAM <>>
		<PUT ,P-ADJT 0 0>
		<PUT ,P-ADJNT 0 0>)
	       (ELSE
		<SET N <GET ,P-ADJT 0>>
		<COND (<L? .N 4> <SET N <+ .N 1>>)>
		<PUT ,P-ADJT 0 .N>
		<PUT ,P-ADJT .N .WV>
		<PUT ,P-ADJNT 0 .N>
		<PUT ,P-ADJNT .N .WRD>)>>

<ROUTINE COPY-ADJ (SRC DST "AUX" N)
	 <SET N <GET .SRC 0>>
	 <REPEAT ()
		 <PUT .DST .N <GET .SRC .N>>
		 <COND (<L? <SET N <- .N 1>> 0>
			<RTRUE>)>>>

"magic bits for syntaxes"

<CONSTANT SH 128>	;"HELD"
<CONSTANT SC 64>	;"CARRIED"
<CONSTANT SIR 32>	;"IN-ROOM"
<CONSTANT SOG 16>	;"ON-GROUND"
<CONSTANT STAKE 8>	;"TAKE"
<CONSTANT SMANY 4>	;"MANY"
<CONSTANT SHAVE 2>	;"HAVE"

<GLOBAL NOUN-MISSING "There seems to be a noun missing in that sentence.">

<ROUTINE SEARCH-CONTENTS? (OBJ)
	 <COND (<FSET? .OBJ ,INVISIBLE> <RFALSE>)
	       (<AND <FSET? .OBJ ,SEARCHBIT>
		     <OR <FSET? .OBJ ,OPENBIT>
			 <FSET? .OBJ ,TRANSBIT>>>
		<RTRUE>)
	       (<FSET? .OBJ ,SURFACEBIT>
		<RTRUE>)>>

<ROUTINE GET-OBJECT (TBL "OPTIONAL" (VRB T)
		     "AUX" GEN BITS LEN XBITS TLEN (GCHECK <>) (OLEN 0) OBJ)
	 <SET XBITS ,P-SLOCBITS>
	 <SET TLEN <GET .TBL ,P-MATCHLEN>>
	 <COND (<BTST ,P-GETFLAGS ,P-INHIBIT> <RTRUE>)>
	 <COND (<AND <NOT ,P-NAM>
		     <NOT <ZERO? <SET LEN <GET ,P-ADJNT 0>>>>>
		<COND (<NOT <ZERO? <WT? <GET ,P-ADJNT .LEN>
					,PS?OBJECT ,P1?OBJECT>>>
		       <SETG P-NAM <GET ,P-ADJNT <GET ,P-ADJNT 0>>>
		       <PUT ,P-ADJT 0 <- .LEN 1>>
		       <PUT ,P-ADJNT 0 <- .LEN 1>>)
		      (<AND <EQUAL? .LEN 1>
			    <SET BITS
				 <WT? <GET ,P-ADJNT 1>
				      ,PS?DIRECTION
				      ,P1?DIRECTION>>>
		       <PUT ,P-ADJT 0 0>
		       <PUT ,P-ADJNT 0 0>
		       <PUT .TBL ,P-MATCHLEN 1>
		       <PUT .TBL 1 ,INTDIR>
		       <SETG P-DIRECTION .BITS>
		       <RTRUE>)>)>
	 <COND (<AND <NOT ,P-NAM>
		     <ZERO? <GET ,P-ADJT 0>>
		     <NOT <EQUAL? ,P-GETFLAGS ,P-ALL>>
		     <ZERO? ,P-GWIMBIT>>
		<COND (.VRB
		       <TELL ,NOUN-MISSING CR>)>
		<RFALSE>)>
	 <COND (<OR <NOT <EQUAL? ,P-GETFLAGS ,P-ALL>> <ZERO? ,P-SLOCBITS>>
		<SETG P-SLOCBITS -1>)>
	 <SETG P-TABLE .TBL>
	 <PROG ()
	       <COND (.GCHECK <GLOBAL-CHECK .TBL>)
		     (T
		      <COND (,LIT
			     <DO-SL ,HERE ,SOG ,SIR>
			     <COND (<AND <FSET? <LOC ,PLAYER> ,VEHBIT>
					 <NOT <SEARCH-CONTENTS?
					        <LOC ,PLAYER>>>>
				    <DO-SL <LOC ,PLAYER> ,SOG ,SIR>)>)>
		      <DO-SL ,PLAYER ,SH ,SC>)>
	       <SET LEN <- <GET .TBL ,P-MATCHLEN> .TLEN>>
	       <COND (<BTST ,P-GETFLAGS ,P-ALL> ;<AND * <NOT <EQUAL? .LEN 0>>>)
		     (<AND <BTST ,P-GETFLAGS ,P-ONE>
			   <NOT <ZERO? .LEN>>>
		      <COND (<NOT <EQUAL? .LEN 1>>
			     <PUT .TBL 1 <GET .TBL <RANDOM .LEN>>>
			     <TELL "(How about " THE <GET .TBL 1> "?)" CR>)>
		      <PUT .TBL ,P-MATCHLEN 1>)
		     (<OR <G? .LEN 1>
			  <AND <ZERO? .LEN> <NOT <EQUAL? ,P-SLOCBITS -1>>>>
		      <COND (<EQUAL? ,P-SLOCBITS -1>
			     <SETG P-SLOCBITS .XBITS>
			     <SET OLEN .LEN>
			     <PUT .TBL
				  ,P-MATCHLEN
				  <- <GET .TBL ,P-MATCHLEN> .LEN>>
			     <AGAIN>)
			    (T
			     <COND (<ZERO? .LEN> <SET LEN .OLEN>)>
			     <COND (<AND <G? .LEN 1>
					 <SET GEN <GENERIC? .TBL .LEN>>>
				    <PUT .TBL
					 ,P-MATCHLEN
					 <SET LEN <+ .TLEN 1>>>
				    <PUT .TBL .LEN .GEN>
				    <SETUP-XADJ>
				    <RTRUE>)
			      	   (<AND .VRB ;".VRB added 8/14/84 by JW"
					 <NOT <EQUAL? ,WINNER ,PLAYER>>>
				    <WHICH-PRINT .TLEN .LEN .TBL>)
				   (<AND .VRB
					 <OR ,P-NAM
					     <NOT <ZERO? <GET ,P-ADJT 0>>>>>
				    <WHICH-PRINT .TLEN .LEN .TBL>
				    <SETG P-ACLAUSE
					  <COND (<EQUAL? .TBL ,P-PRSO> ,P-NC1)
						(T ,P-NC2)>>
				    ;<COPY-ADJ ,P-ADJNT ,P-AADJNT>
				    	;<SETG P-AADJ ,P-ADJ>
				    <SETG P-ANAM ,P-NAM>
				    <ORPHAN <> <>>
				    <SETG P-OFLAG T>)
				   (.VRB
				    <TELL ,NOUN-MISSING CR>)>
			     <NEW-ADJ>
			     <RFALSE>)>)>
	       <COND (<AND <ZERO? .LEN> .GCHECK>
		      <COND (.VRB
			     <SETG P-SLOCBITS .XBITS>
			     <COND (<OR ,LIT
					<AND <EQUAL? .TBL ,P-PRSO>
					     <VERB? TELL WHERE WHAT WHO
						    FOLLOW WAIT-FOR>>
					<AND <EQUAL? .TBL ,P-PRSI>
					     <VERB? ASK-ABOUT ASK-FOR
						    TELL-ABOUT>>>
				    ;"Changed 6/10/83 - MARC"
				    <OBJ-FOUND ,NOT-HERE-OBJECT .TBL>
				    <SETUP-XADJ>
				    <RTRUE>)
				   (T
				    <TELL ,TOO-DARK>)>)>
		      <NEW-ADJ>
		      <RFALSE>)
		     (<ZERO? .LEN> <SET GCHECK T> <AGAIN>)>
	       <SETG P-SLOCBITS .XBITS>
	       <NEW-ADJ>
	       <RTRUE>>>

<ROUTINE SETUP-XADJ ()
	 <SETG P-XNAM ,P-NAM>
	 <COPY-ADJ ,P-ADJT ,P-XADJT>
	 <COPY-ADJ ,P-ADJNT ,P-XADJNT>
	 <NEW-ADJ>>

<ROUTINE MOBY-FIND (TBL "AUX" FOO LEN GEN)
	 <SETG P-MOBY-FLAG T>
	 <SETG P-SLOCBITS -1>
	 <SETG P-TABLE .TBL>
	 <SETG P-NAM ,P-XNAM>
	 <COPY-ADJ ,P-XADJT ,P-ADJT> ;<SETG P-ADJ ,P-XADJ>
	 <PUT .TBL ,P-MATCHLEN 0>
	 <SET FOO <FIRST? ,ROOMS>>
	 <REPEAT ()
		 <COND (<NOT .FOO> <RETURN>)
		       (T
			<SEARCH-LIST .FOO .TBL ,P-SRCALL>
			<SET FOO <NEXT? .FOO>>)>>
	 <DO-SL ,LOCAL-GLOBALS 1 1>
	 <SEARCH-LIST ,ROOMS .TBL ,P-SRCTOP>
	 <COND (<EQUAL? <SET LEN <GET .TBL ,P-MATCHLEN>> 1>
		<SETG P-MOBY-FOUND <GET .TBL 1>>)
	       (<AND <G? .LEN 1>
		     <SET GEN <GENERIC? .TBL .LEN>>>
		<SET LEN 1>
		<SETG P-MOBY-FOUND .GEN>)>
	 <SETG P-MOBY-FLAG <>>
	 <NEW-ADJ>
	 .LEN>

<GLOBAL P-MOBY-FOUND <>>
<GLOBAL P-MOBY-FLAG <>>

<GLOBAL P-XNAM <>>
<GLOBAL P-XADJT <ITABLE 5 0>>
<GLOBAL P-XADJNT <ITABLE 5 0>>

<ROUTINE GENERIC? (TBL LEN "AUX" (GEN <>) G (N 0))
	 <COND (<G? .LEN 1>
		<REPEAT ()
			<COND (<G? <SET N <+ .N 1>> .LEN>
			       <RETURN <APPLY .GEN>>)
			      (ELSE
			       <SET G <GETP <GET .TBL .N> ,P?GENERIC>>
			       <COND (<NOT .GEN> <SET GEN .G>)
				     (<NOT <EQUAL? .GEN .G>>
				      <RFALSE>)>)>>)>>

<ROUTINE WHICH-PRINT (TLEN LEN TBL "AUX" OBJ RLEN)
	 <COND (<ZERO? .LEN>
		<TELL ,REFERRING CR>
		<RTRUE>)>
	 <SET RLEN .LEN>
	 <COND (<NOT <==? ,WINNER ,PLAYER>>
	        <TELL "\"I don't understand if you mean ">)
	       (T
		<TELL "Which ">
		<COND (<OR ,P-OFLAG ,P-MERGED ,P-AND>
		       <COND (<PRINT-ADJT ,P-ADJNT>
			      <COND (,P-NAM <TELL " "> <PRINTB ,P-NAM>)>)
			     (,P-NAM <PRINTB ,P-NAM>)
			     (ELSE <PRINTB ,W?ONE>)>)
		      (ELSE
		       <THING-PRINT <EQUAL? .TBL ,P-PRSO>>)>
		<TELL " do you mean, ">)>
	 <REPEAT ()
		 <SET TLEN <+ .TLEN 1>>
		 <SET OBJ <GET .TBL .TLEN>>
		 <COND (<EQUAL? .OBJ ,FLOOR-BUTTON>
			<TELL "the 1 button, the 2 button, the 3 button">)
		       (ELSE
			<TELL THE .OBJ>)>
		 <COND (<EQUAL? .LEN 2>
			<COND (<NOT <EQUAL? .RLEN 2>>
			       <TELL ",">)>
			<TELL " or ">)
		       (<G? .LEN 2>
			<TELL ", ">)>
		 <COND (<L? <SET LEN <- .LEN 1>> 1>
			<RETURN>)>>
	 <COND (<NOT <==? ,WINNER ,PLAYER>>
		<TELL ".\"" CR>)
	       (T
		<TELL "?" CR>)>>

<ROUTINE PRINT-ADJT (TBL "AUX" N (CNT 0))
	 <COND (<NOT <ZERO? <SET N <GET .TBL 0>>>>
		<REPEAT ()
			<PRINTB <GET .TBL .N>>
			<COND (<ZERO? <SET N <- .N 1>>>
			       <RTRUE>)>
			<TELL " ">>)>>



<ROUTINE GLOBAL-CHECK (TBL "AUX" LEN RMG RMGL (CNT 0) OBJ OBITS FOO NOBJ)
	<SET LEN <GET .TBL ,P-MATCHLEN>>
	<SET OBITS ,P-SLOCBITS>
	<COND (<SET RMG <GETPT ,HERE ,P?GLOBAL>>
	       <SET RMGL <- <PTSIZE .RMG> 1>>
	       <REPEAT ()
		       <COND (<SET OBJ <GETB .RMG .CNT>>
			      <COND (<THIS-IT? .OBJ .TBL>
				     <OBJ-FOUND .OBJ .TBL>)>
			      <COND (<AND <SEARCH-CONTENTS? .OBJ>
					  <SET NOBJ <FIRST? .OBJ>>>
				     <SEARCH-LIST .OBJ .TBL ,P-SRCALL>)>)>
		       <COND (<IGRTR? CNT .RMGL> <RETURN>)>>)>
	<COND (<SET RMG <GETP ,HERE ,P?THINGS>>
	       <SET RMGL <GET .RMG 0>>
	       <SET CNT 0>
	       <REPEAT ()
		       <COND (<AND <EQUAL? ,P-NAM <GET .RMG <+ .CNT 2>>>
				   <OR <ZERO? <GET ,P-ADJT 0>>
				       <ZMEMQ <GET .RMG <+ .CNT 1>>
					      ,P-ADJNT> 
				       ;<EQUAL? ,P-ADJN
					       <GET .RMG <+ .CNT 2>>>>>
			      <SETG P-PNAM ,P-NAM>
			      ;<COND (<NOT <ZERO? <GET ,P-ADJT 0>>>
				     <COPY-ADJ ,P-ADJNT ,P-PADJNT>
				     	;<SETG P-PADJNT ,P-ADJNT>)
				    (ELSE
				     <PUT ,P-PADJNT 0 0>
				     	;<SETG P-PADJN <>>)>
			      <SETG LAST-PSEUDO-LOC ,HERE>
			      <PUTP ,PSEUDO-OBJECT
				    ,P?ACTION
				    ,RANDOM-PSEUDO ;<GET .RMG <+ .CNT 2>>>
			      <SET FOO
				   <BACK <GETPT ,PSEUDO-OBJECT ,P?ACTION> 5>>
			      <PUT .FOO 0 <GET ,P-NAM 0>>
			      <PUT .FOO 1 <GET ,P-NAM 1>>
			      <OBJ-FOUND ,PSEUDO-OBJECT .TBL>
			      <RETURN>)>
		       <SET CNT <+ .CNT 2>>
		       <COND (<NOT <L? .CNT .RMGL>> <RETURN>)>>)>
	<COND (<EQUAL? <GET .TBL ,P-MATCHLEN> .LEN>
	       <SETG P-SLOCBITS -1>
	       <SETG P-TABLE .TBL>
	       <DO-SL ,GLOBAL-OBJECTS 1 1>
	       <SETG P-SLOCBITS .OBITS>
	       ;<COND (<AND <ZERO? <GET .TBL ,P-MATCHLEN>>
			   <EQUAL? ,PRSA ,V?LOOK-INSIDE ,V?SEARCH ,V?EXAMINE>>
		      <DO-SL ,ROOMS 1 1>)>)>>

<GLOBAL P-TABLE <>>	;"DO-SL outputs stuff to this table"

<CONSTANT P-SRCBOT 2>
<CONSTANT P-SRCALL 1>
<CONSTANT P-SRCTOP 0>

<ROUTINE DO-SL (OBJ BIT1 BIT2 "AUX" BTS)
	<COND (<BTST ,P-SLOCBITS <+ .BIT1 .BIT2>>
	       <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCALL>)
	      (T
	       <COND (<BTST ,P-SLOCBITS .BIT1>
		      <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCTOP>)
		     (<BTST ,P-SLOCBITS .BIT2>
		      <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCBOT>)
		     (T <RTRUE>)>)>>

<ROUTINE SEARCH-LIST (OBJ TBL LVL "AUX" ROBJ)
	 <COND (<SET OBJ <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <NOT <EQUAL? .LVL ,P-SRCBOT>>
				    <GETPT .OBJ ,P?SYNONYM>
				    <THIS-IT? .OBJ .TBL>>
			       <OBJ-FOUND .OBJ .TBL>)>
			<COND (<EQUAL? .OBJ ,ELEVATOR-DOOR>
			       <SET ROBJ <DOOR-AT-ELEVATOR>>)
			      (ELSE
			       <SET ROBJ .OBJ>)>
			<COND (<AND <FIRST? .ROBJ>
				    <SEARCH-CONTENTS? .ROBJ>
				    <OR <NOT <EQUAL? .LVL ,P-SRCTOP>>
					,P-MOBY-FLAG>>
			       <SEARCH-LIST
				.ROBJ
				.TBL
				<COND (<OR ,P-MOBY-FLAG
					   <FSET? .ROBJ ,SURFACEBIT>
					   <FSET? .ROBJ ,SEARCHBIT>>
				       ,P-SRCALL)
				      (T ,P-SRCTOP)>>)>
			<COND (<NOT <SET OBJ <NEXT? .OBJ>>>
			       <RETURN>)>>)>>

<GLOBAL P-NAMW <TABLE 0 0>>	;"table of actual noun used by player"
<GLOBAL P-ADJW <TABLE 0 0>>	;"table of actual adj used by player"

<ROUTINE OBJ-FOUND (OBJ TBL "AUX" PTR)
	<COND (<EQUAL? .TBL ,P-PRSO>
	       <PUT ,P-NAMW 0 ,P-NAM>
	       <PUT ,P-ADJW 0 <GET ,P-ADJNT 1>>)
	      (<EQUAL? .TBL ,P-PRSI>
	       <PUT ,P-NAMW 1 ,P-NAM>
	       <PUT ,P-ADJW 1 <GET ,P-ADJNT 1>>)>
	<SET PTR <GET .TBL ,P-MATCHLEN>>
	<PUT .TBL <+ .PTR 1> .OBJ>
	<PUT .TBL ,P-MATCHLEN <+ .PTR 1>>>

<ROUTINE TAKE-CHECK ()
	<AND <ITAKE-CHECK ,P-PRSO <GETB ,P-SYNTAX ,P-SLOC1>>
	     <ITAKE-CHECK ,P-PRSI <GETB ,P-SYNTAX ,P-SLOC2>>>>

<ROUTINE ITAKE-CHECK (TBL IBITS "AUX" PTR OBJ TAKEN)
   <COND (<AND <SET PTR <GET .TBL ,P-MATCHLEN>>
	       <OR <BTST .IBITS ,SHAVE>
	           <BTST .IBITS ,STAKE>>>
	  <REPEAT ()
	    <COND (<L? <SET PTR <- .PTR 1>> 0>
		   <RETURN>)
		  (T
		   <SET OBJ <GET .TBL <+ .PTR 1>>>
		   <COND (<EQUAL? .OBJ ,IT>
			  <COND (<NOT ,P-IT-OBJECT>
				 <TELL ,REFERRING CR>)
				(<NOT <ACCESSIBLE? ,P-IT-OBJECT>>
				 <TELL
"I don't see " THE ,P-IT-OBJECT " here." CR>
				 <RFALSE>)
				(T
				 <SET OBJ ,P-IT-OBJECT>)>)
			 (<EQUAL? .OBJ ,HIM>
			  <COND (<NOT ,P-HIM-OBJECT>
				 <TELL ,REFERRING CR>)
				(<NOT <ACCESSIBLE? ,P-HIM-OBJECT>>
				 <TELL
"I don't see " THE ,P-HIM-OBJECT " here." CR>
				 <RFALSE>)
				(T
				 <SET OBJ ,P-HIM-OBJECT>)>)>
		   <COND (<OR <HELD? .OBJ ,WINNER>
			      <INTRINSIC? .OBJ>
			      <IN? ,WINNER .OBJ>>
			  T)
			 (T
			  <SETG PRSO .OBJ>
			  <SET TAKEN T>
			  <COND (<FSET? .OBJ ,TRYTAKEBIT>
				 <SET TAKEN <>>)
				(<NOT <EQUAL? ,WINNER ,PLAYER>>)
				(<AND <BTST .IBITS ,STAKE>
				      <EQUAL? <ITAKE <>> T>>)
				(T
				 <SET TAKEN <>>)>
			  <COND (<AND <NOT .TAKEN> <BTST .IBITS ,SHAVE>>
				 <COND (<L? 1 <GET .TBL ,P-MATCHLEN>>
				        <TELL
,YOU-ARENT "holding all those things!" CR>
					<RFALSE>)
				       (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
					<TELL ,YOU-CANT-SEE "that here!" CR>
					<RFALSE>)
				       (<EQUAL? ,WINNER ,PLAYER>
					<TELL ,YOU-ARENT>)
				       (T
					<TELL S "It doesn't look like ">
					<TELL THE ,WINNER " is ">)>
				 <TELL "holding ">
				 <COND (<EQUAL? .OBJ ,PSEUDO-OBJECT>
					<TELL "that">)
				       (ELSE
					<TELL THE .OBJ>)>
				 <THIS-IS-IT .OBJ>
				 <TELL ,PERIOD>
				 <RFALSE>)
				(<AND .TAKEN
				      <EQUAL? ,WINNER ,PLAYER>
				      <NOT <PRSO? ,INTNUM>>>
				 <TAKING-FIRST .OBJ>)>)>)>>)
	       (T)>>

<ROUTINE TAKING-FIRST (OBJ)
	 <TELL
"(Taking " THE .OBJ " first)" CR>>

<ROUTINE MANY-CHECK ("AUX" (LOSS <>) TMP)
	<COND (<AND <G? <GET ,P-PRSO ,P-MATCHLEN> 1>
		    <NOT <BTST <GETB ,P-SYNTAX ,P-SLOC1> ,SMANY>>>
	       <SET LOSS 1>)
	      (<AND <G? <GET ,P-PRSI ,P-MATCHLEN> 1>
		    <NOT <BTST <GETB ,P-SYNTAX ,P-SLOC2> ,SMANY>>>
	       <SET LOSS 2>)>
	<COND (.LOSS
	       <TELL ,YOU-CANT "use multiple ">
	       <COND (<EQUAL? .LOSS 2>
		      <TELL "in">)>
	       <TELL "direct objects with \"">
	       <SET TMP <GET ,P-ITBL ,P-VERBN>>
	       <COND (<ZERO? .TMP>
		      <TELL "tell">)
		     (<OR ,P-OFLAG ,P-MERGED>
		      <PRINTB <GET .TMP 0>>)
		     (T
		      <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>
	       <TELL "\"." CR>
	       <RFALSE>)
	      (T)>>

<ROUTINE ZMEMQ (ITM TBL "OPTIONAL" (SIZE -1) "AUX" (CNT 1))
	<COND (<NOT .TBL> <RFALSE>)>
	<COND (<NOT <L? .SIZE 0>> <SET CNT 0>)
	      (ELSE <SET SIZE <GET .TBL 0>>)>
	<REPEAT ()
		<COND (<EQUAL? .ITM <GET .TBL .CNT>>
		       <RETURN <REST .TBL <* .CNT 2>>>)
		      (<IGRTR? CNT .SIZE> <RFALSE>)>>>

<ROUTINE ZMEMQB (ITM TBL SIZE "AUX" (CNT 0))
	<REPEAT ()
		<COND (<EQUAL? .ITM <GETB .TBL .CNT>>
		       <RTRUE>)
		      (<IGRTR? CNT .SIZE>
		       <RFALSE>)>>>

<ROUTINE LIT? (RM "OPTIONAL" (RMBIT T) "AUX" OHERE (LIT <>))
	 <SETG P-GWIMBIT ,ONBIT>
	 <SET OHERE ,HERE>
	 <SETG HERE .RM>
	 <COND (<AND .RMBIT
		     <FSET? .RM ,ONBIT>>
		<SET LIT ,HERE>)
	       (<AND <HERE? ,ELEVATOR-PIT>
		     <OR <FSET? ,ELEVATOR-DOOR-B ,OPENBIT>
			 <FSET? ,ELEVATOR-DOOR-1 ,OPENBIT>>>
		<SET LIT ,CS-BASEMENT>)
	       (<AND <HERE? ,UNDER-ALCHEMY-LAB>
		     <FSET? ,ALCHEMY-TRAP-DOOR ,OPENBIT>
		     <FSET? ,ALCHEMY-LAB ,ONBIT>>
		<SET LIT ,ALCHEMY-LAB>)
	       (<AND <FSET? ,WINNER ,ONBIT>
		     <HELD? ,WINNER .RM>>
		<SET LIT ,WINNER>)
	       (T
		<PUT ,P-MERGE ,P-MATCHLEN 0>
		<SETG P-TABLE ,P-MERGE>
		<SETG P-SLOCBITS -1>
		<COND (<EQUAL? .OHERE .RM>
		       <DO-SL ,WINNER 1 1>
		       <COND (<AND <NOT <EQUAL? ,WINNER ,PLAYER>>
				   <IN? ,PLAYER .RM>>
			      <DO-SL ,PLAYER 1 1>)>)>
		<COND (<AND <FSET? <LOC ,WINNER> ,VEHBIT>
			    <NOT <FSET? <LOC ,WINNER> ,OPENBIT>>>
		       <DO-SL <LOC ,WINNER> 1 1>)>
		<DO-SL .RM 1 1>
		<COND (<G? <GET ,P-TABLE ,P-MATCHLEN> 0>
		       <SET LIT <GET ,P-TABLE 1>>)>)>
	 <SETG HERE .OHERE>
	 <SETG P-GWIMBIT 0>
	 .LIT>

;"former CRUFTY.ZIL routine"

<ROUTINE THIS-IT? (OBJ TBL "AUX" SYNS ACNT)
	 <COND (<FSET? .OBJ ,INVISIBLE> <RFALSE>)
	       (<AND ,P-NAM
		     <NOT <ZMEMQ ,P-NAM
				 <SET SYNS <GETPT .OBJ ,P?SYNONYM>>
				 <- </ <PTSIZE .SYNS> 2> 1>>>>
		<RFALSE>)
	       (<AND <NOT <ZERO? <SET ACNT <GET ,P-ADJT 0>>>>
		     <NOT <SET SYNS <GETPT .OBJ ,P?ADJECTIVE>>>>
		<RFALSE>)
	       (ELSE
		<COND (<NOT <ZERO? .ACNT>>
		       <REPEAT ()
			       <COND (<NOT <ZMEMQB <GET ,P-ADJT .ACNT>
						   .SYNS
						   <- <PTSIZE .SYNS> 1>>>
				      <RFALSE>)>
			       <COND (<ZERO? <SET ACNT <- .ACNT 1>>>
				      <RETURN>)>>)>
		<COND (<AND <NOT <ZERO? ,P-GWIMBIT>>
			    <NOT <FSET? .OBJ ,P-GWIMBIT>>>
		       <RFALSE>)>)>
	 <RTRUE>>

<ROUTINE END-QUOTE ()
	 <SETG QUOTE-FLAG <>>
	 <SETG P-CONT <>>
	 <RFATAL>>
