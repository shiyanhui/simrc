# simrc

A vim configuration kept simple and small.

## Installation

```shell
curl -fLo ~/.vimrc https://raw.githubusercontent.com/shiyanhui/simrc/master/vimrc && vim
```

## Screenshots

<img src='https://raw.githubusercontent.com/shiyanhui/simrc/master/doc/screenshots/screenshot.png' width='600'>

## Key maps

```vim
" below is a part of the key mappping settings.

let mapleader = ','     " mapleader
<Leader>w               " save file
<Leader>q               " quit
<C-a>                   " jump to head of line
<C-e>                   " jump to tail of line
<C-f>                   " move forward
<C-b>                   " move backward
>                       " continued right shift
<                       " continued left shift
<Leader>/               " unhighlight
```

## Uninstall

```shell
rm -rf ~/.vimrc ~/.vim
```

## License

NO LICENSE. Do what you want with it :)
