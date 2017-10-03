#include <hmg.ch>

/*
** @author: Cisino Junior
** @email: cisinojr@gmail.com
** @description: Here I create some utils functions to do things 
**               like clean or change elements ui colors.
**
** @NOTE: I only tried to create some functions to automate some things
**        for fun, fell free to submit an improvement for any of the 
**        functions above or new functions.
*/

/*
** @description: This function cleans the elements of ui that you want.
** @params = cForm -> The form that has the Element UI you want to clean
**           aFields -> Array of all UI elements you want to clean.
** @void
*/
function cleanFields(cForm, aFields)
local i

      if (len(aFields) > 0)
         for i:=1 to len(aFields)
             setProperty(cForm, aFields[i], "value", "")
         next i
      endif

return nil

/*
** @description: This function changes the elements font color that you want.
** @params = cForm -> The form that has the Element UI you want to clean
**           aFields -> Array of all UI elements you want to clean.
**           aColor -> Array with the colors you want to use.
** @void
*/
function changeElementsFontColors(cForm, aFields, aColor)
local i

      if (len(aFields) > 0)
         for i:=1 to len(aFields)
             setProperty(cForm, aFields[i], "FONTCOLOR", aColor)
         next i
      endif

return nil

/*
** @description: This function removes the selected row from the Grid.
** @params = cForm -> The form that has the Element UI you want to clean
**           cGrid -> The name of the Grid to delete an item.
** @void
*/
function removeGridItem(cForm, cGrid, nPos)

      if !empty(cForm) .and. !empty(cGrid) .and. nPos > 0
         doMethod(cForm, cGrid, "DeleteItem", nPos)
      endif

return

/*
** @description: This function waits a certain amount of time that you define.
** @params = cForm -> The form that has the Element UI you want to clean
**           cGrid -> The name of the Grid to delete an item.
** @void
*/
function waitToCleanAfterDelete(cForm, aElements, nTime)
local i, j:=1

      do while j != nTime
         j++
         if j = nTime
            exit
         endif
      enddo

      for i:=1 to len(aElements)
          setProperty(cForm, aElements[i], "value", "")
      next i

return nil
