# simrc

A vim configuration kept simple and small.

## Installation

```shell
curl -fLo ~/.vimrc https://raw.githubusercontent.com/shiyanhui/simrc/master/vimrc && vim
```

## Screenshots

<img src='https://raw.githubusercontent.com/shiyanhui/simrc/master/doc/screenshots/screenshot.png' width='600'>

## Key maps

| Key       | Alias     | Description                                         |
|:----------|:----------|:----------------------------------------------------|
| ,w        | :w        | Save current file.                                  |
| ,q        | :q        | Quit vim.                                           |
| ,/        | :nohls    | Clear search highlight.                             |
| ;         | :!        | Run shell command.                                  |
| >         | >gv       | Shift indent right.                                 |
| <         | <gv       | Shift indent left.                                  |
| p         | pgvy      | Paste.                                              |
| H         | ^         | Jump to head of line in normal mode.                |
| L         | $         | Jump to end of line in normal mode.                 |
| \<CTRL\>a | \<S-i\>   | Jump to head of line and enter insert mode.         |
| \<CTRL\>e | \<S-a\>   | Jump to end of line and enter insert mode.          |
| \<CTRL\>f | \<Right\> | Move forward.                                       |
| \<CTRL\>b | \<Left\>  | Move backward.                                      |
| \<CTRL\>t | \<C-o\>   | Jump back to last position.                         |
| \<CTRL\>o | o         | Begin a new line below the cursor and insert text.  |
| \<CTRL\>j | O         | Begin a new line above the cursor and insert text.  |

## Extra Settings

```vim
" Set colorscheme, currently only support `solarized` and `srcery`. Default is `solarized`.
let g:colorscheme = "solarized"
```

## Uninstall

```shell
rm -rf ~/.vimrc ~/.vim
```

## License

MIT.
