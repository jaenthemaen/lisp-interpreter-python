"{ Package: 'cg:hdm/scheme2013' }" !

SystemOrganization addCategory: #'Scheme-Reader/Writer'
!
SystemOrganization addCategory: #'Scheme-tests'
!
SystemOrganization addCategory: #'* Projects & Packages *'
!
SystemOrganization addCategory: #'Scheme-Startup'
!
SystemOrganization addCategory: #'Scheme-Evaluator'
!
SystemOrganization addCategory: #'Scheme-Objects'
!

StandaloneStartup subclass:#SchemeStartup
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Startup'!

!SchemeStartup class methodsFor: 'startup' stamp: 'cg 04202013 12:53'!
main:argv     SchemeInterpreter topLevelReadEvalPrintLoop
! !

!SchemeStartup class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

Object subclass:#SchemeEvaluator
	instanceVariableNames:'globalEnvironment'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Evaluator'!

!SchemeEvaluator class methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluate:expr    ^ self new evaluate: expr
! !

!SchemeEvaluator class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new    "return an initialized instance"    ^ self basicNew initialize.
! !

!SchemeEvaluator class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluate: schemeExpression    ^ self evaluate: schemeExpression inEnvironment:globalEnvironment
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluate: schemeExpression inEnvironment:anEnvironment    schemeExpression isSchemeNil ifTrue:[        ^ schemeExpression    ].    schemeExpression isSchemeInteger ifTrue:[        ^ schemeExpression    ].    schemeExpression isSchemeString ifTrue:[        ^ schemeExpression    ].    schemeExpression isSchemeTrue ifTrue:[        ^ schemeExpression    ].    schemeExpression isSchemeFalse ifTrue:[        ^ schemeExpression    ].    schemeExpression isSchemeCons ifTrue:[        ^ self evaluateList: schemeExpression inEnvironment:anEnvironment    ].    schemeExpression isSchemeSymbol ifTrue:[        ^ anEnvironment at:schemeExpression    ].self halt.    ^ SchemeString new:'kann i no ned'
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateDefine: argList inEnvironment:anEnvironment    |firstArg secondArg|    firstArg := argList car.    secondArg := argList cdr car.    anEnvironment at:firstArg put:(self evaluate:secondArg inEnvironment:anEnvironment).    ^ SchemeVoid singleton.
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateIf: argList inEnvironment:anEnvironment    |unevaluatedCond evaluatedCond unevaluatedIfPart unevaluatedElsePart|    argList isSchemeNil ifTrue:[ self error:'if requires 3 arguments' ].    unevaluatedCond := argList car.    argList cdr isSchemeNil ifTrue:[ self error:'if requires 3 arguments' ].    unevaluatedIfPart := argList cdr car.    argList cdr cdr isSchemeNil ifTrue:[ self error:'if requires 3 arguments' ].    unevaluatedElsePart := argList cdr cdr car.    argList cdr cdr cdr isSchemeNil ifFalse:[ self error:'if requires 3 arguments' ].    evaluatedCond := self evaluate: unevaluatedCond inEnvironment:anEnvironment.    evaluatedCond = SchemeBoolean singletonTrue         ifTrue:[ ^ self evaluate: unevaluatedIfPart inEnvironment:anEnvironment ]        ifFalse:[ ^ self evaluate: unevaluatedElsePart inEnvironment:anEnvironment]
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateLambda: argList inEnvironment:anEnvironment    |unevaluatedArgList unevaluatedBody|    argList isSchemeNil ifTrue:[ self error:'lambda requires 2 arguments' ].    unevaluatedArgList := argList car.    argList cdr isSchemeNil ifTrue:[ self error:'lambda requires 2 arguments' ].    unevaluatedBody := argList cdr car.    argList cdr cdr isSchemeNil ifFalse:[ self error:'lambda requires 2 arguments' ].    ^ SchemeUserDefinedFunction new        argList:unevaluatedArgList        body:unevaluatedBody
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateLess: argList inEnvironment:anEnvironment    |unevaluatedArg1 evaluatedArg1 unevaluatedArg2 evaluatedArg2|    argList isSchemeNil ifTrue:[ self error:'< requires 2 arguments' ].    unevaluatedArg1 := argList car.    argList cdr isSchemeNil ifTrue:[ self error:'< requires 2 arguments' ].    unevaluatedArg2 := argList cdr car.    argList cdr cdr isSchemeNil ifFalse:[ self error:'< requires 2 arguments' ].    evaluatedArg1 := self evaluate: unevaluatedArg1 inEnvironment:anEnvironment.    evaluatedArg2 := self evaluate: unevaluatedArg2 inEnvironment:anEnvironment.    (evaluatedArg1 value < evaluatedArg2 value)        ifTrue:[ ^ SchemeBoolean singletonTrue ]        ifFalse:[ ^ SchemeBoolean singletonFalse ]
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateList: expr inEnvironment:anEnvironment    |unevaluatedFunction evaluatedFunction argList|    unevaluatedFunction := expr car.    argList := expr cdr.    "/ syntax    unevaluatedFunction = (SchemeSymbol new:'define') ifTrue:[        ^ self evaluateDefine:argList inEnvironment:anEnvironment.    ].    unevaluatedFunction = (SchemeSymbol new:'if') ifTrue:[        ^ self evaluateIf:argList inEnvironment:anEnvironment.    ].    unevaluatedFunction = (SchemeSymbol new:'lambda') ifTrue:[        ^ self evaluateLambda:argList inEnvironment:anEnvironment.    ].    "/ rest are unevaluatedFunctions        unevaluatedFunction = (SchemeSymbol new:'+') ifTrue:[        ^ self evaluatePlus:argList inEnvironment:anEnvironment.    ].    unevaluatedFunction = (SchemeSymbol new:'-') ifTrue:[        ^ self evaluateMinus:argList inEnvironment:anEnvironment.    ].    unevaluatedFunction = (SchemeSymbol new:'*') ifTrue:[        ^ self evaluateTimes:argList inEnvironment:anEnvironment.    ].    unevaluatedFunction = (SchemeSymbol new:'<') ifTrue:[        ^ self evaluateLess:argList inEnvironment:anEnvironment.    ].    unevaluatedFunction = (SchemeSymbol new:'write') ifTrue:[        ^ self evaluateWrite:argList inEnvironment:anEnvironment.    ].    evaluatedFunction := self evaluate:unevaluatedFunction inEnvironment:anEnvironment.    ^ self evaluateUserDefinedFunction:evaluatedFunction withArguments:argList inEnvironment:anEnvironment
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateMinus: argList inEnvironment:anEnvironment    |difference restList unevaluatedElement evaluatedElement|    difference := 0.    restList := argList.    restList isSchemeNil ifTrue:[ self error:'- requires at least 1 argument' ].    difference := (self evaluate:restList car inEnvironment:anEnvironment) value.    restList := restList cdr.    restList isSchemeNil ifTrue:[         ^ SchemeInteger new:(difference negated).    ].    [ restList isSchemeNil ] whileFalse:[        unevaluatedElement := restList car.        evaluatedElement := self evaluate:unevaluatedElement inEnvironment:anEnvironment.        difference := difference - evaluatedElement value.        restList := restList cdr.    ].    ^ SchemeInteger new:difference
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluatePlus: argList inEnvironment:anEnvironment    |sum restList unevaluatedElement evaluatedElement|    sum := 0.    restList := argList.    [ restList isSchemeNil ] whileFalse:[        unevaluatedElement := restList car.        evaluatedElement := self evaluate:unevaluatedElement inEnvironment:anEnvironment.        sum := sum + evaluatedElement value.        restList := restList cdr.    ].    ^ SchemeInteger new:sum
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateString: aString    |expr|    expr := SchemeReader readFrom:aString readStream.    ^ self evaluate: expr.
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateTimes: argList inEnvironment:anEnvironment    |product restList unevaluatedElement evaluatedElement|    product := 1.    restList := argList.    [ restList isSchemeNil ] whileFalse:[        unevaluatedElement := restList car.        evaluatedElement := self evaluate:unevaluatedElement inEnvironment:anEnvironment.        product := product * evaluatedElement value.        restList := restList cdr.    ].    ^ SchemeInteger new:product
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateUserDefinedFunction: aFunction withArguments: argList inEnvironment:anEnvironment    |newEnvironment functionArgList functionBody restArgs restValues nextArg nextValue|    newEnvironment := SchemeEnvironment new.    newEnvironment parent:anEnvironment.    functionArgList := aFunction argList.    functionBody := aFunction body.    restArgs := functionArgList.    restValues := argList.    [ restArgs isSchemeNil ] whileFalse:[        nextArg := restArgs car.        restArgs := restArgs cdr.        nextValue := restValues car.        restValues:= restValues cdr.        newEnvironment at:nextArg put:(self evaluate:nextValue inEnvironment:anEnvironment).    ].    ^ self evaluate:functionBody inEnvironment:newEnvironment.
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateWrite: argList inEnvironment:anEnvironment    |restList unevaluatedElement evaluatedElement|    restList := argList.    [ restList isSchemeNil ] whileFalse:[        unevaluatedElement := restList car.        evaluatedElement := self evaluate:unevaluatedElement inEnvironment:anEnvironment.        SchemePrinter print:evaluatedElement on:Transcript.        restList := restList cdr.    ].    ^ SchemeVoid singleton
! !

