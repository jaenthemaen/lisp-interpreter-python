"{ Package: 'cg:hdm/scheme2013' }"

SchemeObject subclass:#SchemeNumber
	instanceVariableNames:'value'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'
!


!SchemeNumber class methodsFor:'instance creation'!

new:arg
    "Create & return a new instance for arg."

    ^ self basicNew initializeNew:arg
! !

!SchemeNumber methodsFor:'accessing'!

value
    ^ value
!

value:something
    value := something.
! !

!SchemeNumber methodsFor:'initialization'!

initializeNew:arg
    value := arg
! !

!SchemeNumber methodsFor:'printing & storing'!

printOn: aStream
    aStream nextPutAll:self class name,'("'.
    value printOn: aStream.
    aStream nextPutAll:'")'.
! !

!SchemeNumber class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

