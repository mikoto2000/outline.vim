outline.vim
===========

アウトライン表示と、ジャンプを行うプラグインです。

Usage:
------

`outline#OpenOutlineBuffer()` を、お好みのキーにマッピングしてください。

設定例 :

```vim
noremap <Leader>o <Esc>:call outline#OpenOutlineBuffer()<Enter>
```

`outline#OpenOutlineBuffer()` を実行すると、アウトライン表示用バッファーが開き、構造体と関数の一覧が表示されます。
移動したい構造体 or 関数にカーソルを合わせ、 ``<Enter>`` を押すと、その場所まで移動します。


License:
--------

Copyright (C) 2016 mikoto2000

This software is released under the MIT License, see LICENSE

このソフトウェアは MIT ライセンスの下で公開されています。 LICENSE を参照してください。


Author:
-------

mikoto2000 <mikoto2000@gmail.com>
