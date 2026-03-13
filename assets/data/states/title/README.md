# Init/Title Metadata
``` json
{
    "initHandler": [
        // {"sickBeat": Beatの数字, "data": [種類, 中身, 値(必要であれば)]}
        // "data"の種類: playMusic, coolText, text, images, 空白またはDelete, skipIntro
        // playMusicは、["playMusic", musicフォルダ内の音楽ファイルの名前, フェードインの時間(もちろん0も可能)]
        // coolTextは、["coolText", [タイトルで表示する文字, 配列なので二つ目以降も追加できる, wackeyの場合dataフォルダにあるランダムな奴.txtを使える], x座標(なしも可)]
        // textは、["text", タイトルで表示する文字(配列では無い), x座標(なしも可)]
        // imagesは、["images", titleDataのintroImagePathで指定した画像を表示するかどうか, x座標(なしも可)]
        // Delete系は、["delete"] で文字が消える
        // skipIotroは、["skipIntro"] でタイトルメニューに変わる
        {"sickBeat": 1, "data": ["playMusic", "freakyMenu", 0.4]},
        {"sickBeat": 2, "data": ["coolText", ["Horizon Engine by"], 40]},
        {"sickBeat": 4, "data": ["text", "Youbadao", 40]},

        {"sickBeat": 5, "data": [""]},

        {"sickBeat": 6, "data": ["coolText", ["Not associated", "with"], -40]},
        {"sickBeat": 8, "data": ["text", "newgrounds", -40]},
        {"sickBeat": 6, "data": ["images", true, -40]},

        {"sickBeat": 9, "data": [""]},
        {"sickBeat": 9, "data": ["images", false]},

        {"sickBeat": 10, "data": ["coolText", ["wacky1"]]},
        {"sickBeat": 12, "data": ["text", "wacky2"]},

        {"sickBeat": 13, "data": [""]},

        {"sickBeat": 14, "data": ["text", "Friday"]},
        {"sickBeat": 9, "data": ["text", "Night"]},
        {"sickBeat": 9, "data": ["text", "Funkin"]},

        {"sickBeat": 9, "data": ["skipIntro"]}
    ],
    "titleData": {
        "introImagePath": "newgrounds_logo", // イントロで表示する画像(newgrounds等)
        "characters": ["gfTitle"], // このフォルダにあるcharsフォルダ内のjson名を参照
        "logo": { // ロゴの設定
            "normal": {
                "assetPath": "logoBumpin",
                "animation": {
                    "name": "idle",
                    "prefix": "logo bumpin",
                    "looped": true // これをfalseにすると、beatHitでアニメーションが再生される
                },
                "position": [-150, -100]
            }
        },
        "start": { // Press Enter Keyなんとかかんとかなどの画像の設定
            "assetPath": "",
            "animation": [
                {
                    "name": "idle",
                    "prefix": "Press Enter to Begin",
                    "frameRate": 24
                },
                {
                    "name": "confirm",
                    "prefix": "ENTER PRESSED",
                    "frameRate": 24
                }
            ],
            "position": [100, 576],
            // "nextState": [package, stateClass]
            "nextState": ["funkin.play", "MainMenuState"]
        },
        "bpm": 102 // テンポ。これでイントロの速さ等が決まる
    },
    "easterEgg": false, // イースターエッグ要素を入れるかどうか

    "author": "Youbadao"
}
```
____________________________
## Title data

* `initHandler`: Init text data. Read `Init Handler` Section.
* `titleData`: Title Data. Read `Title Visible` Section.

### Optional Settings
* `easterEgg`: Enabled to Title EasterEgg.
    - `Default`: false
* `author`: Enter the name of the persons who created or proposed the Text or Sprite.

____________________________
## Init Handler
This data is an array, can manage multiple .
* `sickBeat`: Enter the number of beats to set.
* `data`: Dynamic Settings. Read `data` part.

### data
The first part of the array is a string. Leave it blank or enter one of the following characters:
* `coolText`
* `text`
* `playMusic`
* `images`
* `skipIntro`
    - Leaving it blank will clear everything, while setting it to skipIntro will proceed to the title screen.
    - For the second and subsequent selections, the text at the beginning determines the branch.
    If set to blank or skipIntro, no subsequent settings will be applied.

The second part of the array is a dynamic.
All objects added other than playMusic will remain displayed until they are cleared.

* If it's `coolText`: The second part of the array is a Array of String.
    - You can add multiple lines of text to display on the screen.

* If it's `text`: The second part of the array is a String.
    - You can add a lines of text to display on the screen.

* If it's `playMusic`: The second part of the array is a String.
    - You can add a path of `MusicName.ogg` file in `music/${MusicName}` folder.

* If it's `images`: The second part of the array is a Boolean.
    - You can control the display of the image set in titleData.introImagePath.

The final part of the array is a Float.

* If it's `coolText` or `text` or `images`: The final part of the array is a float.
    - You can set X offset of the text line.

* If it's `playMusic` The final part of the array is a float.
    - You can set fadeIn time of music.