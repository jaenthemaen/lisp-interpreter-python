"{ Package: 'cg:hdm/scheme2013' }"

SchemeNumber subclass:#SchemeFloat
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'
!


!SchemeFloat class methodsFor:'instance creation'!

new:arg
    "Create & return a new instance for arg."

    self assert:(arg isFloat).
    ^ super new:arg
! !

!SchemeFloat class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

