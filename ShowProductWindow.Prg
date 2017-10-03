#include <hmg.ch>

function openRegisterProduct(aItem)

   if IsWindowActive(RegisterProduct)
      doMethod("RegisterProduct","MINIMIZE")
      doMethod("RegisterProduct","RESTORE")
      doMethod("RegisterProduct","SETFOCUS")
   else
      load window RegisterProduct
      activate window RegisterProduct
   endif

return nil