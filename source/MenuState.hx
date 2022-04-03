package;

import flixel.system.debug.interaction.tools.Pointer;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.addons.ui.FlxButtonPlus;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
    var titleText:FlxText;
    var playButton:FlxButtonPlus;
    #if desktop
    var exitButton:FlxButtonPlus;
    #end

    override public function create()
    {
        titleText = new FlxText(20, 0, 0, "Name of Game", 22);
        titleText.alignment = CENTER;
        titleText.screenCenter(X);
        add(titleText);

        playButton = new FlxButtonPlus(0, 0, clickPlay, "Play", 200, 50);
        //PlayButton.onUp.sound = FlxG.sound.load(AssetPaths.start__wav);
        playButton.x = (FlxG.width / 2) - (0.5 * playButton.width);
        playButton.y = FlxG.height - playButton.height - 150;
        add(playButton);

        #if desktop
        exitButton = new FlxButtonPlus(FlxG.width - 90, 8, clickExit, "X", 80, 20);
        //exitButton.loadGraphic(AssetPaths.button__png, true, 20, 20);
        add(exitButton);
        #end

        FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

        super.create();
    }

    private function clickPlay()
    {
        FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
        {
            FlxG.switchState(new PlayState());
        });
    }

    #if desktop
    private function clickExit()
    {
        Sys.exit(0);
    }
    #end

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER)
            FlxG.fullscreen = !FlxG.fullscreen;
    }
}