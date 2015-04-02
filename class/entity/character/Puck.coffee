class Puck

	constructor: (options = {}) ->
		@paused = no
		@ready = yes
		@health = 3
		@hitTimeout = no
		@bodySize = [
			65 # width
			65 # height
			0 # x
			48 # y
		]
		@bounce = 0.5
		@sprite = @createSprite()
		@addAnimations @sprite

	createSprite: ->
		sprite = game.add.sprite 0 - @bodySize[2], 0 - @bodySize[3], 'puck'
		game.physics.enable sprite, Phaser.Physics.ARCADE
		sprite.anchor.setTo 0.5, 0.5
		sprite.body.collideWorldBounds = yes
		sprite.body.bounce.setTo @bounce, @bounce
		sprite.body.setSize @bodySize[0], @bodySize[1], @bodySize[2], @bodySize[3]
		sprite

	addAnimations: (sprite) ->
		loopFPS = 10
		deathFPS = 10
		@sprite.animations.add 'firstLoop', [7, 0, 1, 2, 3, 4, 5, 6], loopFPS, true
		@sprite.animations.add 'firstDeath', [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21], deathFPS, false
		@sprite.animations.add 'secondLoop', [29, 23, 24, 25, 26, 27, 28, 22], loopFPS, true
		@sprite.animations.add 'secondDeath', [30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43], deathFPS, false
		@sprite.animations.add 'thirdLoop', [51, 45, 46, 47, 48, 49, 50, 44], loopFPS, true
		@sprite.animations.add 'thirdDeath', [52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65], deathFPS, false
		sprite.animations.play 'firstLoop'

	updateAnimation: ->
		current = @sprite.animations.currentAnim.name
		if @sprite.animations.currentAnim.isFinished
			switch current
				when 'firstDeath' then @sprite.animations.play 'secondLoop'
				when 'secondDeath' then @sprite.animations.play 'thirdLoop'
		if @sprite.animations.currentAnim.loop
			if @health is 2 and current is 'firstLoop' then @sprite.animations.play 'firstDeath'
			if @health is 1 and current is 'secondLoop' then @sprite.animations.play 'secondDeath'
			if @health is 0 and current is 'thirdLoop' then @sprite.animations.play 'thirdDeath'

	update: ->
		if game.controls.newPrimary
			@smash()
		@updateAnimation()

	smash: ->
		force = 1.5
		vectorX = (game.controls.worldX - @sprite.body.center.x) * force
		vectorY = (game.controls.worldY - @sprite.body.center.y) * force
		if @health > 0 and @ready
			@deactivate()
			@sprite.body.velocity.setTo vectorX, vectorY

	stop: ->
		@sprite.body.velocity.setTo 0

	activate: ->
		@ready = yes

	deactivate: ->
		@ready = no

	moveTo: (x, y) ->
		@sprite.position.setTo x - @bodySize[2], y - @bodySize[3]

	damage: ->
		@health--
		@activate()
		if @health is 0 then @stop()
			
		