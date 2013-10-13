"{ Package: 'cg:hdm/scheme2013' }"

Object subclass:#SchemePrinter
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Reader/Writer'
!


!SchemePrinter class methodsFor:'printing'!

print:anObject on:aStream
    anObject isSchemeInteger ifTrue:[
        self printInteger:anObject on:aStream.
        ^ self.
    ].
    anObject isSchemeSymbol ifTrue:[
        self printSymbol:anObject on:aStream.
        ^ self.
    ].
    anObject isSchemeString ifTrue:[
        self printString:anObject on:aStream.
        ^ self.
    ].
    anObject isSchemeNil ifTrue:[
        aStream nextPutAll:'()'.
        ^ self.
    ].
    anObject isSchemeCons ifTrue:[
        self printList:anObject on:aStream.
        ^ self.
    ].
    anObject isSchemeTrue ifTrue:[
        aStream nextPutAll:'true'.
        ^ self.
    ].
    anObject isSchemeFalse ifTrue:[
        aStream nextPutAll:'false'.
        ^ self.
    ].
    anObject isSchemeVoid ifTrue:[
        ^ self.
    ].
    anObject isSchemeUserDefinedFunction ifTrue:[
        aStream nextPutAll:'some user defined function???'.
        ^ self.
    ].    
    self error:'oops - cannot print'.
!

printInteger:anObject on:aStream
    anObject value printOn:aStream.
!

printList:anObject on:aStream
    aStream nextPutAll: '('.
    self printRestList:anObject on:aStream
!

printRestList:anObject on:aStream
    self print: (anObject car) on: aStream.
    anObject cdr isSchemeNil ifTrue:[
        aStream nextPutAll: ')'.
        ^ self.
    ].
    aStream nextPutAll:' '.
    self printRestList: (anObject cdr) on: aStream.
!

printString:anObject on:aStream
    aStream nextPutAll:'"'.
    anObject characters printOn:aStream.
    aStream nextPutAll:'"'.
!

printSymbol:anObject on:aStream
    anObject characters printOn:aStream.
! !

!SchemePrinter class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

