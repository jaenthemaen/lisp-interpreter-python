"{ Package: 'cg:hdm/scheme2013' }"

SchemeObject subclass:#SchemeCons
	instanceVariableNames:'car cdr'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'
!


!SchemeCons class methodsFor:'instance creation'!

new
    "return an initialized instance"

    ^ self basicNew initialize.
! !

!SchemeCons methodsFor:'accessing'!

car
    ^ car
!

car:something
    car := something.
!

car:carArg cdr:cdrArg 
    car := carArg.
    cdr := cdrArg.
!

cdr
    ^ cdr
!

cdr:something
    cdr := something.
! !

!SchemeCons methodsFor:'initialization'!

initialize
    car := SchemeNil singleton.
    cdr := SchemeNil singleton.
! !

!SchemeCons methodsFor:'testing'!

isSchemeCons
    ^ true
! !

!SchemeCons class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

