#include <hmg.ch>

DECLARE WINDOW config

FUNCTION showConfig()

   IF IsWindowActive(config)
   
      doMethod("config","MINIMIZE")
      doMethod("config","RESTORE")
      doMethod("config","SETFOCUS")
   
   ELSE
   
      LOAD WINDOW config
      ACTIVATE WINDOW config
   
   ENDIF

RETURN nil