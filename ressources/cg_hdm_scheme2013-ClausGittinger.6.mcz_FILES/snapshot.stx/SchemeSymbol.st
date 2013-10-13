"{ Package: 'cg:hdm/scheme2013' }"

SchemeObject subclass:#SchemeSymbol
	instanceVariableNames:'characters'
	classVariableNames:'AllKnownInstances'
	poolDictionaries:''
	category:'Scheme-Objects'
!


!SchemeSymbol class methodsFor:'initialization'!

initialize
    AllKnownInstances := Dictionary new.
! !

!SchemeSymbol class methodsFor:'instance creation'!

new:aString
    ^ AllKnownInstances 
        at:aString 
        ifAbsentPut:[ super new characters:aString ].
! !

!SchemeSymbol methodsFor:'accessing'!

characters
    ^ characters
!

characters:something
    characters := something.
! !

!SchemeSymbol methodsFor:'printing & storing'!

printOn: aStream
    aStream nextPutAll:'SchemeSymbol("'.
    aStream nextPutAll:characters.
    aStream nextPutAll:'")'.
! !

!SchemeSymbol methodsFor:'testing'!

isSchemeSymbol
    ^ true
! !

!SchemeSymbol class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !


SchemeSymbol initialize!
