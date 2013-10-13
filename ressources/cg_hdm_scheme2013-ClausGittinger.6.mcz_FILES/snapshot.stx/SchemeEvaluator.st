"{ Package: 'cg:hdm/scheme2013' }"

Object subclass:#SchemeEvaluator
	instanceVariableNames:'globalEnvironment'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Evaluator'
!


!SchemeEvaluator class methodsFor:'instance creation'!

new
    "return an initialized instance"

    ^ self basicNew initialize.
! !

!SchemeEvaluator class methodsFor:'evaluation'!

evaluate:expr
    ^ self new evaluate: expr
! !

!SchemeEvaluator methodsFor:'evaluation'!

evaluate: schemeExpression
    ^ self evaluate: schemeExpression inEnvironment:globalEnvironment
!

evaluate: schemeExpression inEnvironment:anEnvironment
    schemeExpression isSchemeNil ifTrue:[
        ^ schemeExpression
    ].
    schemeExpression isSchemeInteger ifTrue:[
        ^ schemeExpression
    ].
    schemeExpression isSchemeString ifTrue:[
        ^ schemeExpression
    ].
    schemeExpression isSchemeTrue ifTrue:[
        ^ schemeExpression
    ].
    schemeExpression isSchemeFalse ifTrue:[
        ^ schemeExpression
    ].
    schemeExpression isSchemeCons ifTrue:[
        ^ self evaluateList: schemeExpression inEnvironment:anEnvironment
    ].
    schemeExpression isSchemeSymbol ifTrue:[
        ^ anEnvironment at:schemeExpression
    ].
self halt.
    ^ SchemeString new:'kann i no ned'
!

evaluateDefine: argList inEnvironment:anEnvironment
    |firstArg secondArg|

    firstArg := argList car.
    secondArg := argList cdr car.
    anEnvironment at:firstArg put:(self evaluate:secondArg inEnvironment:anEnvironment).
    ^ SchemeVoid singleton.
!

evaluateIf: argList inEnvironment:anEnvironment
    |unevaluatedCond evaluatedCond unevaluatedIfPart unevaluatedElsePart|

    argList isSchemeNil ifTrue:[ self error:'if requires 3 arguments' ].
    unevaluatedCond := argList car.
    argList cdr isSchemeNil ifTrue:[ self error:'if requires 3 arguments' ].
    unevaluatedIfPart := argList cdr car.
    argList cdr cdr isSchemeNil ifTrue:[ self error:'if requires 3 arguments' ].
    unevaluatedElsePart := argList cdr cdr car.
    argList cdr cdr cdr isSchemeNil ifFalse:[ self error:'if requires 3 arguments' ].

    evaluatedCond := self evaluate: unevaluatedCond inEnvironment:anEnvironment.

    evaluatedCond = SchemeBoolean singletonTrue 
        ifTrue:[ ^ self evaluate: unevaluatedIfPart inEnvironment:anEnvironment ]
        ifFalse:[ ^ self evaluate: unevaluatedElsePart inEnvironment:anEnvironment]
!

evaluateLambda: argList inEnvironment:anEnvironment
    |unevaluatedArgList unevaluatedBody|

    argList isSchemeNil ifTrue:[ self error:'lambda requires 2 arguments' ].
    unevaluatedArgList := argList car.
    argList cdr isSchemeNil ifTrue:[ self error:'lambda requires 2 arguments' ].
    unevaluatedBody := argList cdr car.
    argList cdr cdr isSchemeNil ifFalse:[ self error:'lambda requires 2 arguments' ].

    ^ SchemeUserDefinedFunction new
        argList:unevaluatedArgList
        body:unevaluatedBody
!

evaluateLess: argList inEnvironment:anEnvironment
    |unevaluatedArg1 evaluatedArg1 unevaluatedArg2 evaluatedArg2|

    argList isSchemeNil ifTrue:[ self error:'< requires 2 arguments' ].
    unevaluatedArg1 := argList car.
    argList cdr isSchemeNil ifTrue:[ self error:'< requires 2 arguments' ].
    unevaluatedArg2 := argList cdr car.
    argList cdr cdr isSchemeNil ifFalse:[ self error:'< requires 2 arguments' ].

    evaluatedArg1 := self evaluate: unevaluatedArg1 inEnvironment:anEnvironment.
    evaluatedArg2 := self evaluate: unevaluatedArg2 inEnvironment:anEnvironment.

    (evaluatedArg1 value < evaluatedArg2 value)
        ifTrue:[ ^ SchemeBoolean singletonTrue ]
        ifFalse:[ ^ SchemeBoolean singletonFalse ]
!

