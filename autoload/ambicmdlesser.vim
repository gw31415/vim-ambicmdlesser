fu ambicmdlesser#expand(key) abort
	let i_len = getcmdpos() - 1
	let i = strpart(getcmdline(), 0, i_len)
	if i =~# '^[!-~]\+$'
		let cmds = getcompletion('', 'cmdline')

		for cmd in cmds
			if cmd ==# i
				break
			elsei cmd ==? i
				let bses = repeat("\<bs>", i_len)
				retu bses .. cmd .. a:key
			end
		endfor
	end
	retu a:key
endf
