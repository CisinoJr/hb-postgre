#include "hmg.ch"

declare window config


/*
** @description: ignores all changes 
*/
Function ignoreConfigChanges()

   doMethod("config","release")

Return Nil
