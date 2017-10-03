#include <hmg.ch>

/*
** @description: Checks the existence of the table product at the database, if not, the table is created.
*/
function createTable()

   if !oServer:TableExists( "product" )
      cQuery := "CREATE TABLE product("
      cQuery += "     id serial not null primary key, "
      cQuery += "     product_code varchar(10) not null unique,"
      cQuery += "     description Varchar(40)  not null unique, "
      cQuery += "     category Varchar(40) ) "

      oQuery := oServer:Query( cQuery )

      IF oQuery:NetErr()
         msgStop(oQuery:ErrorMsg(), "Database ERROR")
      ENDIF

      oQuery:Destroy()
   endif

return