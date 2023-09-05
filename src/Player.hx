enum FacingDirection {
    Right;
    Left;
}

class Player {
    static var PW = 16;
    static var PH = 16;
    static var GROUND_Y = 100;
    static var V_0 = -4;
    static var AY = 0.3 ;

    // View
    var anim: h2d.Anim;
    var stillFrames: Array<h2d.Tile>;
    var runningFrames: Array<h2d.Tile>;
    var allAnims: Array<Array<h2d.Tile>>;

    // State
    var facingDirection: FacingDirection;
    var x: Float;
    var y: Float;
    var dy: Float;

    public function new(game: Game, x: Float, y: Float) {
        this.x = x;
        this.y = y;
        this.dy = 0;

        initFrames(game.tileSheet);
        anim = new h2d.Anim(stillFrames, 5);
        anim.x = x;
        anim.y = y;
        game.world.add(anim, Game.LAYER_SPRITES);
        facingDirection = FacingDirection.Right;
    }

    private function initFrames(tileSheet: h2d.Tile) {
        stillFrames = [tileSheet.sub(0, 0, PW, PH)];
        runningFrames = [for (i in 0...2) tileSheet.sub(0, i*PW, PW, PH)];
        allAnims = [stillFrames, runningFrames];
        for (animFrames in allAnims) {
            for (tile in animFrames) {
                tile.dx = -8;
            }
        }
    }

    public function update(dt: Float, input: Input) {
        var isRunning = false;
        var oldFacingDir = facingDirection;

        if (isOnGround()) {
            y = GROUND_Y;
            dy = 0;
        }
        else {
            dy += AY;
        }

        if (input.up && isOnGround()) {
            dy = V_0;
        }
        if (input.left) {
            x -= 1;
            facingDirection = FacingDirection.Left;
            isRunning = true;
        }
        if (input.right) {
            x += 1;
            facingDirection = FacingDirection.Right;
            isRunning = true;
        }

        y += dy;

        anim.x = x;
        anim.y = y;

        if (isRunning) {
            anim.play(runningFrames, anim.currentFrame);
        }
        else {
            anim.play(stillFrames, anim.currentFrame);
        }

        if (facingDirection != oldFacingDir) {
            for (animFrames in allAnims) {
                for (frame in animFrames) {
                    frame.flipX();
                }
            }
        }
    }

    public function isOnGround() {
        return y >= GROUND_Y;
    }
}