!SchemeEvaluator methodsFor: 'initialization' stamp: 'cg 04202013 13:02'!
initialize    globalEnvironment := SchemeEnvironment new.    globalEnvironment at:(SchemeSymbol new:'true') put:(SchemeBoolean singletonTrue).    globalEnvironment at:(SchemeSymbol new:'false') put:(SchemeBoolean singletonFalse).
! !

Object subclass:#SchemeInterpreter
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Startup'!

!SchemeInterpreter class methodsFor: 'main' stamp: 'cg 04202013 12:53'!
readEvalPrint    |value expr|    Stdout nextPutAll:'Scheme ready: '.    expr := SchemeReader readFrom:Stdin.    value := SchemeEvaluator evaluate:expr.    Stdout nextPutAll:'value is: '.    SchemePrinter print:value on:Stdout.    ^ Stdout cr.
! !

!SchemeInterpreter class methodsFor: 'main' stamp: 'cg 04202013 12:53'!
topLevelReadEvalPrintLoop    [ true ] whileTrue:[        self readEvalPrint    ].    "      self topLevelReadEvalPrintLoop    "
! !

!SchemeInterpreter class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

Object subclass:#SchemeObject
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'!

SchemeObject subclass:#SchemeBoolean
	instanceVariableNames:''
	classVariableNames:'TheOneAndOnlyFalse TheOneAndOnlyTrue'
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeBoolean class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new    ^ self error
! !

