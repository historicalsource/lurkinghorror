"DESC for
			       Your Game
	(c) Copyright 1986 Infocom, Inc. All Rights Reserved."

"The fabled new describers, as updated and modified to conform to the
latest bug fixes.  See ZD:DESC.DOC for details.  See Z:DESC.ZIL for
the source."

<CONSTANT M-OBJDESC? 9>	;"modify if necessary for games with other M-..."

<GLOBAL DESCRIBED-ROOM? <>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <COND (<NOT ,LIT>
		<TELL "It is pitch black." CR>
		<RFALSE>)>
	 <COND (<IN? ,HERE ,ROOMS> <TELL 'HERE>)>
	 <SET AV <LOC ,WINNER>>
	 <COND (<FSET? .AV ,VEHBIT>
		<COND (<FSET? .AV ,SURFACEBIT>
		       <TELL ", on ">)
		      (ELSE
		       <TELL ", in ">)>
		<TELL THE .AV>)>
	 <CRLF>
	 <SET V? <OR .LOOK? <EQUAL? ,VERBOSITY 2>>>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<COND (,VERBOSITY <SET V? T>)>)>
	 <SETG DESCRIBED-ROOM? .V?>
	 <COND (.V?
		<COND (<AND <NOT <EQUAL? ,HERE .AV>>
			    <FSET? .AV ,VEHBIT>
			    <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>
		       <RTRUE>)
		      (<SET STR <GETP ,HERE ,P?LDESC>>
		       <TELL .STR CR>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("AUX" O STR (AV <LOC ,WINNER>) TMP)
	 <SET O <FIRST? ,HERE>>
	 <COND (<NOT .O> <RFALSE>)>
	 <REPEAT () ;"FDESCS and MISC."
		 <COND (<NOT .O> <RETURN>)
		       (<AND <DESCRIBABLE? .O>
			     <NOT <FSET? .O ,TOUCHBIT>>
			     <SET STR <GETP .O ,P?FDESC>>>
			<THIS-IS-IT .O>
			<CRLF>
			<TELL .STR>
			<COND (<FSET? .O ,CONTBIT>
			       <DESCRIBE-CONTENTS .O
						  T
						  <+ ,D-ALL?
						     ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <SET O <FIRST? ,HERE>>
	 <REPEAT () ;"DESCFCNS and LDESCS"
		 <COND (<NOT .O> <RETURN>)
		       (<OR <NOT <DESCRIBABLE? .O>>
			    <AND <GETP .O ,P?FDESC>
				 <NOT <FSET? .O ,TOUCHBIT>>>>
			T)
		       (<AND <SET STR <GETP .O ,P?DESCFCN>>
			     <SET TMP <APPLY .STR ,M-OBJDESC? .O>>>
			<COND (<NOT <EQUAL? .TMP ,M-FATAL>>
			       <THIS-IS-IT .O>
			       <CRLF>
			       <COND (<SET STR <APPLY .STR ,M-OBJDESC .O>>
				      <COND (<AND <FSET? .O ,CONTBIT>
						  <N==? .STR ,M-FATAL>>
					     <DESCRIBE-CONTENTS
					      .O
					      T
					      <+ ,D-ALL?
						 ,D-PARA?>>)>)>
			       <CRLF>)>)
		       (<SET STR <GETP .O ,P?LDESC>>
			<THIS-IS-IT .O>
			<CRLF>
			<TELL .STR>
			<COND (<FSET? .O ,CONTBIT>
			       <DESCRIBE-CONTENTS .O
						  T
						  <+ ,D-ALL?
						     ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <DESCRIBE-CONTENTS ,HERE <> <>>
	 <COND (<AND .AV <NOT <EQUAL? ,HERE .AV>>>
		<DESCRIBE-CONTENTS .AV <> <>>)>>

<CONSTANT D-ALL? 1>	;"print everything?"
<CONSTANT D-PARA? 2>	;"started paragraph yet?"

"<DESCRIBE-CONTENTS object-whose-contents-to-describe
		    level: -1 means only top level (default)
			    <> means top-level (include crlf)
			    T for all other levels
			    or string to print
		    all?: t if not being called from room-desc >

Prints nothing and rfalses if there was nothing to list.

'The wall crumbles to dust, revealing ' <DESCRIBE-CONTENTS .OBJ> "

<ROUTINE DESCRIBE-CONTENTS (OBJ "OPTIONAL" (LEVEL -1) (ALL? ,D-ALL?)
			    "AUX" (F <>) N (1ST? T) (IT? <>) (TWO? <>)
			    (START? <>) (PARA? <>) DB)
	 <COND (<EQUAL? .LEVEL 2>
		<SET LEVEL T>
		<SET PARA? T>
		<SET START? T>)
	       (<BTST .ALL? ,D-PARA?>
		<SET PARA? T>)>
	 <SET N <FIRST? .OBJ>>
	 <COND (<OR .START?
		    <IN? .OBJ ,ROOMS>
		    <FSET? .OBJ ,PERSON>
		    <AND .N
			 <FSET? .OBJ ,CONTBIT>
			 <OR <FSET? .OBJ ,OPENBIT>
			     <FSET? .OBJ ,TRANSBIT>>
			 <OR <EQUAL? .LEVEL -1>
			     <FSET? .OBJ ,SEARCHBIT>>>>
		<REPEAT ()
		 <COND (<OR <NOT .N>
			    <AND <DESCRIBABLE? .N>
				 <OR <BTST .ALL? ,D-ALL?>
				     <SIMPLE-DESC? .N>>>>
			<COND (.F
			       <COND (.1ST?
				      <SET 1ST? <>>
				      <COND (<EQUAL? .LEVEL <> T>
					     <COND (<NOT .START?>
						    <COND (<NOT .PARA?>
							   <SET PARA? T>
							   <CRLF>)
							  (<EQUAL? .LEVEL T>
							   <TELL " ">)>
						    <DESCRIBE-START .OBJ .N>)>)
					    (<NOT <EQUAL? .LEVEL -1>>
					     <TELL .LEVEL>)>)
				     (.N
				      <TELL ", ">)
				     (ELSE
				      <TELL " and ">)>
			       <TELL A .F>
			       <DESCRIBE-SPECIAL .F>
			       <COND (<AND <NOT .IT?> <NOT .TWO?>>
				      <SET IT? .F>)
				     (T
				      <SET TWO? T>
				      <SET IT? <>>)>)>
			<SET F .N>)>
		 <COND (.N <SET N <NEXT? .N>>)>
		 <COND (<AND <NOT .F> <NOT .N>>
			<COND (<AND .IT? <NOT .TWO?>>
			       <THIS-IS-IT .IT?>)>
			<COND (<AND .1ST? .START?>
			       <TELL " nothing">
			       <RFALSE>)
			      (<AND <NOT .1ST?>
				    <EQUAL? .LEVEL <> T>>
			       <COND (<EQUAL? .OBJ ,HERE>
				      <TELL " here">)>
			       <TELL ".">)>
			<RETURN>)>>
		<COND (<EQUAL? .LEVEL <> T>
		       <SET F <FIRST? .OBJ>>
		       <REPEAT ()
			       <COND (<NOT .F> <RETURN>)
				     (<AND <FSET? .F ,CONTBIT>
					   <DESCRIBABLE? .F T>
					   <OR <BTST .ALL? ,D-ALL?>
					       <SIMPLE-DESC? .F>>>
				      <SET DB ,D-BIT>
				      <SETG D-BIT <>>
				      <COND (<DESCRIBE-CONTENTS
					      .F
					      T
					      <COND (.PARA?
						     <+ ,D-ALL?
							,D-PARA?>)
						    (ELSE ,D-ALL?)>>
					     <SET 1ST? <>>
					     <SET PARA? T>)>
				      <SETG D-BIT .DB>)>
			       <SET F <NEXT? .F>>>)>
		<COND (<AND <NOT .1ST?>
			    <EQUAL? .LEVEL <> T>
			    <EQUAL? .OBJ ,HERE <LOC ,WINNER>>>
		       <CRLF>)>
		<NOT .1ST?>)>>

"DESCRIBE-START -- add starters for special classes of objects here"

<ROUTINE DESCRIBE-START (OBJ N)
	 <COND (<EQUAL? .OBJ ,HERE>
		<TELL "There is ">)
	       (<EQUAL? .OBJ ,PLAYER>
		<COND (<EQUAL? ,D-BIT ,WEARBIT>
		       <TELL " You are wearing ">)
		      (T
		       <TELL "You are carrying ">)>)
	       (<FSET? .OBJ ,PERSON>
		;<COND (<NOT <FSET? .OBJ ,NOTHEBIT>>
		       <TELL "The ">)> ;"hand is only one this clause catches"
		<TELL CTHE .OBJ " wears ">)
	       (<FSET? .OBJ ,SURFACEBIT>
		<TELL "Sitting on " THE .OBJ " is ">)
	       (ELSE
		<TELL CTHE .OBJ " contains ">)>>

"DESCRIBE-SPECIAL -- add special trailers to object descriptions here"

<ROUTINE DESCRIBE-SPECIAL (OBJ)
	 <COND (<FSET? .OBJ ,ONBIT>
		<TELL " (providing light)">)
	       ;(<EQUAL? .OBJ ,SLIME>
		<TELL " (crawling up your arm)">)
	       (<FSET? .OBJ ,SLIMEBIT>
		<TELL " (slimed)">)
	       (<AND <EQUAL? .OBJ ,HAND>
		     <FSET? ,HAND ,PERSON>
		     <IN? ,HAND ,PLAYER>>
		<TELL " (perched on your shoulder)">)
	       ;(<FSET? .OBJ ,WEARBIT>
		<TELL " (being worn)">)>>

"determines if an object is describable at all."

<GLOBAL D-BIT <>>	;"bit to screen objects"

<ROUTINE DESCRIBABLE? (OBJ "OPT" (CONT? <>))
	 <COND (<FSET? .OBJ ,INVISIBLE> <RFALSE>)
	       (<EQUAL? .OBJ ,WINNER> <RFALSE>)
	       (<AND <EQUAL? .OBJ <LOC ,WINNER>>
		     <NOT <EQUAL? ,HERE <LOC ,WINNER>>>>
		<RFALSE>)
	       (<AND <NOT .CONT?> <FSET? .OBJ ,NDESCBIT>>
		<RFALSE>)
	       (,D-BIT
		<COND (<G? ,D-BIT 0>
		       <COND (<FSET? .OBJ ,D-BIT> <RTRUE>)
			     (ELSE <RFALSE>)>)
		      (<NOT <FSET? .OBJ <- ,D-BIT>>>
		       <RTRUE>)
		      (ELSE <RFALSE>)>)
	       (ELSE
		<RTRUE>)>>

"Determines, for DESCRIBE-OBJECTS, if an object has a simple description
(not a FDESC, LDESC, or whatever)."

<ROUTINE SIMPLE-DESC? (OBJ "AUX" STR)
	 <COND (<AND <GETP .OBJ ,P?FDESC>
		     <NOT <FSET? .OBJ ,TOUCHBIT>>>
		<RFALSE>)
	       (<AND <SET STR <GETP .OBJ ,P?DESCFCN>>
		     <APPLY .STR ,M-OBJDESC? .OBJ>>
		<RFALSE>)
	       (<GETP .OBJ ,P?LDESC> <RFALSE>)
	       (ELSE <RTRUE>)>>



"DESCRIBE-REST finishes 'Opening the crocodile's mouth reveals '"

<ROUTINE DESCRIBE-REST (OBJ)
	 <COND (<NOT <DESCRIBE-CONTENTS .OBJ>>
	        <TELL "nothing">)>
	 <RTRUE>>

"DESCRIBE-SENT does the whole ball of wax"

<ROUTINE DESCRIBE-SENT (OBJ)
	 <COND (<NOT <DESCRIBE-CONTENTS .OBJ <> <+ ,D-ALL? ,D-PARA?>>>
	        <TELL "The " D .OBJ " is empty.">)>
	 <RTRUE>>

"DESCRIBE-NOTHING returns false if nothing was described"

;<ROUTINE DESCRIBE-NOTHING ()
	 <COND (<DESCRIBE-CONTENTS ,PRSO 2>
	 	<COND (<NOT <IN? ,WINNER ,PRSO>>
		       <CRLF>)>
		<RTRUE>)
	       (T ;"nothing"
		<RFALSE>)>>

;"END"