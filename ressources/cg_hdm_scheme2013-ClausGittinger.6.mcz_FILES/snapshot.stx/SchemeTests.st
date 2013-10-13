"{ Package: 'cg:hdm/scheme2013' }"

TestCase subclass:#SchemeTests
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Scheme-tests'
!

!SchemeTests class methodsFor:'documentation'!

documentation
"
    documentation to be added.

    [author:]
        cg

    [instance variables:]

    [class variables:]

    [see also:]

"
! !

!SchemeTests methodsFor:'initialize / release'!

setUp
    "common setup - invoked before testing."

    super setUp
!

tearDown
    "common cleanup - invoked after testing."

    super tearDown
! !

!SchemeTests methodsFor:'tests'!

test_001_nilIsSingleton
    |o1 o2|

    "/ test schemeNil is singleton
    o1 := SchemeNil singleton.
    o2 := SchemeNil singleton.
    self assert:(o1 == o2).
!

test_002_symbolIdentity
    |o1 o2|

    "/ test two symbols are identical if same chars
    o1 := SchemeSymbol new: 'abc'.
    o2 := SchemeSymbol new: 'abc'.
    self assert:(o1 == o2).

    o1 := SchemeSymbol new: 'abc'.
    o2 := SchemeSymbol new: 'abcd'.
    self assert:(o1 ~~ o2).
!

test_003_conses
    |o|

    o := SchemeCons new.
    self assert:(o car isSchemeNil).

    "
     self run:#test1
     self new test1
    "
!

test_004_numbers
    |o|

    o := SchemeInteger new: 1234.
    self assert:(o value = 1234).

    o := SchemeFloat new: 1234.0.
    self assert:(o value = 1234.0).

    self 
        should: [ o := SchemeFloat new: 1234 ]
        raise: Error.
!

test_010_readingAtoms
    |o s|

    o := SchemeReader readFrom: ('1234' readStream).
    self assert:(o isSchemeInteger).
    self assert:(o value = 1234).

"/    o := SchemeReader readFrom: ('-1234' readStream).
"/    self assert:(o isSchemeInteger).
"/    self assert:(o value = -1234).

    o := SchemeReader readFrom: ('    1234' readStream).
    self assert:(o isSchemeInteger).
    self assert:(o value = 1234).

    s := ' 1234 2345' readStream.
    o := SchemeReader readFrom: s.
    self assert:(o isSchemeInteger).
    self assert:(o value = 1234).

    o := SchemeReader readFrom: s.
    self assert:(o isSchemeInteger).
    self assert:(o value = 2345).

    s := ' abc - -+--abcd+++' readStream.
    o := SchemeReader readFrom: s.
    self assert:(o isSchemeSymbol).
    self assert:(o characters = 'abc').

    o := SchemeReader readFrom: s.
    self assert:(o isSchemeSymbol).
    self assert:(o characters = '-').

    o := SchemeReader readFrom: s.
    self assert:(o isSchemeSymbol).
    self assert:(o characters = '-+--abcd+++').

"/    s := ' 1+' readStream.
"/    o := SchemeReader readFrom: s.
"/    self assert:(o isSchemeSymbol).
"/    self assert:(o characters = '1+').
!

test_011_readingStrings
    |o|

    o := SchemeReader readFrom: ('"abc"' readStream).
    self assert:(o isSchemeString).
    self assert:(o isSchemeSymbol not).
    self assert:(o isSchemeInteger not).
    self assert:(o characters = 'abc').

    o := SchemeReader readFrom: ('"a\nbc"' readStream).
    self assert:(o isSchemeString).
    self assert:(o isSchemeSymbol not).
    self assert:(o isSchemeInteger not).
    self assert:(o characters = ('a',Character nl,'bc')).

    o := SchemeReader readFrom: ('"a\"bc"' readStream).
    self assert:(o isSchemeString).
    self assert:(o isSchemeSymbol not).
    self assert:(o isSchemeInteger not).
    self assert:(o characters = ('a"bc')).
!

