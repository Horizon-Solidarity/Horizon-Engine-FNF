package;

import sys.FileSystem;
import sys.io.File;

using StringTools;

class ChartConverter {
	public static function main()
	{
		trace("Put V-Slice's Chart Path!");
		var vsliceChartPath = Sys.stdin().readLine().trim();
		if (!FileSystem.exists(vsliceChartPath)) {
			trace('No Chart Exists in ($vsliceChartPath) !!');
			return;
		}

		trace("Put V-Slice's Metadata Path!");
		var vsliceMetaPath = Sys.stdin().readLine().trim();
		if (!FileSystem.exists(vsliceMetaPath)) {
			trace('No Metadata Exists in ($vsliceMetaPath) !!');
			return;
		}

		var vsliceChart = haxe.Json.parse(File.getContent(vsliceChartPath));
		var vsliceMeta = haxe.Json.parse(File.getContent(vsliceMetaPath));

		var horizonMeta:SongMetadata = {
			name: vsliceMeta.songName,

			difficulties: vsliceMeta.playData.difficulties,
			variations: [],

			credits: {
				charter: vsliceMeta.charter
			}

		}

		var variations:Array<String> = vsliceMeta.playData.songVariations;
		for (variation in variations)
		{
			var variationJson = haxe.Json.parse(File.getContent(vsliceMetaPath.replace(".json", "-" + variation + ".json")));
			horizonMeta.variations.push({
				id: variation,
				name: variationJson.songName,
				difficulties: variationJson.playData.difficulties,
				credits: {
					charter: variationJson.charter
				}
			});
		}

		FileSystem.createDirectory("exported_charts/data/");
		File.saveContent("exported_charts/data/metadata.json", haxe.Json.stringify(horizonMeta, "\t"));

		variations.push("default");

		for (variation in variations)
		{
			var curVSliceChart = vsliceChart;
			var curVSliceMeta = vsliceMeta;
			if (variation != "default")
			{
				curVSliceChart = haxe.Json.parse(File.getContent(vsliceChartPath.replace(".json", "-" + variation + ".json")));
				curVSliceMeta = haxe.Json.parse(File.getContent(vsliceMetaPath.replace(".json", "-" + variation + ".json")));
			}

			var difficulties:Array<String> = curVSliceMeta.playData.difficulties;

			for (difficulty in difficulties)
			{
				var horizonChart:SongChartData = {
					scrollSpeed: Reflect.field(curVSliceChart.scrollSpeed, difficulty),
					events: [],
					characters: [
						{ // bf
							id: curVSliceMeta.playData.characters.player,
							type: CharacterType.PLAYER,
							vocalSuffix: "-" + curVSliceMeta.playData.characters.player,
							strumline: {
								visible: true,
								keys: 4,
								noteskin: curVSliceMeta.playData.noteStyle,
								scale: 1,
								offset: [0, 0],
								notes: []
							}
						},
						{ // dad
							id: curVSliceMeta.playData.characters.opponent,
							type: CharacterType.OPPONENT,
							vocalSuffix: "-" + curVSliceMeta.playData.characters.opponent,
							strumline: {
								visible: true,
								keys: 4,
								noteskin: curVSliceMeta.playData.noteStyle,
								scale: 1,
								offset: [0, 0],
								notes: []
							}
						},
						{ // gf
							id: curVSliceMeta.playData.characters.girlfriend,
							type: CharacterType.SPECTATOR,
							vocalSuffix: "-" + curVSliceMeta.playData.characters.girlfriend,
							strumline: {
								visible: false,
								keys: 4,
								noteskin: curVSliceMeta.playData.noteStyle,
								scale: 1,
								offset: [0, 0],
								notes: []
							}
						}
					],

					stage: curVSliceMeta.playData.stage,
					uiStyle: curVSliceMeta.playData.noteStyle
				}



				for (i in 0...Reflect.field(curVSliceChart.notes, difficulty).length)
				{
					var vsliceNote = Reflect.field(curVSliceChart.notes, difficulty)[i];

					var horizonNote:ChartNotesData = {
						time: vsliceNote.t,
						lane: vsliceNote.d % 4,
						length: vsliceNote.l,
						type: vsliceNote.k
					}

					if (vsliceNote.d >= 4)
						horizonChart.characters[1].strumline.notes.push(horizonNote);
					else
						horizonChart.characters[0].strumline.notes.push(horizonNote);
				}

				for (i in 0...curVSliceChart.events.length)
				{
					var vsliceEvent = curVSliceChart.events[i];

					var name:String = "";
					var data:Dynamic = {};
					
					switch (vsliceEvent.e)
					{
						case "FocusCamera":
							name = "Change Camera Focus";
							data = {
								target: vsliceEvent.v.char,
								xPos: vsliceEvent.v.x,
								yPos: vsliceEvent.v.y,
								ease: vsliceEvent.v.ease == "CLASSIC" ? "expoOut" : vsliceEvent.v.ease,
								duration: vsliceEvent.v.ease != "CLASSIC" ? vsliceEvent.v.duration : 16
							}
					}

					var horizonEvent:ChartEventsData = {
						time: vsliceEvent.t,
						name: name,
						data: data
					}

					horizonChart.events.push(horizonEvent);
				}

				if (variation != "default")
				{
					FileSystem.createDirectory("exported_charts/data/charts/" + variation);
					File.saveContent("exported_charts/data/charts/" + variation + "/" + difficulty + ".json", haxe.Json.stringify(horizonChart, "\t"));
				}
				else
				{
					FileSystem.createDirectory("exported_charts/data/charts/");
					File.saveContent("exported_charts/data/charts/" + difficulty + ".json", haxe.Json.stringify(horizonChart, "\t"));
				}
			}

			var horizonTrack:SoundTrackMetadata = {
				artist: curVSliceMeta.artist,
				preview: {
					start: curVSliceMeta.playData.previewStart,
					end: curVSliceMeta.playData.previewEnd
				},
				album: curVSliceMeta.playData.album,
				bpmChanges: []
			};

			var stepsPerBeat:Int = 4;
			var beatsPerMeasure:Int = 4;

			for (i in 0...curVSliceMeta.timeChanges.length)
			{
				var timeChange = curVSliceMeta.timeChanges[i];
				horizonTrack.bpmChanges.push({
					time: timeChange.t,
					bpm: timeChange.bpm,
					stepTime: timeChange.n * timeChange.b,
					stepsPerBeat: timeChange.n,
					beatsPerMeasure: timeChange.d,
				});
			}

			if (variation != "default")
			{
				FileSystem.createDirectory("exported_charts/audio/" + variation);
				File.saveContent("exported_charts/audio/" + variation + "/track.json", haxe.Json.stringify(horizonTrack, "\t"));
			}
			else
			{
				FileSystem.createDirectory("exported_charts/audio/");
				File.saveContent("exported_charts/audio/track.json", haxe.Json.stringify(horizonTrack, "\t"));
			}
		}
	}
}

