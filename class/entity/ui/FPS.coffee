class FPS

    constructor: ->
        @text = game.add.bitmapText(0, 0, 'astonished', '', 36)
        @text.fixedToCamera = yes
        @text.scale.set scaleManager.scale

    update: ->
        unless game.time.fps is 60
            @text.visible = yes
            @text.cameraOffset.x = game.camera.width - 32 - @text.width
            @text.cameraOffset.y = 16
            @text.setText (game.time.fps or '--') + ' FPS'
        else
            @text.visible = no
        @