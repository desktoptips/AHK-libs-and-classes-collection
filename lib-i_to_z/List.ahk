List_AddItem(list, item, select = false)
{
;   OutputDebug In List_AddItem(%list%, %item%, %select%)
	if(list = "")
		list := item
	else
  {
		if(SubStr(list, -1, 2) = "||")
      list = %list%%item%
    else
      list = %list%|%item%
	}
  
	if(select)
	{
		StringReplace, list, list, ||, |, all
		list = %list%||
;     OutputDebug Selecting item %item%
	}
	return list
}

List_AddRange(list, range)
{
	result = %list%|%range%
	return, result
}

List_GetItem(list, index)
{
	StringSplit, arr, list, |
	return arr[index]
}

List_InsertItem(list, item, index)
{
	StringSplit, arr, list, |
	if (index > arr0)
	{
		return List_AddItem(list, item)
	}
	else
	{
		result =
		Loop, %arr0%
		{
			if(A_Index = index)
			{
				result := List_AddItem(result, item)
			}
			result := List_AddItem(result, arr%A_Index%)
		}
		return result
	}
}

List_FromPseudoArray(arr)
{
	result =
	Loop, %arr0%
	{
		result := List_AddItem(result, arr%A_Index%)
	}
	return result
}

List_FromArray(arr, selectedItem="", selectIndex = false)
{
	result =
	for i, el in arr
	{
		;~ OutputDebug, List_FromArray: adding %el%
		if(!selectIndex)
    {
      if (selectedItem <> "" && selectedItem = el)
  			result := List_AddItem(result, el, true)
  		else
  			result := List_AddItem(result, el)
    }
    else
    {
      if(A_Index = selectedItem)
        result := List_AddItem(result, el, true)
  		else
  			result := List_AddItem(result, el)
    }
	}
	return result
}

List_FromArrayKeys(arr, selectedItem="", selectIndex = false)
{
	result =
	for key, el in arr
	{
		if(!selectIndex)
    {
      if(selectedItem <> "" && selectedItem = key)
  			result := List_AddItem(result, key, true)
  		else
  			result := List_AddItem(result, key)
    }
    else
    {
;       OutputDebug %A_Index% = %selectedItem%
      if(A_Index = selectedItem)
        result := List_AddItem(result, key, true)
  		else
  			result := List_AddItem(result, key)
    }
	}
	return result
}

List_SelectFirstItem(list)
{
	if(InStr(list, "|") = 0)
	{
		list = %list%||
	}
	else
	{
		StringReplace, list, list, |, ||
	}
	return list
}

List_SelectItem(list, item)
{
	if(!InStr(list, item))
		return list
	
	haystack = |list|
	StringReplace, list, list, ||, |, all
	
	needle = |item|
	
	pos := InStr(haystack, needle)
	if(!pos)
		return list
	
	StringReplace, result, haystack, %needle%, %needle%|
	return result
}

List_MsgBox(list)
{
  StringSplit, values, list, |
  msg = List: %list%`nLength: %values0%`n
  Loop, %values0%
  {
    if(values%A_Index% = "")
      msg .= " (selected)"
    else
      msg .= "`n[" A_Index "]:" values%A_Index%
  }
  MsgBox, %msg%
}