test_020_readingLists
    |o s|

    o := SchemeReader readFrom: ('()' readStream).
    self assert:(o isSchemeNil).

    o := SchemeReader readFrom: ('    ()' readStream).
    self assert:(o isSchemeNil).

    o := SchemeReader readFrom: ('(  )' readStream).
    self assert:(o isSchemeNil).


    s := ' () ()' readStream.
    o := SchemeReader readFrom: s.
    self assert:(o isSchemeNil).

    o := SchemeReader readFrom: s.
    self assert:(o isSchemeNil).

    o := SchemeReader readFrom: ('(1)' readStream).
    self assert:(o isSchemeCons).
    self assert:(o car isSchemeInteger).
    self assert:(o car value = 1).
    self assert:(o cdr isSchemeNil).

    o := SchemeReader readFrom: ('(   1)' readStream).
    self assert:(o isSchemeCons).
    self assert:(o car isSchemeInteger).
    self assert:(o car value = 1).
    self assert:(o cdr isSchemeNil).

    o := SchemeReader readFrom: ('(   1    )' readStream).
    self assert:(o isSchemeCons).
    self assert:(o car isSchemeInteger).
    self assert:(o car value = 1).
    self assert:(o cdr isSchemeNil).

    o := SchemeReader readFrom: ('(plus 1 2)' readStream).
    self assert:(o isSchemeCons).
    self assert:(o car isSchemeSymbol).
    self assert:(o car characters = 'plus').

    self assert:(o cdr car isSchemeInteger).
    self assert:(o cdr car value = 1).

    self assert:(o cdr cdr car isSchemeInteger).
    self assert:(o cdr cdr car value = 2).

    self assert:(o cdr cdr cdr isSchemeNil).

    o := SchemeReader readFrom: ('(1 2 3)' readStream).
    self assert:(o isSchemeCons).
    self assert:(o car isSchemeInteger).
    self assert:(o car value = 1).

    self assert:(o cdr isSchemeCons).
    self assert:(o cdr car isSchemeInteger).
    self assert:(o cdr car value = 2).

    self assert:(o cdr cdr isSchemeCons).
    self assert:(o cdr cdr car isSchemeInteger).
    self assert:(o cdr cdr car value = 3).

    self assert:(o cdr cdr cdr isSchemeNil).
!

test_021_readingNestedLists
    |o e1 e2 e3|

    o := SchemeReader readFrom: ('( () )' readStream).
    self assert:(o isSchemeCons).
    self assert:(o car isSchemeNil).
    self assert:(o cdr isSchemeNil).

    o := SchemeReader readFrom: ('( ( 1 ) ( 2 3 ) 4 )' readStream).
    self assert:(o isSchemeCons).
    e1 := o car.
    self assert:(e1 isSchemeCons).
    self assert:(e1 car isSchemeIntegerWithValue:1).
    self assert:(e1 cdr isSchemeNil).

    e2 := o cdr car.
    self assert:(e2 isSchemeCons).
    self assert:(e2 car isSchemeIntegerWithValue:2).
    self assert:(e2 cdr car isSchemeIntegerWithValue:3).
    self assert:(e2 cdr cdr isSchemeNil).

    e3 := o cdr cdr car.
    self assert:(e3 isSchemeInteger).

    self assert:(o cdr cdr cdr isSchemeNil).
!

test_030_printingAtoms
    |o s|

    o := SchemeInteger new:123.
    s := WriteStream on:''.
    SchemePrinter print:o on:s.
    self assert:(s contents = '123').

    o := SchemeInteger new:123.
    SchemePrinter print:o on:Transcript.
    SchemePrinter print:o on:Stdout.

    o := SchemeString new:'abc'.
    s := WriteStream on:''.
    SchemePrinter print:o on:s.
    self assert:(s contents = '"abc"').

    o := SchemeSymbol new:'abc'.
    s := WriteStream on:''.
    SchemePrinter print:o on:s.
    self assert:(s contents = 'abc').
!

