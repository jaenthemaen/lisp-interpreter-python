"{ Package: 'cg:hdm/scheme2013' }"

Object subclass:#SchemeInterpreter
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Startup'
!


!SchemeInterpreter class methodsFor:'main'!

readEvalPrint
    |value expr|

    Stdout nextPutAll:'Scheme ready: '.
    expr := SchemeReader readFrom:Stdin.
    value := SchemeEvaluator evaluate:expr.
    Stdout nextPutAll:'value is: '.
    SchemePrinter print:value on:Stdout.
    ^ Stdout cr.
!

topLevelReadEvalPrintLoop
    [ true ] whileTrue:[
        self readEvalPrint
    ].

    "
      self topLevelReadEvalPrintLoop
    "
! !

!SchemeInterpreter class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

