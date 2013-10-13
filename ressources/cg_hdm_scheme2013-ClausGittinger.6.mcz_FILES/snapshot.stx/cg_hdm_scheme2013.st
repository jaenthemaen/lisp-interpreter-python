"{ Package: 'cg:hdm/scheme2013' }"

ApplicationDefinition subclass:#cg_hdm_scheme2013
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'* Projects & Packages *'
!

!cg_hdm_scheme2013 class methodsFor:'documentation'!

extensionsVersion_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

!cg_hdm_scheme2013 class methodsFor:'description'!

excludedFromPreRequisites
    "list all packages which should be ignored in the automatic
     preRequisites scan. See #preRequisites for more."

    ^ #(
    )
!

isGUIApplication
    "return true, if this is a GUI application.
     (these need more libraries and use a different startup procedure)"

    ^ false
!

mandatoryPreRequisites
    "list all required mandatory packages.
     Packages are mandatory, if they contain superclasses of the package's classes
     or classes which are extended by this package.
     This list can be maintained manually or (better) generated and
     updated by scanning the superclass hierarchies
     (the browser has a menu function for that)
     However, often too much is found, and you may want to explicitely
     exclude individual packages in the #excludedFromPreRequisites method."

    ^ #(
        #'stx:goodies/sunit'    "TestAsserter - superclass of SchemeTests "
        #'stx:libbasic'    "Object - superclass of SchemeEvaluator "
    )
!

referencedPreRequisites
    "list all packages containing classes referenced by the packages's members.
     This list can be maintained manually or (better) generated and
     updated by looking for global variable accesses
     (the browser has a menu function for that)
     However, often too much is found, and you may want to explicitely
     exclude individual packages in the #excludedFromPreRequisites method."

    ^ #(
    )
!

subProjects
    "list packages which are known as subprojects.
     This method is generated automatically; however, when generating automatically,
     packages are only added - never removed, unless listed in #excludedFromSubProjects."

    ^ #(
)
! !

!cg_hdm_scheme2013 class methodsFor:'description - contents'!

classNamesAndAttributes
    "lists the classes which are to be included in the project.
     Each entry in the list may be: a single class-name (symbol),
     or an array-literal consisting of class name and attributes.
     Attributes are: #autoload or #<os> where os is one of win32, unix,..."

    ^ #(
        "<className> or (<className> attributes...) in load order"
        SchemeInterpreter
        SchemeStartup
        #'cg_hdm_scheme2013'
        SchemeEvaluator
        SchemeObject
        SchemePrinter
        SchemeReader
        (SchemeTests autoload)
        SchemeBoolean
        SchemeCons
        SchemeEnvironment
        SchemeNil
        SchemeNumber
        SchemeString
        SchemeSymbol
        SchemeUserDefinedFunction
        SchemeVoid
        SchemeFloat
        SchemeInteger
    )
!

extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
    )
! !

!cg_hdm_scheme2013 class methodsFor:'description - project information'!

applicationIconFileName
    "Return the name (without suffix) of an icon-file (the app's icon); will be included in the rc-resource file"

    ^ nil
    "/ ^ self applicationName
!

companyName
    "Return a companyname which will appear in <lib>.rc"

    ^ 'My Company'
!

description
    "Return a description string which will appear in vc.def / bc.def"

    ^ 'Application'
!

legalCopyright
    "Return a copyright string which will appear in <lib>.rc"

    ^ 'My CopyRight or CopyLeft'
!

productInstallDirBaseName
    "Returns a default installDir which will appear in <app>.nsi.
     This is usually not the one you want to keep"

    ^ (self package asCollectionOfSubstringsSeparatedByAny:':/') last
!

productName
    "Return a product name which will appear in <lib>.rc"

    ^ 'ProductName'
! !

!cg_hdm_scheme2013 class methodsFor:'description - startup'!

startupClassName
    "the class that starts the show in its startupSelector method"

    ^ 'SchemeStartup'
!

startupSelector
    "the message that is sent to the startupClass to start the show"

    ^ #'start'        
! !

!cg_hdm_scheme2013 class methodsFor:'documentation'!

version_MC
    ^ 'cg:hdm/scheme2013-ClausGittinger.6 4da31fd7-c75f-4bba-a826-9878498dc6d7 2013-04-21T10:18:22 ClausGittinger'
! !