!SchemeBoolean class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
singletonFalse    TheOneAndOnlyFalse isNil ifTrue:[        TheOneAndOnlyFalse := super new.    ].    ^ TheOneAndOnlyFalse
! !

!SchemeBoolean class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
singletonTrue    TheOneAndOnlyTrue isNil ifTrue:[        TheOneAndOnlyTrue := super new.    ].    ^ TheOneAndOnlyTrue
! !

!SchemeBoolean class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!SchemeBoolean methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeFalse    ^ self == TheOneAndOnlyFalse
! !

!SchemeBoolean methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeTrue    ^ self == TheOneAndOnlyTrue
! !

SchemeObject subclass:#SchemeCons
	instanceVariableNames:'car cdr'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeCons class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new    "return an initialized instance"    ^ self basicNew initialize.
! !

!SchemeCons class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!SchemeCons methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
car    ^ car
! !

!SchemeCons methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
car:something    car := something.
! !

!SchemeCons methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
car:carArg cdr:cdrArg     car := carArg.    cdr := cdrArg.
! !

!SchemeCons methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
cdr    ^ cdr
! !

!SchemeCons methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
cdr:something    cdr := something.
! !

!SchemeCons methodsFor: 'initialization' stamp: 'cg 04202013 13:02'!
initialize    car := SchemeNil singleton.    cdr := SchemeNil singleton.
! !

!SchemeCons methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeCons    ^ true
! !

SchemeObject subclass:#SchemeEnvironment
	instanceVariableNames:'hashTable parent'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeEnvironment class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new    "return an initialized instance"    ^ self basicNew initialize.
! !

!SchemeEnvironment class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!SchemeEnvironment methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
at:aSchemeSymbol     ^ hashTable at:aSchemeSymbol ifAbsent:[ parent at:aSchemeSymbol ] 
! !

!SchemeEnvironment methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
at:aSchemeSymbol put:aSchemeObject    hashTable at:aSchemeSymbol put:aSchemeObject
! !

!SchemeEnvironment methodsFor: 'initialization' stamp: 'cg 04202013 13:02'!
initialize    hashTable := IdentityDictionary new.
! !

!SchemeEnvironment methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
parent    ^ parent
! !

!SchemeEnvironment methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
parent:something    parent := something.
! !

SchemeObject subclass:#SchemeNil
	instanceVariableNames:''
	classVariableNames:'TheOneAndOnlyInstance'
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeNil class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new    ^ self singleton
! !

!SchemeNil class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
singleton    TheOneAndOnlyInstance isNil ifTrue:[        TheOneAndOnlyInstance := super new.    ].    ^ TheOneAndOnlyInstance
! !

!SchemeNil class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!SchemeNil methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeNil    ^ true
! !

SchemeObject subclass:#SchemeNumber
	instanceVariableNames:'value'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'!

SchemeNumber subclass:#SchemeFloat
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeFloat class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new:arg    "Create & return a new instance for arg."    self assert:(arg isFloat).    ^ super new:arg
! !

!SchemeFloat class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

SchemeNumber subclass:#SchemeInteger
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeInteger class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!SchemeInteger methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeIntegerWithValue:x   ^ value = x
! !

!SchemeNumber class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new:arg    "Create & return a new instance for arg."    ^ self basicNew initializeNew:arg
! !

!SchemeNumber class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!SchemeNumber methodsFor: 'initialization' stamp: 'cg 04202013 13:02'!
initializeNew:arg    value := arg
! !

!SchemeNumber methodsFor: 'printing & storing' stamp: 'cg 04202013 13:02'!
printOn: aStream    aStream nextPutAll:self class name,'("'.    value printOn: aStream.    aStream nextPutAll:'")'.
! !

!SchemeNumber methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
value    ^ value
! !

!SchemeNumber methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
value:something    value := something.
! !

!SchemeObject class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeCons    ^ false
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeFalse    ^ false
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeInteger    ^ false
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeIntegerWithValue:x    ^ false
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeNil    ^ false
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeString    ^ false
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeSymbol    ^ false
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeTrue    ^ false
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeUserDefinedFunction    ^ false
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeVoid    ^ false
! !

!SchemeObject methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
printOn:aStream    SchemePrinter print:self on:aStream
! !

SchemeObject subclass:#SchemeString
	instanceVariableNames:'characters'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeString class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new: aString    ^ super new characters:aString
! !

!SchemeString class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!SchemeString methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
characters    ^ characters
! !

!SchemeString methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
characters:something    characters := something.
! !

!SchemeString methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeString    ^ true
! !

SchemeObject subclass:#SchemeSymbol
	instanceVariableNames:'characters'
	classVariableNames:'AllKnownInstances'
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeSymbol class methodsFor: 'initialization' stamp: 'cg 04202013 13:02'!
initialize    AllKnownInstances := Dictionary new.
! !

!SchemeSymbol class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new:aString    ^ AllKnownInstances         at:aString         ifAbsentPut:[ super new characters:aString ].
! !