test_030_printingLists
    |o s|

    o := SchemeReader readFrom:'()' readStream.
    s := WriteStream on:''.
    SchemePrinter print:o on:s.
    self assert:(s contents = '()').

    #(
        '123'                   '123'
        'abc'                   'abc'
        '"abc"'                 '"abc"'
        '()'                    '()'
        '( )'                   '()'
        '  ( )'                 '()'
        '(1 3)'                 '(1 3)'
        '(1 2 3)'               '(1 2 3)'
        '(  1 2 3)'             '(1 2 3)'
        '(  1 2 3   )'          '(1 2 3)'
        '(1 () 3)'              '(1 () 3)' 
        '(1 (2) 3)'             '(1 (2) 3)' 
        '(1 (2 3) 4)'           '(1 (2 3) 4)' 
        '(abc (2 3) 4)'         '(abc (2 3) 4)' 
        '(abc (def ghi) 4)'     '(abc (def ghi) 4)' 
        '("hello" 4)'           '("hello" 4)'
        '("hello" (2 3) 4)'     '("hello" (2 3) 4)'
    ) pairWiseDo:[:eachTestString :eachExpectedResult|
       Transcript showCR:'testing: ',eachTestString.
       s := WriteStream on:''.
       o := SchemeReader readFrom:eachTestString readStream.
       SchemePrinter print:o on:s.
       self assert:(s contents = eachExpectedResult).
    ].
!

test_050_evaluatingAtoms
    |input result stream|

    input := SchemeReader readFrom:'()' readStream.
    result := SchemeEvaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '()').

    input := SchemeReader readFrom:'1234' readStream.
    result := SchemeEvaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '1234').

    input := SchemeReader readFrom:'"hello"' readStream.
    result := SchemeEvaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '"hello"').

    input := SchemeReader readFrom:'true' readStream.
    result := SchemeEvaluator evaluate: input.
    self assert:(result isSchemeTrue).
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = 'true').

    input := SchemeReader readFrom:'false' readStream.
    result := SchemeEvaluator evaluate: input.
    self assert:(result isSchemeFalse).
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = 'false').
!

test_051_evaluatingList
    |input result stream evaluator|

    evaluator := SchemeEvaluator new.

    input := SchemeReader readFrom:'(define a 10)' readStream.
    evaluator evaluate: input.

    input := SchemeReader readFrom:'(define b 20)' readStream.
    evaluator evaluate: input.

    input := SchemeReader readFrom:'(define c 30)' readStream.
    evaluator evaluate: input.

    input := SchemeReader readFrom:'(define d a)' readStream.
    evaluator evaluate: input.
    input := SchemeReader readFrom:'d' readStream.
    result := evaluator evaluate: input.
    self assert:(result isSchemeIntegerWithValue:10).

    input := SchemeReader readFrom:'(define e (+ a 20))' readStream.
    evaluator evaluate: input.
    input := SchemeReader readFrom:'e' readStream.
    result := evaluator evaluate: input.
    self assert:(result isSchemeIntegerWithValue:30).

    input := SchemeReader readFrom:'(+ a 1)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '11').

    input := SchemeReader readFrom:'(+ (+ a 1) (+ b 2))' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '33').

    Transcript clear.
    input := SchemeReader readFrom:'(write 123)' readStream.
    result := evaluator evaluate: input.
    self assert:(result isSchemeVoid).
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '').
    Transcript flush.
    self assert:(Transcript contents asStringCollection first = '123').
!

test_052_evaluatingConditions
    |input result stream evaluator|

    evaluator := SchemeEvaluator new.

    self should:[
        input := SchemeReader readFrom:'(<)' readStream.
        result := evaluator evaluate: input.
    ] raise:Error.

    self should:[
        input := SchemeReader readFrom:'(< 1 2 3)' readStream.
        result := evaluator evaluate: input.
    ] raise:Error.

    input := SchemeReader readFrom:'(< 1 2)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = 'true').

    input := SchemeReader readFrom:'(< 1 1)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = 'false').

    input := SchemeReader readFrom:'(< 1 0)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = 'false').
!

