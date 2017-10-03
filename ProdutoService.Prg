#include <hmg.ch>

declare window RegisterProduct

/*
** @author: Cisino Junior
** @email: cisinojr@gmail.com
** @description: Here I create some functions to persist the data
** to the database table. I didn't use relational tables because it's
** a simple example.
*/


/*
** @description: This function tries to save the data into the product table.
** @params = none
** @void
*/
function saveNewProduct()
local aFieldsUIName:=Array(3), aLabels:=Array(4)
local cQuery, cValidateQuery

      aFieldsUIName[01] := 'txtProductCode'
      aFieldsUIName[02] := 'txtDescription'
      aFieldsUIName[03] := 'txtCategory'
      
      aLabels[01] := 'Label_1'
      aLabels[02] := 'Label_2'
      aLabels[03] := 'Label_3'
      aLabels[04] := 'lblStatus'

      cQuery := "INSERT INTO product(product_code, description, category)"+ ;
                             "VALUES('"+alltrim(RegisterProduct.txtProductCode.value)+"', '"+RegisterProduct.txtDescription.value+"', '"+;
                                     RegisterProduct.txtCategory.value+"');"

      cValidateCode := "SELECT product_code from product where product_code = '"+alltrim(RegisterProduct.txtProductCode.value)+"';"
      cValidateDescription := "SELECT description from product where description = '"+alltrim(RegisterProduct.txtDescription.value)+"';"

      if(!empty(RegisterProduct.txtProductCode.value) .and. !empty(RegisterProduct.txtDescription.value) .and. !empty(RegisterProduct.txtDescription.value))
          if validData("RegisterProduct", "lblStatus", "Já existe um produto com este código!", cValidateCode)
             if validData("RegisterProduct", "lblStatus", "Já existe um produto com esta descrição!", cValidateDescription)
                if executeQuery("RegisterProduct", "lblStatus", "Ocorreu um erro ao salvar o registro na tabela:", cQuery)
                   cleanFields("RegisterProduct",aFieldsUIName)
                   setProperty("RegisterProduct", "lblStatus", "value", "STATUS: PRODUTO CADASTRADO COM SUCESSO!")
                   setProperty("RegisterProduct", "lblStatus", "FONTCOLOR", {0, 242, 0})
                endif
             endif
          endif
      else
          changeElementsFontColors("RegisterProduct", aLabels, {255, 0, 0})
          setProperty("RegisterProduct", "lblStatus", "value", "Favor preencher todos os campos obrigatórios(*)!")
      endif

return nil

/*
** @description: This function tries to update the data into the table products.
** @params = none
** @void
*/
function updateProduct()
local cQuery, aFieldsUIName:=Array(4)
local id:=getProperty("Main","txtID","value")
local cCode:=alltrim(getProperty("Main","txtProductCode","value"))
local cDescription:=getProperty("Main","txtDescription","value")
local cCategory:=getProperty("Main","txtCategory","value")

      aFieldsUIName[01] := 'txtID'
      aFieldsUIName[02] := 'txtDescription'
      aFieldsUIName[03] := 'txtCategory'
      aFieldsUIName[04] := 'txtProductCode'

      cQuery := "UPDATE product SET product_code='"+ cCode +"', description='"+ cDescription +"', category='"+ cCategory +"' WHERE id='"+id+"';"

      if !empty(id) .and. !empty(cCode) .and. !empty(cDescription) .and. !empty(cCategory)
          if executeQuery("Main", "lblMainStatus", "Ocorreu um erro ao tentar atualizar o registro: ", cQuery)
             cleanFields("Main", aFieldsUIName)
             setProperty("Main", "lblMainStatus", "value", "STATUS: PRODUTO ATUALIZADO COM SUCESSO!")
             setProperty("Main", "lblMainStatus", "FONTCOLOR", {0, 242, 0})
             searchProduct()
          endif
      endif

return nil

/*
** @description: This function tries to delete the data from the table products.
** @params = none
** @void
*/
function deleteProduct()
local nPos, aItem:={}, aElements:=array(1)
local cQuery

      nPos := getProperty("Main", "Grid_1", "value")
      aItem := getProperty("Main", "Grid_1", "item", nPos)
      
      aElements[01]:='lblMainStatus'

      cQuery := "DELETE FROM product WHERE id='"+aItem[1]+"';"

      if !empty(cQuery)
         if executeQuery("Main", "lblMainStatus", "Ocorreu um erro ao tentar deletar o registro: ", cQuery)
            removeGridItem("Main", "Grid_1", nPos)
            setProperty("Main", "lblMainStatus", "value", "STATUS: PRODUTO REMOVIDO COM SUCESSO!")
            setProperty("Main", "lblMainStatus", "FONTCOLOR", {0, 242, 0})
            waitToCleanAfterDelete("Main", aElements, 800*4000)
          endif
      endif

return nil

/*
** @description: This function gets the selected row from the Grid and sets the forms fields
** @params = none
** @void
*/
function getProduct()
local nPos, aItem:={}

     nPos := getProperty("Main", "Grid_1", "value")
     aItem := getProperty("Main", "Grid_1", "item", nPos)

     setProperty("Main", "txtID", "value", aItem[1])
     setProperty("Main", "txtProductCode", "value", aItem[2])
     setProperty("Main", "txtDescription", "value", aItem[3])
     setProperty("Main", "txtCategory", "value", aItem[4])

return nil

