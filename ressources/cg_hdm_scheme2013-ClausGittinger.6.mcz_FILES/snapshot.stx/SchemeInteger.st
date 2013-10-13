"{ Package: 'cg:hdm/scheme2013' }"

SchemeNumber subclass:#SchemeInteger
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'
!


!SchemeInteger methodsFor:'* As yet uncategorized *'!

isLispInteger
    self halt:'please define isLispInteger here'.
!

isSchemeInteger
    ^ true
! !

!SchemeInteger methodsFor:'testing'!

isSchemeIntegerWithValue:x
   ^ value = x
! !

!SchemeInteger class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

