# Characters
## data
``` Json
{
    "name": "Daddy Dearest",
    "assetPath": "characters/DADDY_DEAREST",
    "renderType": "sparrow",
    "isPixel": false,
    "flipX": false,
    "offsets": [2, 16],
    "cameraOffsets": [-2, 9],
    "idleBeat": 2,
    "singTime": 8.0,
    "sustainAnim": false,
    "ghostEffect": false,
    "healthIcon": {
        "id": "dad",
        "splitable": {"enabledS": false},
        "win": {"enabled": false},
        "scale": 1,
        "angle": 0,
        "flipX": false
    },
    "animations": [
        {
            "name": "idle",
            "prefix": "Dad idle dance",
            "frameRate": 24
        },
        {
            "name": "singLeft",
            "prefix": "dad sing note right",
            "frameRate": 24
        },
        {
            "name": "singDown",
            "prefix": "Dad Sing Note DOWN",
            "frameRate": 24
        },
        {
            "name": "singUp",
            "prefix": "Dad Sing note UP",
            "frameRate": 24
        },
        {
            "name": "singRight",
            "prefix": "Dad Sing Note LEFT",
            "frameRate": 24
        }
    ]
}
```
_________
* `name`: Character's full name in Chart Editor
* `assetPath`: Asset Path of sprite data.
* `renderType`: Sprite Rendering Type
    * `sparrow`: xml and png fileFormat.
    * `animateatlas`: Adobe Animate's Texture Atlas Sprite.

            (`Animation.json`, `spritemap1.json`, `spritemap1.png`)
    * `packer`: txt and png fileFormat.
    * `Multiple-Sparrow`: Multiple sparrow sprite. can add `altAssetPath` to `animations`.
    * `Multiple-Animateatlas`: Multiple Adobe Animate' Texture Atlas sprite.
        can add `altAssetPath` to `animations`.

* `offsets`: Sprite position in Game. `[x, y]`
* `cameraOffsets`: Sprite's camera position in Game. `[x, y]`
* `healthIcon`: Health icon Settings. Read `Health Icon data` section.
* `animations`: Animation data. Read `Animation data` section.

### Optionally Settings
* `isPixel`: If your sprites are pixel art, turn this true. (This will disable anti-aliasing.)
    - `default: false`
* `scale`: Sprite Scale setting.
    - `default: [1.0, 1.0]`
* `flipX`: If you want to X flip the sprite, turn this true.
    - `default: false`
* `flipY`: If you want to Y flip the sprite, turn this true.
    - `default: false`
* `idleBeat`: Beat interval for idle animation.
    - `default: 2`
* `singTime`: Wait time before reset animation to idle after animation ends.
    - `default: 8.0`
* `sustainAnim`: If you want to animate during the hold, turn this true.
    - `default: false`
* `ghostEffect`: If you want to display the ghost effect during a double note hit, turn this true.
    - `default: false`

* `deathData`: Gameplay settings upon death. Read `Death data` section.
___________________

## Health Icon data
* `id`: Health Icon Name (in `images/states/play/charIcons` folder).
* `splitable`: Read `Splitable` parts.
* `win`: Read `Win Icon` parts.

### Optionally Settings
* `scale`: icon scale.
    - `default: [1.0, 1.0]`
* `angle`: icon angle.
    - `default: 1.0`
* `flipX`: icon Xflipping.
    - `default: false`
* `flipY`: icon Yflipping.
    - `default: false`
* `offsets`: Icon position in Game.
    - `default: [0, 0]`

___________________
### Splitable
* `enabledS`: If the ID is the folder name, turn this true.

#### Optionally
* `normalPath`: Enter the path to the normal icon in the folder.
    - `default: "normal"`
* `missPath`: Enter the path to the miss icon in the folder.
    - `default: "misses"`

__________________________________
### Win Icon
* `enabledW`: If add win icon, turn this true.

#### Optionally
`default: ""`
* `path`: Win Icon Name (in `images/states/play/charIcons/win` folder).
__________________________

## Death data
if the character is Playable. using this data.
``` json
/// data/characters/bf.json
{
    // (Code Omitted)
    "deathData": {
        "cameraOffsets": [-73, 42]
    },
    // (Code Omitted)
}
```
* `cameraOffsets`: Camera Offsets in Death Screen.
* `cameraZoom`: Camera Zoom in Death Screen.
* `preTransDelay`: Pre Transition Delay.

___

## Animation Data
This data is an array, can manage multiple animations.
* `name`: Animation Name. Read `Anim Name` parts.
* `prefix`: Animation The animation name as specified by character spritesheet.
    - For Sparrow or Packer, check inside the data file to see what each set of frames is named, and use that as the prefix, excluding the frame numbers at the end.
    - For Animate Atlases, use either the frame label or the symbol name of the animation you want to play.

### Optionally Settings
* `altAssetPath`: Asset path of sprite data.
    - If you set the `renderType` string to `Multiple-${RenderType}`, you can use this.
* `indices`: Specify an array of frame numbers (starting at frame 0!) to use from a given prefix for this animation.
For example, specifying [0, 1, 2, 3] will make this animation only use the first 4 frames of the given prefix.

* `frameRate`: Animation fps
    - `default: 24`
* `flipX`: Sprite X flipping in playing animation.
    - `default: false`
* `flipY`: Sprite Y flipping in playing animation.
    - `default: false`
* `scale`: Sprite Scale setting.
    - `default: [1, 1]`
* `offsets`: Sprite position in Game to playing Animation.
    - `default: [0, 0]`
* `looped`: if you enabled this, animation is Looping

### Anim Name
#### Regular Name
* `idle`: Animation name during standby.
* `singA`: Animation name during sing. The following word gose in A:
    * `Left`
    * `Down`
    * `Up`
    * `Right`
* `singA-miss`: Animation name during miss animation.
* `singA-end`: Animation name during ended animTimer.
    - You can also use this to create smooth animations.

#### Other Name