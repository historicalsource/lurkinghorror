"H for
			   The Lurking Horror
	(c) Copyright 1986 Infocom, Inc. All Rights Reserved."

<SNAME "H1">

<PRINC "
*** The Lurking Horror: Interactive Horror ***
">

<VERSION ZIP>		;"maybe ezip or xzip someday"
<FREQUENT-WORDS?>	;"include frequent words"
;<LONG-WORDS?>		;"make a table of long words"
<SETG ZDEBUGGING? <>>	;"don't include debugging code"
<SETG NEW-VOC? T>	;"allows words to be adj/noun/verb all at once!"
<SET REDEFINE T>	;"don't stop and ask"
<SETG SOUND-EFFECTS? T>	;"include sound effects?"

<DEFINE IFSOUND ("ARGS" FOO)
	<COND (,SOUND-EFFECTS?
	       <FORM PROG () !.FOO>)
	      (ELSE T)>>

<INSERT-FILE "MISC">
<INSERT-FILE "PARSER">
<INSERT-FILE "SYNTAX">
<INSERT-FILE "DEBUG">
<INSERT-FILE "RECORD">
<INSERT-FILE "INTERRUPTS">
<INSERT-FILE "DESC">
<INSERT-FILE "VERBS">
<INSERT-FILE "GLOBALS">
<INSERT-FILE "CS">
<INSERT-FILE "HACKER">
<INSERT-FILE "PC">
<INSERT-FILE "YUGGOTH">
<INSERT-FILE "GREEN">
<INSERT-FILE "FROB">

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
