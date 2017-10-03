#include "hmg.ch"

declare window config


/*
** @description:  save the data into the config.ini file
*/
Function saveConfig()

   pcHostName := getProperty("config","text_hostname","value")
   pcDataBase := getProperty("config","text_database","value")
   pcUserName := getProperty("config","text_username","value")
   pcPassWord := getProperty("config","text_password","value")
   
   iniSave()
   
   doMethod("config","release")

Return Nil
