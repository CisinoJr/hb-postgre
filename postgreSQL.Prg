#include <hmg.ch>
#include "postgres.ch"

/*
** author = {
** Crocciari, Daniel
** hmglights.wordpress.com
** danielcrocciari@gmail.com
** }
**
** @modificated by: Cisino Junior. 
** @email: cisinojr@gmail.com
**
** @description: Originaly those functions were created by Daniel Crocciari, 
** to allow the use of MySQL/MariaDB as a backend database for softwares writen in harbour(hmg).
** All modifications made by me(Cisino Junior), was made to allow the use of PostgreSQL insted of MySQL.
** That is why I had changed the name of all functions.
** And I only needed to do some tyne changes thanks to Daniel's knowledge.
**
** LICENSE:
** You are allowed to use all those functions, but all the modifications
** that you may want to do is by your own. I'll not provide any directed support.
** I only ask that you do not modify or remove this description of the header.
**
** Acknowledgment:
** All thanks to Daniel for all the content about HMG that he made/make
** for his youtube channel and blog. Thank you for share your knowledge.
**
** @youtube: https://www.youtube.com/user/hmglights
** @blog: http://hmglights.ceuazul.net/
**
** Version: 0.1.0
*/

/*
** @description: This function tries to connect into the PostgreSQL server.
** @param: cHostname
*/
FUNCTION pgConnect(cHostname ,cDatabase, cUsername, cPassword)

	IF( cHostname == nil)
		cHostname := pcHostName
	ENDIF
	
	IF( cDatabase == nil)
		cDatabase := pcDataBase
	ENDIF

	IF( cUsername == nil)
		cUsername := pcUserName
	ENDIF

	IF( cPassword == nil)
		cPassword := pcPassWord
	ENDIF

	oServer := TPQServer():New( cHostname , cDatabase , cUsername , cPassword )
	
	IF( oServer:NETERR() )

	    msgStop("Erro tentando conectar ao servidor de banco de dados { "+oServer:errorMsg()+" }", "Banco de Dados")

	    RETURN .f.
		
	ENDIF

RETURN .t.

/*
** @description: This function destroy the connection with PostgreSQL server.
** @return: .T.
*/
FUNCTION pgDestroy()

         IF(oServer!=nil)
            oServer:DESTROY()
            oServer := nil
	ENDIF

RETURN .t.

/*
** @description: This function tries to connect with de Database PostgreSQL server.
** @param: cDataBase -> database name
** @return: bSucesso
**
** NOTE: I left this function, but I just changed its name because I could not 
**       figure out how to list the PostgreSQL databases.
**
/*
FUNCTION pgDatabaseConnect(cDataBase)
LOCAL aDatabaseList := {}, bSucesso := .f.

    IF( cDataBase == nil )
    	cDataBase := LOWER(pcDatabase)
    ENDIF

    IF( oServer == nil )
    	MSGSTOP("Servidor não conectado!","SQL")
    	RETURN bSucesso
    ENDIF
    
    aDatabaseList := oServer:LISTDBS()
    
    IF( oServer:NETERR() )
    	MSGSTOP("Erro verificando a lista de banco de dados: " + oServer:errorMsg(), "SQL" )
    	RETURN bSucesso
    ENDIF
    
    IF( ASCAN( aDatabaseList, cDataBase ) == 0 )
    	MSGSTOP("Banco de dados " + cDataBase + " não existe!", "SQL")
    	RETURN bSucesso
    ENDIF
    
    oServer:SELECTDB( cDataBase )
    
    IF( oServer:NETERR() )
        MSGSTOP("Erro conectado banco de dados " + cDataBase + ": " + oServer:errorMsg(), "SQL" )
        RETURN bSucesso
    ENDIF
    
    bSucesso := .t.

RETURN bSucesso
*/

/*
** @description: This function tries to execute a Select query and 
**               return an Array with the persisted data.
** @param: oServer -> server object connection ;
**         cQuery -> the query to execute
** @return: aTable
*/
FUNCTION pgSelectQuery(oServer, cQuery)
LOCAL oQuery, oRow, i, j, aTable := {}, aRow := {}

	IF( oServer == nil )
	    MSGSTOP(oServer:errorMsg())
	    return aTable
	ENDIF

	IF( cQuery == nil )
		cQuery := ""
	ENDIF
	
	IF( EMPTY( ALLTRIM(cQuery) ) )
	    MSGSTOP("Erro: query vazia","SQL")
	    RETURN aTable
	ENDIF
	
	oQuery := oServer:QUERY( cQuery )
	
	IF( oQuery:NETERR() )
	    MSGSTOP("Erro: " + oQuery:errorMsg(), "SQL" )
	ELSE
	    IF( oQuery:LASTREC() > 0 )
	    	ASIZE(aTable,0)
                FOR i := 1 TO oQuery:LASTREC()
                    ASIZE(aRow,0)
	    	    oRow := oQuery:GETROW(i)
                    FOR j := 1 TO oQuery:FCOUNT()
	     	    	IF( VALTYPE(oRow:FIELDGET(j))=="C" )
	     	    	    campo := ALLTRIM(oRow:FIELDGET(j))
	     	    	ELSE
	     	    	    campo := oRow:FIELDGET(j)
	    	    	ENDIF
	    	     	AADD( aRow, campo)
                    NEXT j
	    	    AADD( aTable, ACLONE(aRow) )
	    	NEXT i
            ENDIF
	ENDIF
	
RETURN aTable

/*
** @author: Cisino Junior
** @email: cisinojr@gmail.com
** @description: This function tries to execute querys that return TRUE OR FALSE, insert querys,
**               delete querys and update querys and send a response for a element of your choice(like labels).
** @param: cForm        -> the form that has the element to display the message
**         cElementUI   -> the element that the message will be displayed
**         cMessage     -> the error message to display to the user
**         cQuery       -> the query to execute into the database
** @return: .t. (if the query was executed correctly)
*/
function executeQuery(cForm, cElementUI, cMessage, cQuery)
local oQuery

      oServer:StartTransaction()
      
      oQuery := oServer:Query( cQuery )

      if( oQuery:NETERR() )
          setProperty(cForm, cElementUI, "value", cMessage +" " + oQuery:errorMsg())
          setProperty(cForm, cElementUI, "FONTCOLOR",{255, 0, 0})
          return .f.
      endif

      oServer:Commit()
      oQuery:destroy()

return .t.


/*
** @author: Cisino Junior
** @email: cisinojr@gmail.com
** @description: This functions uses the pgSelectQuery function to search for duplicated 
**               registers into a table.
** @param: cForm        -> the form that has the element to display the message
**         cElementUI   -> the element that the message will be displayed
**         cMessage     -> the error message to display to the user
**         cQuery       -> the validation query, ex: cQuery:=select description from produto where description = '"+searchString+"';"
** @vars: aTable : Array -> array that store the data resulted from the query execution
** @return: True if aTable is empty. False if the table is not empty.
**
*/
function validData(cForm, cElementUI, cMessage, cQuery)
local aTable:={}
      aTable := pgSelectQuery(oServer, cQuery)

      if !empty(aTable)
         setProperty(cForm, cElementUI, "value", cMessage)
         setProperty(cForm, cElementUI, "FONTCOLOR",{255, 0, 0})
         return .f.
      endif

return .t.