!SchemeSymbol class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!SchemeSymbol methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
characters    ^ characters
! !

!SchemeSymbol methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
characters:something    characters := something.
! !

!SchemeSymbol methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeSymbol    ^ true
! !

!SchemeSymbol methodsFor: 'printing & storing' stamp: 'cg 04202013 13:02'!
printOn: aStream    aStream nextPutAll:'SchemeSymbol("'.    aStream nextPutAll:characters.    aStream nextPutAll:'")'.
! !

SchemeObject subclass:#SchemeUserDefinedFunction
	instanceVariableNames:'argList body'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeUserDefinedFunction class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!SchemeUserDefinedFunction methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
argList    ^ argList
! !

!SchemeUserDefinedFunction methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
argList:argListArg body:bodyArg     argList := argListArg.    body := bodyArg.
! !

!SchemeUserDefinedFunction methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
body    ^ body
! !

!SchemeUserDefinedFunction methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeUserDefinedFunction    ^ true
! !

SchemeObject subclass:#SchemeVoid
	instanceVariableNames:''
	classVariableNames:'TheOneAndOnlyInstance'
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeVoid class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new    ^ self singleton
! !

!SchemeVoid class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
singleton    TheOneAndOnlyInstance isNil ifTrue:[        TheOneAndOnlyInstance := super new.    ].    ^ TheOneAndOnlyInstance
! !

!SchemeVoid class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!SchemeVoid methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeVoid    ^ true
! !

Object subclass:#SchemePrinter
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Reader/Writer'!

!SchemePrinter class methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
print:anObject on:aStream    anObject isSchemeInteger ifTrue:[        self printInteger:anObject on:aStream.        ^ self.    ].    anObject isSchemeSymbol ifTrue:[        self printSymbol:anObject on:aStream.        ^ self.    ].    anObject isSchemeString ifTrue:[        self printString:anObject on:aStream.        ^ self.    ].    anObject isSchemeNil ifTrue:[        aStream nextPutAll:'()'.        ^ self.    ].    anObject isSchemeCons ifTrue:[        self printList:anObject on:aStream.        ^ self.    ].    anObject isSchemeTrue ifTrue:[        aStream nextPutAll:'true'.        ^ self.    ].    anObject isSchemeFalse ifTrue:[        aStream nextPutAll:'false'.        ^ self.    ].    anObject isSchemeVoid ifTrue:[        ^ self.    ].    anObject isSchemeUserDefinedFunction ifTrue:[        aStream nextPutAll:'some user defined function???'.        ^ self.    ].        self error:'oops - cannot print'.
! !

!SchemePrinter class methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
printInteger:anObject on:aStream    anObject value printOn:aStream.
! !

!SchemePrinter class methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
printList:anObject on:aStream    aStream nextPutAll: '('.    self printRestList:anObject on:aStream
! !

!SchemePrinter class methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
printRestList:anObject on:aStream    self print: (anObject car) on: aStream.    anObject cdr isSchemeNil ifTrue:[        aStream nextPutAll: ')'.        ^ self.    ].    aStream nextPutAll:' '.    self printRestList: (anObject cdr) on: aStream.
! !

!SchemePrinter class methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
printString:anObject on:aStream    aStream nextPutAll:'"'.    anObject characters printOn:aStream.    aStream nextPutAll:'"'.
! !

!SchemePrinter class methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
printSymbol:anObject on:aStream    anObject characters printOn:aStream.
! !

!SchemePrinter class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

Object subclass:#SchemeReader
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Reader/Writer'!

!SchemeReader class methodsFor: 'reading' stamp: 'cg 04202013 13:02'!
readFrom:aStream       |peekChar|    aStream skipSeparators.    peekChar := aStream peek.    peekChar isDigit ifTrue:[        ^ self readSchemeNumberFrom:aStream    ].    peekChar == $" ifTrue:[        aStream next.   "/ read "        ^  self readSchemeStringFrom:aStream    ].    peekChar == $( ifTrue:[        aStream next.   "/ read (        ^  self readSchemeListFrom:aStream    ].    ^ self readSchemeSymbolFrom:aStream
! !

