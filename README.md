# vim-ambicmdlesser

This is a minimal arrangement of [`thinca/vim-ambicmd`](https://github.com/thinca/vim-ambicmd).

## Motivation

vim-ambicmd is a powerful plugin that enables flexible, ambiguous command
execution. However, for users who already rely on completion frameworks (like
`nvim-cmp`, `blink.cmp`, or `ddc.vim`), such a large and feature-rich solution
may not be necessary. In particular, when mapping commands to `<CR>`, you often
want more predictable, less ambiguous completions. `vim-ambicmdlesser` provides
a lightweight alternative with a single function that expands commands based on
case-insensitive prefix matching.

## Functions

### `ambicmdlesser#expand(key)`

This function expands the currently typed command in the command line. If the
typed text is a case-insensitive prefix to a unique command, it will be
expanded.

## Setting Examples

```vim
cnoremap <expr> <Space> ambicmdlesser#expand('\<Space>')
cnoremap <expr> <CR> ambicmdlesser#expand('\<CR>')
```

With this mapping, when you press Enter in the command line, it will attempt to
expand the command before execution.

## Related Plugins

- [`thinca/vim-ambicmd`](https://github.com/thinca/vim-ambicmd)
  - Inspiration and base for this plugin.

## License

This project is licensed under the [Apache License 2.0](./LICENSE).
