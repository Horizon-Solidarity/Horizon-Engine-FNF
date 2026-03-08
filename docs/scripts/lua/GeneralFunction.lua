
function onCreate()
	-- Triggered when the lua file is started, some variables weren't created yet
end

function onCreatePost()
	-- End of "create"
end

function onDestroy()
	-- Triggered when the lua file is ended
end


-- Gameplay/Song interactions
function onSectionHit()
	-- Triggered after it goes to the next section
end

function onBeatHit()
	-- Triggered 4 times per section
end

function onStepHit()
	-- Triggered 16 times per section
end

function onUpdate(elapsed)
	-- Start of "update", some variables weren't updated yet
	-- Also gets called while in the game over screen
end

function onUpdatePost(elapsed)
	-- End of "update"
	-- Also gets called while in the game over screen
end

function onStartCountdown()
	-- Countdown started, duh
	-- return Function_Stop if you want to stop the countdown from happening (Can be used to trigger dialogues and stuff! You can trigger the countdown with startCountdown())
	return Function_Continue;
end

function onCountdownStarted()
	-- Called AFTER countdown started, if you want to stop it from starting, refer to the previous function (onStartCountdown)
end

function onCountdownTick(counter)
	-- counter = 0 -> "Three"
	-- counter = 1 -> "Two"
	-- counter = 2 -> "One"
	-- counter = 3 -> "Go!"
	-- counter = 4 -> Nothing happens lol, tho it is triggered at the same time as onSongStart i think
end

function onSpawnNote(id, data, type, isSustainNote, strumTime)
	--You can use id to get other properties from notes, for example:
	--getPropertyFromGroup('notes', id, 'texture')
end

function onStartSong()
	-- Inst and Vocals start playing, songPosition = 0
end

function onEndSong()
	-- Song ended/starting transition (Will be delayed if you're unlocking an achievement)
	-- return Function_Stop to stop the song from ending for playing a cutscene or something.
	return Function_Continue;
end

