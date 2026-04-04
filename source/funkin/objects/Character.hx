package funkin.objects;

import funkin.data.character.CharacterData;
import funkin.objects.FunkinSprite;

class Character extends FunkinSprite
{
	public var id:String;
	public var data:CharacterMetadata;

	public var cameraOffset:FlxPoint = FlxPoint.get();
	public var characterOrigin(get, never):FlxPoint;

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
		centerOrigin();

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
		flipX = data.flipX;
		flipY = data.flipY;
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
		if (Conductor.instance.curBeat - lastSingBeat >= 2)
		{
			if (animation.exists(animation.name + "-end"))
			{
				playAnimation(animation.name + "-end", true);
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

	function get_characterOrigin()
	{
		var xPos = (width / 2);
		var yPos = (height);
		return FlxPoint.get(xPos, yPos);
	}
}