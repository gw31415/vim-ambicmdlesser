fu s:getcompletion(leading = '') abort
	return getcompletion(a:leading, 'cmdline')->filter({_,v -> empty(v) || v[0] =~ '\a'} )
endf

fu ambicmdlesser#default_matcher(cmds, query) abort
	cal filter(a:cmds, {_,v -> v ==? a:query })
	if empty(a:cmds) || index(a:cmds, a:query) >= 0
		retu v:null
	end
	retu a:cmds[0]
endf

fu ambicmdlesser#expand(key, opts = {}) abort
	if getcmdtype() != ':'
		retu a:key
	end
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

	let completed = call(get(a:opts, 'matcher', function('ambicmdlesser#default_matcher')), [cmds, cmd])
	if completed != v:null
		retu repeat("\<bs>", strcharlen(cmd)) .. completed .. a:key
	end
	retu a:key
endf
