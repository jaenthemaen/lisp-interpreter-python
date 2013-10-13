"{ Package: 'cg:hdm/scheme2013' }"

SchemeObject subclass:#SchemeBoolean
	instanceVariableNames:''
	classVariableNames:'TheOneAndOnlyTrue TheOneAndOnlyFalse'
	poolDictionaries:''
	category:'Scheme-Objects'
!


!SchemeBoolean class methodsFor:'instance creation'!

new
    ^ self error
!

singletonFalse
    TheOneAndOnlyFalse isNil ifTrue:[
        TheOneAndOnlyFalse := super new.
    ].
    ^ TheOneAndOnlyFalse
!

singletonTrue
    TheOneAndOnlyTrue isNil ifTrue:[
        TheOneAndOnlyTrue := super new.
    ].
    ^ TheOneAndOnlyTrue
! !

!SchemeBoolean methodsFor:'testing'!

isSchemeFalse
    ^ self == TheOneAndOnlyFalse
!

isSchemeTrue
    ^ self == TheOneAndOnlyTrue
! !

!SchemeBoolean class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

