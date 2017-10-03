#include "hmg.ch"

declare window config
                       
/*
** @description: Tests the server connection.
*/
Function testServerConnection()
local hostname  := getProperty("config", "text_hostname", "value")
local username  := getProperty("config", "text_username", "value")
local password  := getProperty("config", "text_password", "value")
local cDatabase := getProperty("config", "text_database", "value")
   

   if pgConnect(hostname, cDatabase, username, password)
      msgInfo("Servidor conectado com sucesso!", "SQL")
   else
      msgStop("Servidor [" + hostname + "] não conectado!","SQL")
   endif
   
   // destroys the connection opened for the test
   pgDestroy()

Return Nil
