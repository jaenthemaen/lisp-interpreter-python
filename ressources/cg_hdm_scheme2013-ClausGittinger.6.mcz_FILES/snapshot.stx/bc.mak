# $Header$
#
# DO NOT EDIT 
# automagically generated from the projectDefinition: cg_hdm_scheme2013.
#
# Warning: once you modify this file, do not rerun
# stmkmp or projectDefinition-build again - otherwise, your changes are lost.
#
# Historic Note:
#  this used to contain only rules to make with borland 
#    (called via bmake, by "make.exe -f bc.mak")
#  this has changed; it is now also possible to build using microsoft visual c
#    (called via vcmake, by "make.exe -f bc.mak -DUSEVC")
#

TOP=..\..\..\stx       
INCLUDE_TOP=$(TOP)\..

# An old file, used as a dummy target for FORCE if we do not want
#   re-make libraries. Windows make does not work if we redefine FORCE=   (empty string)
OLD_FILE=bmake.bat

!ifndef FORCE
# dummy target to force a build
FORCE=$(OLD_FILE)
!endif

CFLAGS_LOCAL=$(CFLAGS_APPTYPE) \
 -DSTARTUP_CLASS="\"SchemeStartup\"" \
 -DSTARTUP_SELECTOR="\"start\"" \
 -DUSE_MODULE_TABLE

#

!INCLUDE $(TOP)\rules\stdHeader_bc
!INCLUDE Make.spec

OBJS= $(COMMON_OBJS) $(WIN32_OBJS)



#
LIBNAME=dummy
STCOPT="+optinline"
LOCALINCLUDES= -I$(INCLUDE_TOP)\stx\goodies\sunit -I$(INCLUDE_TOP)\stx\libbasic
LOCALDEFINES=
GLOBALDEFINES=

STCLOCALOPT='-package=$(PACKAGE)' $(LOCALDEFINES) $(LOCALINCLUDES)  $(STCLOCALOPTIMIZATIONS) $(STCWARNINGS) $(LOCALDEFINES) $(COMMONSYMFLAG) -varPrefix=$(LIBNAME)

LFLAGS=$(APP_LFLAGS)

PROJECT_NOCONSOLE= scheme2013.exe
PROJECT_CONSOLE= scheme2013.com
ALLOBJFILES= main.$(O)
!ifdef USETCC
RESFILES=
!else
RESFILES= scheme2013WinRC.$(RES)
!endif

ALLOBJ= $(ALLOBJFILES) $(OBJS)
DEFFILE=$(TOP)\rules\bc_exe.def

LIBFILES=$(LIBDIR_LIBRUN)\librun.lib
ALLLIB=$(LIBFILES) $(APP_IMPORTLIBS) $(APP_RT_LIB)

REQUIRED_LIBS=librun.dll  \
 libstx_libbasic.dll \
 libstx_libbasic2.dll \
 libstx_libcomp.dll \
 libstx_libview.dll \
 libstx_libui.dll \
 libstx_libview2.dll \
 libstx_goodies_sunit.dll \


# REQUIRED_FILES=cs3245.dll X11.dll Xext.dll symbols.stc $(REQUIRED_LIBS)
REQUIRED_FILES=$(RT_DLL) $(X11_DLL) $(XEXT_DLL) symbols.stc $(REQUIRED_LIBS)

REQUIRED_SUPPORT_DIRS=RESOURCEFILES

target: ALL postBuildCleanup 

# the executable, all required files and a self-installing-installer-exe
ALL:: prereq ALL_NP

# all, but no prereqs
ALL_NP:: exe $(REQUIRED_SUPPORT_DIRS) postBuildCleanup setup

exe:  newBuildDate $(REQUIRED_LIBS) noConsoleApp consoleApp

# the executable only
# with console
consoleApp: $(REQUIRED_LIBS)
	-del main.$(O)
	$(MAKE) -N -f bc.mak $(USE_ARG) \
		MAKE_BAT=$(MAKE_BAT) \
		PROJECT=$(PROJECT_CONSOLE) \
		CFLAGS_APPTYPE=" -DWIN32GUI $(CFLAGS_CONSOLE)" \
		LFLAGS_APPTYPE=" $(LFLAGS_CONSOLE)" \
		CRT_STARTUP=" $(CRT_STARTUP_CONSOLE)" theExe

