#include "hmg.ch"

declare window Main

/*
** @description: Searchs for the product at the database table
** @params: null
** @vars: cSearch : String  -> User input search string
**        cQuery  : String  -> Query string
**        nLimit  : Integer -> User input value to tell the database the limit of the query's result
**        aTable  : Array   -> Array that stores the result returned by the query's execution
**        nPos    : Integer -> Variable to run through the aTable array
**        searchOption : Integer -> Variable that gets the search option choosen by the user
** @return: null
*/
function searchProduct()
local cSearch, cQuery, nLimit
local aTable:={}, nPos, searchOption

      cSearch:=Main.txtBusca.value   // gets the search string
      nLimit:=Main.nLimit.value      // gets the limit
      searchOption:=onChangeSearchOption() // gets the search option

      switch searchOption
             case 1
                  cQuery:="SELECT id, product_code, description, category FROM product where product_code LIKE '%"+ ;
                           cSearch+"%' or product_code LIKE '%"+upper(cSearch)+"%' order by id limit "+ALLTRIM(STR(nLimit))+";"
                  exit
             case 2
                  cQuery:="SELECT id, product_code, description, category FROM product where description LIKE '%"+ ;
                           cSearch+"%' or description LIKE '%"+upper(cSearch)+"%' order by id limit "+ALLTRIM(STR(nLimit))+";"
                  exit
             case 3
                  cQuery:="SELECT id, product_code, description, category FROM product where category LIKE '%"+ ;
                           cSearch+"%' or category LIKE '%"+upper(cSearch)+"%' order by id limit "+ALLTRIM(STR(nLimit))+";"
                  exit
             otherwise
                  cQuery:="SELECT id, product_code, description, category FROM product where description LIKE '%"+ ;
                           cSearch+"%' or description LIKE '%"+upper(cSearch)+"%' order by id limit "+ALLTRIM(STR(nLimit))+";"
      end

      doMethod("Main", "Grid_1","DELETEALLITEMS") // delete all Grid items

      if pgConnect()// conects to the server
        // if pgDatabaseConnect(pcDataBase)
            aTable:=pgSelectQuery(oServer, cQuery) // executes the query
        // endIf
      endif

      if len(aTable) > 0 // add the items into the Grid element
         for nPos:=1 to len(aTable)
             doMethod("Main", "Grid_1", "ADDITEM", aTable[nPos])
         next
      endif

return nil

/*
** @description: Gets the user chooise for the search at the ComboBox's onChange Event
** @params: null
** @vars: pOption : Integer -> Gets the ComboBox's value
** @return: pOption
*/
function onChangeSearchOption()
local pOption
     pOption:=getProperty("Main","Combo_1","value")

return pOption