test_053_evaluatingIf
    |input result stream evaluator|

    evaluator := SchemeEvaluator new.

    input := SchemeReader readFrom:'(if true 0 1)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '0').

    input := SchemeReader readFrom:'(if false 0 1)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '1').

    input := SchemeReader readFrom:'(if (< 10 20) 1 0)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '1').

    input := SchemeReader readFrom:'(if (< 20 10) 1 0)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '0').

    Transcript clear.
    input := SchemeReader readFrom:'(if (< 10 20) (write "hello") (write "world"))' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '').
    Transcript flush.
    self assert:(Transcript contents asStringCollection first = '"hello"').
!

test_054_evaluatingArithmetic
    |input result stream evaluator|

    evaluator := SchemeEvaluator new.

    input := SchemeReader readFrom:'(+)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '0').

    input := SchemeReader readFrom:'(+ 1 2)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '3').

    input := SchemeReader readFrom:'(+ 10)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '10').

    input := SchemeReader readFrom:'(+ 10 1)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '11').

    input := SchemeReader readFrom:'(+ (+ 1 2) 3)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '6').

    input := SchemeReader readFrom:'(+ (+ 10 1) (+ 20 2))' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '33').

    input := SchemeReader readFrom:'(*)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '1').

    input := SchemeReader readFrom:'(* 3 2)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '6').

    input := SchemeReader readFrom:'(* 10)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '10').

    input := SchemeReader readFrom:'(+ 10 1)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '11').

    input := SchemeReader readFrom:'(* (+ 1 2) 3)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '9').

    input := SchemeReader readFrom:'(* (+ 10 1) (+ 20 2))' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '242').

    input := SchemeReader readFrom:'(- 2 1)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '1').

    input := SchemeReader readFrom:'(- 10)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '-10').

    input := SchemeReader readFrom:'(- 10 1 2)' readStream.
    result := evaluator evaluate: input.
    SchemePrinter print:result on:(stream := WriteStream on:'').
    self assert:(stream contents = '7').
!

test_060_defineFunction
    |input result evaluator|

    evaluator := SchemeEvaluator new.

    input := SchemeReader readFrom:'(lambda (a b c) (+ a b c 1))' readStream.
    result := evaluator evaluate: input.
    self assert:(result isSchemeUserDefinedFunction).

    input := SchemeReader readFrom:'(lambda () 123 )' readStream.
    result := evaluator evaluate: input.
    self assert:(result isSchemeUserDefinedFunction).

    result := evaluator evaluateString: '(define f (lambda (a b c) (+ a b c 1)))'.

    input := SchemeReader readFrom:'f' readStream.
    result := evaluator evaluate: input.
    self assert:(result isSchemeUserDefinedFunction).

"/    input := SchemeReader readFrom:'(f 10 20 30)' readStream.
"/    result := evaluator evaluate: input.
"/    self assert:(result isSchemeIntegerWithValue:61).
"/
"/    result := evaluator evaluateString: '(define globalA 10)'.
"/    result := evaluator evaluateString: '(define globalB 20)'.
"/    result := evaluator evaluateString: '(define globalC (+ a b))'.

"/    input := SchemeReader readFrom:'(f globalA globalB globalC)' readStream.
"/    result := evaluator evaluate: input.
"/    self assert:(result isSchemeIntegerWithValue:61).    

    result := evaluator evaluateString: '(define a 10)'.
    result := evaluator evaluateString: '(define b 20)'.
    result := evaluator evaluateString: '(define c 30)'.

    input := SchemeReader readFrom:'(f c b a)' readStream.
    result := evaluator evaluate: input.
    self assert:(result isSchemeIntegerWithValue:61).
!

test_061_factorial
    |result evaluator|

    evaluator := SchemeEvaluator new.

    result := evaluator evaluateString:'
(define fac 
  (lambda (n)
   (if (< n 2)
        1
        (* n (fac (- n 1))))
  )
)
'.

    result := evaluator evaluateString: 'fac'.
    self assert:(result isSchemeUserDefinedFunction).

    result := evaluator evaluateString: '(fac 10)'.
    self assert:(result isSchemeIntegerWithValue:3628800).
! !

!SchemeTests class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

