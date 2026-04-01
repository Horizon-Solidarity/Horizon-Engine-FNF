-- 構想段階


-- この例では、カスタムResultStateを呼び出すことにします

-- ../scripts/play/resultCallbackHandler.lua
function onLoadGame()
    classImport('custom.results.CustomResultState')
end

function onEndSong()
    return Function_Stop;

    callNextState('CustomResultState', [true, songName, charId, newHighscore, practice])

    if getVariable('public', 'ResultEnds', true)
        return Function_Continue;
    end
end

-- ../scripts/states/custom/CustomResultState.lua
function onLoadGame()
    -- setClassPackage(CustomPackageNamehere, 'ClassNameHere')
    -- For example:
    setClassPackage('custom.results', 'CustomResultState')
    setVariable('public', 'ResultEnds', false)
end

function callNew(storyMode, title, charId, newHighscore, practice)
    
    setVariable('public', 'ResultEnds', true)
end