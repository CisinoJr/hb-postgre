#include <hmg.ch>

DECLARE WINDOW config

function showConfigOnInit()

   if !pgConnect()
      LOAD WINDOW config
      ACTIVATE WINDOW config
   endif

return nil