evaluateList: expr inEnvironment:anEnvironment
    |unevaluatedFunction evaluatedFunction argList|

    unevaluatedFunction := expr car.
    argList := expr cdr.

    "/ syntax
    unevaluatedFunction = (SchemeSymbol new:'define') ifTrue:[
        ^ self evaluateDefine:argList inEnvironment:anEnvironment.
    ].
    unevaluatedFunction = (SchemeSymbol new:'if') ifTrue:[
        ^ self evaluateIf:argList inEnvironment:anEnvironment.
    ].
    unevaluatedFunction = (SchemeSymbol new:'lambda') ifTrue:[
        ^ self evaluateLambda:argList inEnvironment:anEnvironment.
    ].

    "/ rest are unevaluatedFunctions
    
    unevaluatedFunction = (SchemeSymbol new:'+') ifTrue:[
        ^ self evaluatePlus:argList inEnvironment:anEnvironment.
    ].
    unevaluatedFunction = (SchemeSymbol new:'-') ifTrue:[
        ^ self evaluateMinus:argList inEnvironment:anEnvironment.
    ].
    unevaluatedFunction = (SchemeSymbol new:'*') ifTrue:[
        ^ self evaluateTimes:argList inEnvironment:anEnvironment.
    ].
    unevaluatedFunction = (SchemeSymbol new:'<') ifTrue:[
        ^ self evaluateLess:argList inEnvironment:anEnvironment.
    ].
    unevaluatedFunction = (SchemeSymbol new:'write') ifTrue:[
        ^ self evaluateWrite:argList inEnvironment:anEnvironment.
    ].

    evaluatedFunction := self evaluate:unevaluatedFunction inEnvironment:anEnvironment.
    ^ self evaluateUserDefinedFunction:evaluatedFunction withArguments:argList inEnvironment:anEnvironment
!

evaluateMinus: argList inEnvironment:anEnvironment
    |difference restList unevaluatedElement evaluatedElement|

    difference := 0.
    restList := argList.
    restList isSchemeNil ifTrue:[ self error:'- requires at least 1 argument' ].
    difference := (self evaluate:restList car inEnvironment:anEnvironment) value.
    restList := restList cdr.

    restList isSchemeNil ifTrue:[ 
        ^ SchemeInteger new:(difference negated).
    ].
    [ restList isSchemeNil ] whileFalse:[
        unevaluatedElement := restList car.
        evaluatedElement := self evaluate:unevaluatedElement inEnvironment:anEnvironment.
        difference := difference - evaluatedElement value.
        restList := restList cdr.
    ].
    ^ SchemeInteger new:difference
!

evaluatePlus: argList inEnvironment:anEnvironment
    |sum restList unevaluatedElement evaluatedElement|

    sum := 0.
    restList := argList.
    [ restList isSchemeNil ] whileFalse:[
        unevaluatedElement := restList car.
        evaluatedElement := self evaluate:unevaluatedElement inEnvironment:anEnvironment.
        sum := sum + evaluatedElement value.
        restList := restList cdr.
    ].
    ^ SchemeInteger new:sum
!

evaluateString: aString
    |expr|

    expr := SchemeReader readFrom:aString readStream.
    ^ self evaluate: expr.
!

evaluateTimes: argList inEnvironment:anEnvironment
    |product restList unevaluatedElement evaluatedElement|

    product := 1.
    restList := argList.
    [ restList isSchemeNil ] whileFalse:[
        unevaluatedElement := restList car.
        evaluatedElement := self evaluate:unevaluatedElement inEnvironment:anEnvironment.
        product := product * evaluatedElement value.
        restList := restList cdr.
    ].
    ^ SchemeInteger new:product
!

evaluateUserDefinedFunction: aFunction withArguments: argList inEnvironment:anEnvironment
    |newEnvironment functionArgList functionBody restArgs restValues nextArg nextValue|

    newEnvironment := SchemeEnvironment new.
    newEnvironment parent:anEnvironment.

    functionArgList := aFunction argList.
    functionBody := aFunction body.

    restArgs := functionArgList.
    restValues := argList.
    [ restArgs isSchemeNil ] whileFalse:[
        nextArg := restArgs car.
        restArgs := restArgs cdr.
        nextValue := restValues car.
        restValues:= restValues cdr.
        newEnvironment at:nextArg put:(self evaluate:nextValue inEnvironment:anEnvironment).
    ].
    ^ self evaluate:functionBody inEnvironment:newEnvironment.
!

evaluateWrite: argList inEnvironment:anEnvironment
    |restList unevaluatedElement evaluatedElement|

    restList := argList.
    [ restList isSchemeNil ] whileFalse:[
        unevaluatedElement := restList car.
        evaluatedElement := self evaluate:unevaluatedElement inEnvironment:anEnvironment.
        SchemePrinter print:evaluatedElement on:Transcript.
        restList := restList cdr.
    ].
    ^ SchemeVoid singleton
! !

!SchemeEvaluator methodsFor:'initialization'!

initialize
    globalEnvironment := SchemeEnvironment new.
    globalEnvironment at:(SchemeSymbol new:'true') put:(SchemeBoolean singletonTrue).
    globalEnvironment at:(SchemeSymbol new:'false') put:(SchemeBoolean singletonFalse).
! !

!SchemeEvaluator class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

