" vim:ts=4
"
" vim config

" theme
set t_Co=256
syntax on
colorscheme aob

" defaults
set backspace=indent,eol,start " backspace works like i expect

" tell vim what kinds of files these are based on extension
au BufNewFile,BufRead *.phtml setlocal ft=php
au BufNewFile,BufRead *.rake,*.mab setlocal ft=ruby
au BufNewFile,BufRead *.erb setlocal ft=eruby
au BufNewFile,BufRead *.pjs setlocal ft=php.javascript
au BufRead,BufNewFile *.go setlocal ft=go

" markdown should be automatically wrapped at 80 columns
au BufRead,BufNewFile *.md setlocal textwidth=80

" strip trailing whitespace when coding
autocmd FileType go,yaml,python,php,md autocmd BufWritePre <buffer> %s/\s\+$//e

" all source code gets wrapped at <80 and auto-indented
au FileType asm,c,cpp,go,java,javascript,php,html,make,objc,perl setlocal tw=79 autoindent colorcolumn=80

" soft tabs
au FileType ruby,eruby setlocal ts=2 sw=2 tw=79 et sts=2 autoindent colorcolumn=80
au FileType yml,yaml setlocal ts=2 sw=2 et colorcolumn=80

" makefiles and c have tabstops at 8 for portability
au FileType make,c,cpp setlocal ts=8 sw=8

" email and commit messages - expand tabs, wrap at 68 for future quoting, enable spelling
au FileType cvs,gitcommit,mail setlocal tw=68 et spell colorcolumn=69

" highlight stray spaces and tabs when out of insert mode
" match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
" performance hack
if version >= 702
  au BufWinLeave * call clearmatches()
endif

" control+n and +p for next and previous buffers, but only in normal mode
nmap <C-n> :bn<CR>
nmap <C-p> :bp<CR>

" TODO: make this an alias like :sudow
" :w !sudo tee %
"