!SchemeReader class methodsFor: 'reading' stamp: 'cg 04202013 13:02'!
readSchemeListFrom:aStream    |element restList|    aStream skipSeparators.    aStream peek == $) ifTrue:[         aStream next. "/ read over )        ^ SchemeNil singleton     ].    element := self readFrom:aStream.    restList := self readSchemeListFrom:aStream.    ^  SchemeCons new        car: element        cdr: restList
! !

!SchemeReader class methodsFor: 'reading' stamp: 'cg 04202013 13:02'!
readSchemeNumberFrom:aStream    |value ch|    value := 0.    [ (ch := aStream peek) notNil and:[ ch isDigit] ] whileTrue: [        value := value * 10 + (ch digitValue).            aStream next.    ].    ^ SchemeInteger new: value
! !

!SchemeReader class methodsFor: 'reading' stamp: 'cg 04202013 13:02'!
readSchemeStringFrom:aStream    |collectedCharacters ch escapeChar|    collectedCharacters := WriteStream on:''.    [ (ch := aStream peek) notNil       and:[ ch ~~ $"  ]    ] whileTrue: [        ch == $\ ifTrue:[            aStream next.            escapeChar := aStream peek.            escapeChar = $n ifTrue:[                collectedCharacters nextPut: (Character nl).            ] ifFalse:[                collectedCharacters nextPut: escapeChar.            ]        ] ifFalse:[            collectedCharacters nextPut: ch.        ].        aStream next.    ].    aStream next. "/ read closing "    ^ SchemeString new: (collectedCharacters contents).
! !

!SchemeReader class methodsFor: 'reading' stamp: 'cg 04202013 13:02'!
readSchemeSymbolFrom:aStream    |collectedCharacters ch|    collectedCharacters := WriteStream on:''.    [ (ch := aStream peek) notNil       and:[ ch isSeparator not      and:[ ch ~= $(      and:[ ch ~= $) ]]]    ] whileTrue: [        collectedCharacters nextPut: ch.        aStream next.    ].    ^ SchemeSymbol new: (collectedCharacters contents).
! !

!SchemeReader class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

TestCase subclass:#SchemeTests
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-tests'!

!SchemeTests class methodsFor: 'documentation' stamp: 'cg 04202013 13:02'!
documentation"    documentation to be added.    [author:]        cg    [instance variables:]    [class variables:]    [see also:]"
! !

!SchemeTests class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!SchemeTests methodsFor: 'initialize / release' stamp: 'cg 04202013 13:02'!
setUp    "common setup - invoked before testing."    super setUp
! !

!SchemeTests methodsFor: 'initialize / release' stamp: 'cg 04202013 13:02'!
tearDown    "common cleanup - invoked after testing."    super tearDown
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_001_nilIsSingleton    |o1 o2|    "/ test schemeNil is singleton    o1 := SchemeNil singleton.    o2 := SchemeNil singleton.    self assert:(o1 == o2).
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_002_symbolIdentity    |o1 o2|    "/ test two symbols are identical if same chars    o1 := SchemeSymbol new: 'abc'.    o2 := SchemeSymbol new: 'abc'.    self assert:(o1 == o2).    o1 := SchemeSymbol new: 'abc'.    o2 := SchemeSymbol new: 'abcd'.    self assert:(o1 ~~ o2).
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_003_conses    |o|    o := SchemeCons new.    self assert:(o car isSchemeNil).    "     self run:#test1     self new test1    "
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_004_numbers    |o|    o := SchemeInteger new: 1234.    self assert:(o value = 1234).    o := SchemeFloat new: 1234.0.    self assert:(o value = 1234.0).    self         should: [ o := SchemeFloat new: 1234 ]        raise: Error.
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_010_readingAtoms    |o s|    o := SchemeReader readFrom: ('1234' readStream).    self assert:(o isSchemeInteger).    self assert:(o value = 1234)."/    o := SchemeReader readFrom: ('-1234' readStream)."/    self assert:(o isSchemeInteger)."/    self assert:(o value = -1234).    o := SchemeReader readFrom: ('    1234' readStream).    self assert:(o isSchemeInteger).    self assert:(o value = 1234).    s := ' 1234 2345' readStream.    o := SchemeReader readFrom: s.    self assert:(o isSchemeInteger).    self assert:(o value = 1234).    o := SchemeReader readFrom: s.    self assert:(o isSchemeInteger).    self assert:(o value = 2345).    s := ' abc - -+--abcd+++' readStream.    o := SchemeReader readFrom: s.    self assert:(o isSchemeSymbol).    self assert:(o characters = 'abc').    o := SchemeReader readFrom: s.    self assert:(o isSchemeSymbol).    self assert:(o characters = '-').    o := SchemeReader readFrom: s.    self assert:(o isSchemeSymbol).    self assert:(o characters = '-+--abcd+++')."/    s := ' 1+' readStream."/    o := SchemeReader readFrom: s."/    self assert:(o isSchemeSymbol)."/    self assert:(o characters = '1+').
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_011_readingStrings    |o|    o := SchemeReader readFrom: ('"abc"' readStream).    self assert:(o isSchemeString).    self assert:(o isSchemeSymbol not).    self assert:(o isSchemeInteger not).    self assert:(o characters = 'abc').    o := SchemeReader readFrom: ('"a\nbc"' readStream).    self assert:(o isSchemeString).    self assert:(o isSchemeSymbol not).    self assert:(o isSchemeInteger not).    self assert:(o characters = ('a',Character nl,'bc')).    o := SchemeReader readFrom: ('"a\"bc"' readStream).    self assert:(o isSchemeString).    self assert:(o isSchemeSymbol not).    self assert:(o isSchemeInteger not).    self assert:(o characters = ('a"bc')).
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_020_readingLists    |o s|    o := SchemeReader readFrom: ('()' readStream).    self assert:(o isSchemeNil).    o := SchemeReader readFrom: ('    ()' readStream).    self assert:(o isSchemeNil).    o := SchemeReader readFrom: ('(  )' readStream).    self assert:(o isSchemeNil).    s := ' () ()' readStream.    o := SchemeReader readFrom: s.    self assert:(o isSchemeNil).    o := SchemeReader readFrom: s.    self assert:(o isSchemeNil).    o := SchemeReader readFrom: ('(1)' readStream).    self assert:(o isSchemeCons).    self assert:(o car isSchemeInteger).    self assert:(o car value = 1).    self assert:(o cdr isSchemeNil).    o := SchemeReader readFrom: ('(   1)' readStream).    self assert:(o isSchemeCons).    self assert:(o car isSchemeInteger).    self assert:(o car value = 1).    self assert:(o cdr isSchemeNil).    o := SchemeReader readFrom: ('(   1    )' readStream).    self assert:(o isSchemeCons).    self assert:(o car isSchemeInteger).    self assert:(o car value = 1).    self assert:(o cdr isSchemeNil).    o := SchemeReader readFrom: ('(plus 1 2)' readStream).    self assert:(o isSchemeCons).    self assert:(o car isSchemeSymbol).    self assert:(o car characters = 'plus').    self assert:(o cdr car isSchemeInteger).    self assert:(o cdr car value = 1).    self assert:(o cdr cdr car isSchemeInteger).    self assert:(o cdr cdr car value = 2).    self assert:(o cdr cdr cdr isSchemeNil).    o := SchemeReader readFrom: ('(1 2 3)' readStream).    self assert:(o isSchemeCons).    self assert:(o car isSchemeInteger).    self assert:(o car value = 1).    self assert:(o cdr isSchemeCons).    self assert:(o cdr car isSchemeInteger).    self assert:(o cdr car value = 2).    self assert:(o cdr cdr isSchemeCons).    self assert:(o cdr cdr car isSchemeInteger).    self assert:(o cdr cdr car value = 3).    self assert:(o cdr cdr cdr isSchemeNil).
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_021_readingNestedLists    |o e1 e2 e3|    o := SchemeReader readFrom: ('( () )' readStream).    self assert:(o isSchemeCons).    self assert:(o car isSchemeNil).    self assert:(o cdr isSchemeNil).    o := SchemeReader readFrom: ('( ( 1 ) ( 2 3 ) 4 )' readStream).    self assert:(o isSchemeCons).    e1 := o car.    self assert:(e1 isSchemeCons).    self assert:(e1 car isSchemeIntegerWithValue:1).    self assert:(e1 cdr isSchemeNil).    e2 := o cdr car.    self assert:(e2 isSchemeCons).    self assert:(e2 car isSchemeIntegerWithValue:2).    self assert:(e2 cdr car isSchemeIntegerWithValue:3).    self assert:(e2 cdr cdr isSchemeNil).    e3 := o cdr cdr car.    self assert:(e3 isSchemeInteger).    self assert:(o cdr cdr cdr isSchemeNil).
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_030_printingAtoms    |o s|    o := SchemeInteger new:123.    s := WriteStream on:''.    SchemePrinter print:o on:s.    self assert:(s contents = '123').    o := SchemeInteger new:123.    SchemePrinter print:o on:Transcript.    SchemePrinter print:o on:Stdout.    o := SchemeString new:'abc'.    s := WriteStream on:''.    SchemePrinter print:o on:s.    self assert:(s contents = '"abc"').    o := SchemeSymbol new:'abc'.    s := WriteStream on:''.    SchemePrinter print:o on:s.    self assert:(s contents = 'abc').
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_030_printingLists    |o s|    o := SchemeReader readFrom:'()' readStream.    s := WriteStream on:''.    SchemePrinter print:o on:s.    self assert:(s contents = '()').    #(        '123'                   '123'        'abc'                   'abc'        '"abc"'                 '"abc"'        '()'                    '()'        '( )'                   '()'        '  ( )'                 '()'        '(1 3)'                 '(1 3)'        '(1 2 3)'               '(1 2 3)'        '(  1 2 3)'             '(1 2 3)'        '(  1 2 3   )'          '(1 2 3)'        '(1 () 3)'              '(1 () 3)'         '(1 (2) 3)'             '(1 (2) 3)'         '(1 (2 3) 4)'           '(1 (2 3) 4)'         '(abc (2 3) 4)'         '(abc (2 3) 4)'         '(abc (def ghi) 4)'     '(abc (def ghi) 4)'         '("hello" 4)'           '("hello" 4)'        '("hello" (2 3) 4)'     '("hello" (2 3) 4)'    ) pairWiseDo:[:eachTestString :eachExpectedResult|       Transcript showCR:'testing: ',eachTestString.       s := WriteStream on:''.       o := SchemeReader readFrom:eachTestString readStream.       SchemePrinter print:o on:s.       self assert:(s contents = eachExpectedResult).    ].
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_050_evaluatingAtoms    |input result stream|    input := SchemeReader readFrom:'()' readStream.    result := SchemeEvaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '()').    input := SchemeReader readFrom:'1234' readStream.    result := SchemeEvaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '1234').    input := SchemeReader readFrom:'"hello"' readStream.    result := SchemeEvaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '"hello"').    input := SchemeReader readFrom:'true' readStream.    result := SchemeEvaluator evaluate: input.    self assert:(result isSchemeTrue).    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = 'true').    input := SchemeReader readFrom:'false' readStream.    result := SchemeEvaluator evaluate: input.    self assert:(result isSchemeFalse).    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = 'false').
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_051_evaluatingList    |input result stream evaluator|    evaluator := SchemeEvaluator new.    input := SchemeReader readFrom:'(define a 10)' readStream.    evaluator evaluate: input.    input := SchemeReader readFrom:'(define b 20)' readStream.    evaluator evaluate: input.    input := SchemeReader readFrom:'(define c 30)' readStream.    evaluator evaluate: input.    input := SchemeReader readFrom:'(define d a)' readStream.    evaluator evaluate: input.    input := SchemeReader readFrom:'d' readStream.    result := evaluator evaluate: input.    self assert:(result isSchemeIntegerWithValue:10).    input := SchemeReader readFrom:'(define e (+ a 20))' readStream.    evaluator evaluate: input.    input := SchemeReader readFrom:'e' readStream.    result := evaluator evaluate: input.    self assert:(result isSchemeIntegerWithValue:30).    input := SchemeReader readFrom:'(+ a 1)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '11').    input := SchemeReader readFrom:'(+ (+ a 1) (+ b 2))' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '33').    Transcript clear.    input := SchemeReader readFrom:'(write 123)' readStream.    result := evaluator evaluate: input.    self assert:(result isSchemeVoid).    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '').    Transcript flush.    self assert:(Transcript contents asStringCollection first = '123').
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_052_evaluatingConditions    |input result stream evaluator|    evaluator := SchemeEvaluator new.    self should:[        input := SchemeReader readFrom:'(<)' readStream.        result := evaluator evaluate: input.    ] raise:Error.    self should:[        input := SchemeReader readFrom:'(< 1 2 3)' readStream.        result := evaluator evaluate: input.    ] raise:Error.    input := SchemeReader readFrom:'(< 1 2)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = 'true').    input := SchemeReader readFrom:'(< 1 1)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = 'false').    input := SchemeReader readFrom:'(< 1 0)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = 'false').
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_053_evaluatingIf    |input result stream evaluator|    evaluator := SchemeEvaluator new.    input := SchemeReader readFrom:'(if true 0 1)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '0').    input := SchemeReader readFrom:'(if false 0 1)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '1').    input := SchemeReader readFrom:'(if (< 10 20) 1 0)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '1').    input := SchemeReader readFrom:'(if (< 20 10) 1 0)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '0').    Transcript clear.    input := SchemeReader readFrom:'(if (< 10 20) (write "hello") (write "world"))' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '').    Transcript flush.    self assert:(Transcript contents asStringCollection first = '"hello"').
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_054_evaluatingArithmetic    |input result stream evaluator|    evaluator := SchemeEvaluator new.    input := SchemeReader readFrom:'(+)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '0').    input := SchemeReader readFrom:'(+ 1 2)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '3').    input := SchemeReader readFrom:'(+ 10)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '10').    input := SchemeReader readFrom:'(+ 10 1)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '11').    input := SchemeReader readFrom:'(+ (+ 1 2) 3)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '6').    input := SchemeReader readFrom:'(+ (+ 10 1) (+ 20 2))' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '33').    input := SchemeReader readFrom:'(*)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '1').    input := SchemeReader readFrom:'(* 3 2)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '6').    input := SchemeReader readFrom:'(* 10)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '10').    input := SchemeReader readFrom:'(+ 10 1)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '11').    input := SchemeReader readFrom:'(* (+ 1 2) 3)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '9').    input := SchemeReader readFrom:'(* (+ 10 1) (+ 20 2))' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '242').    input := SchemeReader readFrom:'(- 2 1)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '1').    input := SchemeReader readFrom:'(- 10)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '-10').    input := SchemeReader readFrom:'(- 10 1 2)' readStream.    result := evaluator evaluate: input.    SchemePrinter print:result on:(stream := WriteStream on:'').    self assert:(stream contents = '7').
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_060_defineFunction    |input result evaluator|    evaluator := SchemeEvaluator new.    input := SchemeReader readFrom:'(lambda (a b c) (+ a b c 1))' readStream.    result := evaluator evaluate: input.    self assert:(result isSchemeUserDefinedFunction).    input := SchemeReader readFrom:'(lambda () 123 )' readStream.    result := evaluator evaluate: input.    self assert:(result isSchemeUserDefinedFunction).    result := evaluator evaluateString: '(define f (lambda (a b c) (+ a b c 1)))'.    input := SchemeReader readFrom:'f' readStream.    result := evaluator evaluate: input.    self assert:(result isSchemeUserDefinedFunction)."/    input := SchemeReader readFrom:'(f 10 20 30)' readStream."/    result := evaluator evaluate: input."/    self assert:(result isSchemeIntegerWithValue:61)."/"/    result := evaluator evaluateString: '(define globalA 10)'."/    result := evaluator evaluateString: '(define globalB 20)'."/    result := evaluator evaluateString: '(define globalC (+ a b))'."/    input := SchemeReader readFrom:'(f globalA globalB globalC)' readStream."/    result := evaluator evaluate: input."/    self assert:(result isSchemeIntegerWithValue:61).        result := evaluator evaluateString: '(define a 10)'.    result := evaluator evaluateString: '(define b 20)'.    result := evaluator evaluateString: '(define c 30)'.    input := SchemeReader readFrom:'(f c b a)' readStream.    result := evaluator evaluate: input.    self assert:(result isSchemeIntegerWithValue:61).
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_061_factorial    |result evaluator|    evaluator := SchemeEvaluator new.    result := evaluator evaluateString:'(define fac   (lambda (n)   (if (< n 2)        1        (* n (fac (- n 1))))  ))'.    result := evaluator evaluateString: 'fac'.    self assert:(result isSchemeUserDefinedFunction).    result := evaluator evaluateString: '(fac 10)'.    self assert:(result isSchemeIntegerWithValue:3628800).
! !

