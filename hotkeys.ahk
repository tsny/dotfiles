#SingleInstance force

!q::Send !{F4}
return

#IfWinActive ahk_class TTOTAL_CMD
{
    ; Sends j/k for up/down (vim commands)

	j::
	k::
	{
		aKey := A_ThisHotKey == "j" ? "Down" : "Up"
		ControlGetFocus, aControl, A
		if( RegExMatch( aControl, "LCLListBox[1-2]" ) )
			Send, {%aKey%}
		else
			Send, {%A_ThisHotKey%}
	return
	}

    ; Sends ctrl+alt+f1 for opening terminal thru TC

    !t::
    {
		ControlGetFocus, aControl, A
		if( RegExMatch( aControl, "LCLListBox[1-2]" ) )
			Send ^!{F1}
		else
			Send ^t
    return
    }

return
}
