fu s:getcompletion(leading = '') abort
	return getcompletion(a:leading, 'cmdline')->filter({_,v -> empty(v) || v[0] =~ '\a'} )
endf

fu ambicmdlesser#expand(key) abort
	let cmdline = getcmdline()
	let leading = cmdline->strpart(0, getcmdpos() - 1)
	let matches = leading->matchlist('\c\v^(.{-}\s?)([a-z][a-z\d]*)$')
	if empty(matches)
		retu a:key
	end
	let char_behind = cmdline->strgetchar(strcharlen(leading))
	if char_behind != -1 && char_behind->nr2char() !~ '\s'
		retu a:key
	end

	let leading = matches[1]
	let cmd = matches[2]
	let cmds = s:getcompletion()
	if !empty(leading) && cmds != s:getcompletion(leading)
		retu a:key
	end

	cal filter(cmds, {_,v -> v ==? cmd})
	if !empty(cmds) && index(cmds, cmd) < 0
		let cmd = cmds[0]
		let bses = repeat("\<bs>", strcharlen(cmd))
		retu bses .. cmd .. a:key
	end
	retu a:key
endf