ApplicationDefinition subclass:#'cg_hdm_scheme2013'
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'* Projects & Packages *'!

!cg_hdm_scheme2013 class methodsFor: 'description - project information' stamp: 'cg 04202013 12:53'!
applicationIconFileName    "Return the name (without suffix) of an icon-file (the app's icon); will be included in the rc-resource file"    ^ nil    "/ ^ self applicationName
! !

!cg_hdm_scheme2013 class methodsFor: 'description - contents' stamp: 'cg 04202013 13:02'!
classNamesAndAttributes    "lists the classes which are to be included in the project.     Each entry in the list may be: a single class-name (symbol),     or an array-literal consisting of class name and attributes.     Attributes are: #autoload or #<os> where os is one of win32, unix,..."    ^ #(        "<className> or (<className> attributes...) in load order"        SchemeInterpreter        SchemeStartup        #'cg_hdm_scheme2013'        SchemeEvaluator        SchemeObject        SchemePrinter        SchemeReader        (SchemeTests autoload)        SchemeBoolean        SchemeCons        SchemeEnvironment        SchemeNil        SchemeNumber        SchemeString        SchemeSymbol        SchemeUserDefinedFunction        SchemeVoid        SchemeFloat        SchemeInteger    )
! !

!cg_hdm_scheme2013 class methodsFor: 'description - project information' stamp: 'cg 04202013 12:53'!
companyName    "Return a companyname which will appear in <lib>.rc"    ^ 'My Company'
! !