typedef SongMetadata =
{
	var name:String;

    var difficulties:Array<String>;
    var variations:Array<SongVariationData>;

    var credits:SongCredits;

    var ?generatedBy:String;
}

typedef SongCredits =
{
    var ?charter:String;
    var ?artist:String;
    var ?animatior:String;
    var ?coder:String;
}

typedef SongVariationData =
{
	var id:String;
    var name:String;
    var difficulties:Array<String>;
	var credits:SongCredits;
}

// _____________________________ Chart _____________________________
typedef SongChartData =
{
	var bpm:Float;
	var scrollSpeed:Float;
	var events:Array<ChartEventsData>;
	var characters:Array<SongCharacterData>;

	var stage:String;
	var uiStyle:String;
}

typedef SongCharacterData =
{
	var id:String;
	var type:CharacterType;
	var vocalSuffix:String;
	var strumline:StrumLinedata;
}

typedef StrumLinedata =
{
	var visible:Bool;
	var keys:Int;
	var scale:Float;
	var noteskin:String;
	var offset:Array<Float>;
	var notes:Array<ChartNotesData>;
}

typedef ChartNotesData =
{
    var time:Float;
    var lane:Int;
    var length:Float;
	var type:String;
}

typedef ChartEventsData =
{
	var time:Float;
	var name:String;
	var data:Dynamic;
}

enum abstract CharacterType(String) to String
{
	var OPPONENT = 'opponent';
	var SPECTATOR = 'spectator';
	var PLAYER = 'player';
}


typedef SoundTrackMetadata =
{
    var artist:String;
	var preview:AudioPreviewData;
	var album:String;

	var bpmChanges:Array<AudioBPMChangesData>;
}

typedef AudioPreviewData =
{
	var start:Float;
	var end:Float;
}

typedef AudioBPMChangesData =
{
	var time:Float;
	var bpm:Float;
	var ?endBpm:Float;
	var ?stepTime:Float;
	var ?stepsPerBeat:Int;
	var ?beatsPerMeasure:Int;
}