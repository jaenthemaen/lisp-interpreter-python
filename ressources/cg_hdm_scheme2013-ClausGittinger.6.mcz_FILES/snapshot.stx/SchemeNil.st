"{ Package: 'cg:hdm/scheme2013' }"

SchemeObject subclass:#SchemeNil
	instanceVariableNames:''
	classVariableNames:'TheOneAndOnlyInstance'
	poolDictionaries:''
	category:'Scheme-Objects'
!


!SchemeNil class methodsFor:'instance creation'!

new
    ^ self singleton
!

singleton
    TheOneAndOnlyInstance isNil ifTrue:[
        TheOneAndOnlyInstance := super new.
    ].
    ^ TheOneAndOnlyInstance
! !

!SchemeNil methodsFor:'testing'!

isSchemeNil
    ^ true
! !

!SchemeNil class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

