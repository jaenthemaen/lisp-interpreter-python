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
main:argv 
! !

!SchemeStartup class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

Object subclass:#SchemeEvaluator
	instanceVariableNames:'globalEnvironment'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Evaluator'!

!SchemeEvaluator class methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluate:expr
! !

!SchemeEvaluator class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new
! !

!SchemeEvaluator class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluate: schemeExpression
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluate: schemeExpression inEnvironment:anEnvironment
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateDefine: argList inEnvironment:anEnvironment
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateIf: argList inEnvironment:anEnvironment
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateLambda: argList inEnvironment:anEnvironment
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateLess: argList inEnvironment:anEnvironment
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateList: expr inEnvironment:anEnvironment
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateMinus: argList inEnvironment:anEnvironment
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluatePlus: argList inEnvironment:anEnvironment
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateString: aString
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateTimes: argList inEnvironment:anEnvironment
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateUserDefinedFunction: aFunction withArguments: argList inEnvironment:anEnvironment
! !

!SchemeEvaluator methodsFor: 'evaluation' stamp: 'cg 04202013 13:02'!
evaluateWrite: argList inEnvironment:anEnvironment
! !

!SchemeEvaluator methodsFor: 'initialization' stamp: 'cg 04202013 13:02'!
initialize
! !

Object subclass:#SchemeInterpreter
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Startup'!

!SchemeInterpreter class methodsFor: 'main' stamp: 'cg 04202013 12:53'!
readEvalPrint
! !

!SchemeInterpreter class methodsFor: 'main' stamp: 'cg 04202013 12:53'!
topLevelReadEvalPrintLoop
! !

!SchemeInterpreter class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
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
new
! !

!SchemeBoolean class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
singletonFalse
! !

!SchemeBoolean class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
singletonTrue
! !

!SchemeBoolean class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

!SchemeBoolean methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeFalse
! !

!SchemeBoolean methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeTrue
! !

SchemeObject subclass:#SchemeCons
	instanceVariableNames:'car cdr'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeCons class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new
! !

!SchemeCons class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

!SchemeCons methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
car
! !

!SchemeCons methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
car:something
! !

!SchemeCons methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
car:carArg cdr:cdrArg 
! !

!SchemeCons methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
cdr
! !

!SchemeCons methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
cdr:something
! !

!SchemeCons methodsFor: 'initialization' stamp: 'cg 04202013 13:02'!
initialize
! !

!SchemeCons methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeCons
! !

SchemeObject subclass:#SchemeEnvironment
	instanceVariableNames:'hashTable parent'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeEnvironment class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new
! !

!SchemeEnvironment class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

!SchemeEnvironment methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
at:aSchemeSymbol 
! !

!SchemeEnvironment methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
at:aSchemeSymbol put:aSchemeObject
! !

!SchemeEnvironment methodsFor: 'initialization' stamp: 'cg 04202013 13:02'!
initialize
! !

!SchemeEnvironment methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
parent
! !

!SchemeEnvironment methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
parent:something
! !

SchemeObject subclass:#SchemeNil
	instanceVariableNames:''
	classVariableNames:'TheOneAndOnlyInstance'
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeNil class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new
! !

!SchemeNil class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
singleton
! !

!SchemeNil class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

!SchemeNil methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeNil
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
new:arg
! !

!SchemeFloat class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

SchemeNumber subclass:#SchemeInteger
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeInteger class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

!SchemeInteger methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeIntegerWithValue:x
! !

!SchemeNumber class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new:arg
! !

!SchemeNumber class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

!SchemeNumber methodsFor: 'initialization' stamp: 'cg 04202013 13:02'!
initializeNew:arg
! !

!SchemeNumber methodsFor: 'printing & storing' stamp: 'cg 04202013 13:02'!
printOn: aStream
! !

!SchemeNumber methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
value
! !

!SchemeNumber methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
value:something
! !

!SchemeObject class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeCons
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeFalse
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeInteger
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeIntegerWithValue:x
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeNil
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeString
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeSymbol
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeTrue
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeUserDefinedFunction
! !

!SchemeObject methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeVoid
! !

!SchemeObject methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
printOn:aStream
! !

SchemeObject subclass:#SchemeString
	instanceVariableNames:'characters'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeString class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new: aString
! !

!SchemeString class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

!SchemeString methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
characters
! !

!SchemeString methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
characters:something
! !

!SchemeString methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeString
! !

SchemeObject subclass:#SchemeSymbol
	instanceVariableNames:'characters'
	classVariableNames:'AllKnownInstances'
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeSymbol class methodsFor: 'initialization' stamp: 'cg 04202013 13:02'!
initialize
! !

!SchemeSymbol class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new:aString
! !

!SchemeSymbol class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

!SchemeSymbol methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
characters
! !

!SchemeSymbol methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
characters:something
! !

!SchemeSymbol methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeSymbol
! !

!SchemeSymbol methodsFor: 'printing & storing' stamp: 'cg 04202013 13:02'!
printOn: aStream
! !

SchemeObject subclass:#SchemeUserDefinedFunction
	instanceVariableNames:'argList body'
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeUserDefinedFunction class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

!SchemeUserDefinedFunction methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
argList
! !

!SchemeUserDefinedFunction methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
argList:argListArg body:bodyArg 
! !

!SchemeUserDefinedFunction methodsFor: 'accessing' stamp: 'cg 04202013 13:02'!
body
! !

