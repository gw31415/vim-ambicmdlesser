let s:filter = {_,v -> v =~? '^[a-z].\+'} 

fu ambicmdlesser#expand(key) abort
	let cmdline = getcmdline()
	let cmdline_leading = cmdline->strpart(0, getcmdpos() - 1)
	let matches = cmdline_leading->matchlist('^\(.\{-}\s\?\)\([a-zA-Z][a-zA-Z0-9]*\)$')
	if empty(matches)
		retu a:key
	end
	let char_behind = cmdline->strgetchar(strcharlen(cmdline_leading))
	if char_behind != -1 && char_behind->nr2char() !~# '\s'
		retu a:key " If the character immediately after the cursor is blank, it is excluded.
	end

	let cmdline_leading = matches[1]
	let cmd = matches[2]
	let cmds = getcompletion('', 'cmdline')->filter(s:filter)
	if cmdline_leading != '' && cmds != getcompletion(cmdline_leading, 'cmdline')->filter(s:filter)
		retu a:key
	end

	call filter(cmds, {_,v -> v ==? cmd})
	if len(cmds) > 0 && index(cmds, cmd) < 0
		let cmd = cmds[0]
		let bses = repeat("\<bs>", strcharlen(cmd))
		retu bses .. cmd .. a:key
	end
	retu a:key
endf
