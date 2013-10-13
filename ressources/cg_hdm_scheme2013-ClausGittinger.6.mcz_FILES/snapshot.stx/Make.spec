# $Header$
#
# DO NOT EDIT
# automagically generated from the projectDefinition: cg_hdm_scheme2013.
#
# Warning: once you modify this file, do not rerun
# stmkmp or projectDefinition-build again - otherwise, your changes are lost.
#
# This file contains specifications which are common to all platforms.
#

# Do NOT CHANGE THESE DEFINITIONS
# (otherwise, ST/X will have a hard time to find out the packages location from its packageID,
#  to find the source code of a class and to find the library for a package)
MODULE=cg
MODULE_DIR=hdm/scheme2013
PACKAGE=$(MODULE):$(MODULE_DIR)


# Argument(s) to the stc compiler (stc --usage).
#  -headerDir=. : create header files locally
#                (if removed, they will be created as common
#  -Pxxx       : defines the package
#  -Zxxx       : a prefix for variables within the classLib
#  -Dxxx       : defines passed to to CC for inline C-code
#  -Ixxx       : include path passed to CC for inline C-code
#  +optspace   : optimized for space
#  +optspace2  : optimized more for space
#  +optspace3  : optimized even more for space
#  +optinline  : generate inline code for some ST constructs
#  +inlineNew  : additionally inline new
#  +inlineMath : additionally inline some floatPnt math stuff
#
# ********** OPTIONAL: MODIFY the next line(s) ***
# STCLOCALOPTIMIZATIONS=+optinline +inlineNew
# STCLOCALOPTIMIZATIONS=+optspace3
STCLOCALOPTIMIZATIONS=+optspace3


# Argument(s) to the stc compiler (stc --usage).
#  -warn            : no warnings
#  -warnNonStandard : no warnings about ST/X extensions
#  -warnEOLComments : no warnings about EOL comment extension
#  -warnPrivacy     : no warnings about privateClass extension
#
# ********** OPTIONAL: MODIFY the next line(s) ***
# STCWARNINGS=-warn
# STCWARNINGS=-warnNonStandard
# STCWARNINGS=-warnEOLComments
STCWARNINGS=-warnNonStandard

COMMON_CLASSES= \
	SchemeInterpreter \
	SchemeStartup \
	cg_hdm_scheme2013 \
	SchemeEvaluator \
	SchemeObject \
	SchemePrinter \
	SchemeReader \
	SchemeBoolean \
	SchemeCons \
	SchemeEnvironment \
	SchemeNil \
	SchemeNumber \
	SchemeString \
	SchemeSymbol \
	SchemeUserDefinedFunction \
	SchemeVoid \
	SchemeFloat \
	SchemeInteger \




COMMON_OBJS= \
    $(OUTDIR_SLASH)SchemeInterpreter.$(O) \
    $(OUTDIR_SLASH)SchemeStartup.$(O) \
    $(OUTDIR_SLASH)cg_hdm_scheme2013.$(O) \
    $(OUTDIR_SLASH)SchemeEvaluator.$(O) \
    $(OUTDIR_SLASH)SchemeObject.$(O) \
    $(OUTDIR_SLASH)SchemePrinter.$(O) \
    $(OUTDIR_SLASH)SchemeReader.$(O) \
    $(OUTDIR_SLASH)SchemeBoolean.$(O) \
    $(OUTDIR_SLASH)SchemeCons.$(O) \
    $(OUTDIR_SLASH)SchemeEnvironment.$(O) \
    $(OUTDIR_SLASH)SchemeNil.$(O) \
    $(OUTDIR_SLASH)SchemeNumber.$(O) \
    $(OUTDIR_SLASH)SchemeString.$(O) \
    $(OUTDIR_SLASH)SchemeSymbol.$(O) \
    $(OUTDIR_SLASH)SchemeUserDefinedFunction.$(O) \
    $(OUTDIR_SLASH)SchemeVoid.$(O) \
    $(OUTDIR_SLASH)SchemeFloat.$(O) \
    $(OUTDIR_SLASH)SchemeInteger.$(O) \



