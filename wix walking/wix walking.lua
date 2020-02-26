--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:aa7c20b8e04912afe476bd1a0a9fd718:994eede66a9f1d33601073d75c113aa6:b488e064315517a6ef3698ac33b0ed02$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- wix frame 1
            x=1,
            y=1,
            width=248,
            height=558,

            sourceX = 67,
            sourceY = 237,
            sourceWidth = 400,
            sourceHeight = 1080
        },
        {
            -- wix frame 2
            x=1,
            y=561,
            width=248,
            height=556,

            sourceX = 76,
            sourceY = 262,
            sourceWidth = 400,
            sourceHeight = 1080
        },
        {
            -- wix frame 3
            x=1,
            y=1119,
            width=248,
            height=554,

            sourceX = 76,
            sourceY = 263,
            sourceWidth = 400,
            sourceHeight = 1080
        },
    },

    sheetContentWidth = 250,
    sheetContentHeight = 1674
}

SheetInfo.frameIndex =
{

    ["wix frame 1"] = 1,
    ["wix frame 2"] = 2,
    ["wix frame 3"] = 3,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
