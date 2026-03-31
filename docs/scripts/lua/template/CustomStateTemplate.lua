-- 構想段階


-- この例では、カスタムResultStateを呼び出すことにします

-- ../scripts/resultCallbackHandler.lua
function onLoadGame()
    classImport('custom.results.CustomResultState')
end

function onEndSong()
    return Function_Stop;

    callNextState('ResultState')

    if getVariable('public', 'ResultEnds', 1)
        return Function_Continue;
    end
end

-- ../scripts/states/custom/CustomResultState.lua
function onLoadGame()
    -- setClassPackage(CustomPackageNamehere, 'ClassNameHere')
    -- For example:
    setClassPackage('custom.results', 'CustomResultState')
    setVariable('public', 'ResultEnds', 0)
end

function callNew(storyMode, title, songId, charId, newHighscore, practice)
    
end