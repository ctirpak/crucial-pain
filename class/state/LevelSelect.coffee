CrucialPain.LevelSelect = (game) ->

CrucialPain.LevelSelect.prototype =
    create: ->
        game.mode = 'menu'
        game.stage.setBackgroundColor '#000000'

        unless localStorage.getItem 'maxLevel'
            localStorage.setItem 'maxLevel', 1

        maxLevel = localStorage.getItem 'maxLevel'
        maxLevel = maxLevel * 1

        levelCount = 0
        while game.cache._tilemaps[''+(levelCount + 1)+'']
            levelCount++
            x = (100 * ((levelCount - 1) % 8)) + 28 + 115 + scaleManager.levelOffsetX - (scaleManager.scale * 330) + 330
            y = ((58 + 40 / scaleManager.scale) * Math.floor((levelCount - 1) / 8)) + 100 + (52 / scaleManager.scale) + scaleManager.levelOffsetY
            button = new Button(
                x: x
                y: y
                label: '' + levelCount + '')
            maxLevelScore = localStorage.getItem 'maxLevelScore' + levelCount + ''
            if maxLevelScore
                maxLevelScore = maxLevelScore * 1
                text = game.add.bitmapText x + 18, y + 4, 'astonished', Helpers.ScoreToString(maxLevelScore), 24
                text.x = text.x - text.width / 2
            if maxLevel < levelCount
                button.sprite.alpha = 0.25
                button.text.alpha = 0.25

        backButton = game.add.bitmapText 0, 0, 'astonished', 'back', 36
        backButton.fixedToCamera = yes
        backButton.cameraOffset.x = 32
        backButton.cameraOffset.y = 16
        backButton.scale.set scaleManager.scale
        backButton.inputEnabled = yes
        backButton.events.onInputDown.add @startMainMenu, @    

        game.state.states.Default.create()
        game.ui.blank.fadeFrom()
        return
    update: ->
        game.state.states.Default.update()
        return
    render: ->
    startMainMenu: ->
        game.mode = 'stateChange'
        game.ui.blank.fadeTo =>
            game.state.clearCurrentState()
            @state.start 'MainMenu'