# without console
noConsoleApp: $(REQUIRED_LIBS)
	-del main.$(O)
	$(MAKE) -N -f bc.mak $(USE_ARG) \
		MAKE_BAT=$(MAKE_BAT) \
		PROJECT=$(PROJECT_NOCONSOLE) \
		CFLAGS_APPTYPE=" -DWIN32GUI $(CFLAGS_NOCONSOLE) -DWIN_LOGFILE="\\"\"scheme2013.log\\"\""" \
		LFLAGS_APPTYPE=" $(LFLAGS_NOCONSOLE)" \
		CRT_STARTUP=" $(CRT_STARTUP_NOCONSOLE)" theExe

# the executable only (internal target; needs some defines)
theExe: $(OUTDIR) $(OBJS) $(REQUIRED_FILES) show $(PROJECT) 

# build all mandatory prerequisite packages (containing superclasses) for this package
prereq:
	$(MAKE) -N -f bc.mak FORCE=FORCE_BUILD $(REQUIRED_LIBS)

FORCE_BUILD:
	@rem Dummy target to force a build

# a nullsoft installable delivery
# This uses the Nullsoft Installer Package and works in Windows only
setup: $(PROJECT) postBuildCleanup scheme2013.nsi
	$(MAKENSIS) scheme2013.nsi

newBuildDate:
	del buildDate.h

new:
	$(MAKE_BAT) clean
	$(MAKE_BAT)

RESOURCEFILES: scheme2013_RESOURCES scheme2013_BITMAPS  \
	stx_RESOURCES stx_STYLES stx_BITMAPS


scheme2013_RESOURCES: resources\cg\hdm\scheme2013\NUL
	-copy ..\resources\*.rs resources\cg\hdm\scheme2013\..
	-copy ..\resources\*.style resources\cg\hdm\scheme2013\..

scheme2013_BITMAPS: resources\cg\hdm\scheme2013\bitmaps\NUL
	-copy *.ico resources\cg\hdm\scheme2013\bitmaps
	-copy *.gif resources\cg\hdm\scheme2013\bitmaps

resources\cg\hdm\scheme2013\bitmaps\NUL: resources\cg\hdm\scheme2013\NUL
	mkdir resources\cg\hdm\scheme2013\bitmaps

resources\cg\hdm\scheme2013\NUL: resources\cg\hdm\NUL
	mkdir resources\cg\hdm\scheme2013

resources\cg\hdm\NUL: resources\cg\NUL
	mkdir resources\cg\hdm
resources\cg\NUL: resources\NUL
	mkdir resources\cg



stx_RESOURCES: \
	keyboard.rc \
	keyboardMacros.rc \
	host.rc \
	h_win32.rc \
	display.rc \
	d_win32.rc \
	libbasic_RESOURCES \
	libview_RESOURCES \
	libtool_RESOURCES  \
	libtool2_RESOURCES

keyboard.rc: $(TOP)\projects\smalltalk\keyboard.rc
	copy $(TOP)\projects\smalltalk\keyboard.rc *.*

keyboardMacros.rc: $(TOP)\projects\smalltalk\keyboardMacros.rc
	copy $(TOP)\projects\smalltalk\keyboardMacros.rc *.*

host.rc: $(TOP)\projects\smalltalk\host.rc
	copy $(TOP)\projects\smalltalk\host.rc *.*

h_win32.rc: $(TOP)\projects\smalltalk\h_win32.rc
	copy $(TOP)\projects\smalltalk\h_win32.rc *.*

display.rc: $(TOP)\projects\smalltalk\display.rc
	copy $(TOP)\projects\smalltalk\display.rc *.*

d_win32.rc: $(TOP)\projects\smalltalk\d_win32.rc
	copy $(TOP)\projects\smalltalk\d_win32.rc *.*

stx_STYLES: resources\stx\libview\NUL resources\stx\libview\styles\NUL
	-copy $(TOP)\libview\styles\*.style resources\stx\libview\styles\*.*
	-copy $(TOP)\libview\styles\*.common resources\stx\libview\styles\*.*

stx_BITMAPS: \
	libwidg_BITMAPS

libwidg_BITMAPS: resources\stx\libwidg\bitmaps\NUL
	-copy $(TOP)\libwidg\bitmaps\*.xpm resources\stx\libwidg\bitmaps\*.*

libbasic_RESOURCES: resources\stx\libbasic\NUL
	copy $(TOP)\libbasic\resources\*.rs resources\stx\libbasic\*.*

libtool_RESOURCES: resources\stx\libtool\NUL
	-copy $(TOP)\libtool\resources\*.rs resources\stx\libtool\*.*

libtool2_RESOURCES: resources\stx\libtool2\NUL
	-copy $(TOP)\libtool2\resources\*.rs resources\stx\libtool2\*.*

libview_RESOURCES: resources\stx\libview\NUL 
	-copy $(TOP)\libview\resources\*.rs resources\stx\libview\*.*

libview2_RESOURCES: resources\stx\libview2\NUL
	-copy $(TOP)\libview2\resources\*.rs resources\stx\libview2\*.*

resources\stx\libbasic\NUL: resources\stx\NUL
	mkdir resources\stx\libbasic

resources\stx\libtool\NUL: resources\stx\NUL
	mkdir resources\stx\libtool

resources\stx\libtool2\NUL: resources\stx\NUL
	mkdir resources\stx\libtool2

resources\stx\libview\NUL: resources\stx\NUL
	mkdir resources\stx\libview

resources\stx\libview\styles\NUL: resources\stx\libview\NUL
	mkdir resources\stx\libview\styles

resources\stx\libview2\NUL: resources\stx\NUL
	mkdir resources\stx\libview2

resources\stx\libwidg\bitmaps\NUL: resources\stx\libwidg\NUL
	mkdir resources\stx\libwidg\bitmaps

resources\stx\libwidg\NUL: resources\stx\NUL
	mkdir resources\stx\libwidg

resources\stx\NUL: resources\NUL
	mkdir resources\stx

resources\NUL:
	mkdir resources

bitmaps\NUL:
	mkdir bitmaps

doc\NUL:
	mkdir doc






libstx_libbasic.dll: ..\..\..\stx\libbasic\$(OBJDIR)\libstx_libbasic.dll
	copy ..\..\..\stx\libbasic\$(OBJDIR)\libstx_libbasic.dll *.*

..\..\..\stx\libbasic\$(OBJDIR)\libstx_libbasic.dll: $(FORCE)
	pushd ..\..\..\stx\libbasic & $(MAKE_BAT) "CFLAGS_LOCAL=$(GLOBALDEFINES)"

libstx_libbasic2.dll: ..\..\..\stx\libbasic2\$(OBJDIR)\libstx_libbasic2.dll
	copy ..\..\..\stx\libbasic2\$(OBJDIR)\libstx_libbasic2.dll *.*

..\..\..\stx\libbasic2\$(OBJDIR)\libstx_libbasic2.dll: $(FORCE)
	pushd ..\..\..\stx\libbasic2 & $(MAKE_BAT) "CFLAGS_LOCAL=$(GLOBALDEFINES)"

libstx_libcomp.dll: ..\..\..\stx\libcomp\$(OBJDIR)\libstx_libcomp.dll
	copy ..\..\..\stx\libcomp\$(OBJDIR)\libstx_libcomp.dll *.*

..\..\..\stx\libcomp\$(OBJDIR)\libstx_libcomp.dll: $(FORCE)
	pushd ..\..\..\stx\libcomp & $(MAKE_BAT) "CFLAGS_LOCAL=$(GLOBALDEFINES)"

libstx_libview.dll: ..\..\..\stx\libview\$(OBJDIR)\libstx_libview.dll
	copy ..\..\..\stx\libview\$(OBJDIR)\libstx_libview.dll *.*

..\..\..\stx\libview\$(OBJDIR)\libstx_libview.dll: $(FORCE)
	pushd ..\..\..\stx\libview & $(MAKE_BAT) "CFLAGS_LOCAL=$(GLOBALDEFINES)"

libstx_libui.dll: ..\..\..\stx\libui\$(OBJDIR)\libstx_libui.dll
	copy ..\..\..\stx\libui\$(OBJDIR)\libstx_libui.dll *.*

..\..\..\stx\libui\$(OBJDIR)\libstx_libui.dll: $(FORCE)
	pushd ..\..\..\stx\libui & $(MAKE_BAT) "CFLAGS_LOCAL=$(GLOBALDEFINES)"

libstx_libview2.dll: ..\..\..\stx\libview2\$(OBJDIR)\libstx_libview2.dll
	copy ..\..\..\stx\libview2\$(OBJDIR)\libstx_libview2.dll *.*

..\..\..\stx\libview2\$(OBJDIR)\libstx_libview2.dll: $(FORCE)
	pushd ..\..\..\stx\libview2 & $(MAKE_BAT) "CFLAGS_LOCAL=$(GLOBALDEFINES)"

libstx_goodies_sunit.dll: ..\..\..\stx\goodies\sunit\$(OBJDIR)\libstx_goodies_sunit.dll
	copy ..\..\..\stx\goodies\sunit\$(OBJDIR)\libstx_goodies_sunit.dll *.*

..\..\..\stx\goodies\sunit\$(OBJDIR)\libstx_goodies_sunit.dll: $(FORCE)
	pushd ..\..\..\stx\goodies\sunit & $(MAKE_BAT) "CFLAGS_LOCAL=$(GLOBALDEFINES)"

      


sources\NUL: 
	mkdir sources

show:
	@echo LFLAGS= $(LFLAGS)
	@echo ALLOBJ= $(ALLOBJ)
	@echo PROJECT= $(PROJECT)
	@echo APP_IMPORTLIBS= $(APP_IMPORTLIBS)
	@echo ALLLIB= $(ALLLIB)
	@echo DEFFILE= $(DEFFILE)
	@echo ALLRES= $(ALLRES)

!ifdef USEBC

$(PROJECT_CONSOLE): $(ALLOBJFILES) $(OBJS) $(RESFILES) $(DEFFILE) $(LIBFILES)
	$(APP_LINKER) $(LFLAGS) $(LFLAGS_APPTYPE) $(CRT_STARTUP) $(ALLOBJ), $(PROJECT_CONSOLE),, $(ALLLIB), $(DEFFILE), $(RESFILES)

$(PROJECT_NOCONSOLE): $(ALLOBJFILES) $(OBJS) $(RESFILES) $(DEFFILE) $(LIBFILES)
	$(APP_LINKER) $(LFLAGS) $(LFLAGS_APPTYPE) $(CRT_STARTUP) $(ALLOBJ), $(PROJECT_NOCONSOLE),, $(ALLLIB), $(DEFFILE), $(RESFILES)

!else
! ifdef USEVC

$(PROJECT_CONSOLE): $(ALLOBJFILES) $(OBJS) $(RESFILES) $(DEFFILE) $(LIBFILES)
	$(APP_LINKER) $(LFLAGS) $(LFLAGS_APPTYPE) $(CRT_STARTUP) $(ALLOBJ) /OUT:"$(PROJECT_CONSOLE)" \
	    /MANIFEST /MANIFESTFILE:"$(PROJECT_CONSOLE).manifest" \
	    /PDB:"$(PROJECT_CONSOLE).pdb" \
	    /SUBSYSTEM:CONSOLE $(ALLLIB) $(RESFILES)

$(PROJECT_NOCONSOLE): $(ALLOBJFILES) $(OBJS) $(RESFILES) $(DEFFILE) $(LIBFILES)
	$(APP_LINKER) $(LFLAGS) $(LFLAGS_APPTYPE) $(CRT_STARTUP) $(ALLOBJ) /OUT:"$(PROJECT_NOCONSOLE)" \
	    /MANIFEST /MANIFESTFILE:"$(PROJECT_NOCONSOLE).manifest" \
	    /PDB:"$(PROJECT_NOCONSOLE).pdb" \
	    /SUBSYSTEM:WINDOWS $(ALLLIB) $(RESFILES)

! else
!  ifdef USELCC

$(PROJECT_CONSOLE): $(ALLOBJFILES) $(OBJS) $(RESFILES) $(DEFFILE) $(LIBFILES)
	$(APP_LINKER) -subsystem console $(LFLAGS) $(LFLAGS_APPTYPE) $(CRT_STARTUP) $(ALLOBJ) -o "$(PROJECT_CONSOLE)" $(ALLLIB) $(RESFILES)

$(PROJECT_NOCONSOLE): $(ALLOBJFILES) $(OBJS) $(RESFILES) $(DEFFILE) $(LIBFILES)
	$(APP_LINKER) -subsystem windows $(LFLAGS) $(LFLAGS_APPTYPE) $(CRT_STARTUP) $(ALLOBJ) -o "$(PROJECT_NOCONSOLE)" $(ALLLIB) $(RESFILES)

!  else
!   ifdef USETCC

$(PROJECT_CONSOLE): $(ALLOBJFILES) $(OBJS) $(RESFILES) $(DEFFILE) $(LIBFILES)
	$(APP_LINKER) $(LFLAGS) $(LFLAGS_APPTYPE) $(CRT_STARTUP) $(ALLOBJ) -o "$(PROJECT_CONSOLE)" $(ALLLIB) $(RESFILES)

$(PROJECT_NOCONSOLE): $(ALLOBJFILES) $(OBJS) $(RESFILES) $(DEFFILE) $(LIBFILES)
	$(APP_LINKER) $(LFLAGS) $(LFLAGS_APPTYPE) $(CRT_STARTUP) $(ALLOBJ) -o "$(PROJECT_NOCONSOLE)" $(ALLLIB) $(RESFILES)

!   else
!    if defined(USEMINGW32) || defined(USEMINGW64)

$(PROJECT_CONSOLE): $(ALLOBJFILES) $(OBJS) $(RESFILES) $(DEFFILE) $(LIBFILES) show
	$(APP_LINKER) $(LFLAGS) $(LFLAGS_APPTYPE) $(CRT_STARTUP) $(ALLOBJ) -o "$(PROJECT_CONSOLE)" $(ALLLIB) $(RESFILES)

$(PROJECT_NOCONSOLE): $(ALLOBJFILES) $(OBJS) $(RESFILES) $(DEFFILE) $(LIBFILES) show
	$(APP_LINKER) $(LFLAGS) $(LFLAGS_APPTYPE) $(CRT_STARTUP) $(ALLOBJ) -o "$(PROJECT_NOCONSOLE)" $(ALLLIB) $(APP_IMPORTLIBS) $(RESFILES)

!    else
error error error
!    endif
!   endif
!  endif
! endif
!endif

!INCLUDE $(TOP)\rules\stdRules_bc

#
# additional rules
#
scheme2013Win.$(RES): scheme2013Win.rc scheme2013.ico

main.$(O): buildDate.h main.c bc.mak

main.c: $(TOP)\librun\main.c
	copy $(TOP)\librun\main.c main.c

# now in stdRules.
#buildDate.h: $(GENDATE_UTILITIY)
#        $(GENDATE_UTILITIY)

librun.dll: $(TOP)\librun\$(OBJDIR_LIBRUN)\librun.dll
	copy $(TOP)\librun\$(OBJDIR_LIBRUN)\librun.dll librun.dll

cs3245.dll: $(TOP)\support\win32\borland\cs3245.dll
	copy $(TOP)\support\win32\borland\cs3245.dll cs3245.dll

X11.dll: $(TOP)\support\win32\X11.dll
	copy $(TOP)\support\win32\X11.dll X11.dll

Xext.dll: $(TOP)\support\win32\Xext.dll
	copy $(TOP)\support\win32\Xext.dll Xext.dll

symbols.stc: $(TOP)\include\symbols.stc
	copy $(TOP)\include\symbols.stc symbols.stc





clean::
	-del genDate.exe genDate.com
	-del c0x32.dll
	-del c0x32.lib
	-del buildDate.h
	-del $(PROJECT)
	-del install_scheme2013.exe
	-del stx.lib
	-del stx.dll
	-del cs3245.dll
	-del $(REQUIRED_FILES)
	-del main.c
	-del *.log
	-del *.$(RES)
	-rmdir /S /Q resources
	-rmdir /S /Q $(OBJDIR)

clobber:: clean
	-del *.dll *.exe *.com

postBuildCleanup::
	@rem  stupid win-make does not allow empty

# BEGINMAKEDEPEND --- do not remove this line; make depend needs it
$(OUTDIR)SchemeEvaluator.$(O) SchemeEvaluator.$(H): SchemeEvaluator.st $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeInterpreter.$(O) SchemeInterpreter.$(H): SchemeInterpreter.st $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeObject.$(O) SchemeObject.$(H): SchemeObject.st $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemePrinter.$(O) SchemePrinter.$(H): SchemePrinter.st $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeReader.$(O) SchemeReader.$(H): SchemeReader.st $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeStartup.$(O) SchemeStartup.$(H): SchemeStartup.st $(INCLUDE_TOP)\stx\libbasic\StandaloneStartup.$(H) $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)cg_hdm_scheme2013.$(O) cg_hdm_scheme2013.$(H): cg_hdm_scheme2013.st $(INCLUDE_TOP)\stx\libbasic\ApplicationDefinition.$(H) $(INCLUDE_TOP)\stx\libbasic\ProjectDefinition.$(H) $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeBoolean.$(O) SchemeBoolean.$(H): SchemeBoolean.st $(INCLUDE_TOP)\cg\hdm\scheme2013\SchemeObject.$(H) $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeCons.$(O) SchemeCons.$(H): SchemeCons.st $(INCLUDE_TOP)\cg\hdm\scheme2013\SchemeObject.$(H) $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeEnvironment.$(O) SchemeEnvironment.$(H): SchemeEnvironment.st $(INCLUDE_TOP)\cg\hdm\scheme2013\SchemeObject.$(H) $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeNil.$(O) SchemeNil.$(H): SchemeNil.st $(INCLUDE_TOP)\cg\hdm\scheme2013\SchemeObject.$(H) $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeNumber.$(O) SchemeNumber.$(H): SchemeNumber.st $(INCLUDE_TOP)\cg\hdm\scheme2013\SchemeObject.$(H) $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeString.$(O) SchemeString.$(H): SchemeString.st $(INCLUDE_TOP)\cg\hdm\scheme2013\SchemeObject.$(H) $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeSymbol.$(O) SchemeSymbol.$(H): SchemeSymbol.st $(INCLUDE_TOP)\cg\hdm\scheme2013\SchemeObject.$(H) $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeUserDefinedFunction.$(O) SchemeUserDefinedFunction.$(H): SchemeUserDefinedFunction.st $(INCLUDE_TOP)\cg\hdm\scheme2013\SchemeObject.$(H) $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeVoid.$(O) SchemeVoid.$(H): SchemeVoid.st $(INCLUDE_TOP)\cg\hdm\scheme2013\SchemeObject.$(H) $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeFloat.$(O) SchemeFloat.$(H): SchemeFloat.st $(INCLUDE_TOP)\cg\hdm\scheme2013\SchemeNumber.$(H) $(INCLUDE_TOP)\cg\hdm\scheme2013\SchemeObject.$(H) $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)
$(OUTDIR)SchemeInteger.$(O) SchemeInteger.$(H): SchemeInteger.st $(INCLUDE_TOP)\cg\hdm\scheme2013\SchemeNumber.$(H) $(INCLUDE_TOP)\cg\hdm\scheme2013\SchemeObject.$(H) $(INCLUDE_TOP)\stx\libbasic\Object.$(H) $(STCHDR)

# ENDMAKEDEPEND --- do not remove this line
