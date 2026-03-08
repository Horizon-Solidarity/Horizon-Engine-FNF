# hscript
この項目では、hscriptの主な使い方について説明します。
全てのAPIの詳細は[こちら]をご覧ください。

## hscriptって?
hscriptとは、haxeに似た記述形式で、後述の拡張子を使ったスクリプトです。
ただし、haxeとの違いが少しあり、
* classの記述が不要
* コンパイルの過程がないため、エラーが分かりずらい

というものがあります。

hscriptを追加するライブラリは、`hscript`, `Sscript(現在は使えないライブラリ)`, `hscript-iris`があり、
このエンジンでは`hscript-iris`を使用しています。

## 拡張子
* `.hx`
* `.hxs`
* `.hscript`
* `.hxc`

## 書き方
```haxe
package;

import flixel.FlxSprite; // 使用するライブラリファイル

function onCreate() {
  // コードの記述
}
```
