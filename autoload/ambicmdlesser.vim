fu ambicmdlesser#expand(key) abort
	let i_len = getcmdpos() - 1
	let i = getcmdline()->strpart(0, i_len)
	if i =~? '^.*\s\?[A-Z][A-Z0-9]*$'
		let cmds = getcompletion('', 'cmdline')->filter({_,v -> v ==? i})

		if len(cmds) > 0 && index(cmds, i) < 0
			let cmd = cmds[0]
			let bses = repeat("\<bs>", i_len)
			retu bses .. cmd .. a:key
		end
	end
	retu a:key
endf
