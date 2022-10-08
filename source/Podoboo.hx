package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;

class Podoboo extends FlxSprite
{
    private var state:FlxState;

    override public function new(x:Float = 0, y:Float = 0, state:FlxState, yVelocity:Float)
    {
        super(x, y);
        this.state = state;
        frames = Paths.getSparrowAtlas('podoboo_assets');
        antialiasing = ClientPrefs.globalAntialiasing;
		animation.addByPrefix('idle', 'podoboo0', 24, true);
		animation.play('idle');
        updateHitbox();

        acceleration.y = 4000;
        velocity.y = -yVelocity*1000;
    }

    override function update(elapsed:Float)
    {
        flipY = velocity.y > 0;
        super.update(elapsed);

        if (FlxG.random.bool(5))
        {
            var xSpawn = x + FlxG.random.float(width * 0.3, width * 0.6);
            var ySpawn = y + FlxG.random.float(height * 0.3, height * 0.6);
            var particle = new PodobooParticle(xSpawn, ySpawn, state, FlxG.random.float(0.2, 1));
            particle.x -= particle.width / 2;
            particle.y -= particle.height / 2;
            particle.cameras = cameras;
            particle.acceleration.y = FlxG.random.float(300, 600);
            particle.acceleration.x = FlxG.random.float(-200, 200);
            particle.velocity.y = -acceleration.y / 800;
            particle.color = color;
            state.insert(state.members.indexOf(this), particle);
        }
    }
}

class PodobooParticle extends FlxSprite
{
    private var state:FlxState;

    override public function new(x:Float = 0, y:Float = 0, state:FlxState, scale:Float)
    {
        super(x, y);
        this.state = state;
        frames = Paths.getSparrowAtlas('podoboo_assets');
        antialiasing = ClientPrefs.globalAntialiasing;
		animation.addByPrefix('idle', 'podoboo_bubble', 24, false);
		animation.play('idle');
        updateHitbox();

        setGraphicSize(Std.int(width * scale));
        updateHitbox();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (animation.curAnim.finished)
        {
            state.remove(this, true);
            destroy();
        }
    }
}