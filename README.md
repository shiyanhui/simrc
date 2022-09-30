# simrc

A vim configuration kept simple and small.

## Installation

```shell
curl -fLo ~/.vimrc https://raw.githubusercontent.com/shiyanhui/simrc/master/vimrc && vim
```

## Screenshots

<img src='https://raw.githubusercontent.com/shiyanhui/simrc/master/doc/screenshots/screenshot.png' width='600'>

## Key maps

| Key           | Alias     | Description                                         |
|:--------------|:----------|:----------------------------------------------------|
| ,w            | :w        | Save current file.                                  |
| ,q            | :q        | Quit vim.                                           |
| ,/            | :nohls    | Clear search highlight.                             |
| ,rn           |           | Rename all variables.                               |
| ,ac           |           | List all coc actions.                               |
| ,f            |           | Search file by name in current project.             |
| ,b            |           | Search file by name in current buffer.              |
| ,ag           |           | Search in the file content.                         |
| ,h            |           | Show jump points before the cursor in current line. |
| ,l            |           | Show jump points after the cursor in current line.  |
| ,j            |           | Show jump points below current line.                |
| ,k            |           | Show jump points above current line.                |
| ,a            |           | Align.                                              |
| ,t            |           | Show ctags.                                         |
| ;             | :!        | Run shell command.                                  |
| >             | >gv       | Shift indent right.                                 |
| <             | \<gv      | Shift indent left.                                  |
| p             | pgvy      | Paste.                                              |
| H             | ^         | Jump to head of line in normal mode.                |
| L             | $         | Jump to end of line in normal mode.                 |
| K             |           | Show documentation.                                 |
| gd            |           | Goto variable definition.                           |
| gy            |           | Goto type definition.                               |
| gi            |           | Goto the implementations.                           |
| gy            |           | Goto type definition.                               |
| gr            |           | Goto references.                                    |
| \<CTRL\>a     | \<S-i\>   | Jump to head of line and enter insert mode.         |
| \<CTRL\>e     | \<S-a\>   | Jump to end of line and enter insert mode.          |
| \<CTRL\>f     | \<Right\> | Move forward.                                       |
| \<CTRL\>b     | \<Left\>  | Move backward.                                      |
| \<CTRL\>t     | \<C-o\>   | Jump back to last position.                         |
| \<CTRL\>o     | o         | Begin a new line below the cursor and insert text.  |
| \<CTRL\>j     | O         | Begin a new line above the cursor and insert text.  |
| \<CTRL-N\>    |           | Scroll down or next if there is floating window.    |
| \<CTRL-P\>    |           | Scroll up or prev if there is floating window.      |
| \<CTRL-Space\>|           | Trigger completion manually.                        |
| \<TAB\>       |           | Choose next completion item.                        |
| \<SHIFT-TAB\> |           | Choose previous completion item.                    |

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
