nnoremap          <buffer> <Plug>JediGoto             :call jedi#goto()<CR>
nnoremap          <buffer> <Plug>JediGotoAssignments  :call jedi#goto_assignments()<CR>
nnoremap          <buffer> <Plug>JediGotoDefinitions  :call jedi#goto_definitions()<CR>
nnoremap          <buffer> <Plug>JediUsages           :call jedi#usages()<CR>
nnoremap          <buffer> <Plug>JediRename           :call jedi#rename()<CR>
vnoremap          <buffer> <Plug>JediRenameVisual     :call jedi#rename_visual()<CR>
nnoremap <silent> <buffer> <Plug>JediDocumentation    :call jedi#show_documentation()<CR>
inoremap          <buffer> <Plug>JediCompleteString   <C-r>=jedi#complete_string(1)<CR>
inoremap <silent> <buffer> <Plug>JediSmartAutoMapping <C-r>=jedi#smart_auto_mappings()<CR>


if g:jedi#auto_initialization
    if !jedi#init_python()
        finish
    endif

    if len(g:jedi#goto_command)
        execute 'nmap <buffer> '.g:jedi#goto_command.' <Plug>JediGoto'
    endif
    if len(g:jedi#goto_assignments_command)
        execute 'nmap <buffer> '.g:jedi#goto_assignments_command.' <Plug>JediGotoAssignments'
    endif
    if len(g:jedi#goto_definitions_command)
        execute 'nmap <buffer> '.g:jedi#goto_definitions_command.' <Plug>JediGotoDefinitions'
    endif
    if len(g:jedi#usages_command)
        execute 'nmap <buffer> '.g:jedi#usages_command.' <Plug>JediUsages'
    endif
    if len(g:jedi#rename_command)
        execute 'nmap <buffer> '.g:jedi#rename_command.' <Plug>JediRename'
        execute 'vmap <buffer> '.g:jedi#rename_command.' <Plug>JediRenameVisual'
    endif
    if len(g:jedi#documentation_command)
        execute 'nmap <buffer>'.g:jedi#documentation_command.' <Plug>JediDocumentation'
    endif

    if g:jedi#show_call_signatures > 0 && has('conceal')
        call jedi#configure_call_signatures()
    endif

    if g:jedi#completions_enabled == 1
        imap <buffer> . .<Plug>JediCompleteString
    endif

    if g:jedi#smart_auto_mappings == 1
        imap <buffer> <space> <Plug>JediSmartAutoMapping
    end

    if g:jedi#auto_close_doc
        " close preview if its still open after insert
        augroup jedi_preview
            autocmd! InsertLeave <buffer> if pumvisible() == 0|pclose|endif
        augroup END
    endif
endif
