"{ Package: 'cg:hdm/scheme2013' }"

SchemeObject subclass:#SchemeString
	instanceVariableNames:'characters'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'
!


!SchemeString class methodsFor:'instance creation'!

new: aString
    ^ super new characters:aString
! !

!SchemeString methodsFor:'accessing'!

characters
    ^ characters
!

characters:something
    characters := something.
! !

!SchemeString methodsFor:'testing'!

isSchemeString
    ^ true
! !

!SchemeString class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

