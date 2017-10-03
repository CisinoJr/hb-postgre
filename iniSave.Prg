#include <hmg.ch>

/*
** @description: Save/edit the .ini file. 
**               You can use this function getting data from a Form.
*/
Function iniSave()

   BEGIN INI FILE pcFileIni

      SET SECTION "server" ENTRY "hostname" TO pcHostName
      SET SECTION "server" ENTRY "database" TO pcDataBase
      SET SECTION "server" ENTRY "username" TO pcUserName
      SET SECTION "server" ENTRY "password" TO pcPassWord
   
   END INI

RETURN nil