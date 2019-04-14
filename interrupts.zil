"INTERRUPTS for
			    The Lurking Horror
	(c) Copyright 1986 Infocom, Inc. All Rights Reserved."

;"GENERICS"

<GLOBAL LOAD-MAX 150>
<GLOBAL LOAD-ALLOWED 150>

<GLOBAL AWAKE -1>

<ROUTINE I-TIRED ("AUX" (FORG <>))
	 <QUEUE I-TIRED 25>
	 <COND (<G? ,LOAD-ALLOWED 10>
		<SETG LOAD-ALLOWED <- ,LOAD-ALLOWED 10>>)>
	 <COND (<G? ,FUMBLE-NUMBER 1>
		<SETG FUMBLE-NUMBER <- ,FUMBLE-NUMBER 1>>)>
	 <SETG AWAKE <+ ,AWAKE 1>>
	 <CRLF>
	 <COND (<G? ,AWAKE 8>
		<TELL
"You are so exhausted you can't stay awake any longer." CR>
		<CRLF>
		<V-SLEEP T>
		<RFATAL>)
	       (T
		<TELL "You are " <GET ,TIRED-TELL ,AWAKE> ,PERIOD>)>>
