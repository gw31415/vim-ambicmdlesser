fu ambicmdlesser#expand(key) abort
	let i_len = getcmdpos() - 1
	let i = getcmdline()->strpart(0, i_len)
	if i =~# '^[A-Za-z][A-Za-z0-9]*$'
		let cmds = getcompletion('', 'cmdline')->filter({_,v -> v ==? i})

		if len(cmds) > 0 && index(cmds, i) < 0
			let cmd = cmds[0]
			let bses = repeat("\<bs>", i_len)
			retu bses .. cmd .. a:key
		endi
	end
	retu a:key
endf