!cg_hdm_scheme2013 class methodsFor: 'description - project information' stamp: 'cg 04202013 12:53'!
description    "Return a description string which will appear in vc.def / bc.def"    ^ 'Application'
! !

!cg_hdm_scheme2013 class methodsFor: 'description' stamp: 'cg 04202013 12:53'!
excludedFromPreRequisites    "list all packages which should be ignored in the automatic     preRequisites scan. See #preRequisites for more."    ^ #(    )
! !

!cg_hdm_scheme2013 class methodsFor: 'description - contents' stamp: 'cg 04202013 12:53'!
extensionMethodNames    "lists the extension methods which are to be included in the project.     Entries are 2-element array literals, consisting of class-name and selector."    ^ #(    )
! !

!cg_hdm_scheme2013 class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
extensionsVersion_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!cg_hdm_scheme2013 class methodsFor: 'description' stamp: 'cg 04202013 12:53'!
isGUIApplication    "return true, if this is a GUI application.     (these need more libraries and use a different startup procedure)"    ^ false
! !

!cg_hdm_scheme2013 class methodsFor: 'description - project information' stamp: 'cg 04202013 12:53'!
legalCopyright    "Return a copyright string which will appear in <lib>.rc"    ^ 'My CopyRight or CopyLeft'
! !

