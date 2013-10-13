"{ Package: 'cg:hdm/scheme2013' }"

Object subclass:#SchemeReader
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Reader/Writer'
!


!SchemeReader class methodsFor:'reading'!

readFrom:aStream   
    |peekChar|

    aStream skipSeparators.

    peekChar := aStream peek.
    peekChar isDigit ifTrue:[
        ^ self readSchemeNumberFrom:aStream
    ].
    peekChar == $" ifTrue:[
        aStream next.   "/ read "
        ^  self readSchemeStringFrom:aStream
    ].
    peekChar == $( ifTrue:[
        aStream next.   "/ read (
        ^  self readSchemeListFrom:aStream
    ].
    ^ self readSchemeSymbolFrom:aStream
!

readSchemeListFrom:aStream
    |element restList|

    aStream skipSeparators.
    aStream peek == $) ifTrue:[ 
        aStream next. "/ read over )
        ^ SchemeNil singleton 
    ].

    element := self readFrom:aStream.
    restList := self readSchemeListFrom:aStream.

    ^  SchemeCons new
        car: element
        cdr: restList
!

readSchemeNumberFrom:aStream
    |value ch|

    value := 0.
    [ (ch := aStream peek) notNil and:[ ch isDigit] ] whileTrue: [
        value := value * 10 + (ch digitValue).    
        aStream next.
    ].
    ^ SchemeInteger new: value
!

readSchemeStringFrom:aStream
    |collectedCharacters ch escapeChar|

    collectedCharacters := WriteStream on:''.
    [ (ch := aStream peek) notNil 
      and:[ ch ~~ $"  ]
    ] whileTrue: [
        ch == $\ ifTrue:[
            aStream next.
            escapeChar := aStream peek.
            escapeChar = $n ifTrue:[
                collectedCharacters nextPut: (Character nl).
            ] ifFalse:[
                collectedCharacters nextPut: escapeChar.
            ]
        ] ifFalse:[
            collectedCharacters nextPut: ch.
        ].
        aStream next.
    ].
    aStream next. "/ read closing "
    ^ SchemeString new: (collectedCharacters contents).
!

readSchemeSymbolFrom:aStream
    |collectedCharacters ch|

    collectedCharacters := WriteStream on:''.
    [ (ch := aStream peek) notNil 
      and:[ ch isSeparator not
      and:[ ch ~= $(
      and:[ ch ~= $) ]]]
    ] whileTrue: [
        collectedCharacters nextPut: ch.
        aStream next.
    ].
    ^ SchemeSymbol new: (collectedCharacters contents).
! !

!SchemeReader class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

