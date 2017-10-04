#include <hmg.ch>
#include "postgres.ch"

Function Main()
   local cQuery
   public oServer := nil

   public pcFileIni := "config.ini"

   public pcHostName := ""
   public pcDataBase := ""
   public pcUserName := ""
   public pcPassWord := ""
   
   public pacNi := {'TEXTBOX','NUMERIC','9999999999'}
   public pacNc := {'TEXTBOX','NUMERIC','99999999999.99'}
   public pacC := {'TEXTBOX','CHARACTER'}
   public pacD := {'DATEPICKER','UPDOWN'}
   public pacB := { 'CHECKBOX' , 'Sim' , 'Não' }
   public pacM := { 'EDITBOX' }

   iniRead()


   if !pgConnect()
      msgStop("Não foi possível conectar ao servidor de banco de dados, entre em contato com seu suporte!", "DATABASE SERVER ERRO")
    else
        createTable()
   endif

   Load Window Main
   Main.Center
   Main.Activate
   
Return
