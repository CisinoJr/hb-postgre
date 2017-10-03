#include <hmg.ch>

/*
** @description: Read a .ini file
**
*/
Function iniRead()
   IF( !FILE( pcFileIni ) )
       iniSave()
   ENDIF
   
   BEGIN INI FILE pcFileIni
   
      GET pcHostName SECTION "server" ENTRY "hostname"
      GET pcDataBase SECTION "server" ENTRY "database"
      GET pcUserName SECTION "server" ENTRY "username"
      GET pcPassWord SECTION "server" ENTRY "password"
      
   END INI
   
RETURN nil