!cg_hdm_scheme2013 class methodsFor: 'description' stamp: 'cg 04202013 13:02'!
mandatoryPreRequisites    "list all required mandatory packages.     Packages are mandatory, if they contain superclasses of the package's classes     or classes which are extended by this package.     This list can be maintained manually or (better) generated and     updated by scanning the superclass hierarchies     (the browser has a menu function for that)     However, often too much is found, and you may want to explicitely     exclude individual packages in the #excludedFromPreRequisites method."    ^ #(        #'stx:goodies/sunit'    "TestAsserter - superclass of SchemeTests "        #'stx:libbasic'    "Object - superclass of SchemeEvaluator "    )
! !

!cg_hdm_scheme2013 class methodsFor: 'description - project information' stamp: 'cg 04202013 12:53'!
productInstallDirBaseName    "Returns a default installDir which will appear in <app>.nsi.     This is usually not the one you want to keep"    ^ (self package asCollectionOfSubstringsSeparatedByAny:':/') last
! !

!cg_hdm_scheme2013 class methodsFor: 'description - project information' stamp: 'cg 04202013 12:53'!
productName    "Return a product name which will appear in <lib>.rc"    ^ 'ProductName'
! !

!cg_hdm_scheme2013 class methodsFor: 'description' stamp: 'cg 04202013 12:53'!
referencedPreRequisites    "list all packages containing classes referenced by the packages's members.     This list can be maintained manually or (better) generated and     updated by looking for global variable accesses     (the browser has a menu function for that)     However, often too much is found, and you may want to explicitely     exclude individual packages in the #excludedFromPreRequisites method."    ^ #(    )
! !

!cg_hdm_scheme2013 class methodsFor: 'description - startup' stamp: 'cg 04202013 12:53'!
startupClassName    "the class that starts the show in its startupSelector method"    ^ 'SchemeStartup'
! !

!cg_hdm_scheme2013 class methodsFor: 'description - startup' stamp: 'cg 04202013 12:53'!
startupSelector    "the message that is sent to the startupClass to start the show"    ^ #'start'        
! !

!cg_hdm_scheme2013 class methodsFor: 'description' stamp: 'cg 04202013 12:53'!
subProjects    "list packages which are known as subprojects.     This method is generated automatically; however, when generating automatically,     packages are only added - never removed, unless listed in #excludedFromSubProjects."    ^ #()
! !

!cg_hdm_scheme2013 class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !
SchemeSymbol initialize
!
