"{ Package: 'cg:hdm/scheme2013' }"

Object subclass:#SchemeObject
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'
!


!SchemeObject methodsFor:'printing'!

printOn:aStream
    SchemePrinter print:self on:aStream
! !

!SchemeObject methodsFor:'testing'!

isSchemeCons
    ^ false
!

isSchemeFalse
    ^ false
!

isSchemeInteger
    ^ false
!

isSchemeIntegerWithValue:x
    ^ false
!

isSchemeNil
    ^ false
!

isSchemeString
    ^ false
!

isSchemeSymbol
    ^ false
!

isSchemeTrue
    ^ false
!

isSchemeUserDefinedFunction
    ^ false
!

isSchemeVoid
    ^ false
! !

!SchemeObject class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