!SchemeUserDefinedFunction methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeUserDefinedFunction
! !

SchemeObject subclass:#SchemeVoid
	instanceVariableNames:''
	classVariableNames:'TheOneAndOnlyInstance'
	poolDictionaries:''
	category:'Scheme-Objects'!

!SchemeVoid class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
new
! !

!SchemeVoid class methodsFor: 'instance creation' stamp: 'cg 04202013 13:02'!
singleton
! !

!SchemeVoid class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

!SchemeVoid methodsFor: 'testing' stamp: 'cg 04202013 13:02'!
isSchemeVoid
! !

Object subclass:#SchemePrinter
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Reader/Writer'!

!SchemePrinter class methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
print:anObject on:aStream
! !

!SchemePrinter class methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
printInteger:anObject on:aStream
! !

!SchemePrinter class methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
printList:anObject on:aStream
! !

!SchemePrinter class methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
printRestList:anObject on:aStream
! !

!SchemePrinter class methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
printString:anObject on:aStream
! !

!SchemePrinter class methodsFor: 'printing' stamp: 'cg 04202013 13:02'!
printSymbol:anObject on:aStream
! !

!SchemePrinter class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

Object subclass:#SchemeReader
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-Reader/Writer'!

!SchemeReader class methodsFor: 'reading' stamp: 'cg 04202013 13:02'!
readFrom:aStream   
! !

!SchemeReader class methodsFor: 'reading' stamp: 'cg 04202013 13:02'!
readSchemeListFrom:aStream
! !

!SchemeReader class methodsFor: 'reading' stamp: 'cg 04202013 13:02'!
readSchemeNumberFrom:aStream
! !

!SchemeReader class methodsFor: 'reading' stamp: 'cg 04202013 13:02'!
readSchemeStringFrom:aStream
! !

!SchemeReader class methodsFor: 'reading' stamp: 'cg 04202013 13:02'!
readSchemeSymbolFrom:aStream
! !

!SchemeReader class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

TestCase subclass:#SchemeTests
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-tests'!

!SchemeTests class methodsFor: 'documentation' stamp: 'cg 04202013 13:02'!
documentation
! !

!SchemeTests class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !

!SchemeTests methodsFor: 'initialize / release' stamp: 'cg 04202013 13:02'!
setUp
! !

!SchemeTests methodsFor: 'initialize / release' stamp: 'cg 04202013 13:02'!
tearDown
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_001_nilIsSingleton
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_002_symbolIdentity
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_003_conses
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_004_numbers
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_010_readingAtoms
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_011_readingStrings
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_020_readingLists
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_021_readingNestedLists
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_030_printingAtoms
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_030_printingLists
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_050_evaluatingAtoms
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_051_evaluatingList
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_052_evaluatingConditions
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_053_evaluatingIf
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_054_evaluatingArithmetic
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_060_defineFunction
! !

!SchemeTests methodsFor: 'tests' stamp: 'cg 04202013 13:02'!
test_061_factorial
! !

ApplicationDefinition subclass:#'cg_hdm_scheme2013'
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'* Projects & Packages *'!

!cg_hdm_scheme2013 class methodsFor: 'description - project information' stamp: 'cg 04202013 12:53'!
applicationIconFileName
! !

!cg_hdm_scheme2013 class methodsFor: 'description - contents' stamp: 'cg 04202013 13:02'!
classNamesAndAttributes
! !

!cg_hdm_scheme2013 class methodsFor: 'description - project information' stamp: 'cg 04202013 12:53'!
companyName
! !

!cg_hdm_scheme2013 class methodsFor: 'description - project information' stamp: 'cg 04202013 12:53'!
description
! !

!cg_hdm_scheme2013 class methodsFor: 'description' stamp: 'cg 04202013 12:53'!
excludedFromPreRequisites
! !

!cg_hdm_scheme2013 class methodsFor: 'description - contents' stamp: 'cg 04202013 12:53'!
extensionMethodNames
! !

!cg_hdm_scheme2013 class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
extensionsVersion_MC
! !

!cg_hdm_scheme2013 class methodsFor: 'description' stamp: 'cg 04202013 12:53'!
isGUIApplication
! !

!cg_hdm_scheme2013 class methodsFor: 'description - project information' stamp: 'cg 04202013 12:53'!
legalCopyright
! !

!cg_hdm_scheme2013 class methodsFor: 'description' stamp: 'cg 04202013 13:02'!
mandatoryPreRequisites
! !

!cg_hdm_scheme2013 class methodsFor: 'description - project information' stamp: 'cg 04202013 12:53'!
productInstallDirBaseName
! !

!cg_hdm_scheme2013 class methodsFor: 'description - project information' stamp: 'cg 04202013 12:53'!
productName
! !

!cg_hdm_scheme2013 class methodsFor: 'description' stamp: 'cg 04202013 12:53'!
referencedPreRequisites
! !

!cg_hdm_scheme2013 class methodsFor: 'description - startup' stamp: 'cg 04202013 12:53'!
startupClassName
! !

!cg_hdm_scheme2013 class methodsFor: 'description - startup' stamp: 'cg 04202013 12:53'!
startupSelector
! !

!cg_hdm_scheme2013 class methodsFor: 'description' stamp: 'cg 04202013 12:53'!
subProjects
! !

!cg_hdm_scheme2013 class methodsFor: 'documentation' stamp: 'cg 04212013 10:18'!
version_MC
! !
SchemeSymbol initialize
!