""" アウトライン用バッファを開く
function! outline#OpenOutlineBuffer()
    """ 呼び出し元のウィンドウ ID を記憶
    let s:caller_window_id = win_getid()

    """ 編集中ファイルパスを記録
    let file_path = expand("%")

    """ アウトライン表示用バッファを開く
    silent bo new

    """ ctags, awk を使ってアウトラインを作成、バッファに表示する
    silent execute "read !ctags -x " . file_path . " --sort=no | grep -v member | awk '{$1=\"\";$2=\"\";$3=\"\" + $3;$4=\"\";print}'"
    1delete

    """ ウィンドウサイズ調整
    call outline#FitWinCol()

    """ バッファリスト用バッファの設定
    setlocal noshowcmd
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal nomodifiable
    setlocal nowrap
    setlocal nonumber

    """ 行移動のマッピング定義
    map <buffer> <Return> :call outline#GoTarget()<Return>

    """ バッファリストを閉じるのマッピング定義
    map <buffer> q :call outline#CloseOutlineBuffer()<Return>

endfunction

""" カーソル上の構造体 or 関数まで移動
function! outline#GoTarget()
    let line_no = outline#GetLineNo()
    :bwipeout!

    """ 呼び出し元ウィンドウをアクティブにする
    call win_gotoid(s:caller_window_id)

    """ バッファを開く
    execute "normal " . line_no . "gg"
endfunction

""" カーソル上の構造体 or 関数の行番号を取得
function! outline#GetLineNo()
    let line = getline(line('.'))
    let splited_line = split(line, ' ', 0)
    return get(splited_line, 0)
endfunction

""" アウトライン表示用バッファを閉じる
function! outline#CloseOutlineBuffer()
    """ アウトライン表示用バッファを閉じる
    :bwipeout!

    """ 呼び出し元ウィンドウをアクティブにする
    call win_gotoid(s:caller_window_id)
endfunction

""" ウィンドウサイズ調整
function! outline#FitWinCol()
    let current_win_height=winheight('%')
    let line_num=line('$')
    if current_win_height - line_num > 0
        execute "normal z" . line_num . "\<Return>"
    endif
endfunction
