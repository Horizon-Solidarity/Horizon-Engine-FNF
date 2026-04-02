package funkin.objects;

import funkin.data.character.CharacterData;
import funkin.objects.FunkinSprite;

class Character extends FunkinSprite
{
	public var id:String;
	public var data:CharacterMetadata;

	// _____________________ search variables _____________________
	public var specialAnim:Bool = false;
	public var idleSuffix:String = '';

	public var lastSingBeat:Float = 0;

	public var danceAnimations:Array<String> = ["idle"];
	public var singAnimations:Array<String> = ["singLEFT", "singDOWN", "singUP", "singRIGHT"];

	public function new(?charName:String = 'bf')
	{
		super();

		if (Conductor.instance != null)
			Conductor.instance.onBeatHit.add(beatHit);

		changeCharacter(charName);
	}

	public function changeCharacter(charID:String):Void
	{
		clearAnimations();

		id = charID;
		data = CharacterMetadata.fromCharacterId(charID);


		switch(data.renderType)
		{
			default: //case Sparrow:
				frames = FunkinAssets.getSparrow(data.assetPath);
		}

		scale.set(data.scale[0], data.scale[1]);
		updateHitbox();

		antialiasing = (ClientPrefs.data.antialiasing && data.antialiasing);

		for (anim in data.animations)
		{
			addAnimationData(anim.name, anim);
		}

		dance();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (specialAnim && isAnimationFinished())
			specialAnim = false;
	}

	function beatHit(beat:Int)
	{
		if (Conductor.instance.curBeat + 2 >= lastSingBeat)
		{
			if (animation.exists(animation.name + "-end"))
			{
				playAnimation(animation.name + "-end");
				return;
			}
			dance(beat);
		}
	}

	var danceIndex:Int = 0;

	function dance(beat:Int = 0)
	{
		var mod = data.danceAnimations.length > 1 ? 1 : 2;

		if (beat % mod == 0)
		{
			if (data.danceAnimations[danceIndex] != null)
				playAnimation(data.danceAnimations[danceIndex] + idleSuffix);
			danceIndex += 1;
			if (danceIndex >= data.danceAnimations.length)
				danceIndex = 0;
		}
	}

	override public function playAnimation(anim:String, force:Bool = false)
	{
		if (specialAnim)
			return;

		if (!data.danceAnimations.contains(anim))
			danceIndex = 0;
		super.playAnimation(anim, force);
	}

}