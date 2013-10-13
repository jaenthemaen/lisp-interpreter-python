"{ Package: 'cg:hdm/scheme2013' }"

SchemeObject subclass:#SchemeEnvironment
	instanceVariableNames:'hashTable parent'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'
!


!SchemeEnvironment class methodsFor:'instance creation'!

new
    "return an initialized instance"

    ^ self basicNew initialize.
! !

!SchemeEnvironment methodsFor:'accessing'!

at:aSchemeSymbol 
    ^ hashTable at:aSchemeSymbol ifAbsent:[ parent at:aSchemeSymbol ] 
!

at:aSchemeSymbol put:aSchemeObject
    hashTable at:aSchemeSymbol put:aSchemeObject
!

parent
    ^ parent
!

parent:something
    parent := something.
! !

!SchemeEnvironment methodsFor:'initialization'!

initialize
    hashTable := IdentityDictionary new.
! !

!SchemeEnvironment class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

