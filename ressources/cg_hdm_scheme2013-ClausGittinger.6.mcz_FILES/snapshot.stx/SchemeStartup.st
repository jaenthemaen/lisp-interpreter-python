"{ Package: 'cg:hdm/scheme2013' }"

StandaloneStartup subclass:#SchemeStartup
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Startup'
!


!SchemeStartup class methodsFor:'startup'!

main:argv 
    SchemeInterpreter topLevelReadEvalPrintLoop
! !

!SchemeStartup class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

