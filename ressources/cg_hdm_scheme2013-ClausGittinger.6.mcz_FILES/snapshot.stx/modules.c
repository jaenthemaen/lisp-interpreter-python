/* $Header$
 *
 * DO NOT EDIT 
 * automagically generated from the projectDefinition: cg_hdm_scheme2013.
 *
 * Warning: once you modify this file, do not rerun
 * stmkmp or projectDefinition-build again - otherwise, your changes are lost.
 */
typedef void (*vf)();

extern void _SchemeEvaluator_Init();
extern void _SchemeInterpreter_Init();
extern void _SchemeObject_Init();
extern void _SchemePrinter_Init();
extern void _SchemeReader_Init();
extern void _SchemeStartup_Init();
extern void _cg_137hdm_137scheme2013_Init();
extern void _SchemeBoolean_Init();
extern void _SchemeCons_Init();
extern void _SchemeEnvironment_Init();
extern void _SchemeNil_Init();
extern void _SchemeNumber_Init();
extern void _SchemeString_Init();
extern void _SchemeSymbol_Init();
extern void _SchemeUserDefinedFunction_Init();
extern void _SchemeVoid_Init();
extern void _SchemeFloat_Init();
extern void _SchemeInteger_Init();


static vf modules[] = {
    _SchemeEvaluator_Init,
_SchemeInterpreter_Init,
_SchemeObject_Init,
_SchemePrinter_Init,
_SchemeReader_Init,
_SchemeStartup_Init,
_cg_137hdm_137scheme2013_Init,
_SchemeBoolean_Init,
_SchemeCons_Init,
_SchemeEnvironment_Init,
_SchemeNil_Init,
_SchemeNumber_Init,
_SchemeString_Init,
_SchemeSymbol_Init,
_SchemeUserDefinedFunction_Init,
_SchemeVoid_Init,
_SchemeFloat_Init,
_SchemeInteger_Init,

    (vf)0
};

vf *__modules__ = modules;
