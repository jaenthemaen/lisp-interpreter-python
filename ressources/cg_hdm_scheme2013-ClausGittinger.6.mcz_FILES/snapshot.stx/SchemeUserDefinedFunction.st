"{ Package: 'cg:hdm/scheme2013' }"

SchemeObject subclass:#SchemeUserDefinedFunction
	instanceVariableNames:'argList body'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'
!


!SchemeUserDefinedFunction methodsFor:'accessing'!

argList
    ^ argList
!

argList:argListArg body:bodyArg 
    argList := argListArg.
    body := bodyArg.
!

body
    ^ body
! !

!SchemeUserDefinedFunction methodsFor:'testing'!

isSchemeUserDefinedFunction
    ^ true
! !

!SchemeUserDefinedFunction class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

