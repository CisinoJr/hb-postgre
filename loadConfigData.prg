#include "hmg.ch"

declare window config

/*
** @description: opens the config form.
*/
Function loadConfigData()

   SetProperty("config", "text_hostname", "value",pcHostName)
   SetProperty("config", "text_database", "value",pcDataBase)
   SetProperty("config", "text_username", "value",pcUserName)
   SetProperty("config", "text_password", "value",pcPassWord)

Return Nil
