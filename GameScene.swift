import SwiftUI
import SpriteKit


enum PlayerStatus {
    case walk, preJump, jump, land
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    //Gerenciador de somzera da massa 💥💥💥
    let soundManager = SoundManager()
    
    //kenny
    var player: SKSpriteNode!
    
    //puzzle
    var puzzle: SKSpriteNode!
    var puzzleCount = 0
    var puzzleOriginalPosition: CGPoint = .zero
    
    
    //movimentos
    var walkAnimation: SKAction!
    var jumpAnimation: SKAction!
    var preJumpAnimation: SKAction!
    var landAnimation: SKAction!
    

    
    //    //som
    //    var backgroundMusic: SKAudioNode!
    //    var walkSoundMusic: SKAudioNode!
    //    var jumpSoundAction: SKAction!
    //    var landSoundAction: SKAction!
    //    var pieceSoundAction: SKAction!
    
    var playerStatus: PlayerStatus = .walk
    
    override func didMove(to view: SKView) {
        
        // configuração do chão
        let ground = SKNode()
        let groundBody = SKPhysicsBody(rectangleOf: CGSize(width: 1512, height: 50))
        ground.position = CGPoint(x: 673, y: 200)
        ground.setScale(2)
        groundBody.isDynamic = false
        ground.name = "ground"
        ground.physicsBody = groundBody
        self.addChild(ground)
        
        physicsWorld.contactDelegate = self
        
        // configuração do jogador
        player = SKSpriteNode(imageNamed: "walk1")
        player.position = CGPoint(x: 250, y: 220)
        player.setScale(1)
        player.zPosition = 6
        player.name = "player"
        let playerBody = SKPhysicsBody(rectangleOf: CGSize(width: 500, height: 350))
        player.physicsBody = playerBody
        self.addChild(player)
        
        
        // configuração puzzle
        puzzle = SKSpriteNode(imageNamed: "piece1")
        puzzle.name = "puzzle"
        puzzle.setScale(0.45)
        puzzle.zPosition = 6
        
        let puzzleBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        puzzleBody.isDynamic = false
        puzzle.physicsBody = puzzleBody
        self.addChild(puzzle)
        
        
        
        // configuração das animações
        setupBackgroundAnimation()
        setupWalkAnimation()
        setupPreJumpAnimation()
        setupJumpAnimation()
        setupLandAnimation()
        setupPuzzleAnimation()
  
        
        //Iniciar som
        soundManager.playLoop(sound: .background_music)
        soundManager.playLoop(sound: .step)
        
        player.run(walkAnimation)
        
        
        // cnfiguração de máscara de contato
        ground.physicsBody!.categoryBitMask = 1
        puzzle.physicsBody!.categoryBitMask = 2
        
        player.physicsBody!.contactTestBitMask = ground.physicsBody!.categoryBitMask | puzzle.physicsBody!.categoryBitMask
        
        
        player.physicsBody!.collisionBitMask = ground.physicsBody!.categoryBitMask
        
  
        ///configuraçao fala inicial
        var textures: [SKTexture] = []
        
        //walkList.append(SKTexture(imageNamed: "walk11"))
        textures.append(SKTexture(imageNamed: "fala1"))
        textures.append(SKTexture(imageNamed: "fala2"))
        textures.append(SKTexture(imageNamed: "fala3"))
        textures.append(SKTexture(imageNamed: "fala2"))
        textures.append(SKTexture(imageNamed: "fala1"))
        textures.append(SKTexture(imageNamed: "fala4"))
        textures.append(SKTexture(imageNamed: "fala5"))
        textures.append(SKTexture(imageNamed: "fala4"))
        textures.append(SKTexture(imageNamed: "fala1"))
        textures.append(SKTexture(imageNamed: "fala2"))
        textures.append(SKTexture(imageNamed: "fala3"))
        textures.append(SKTexture(imageNamed: "fala2"))
        textures.append(SKTexture(imageNamed: "fala1"))
        
        
        
        let imageNode = SKSpriteNode(texture: textures.first)
        imageNode.position = CGPoint(x: size.width / 2, y: size.height / 2 + 270)
        imageNode.zPosition = 11
        imageNode.alpha = 0
        imageNode.setScale(0.8)
        addChild(imageNode)

        //animação
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2) 

        let fadein = SKAction.fadeIn(withDuration: 2.0)
        let wait = SKAction.wait(forDuration: 1.5)
        let fadeout = SKAction.fadeOut(withDuration: 2.0)
        let remove = SKAction.run {
            imageNode.removeFromParent()
        }
        let sequence = SKAction.sequence([fadein, animation, wait, fadeout, remove])
        
        imageNode.run(sequence)
        
        

//        let label = SKLabelNode(text: "Colete as peças do quebra-cabeça!")
//        label.fontName = "SourGummy-Black_Regular" 
//        label.fontSize = 50 
//        label.fontColor = .white
//        label.position = CGPoint(x: size.width / 2, y: size.height / 2 + 300)
//        label.zPosition = 11
//        self.addChild(label)
//        
//        let fadein = SKAction.fadeIn(withDuration: 2.0)
//        let wait = SKAction.wait(forDuration: 0.5)
//        let fadeout = SKAction.fadeOut(withDuration: 2.0)
//        let remove = SKAction.run {
//            label.removeFromParent()
//        }
//        let sequence = SKAction.sequence([fadein, wait, fadeout, remove])
//        label.run(sequence)
    }
    
    // configuração das animações
    func setupWalkAnimation() {
        var walkList = [SKTexture]()
        walkList.append(SKTexture(imageNamed: "walk11"))
        walkList.append(SKTexture(imageNamed: "walk21"))
        walkList.append(SKTexture(imageNamed: "walk31"))
        walkList.append(SKTexture(imageNamed: "walk41"))
        walkList.append(SKTexture(imageNamed: "walk51"))
        walkList.append(SKTexture(imageNamed: "walk61"))
        
        walkAnimation = SKAction.repeatForever(
            SKAction.animate(with: walkList, timePerFrame: 0.15, resize: true, restore: true)
        )
    }
    
    func setupPreJumpAnimation() {
        // jump1 to jump5
        var preJumpList = [SKTexture]()
        preJumpList.append(SKTexture(imageNamed: "jump11"))
        preJumpList.append(SKTexture(imageNamed: "jump21"))
        preJumpList.append(SKTexture(imageNamed: "jump31"))
        preJumpList.append(SKTexture(imageNamed: "jump41"))
        preJumpList.append(SKTexture(imageNamed: "jump51"))
    
        
        preJumpAnimation = SKAction.sequence([
            SKAction.animate(with: preJumpList, timePerFrame: 0.07, resize: true, restore: false),
            SKAction.wait(forDuration: 0.08),
            SKAction.run { [weak self] in
                self?.jump()
            }
        ])
    }
    
    func setupJumpAnimation() {
        let jumpTexture = SKTexture(imageNamed: "jump61")
        jumpAnimation = SKAction.setTexture(jumpTexture)
    }
    
    func setupLandAnimation() {
        // jump5 to jump1 
        var landList = [SKTexture]()
        landList.append(SKTexture(imageNamed: "jump51"))
        landList.append(SKTexture(imageNamed: "jump41"))
        landList.append(SKTexture(imageNamed: "jump31"))
        landList.append(SKTexture(imageNamed: "jump21"))
        landList.append(SKTexture(imageNamed: "jump11"))
          landList.append(SKTexture(imageNamed: "jump31"))
        
        landAnimation = SKAction.sequence([
            SKAction.animate(with: landList, timePerFrame: 0.05, resize: true, restore: false),
            SKAction.wait(forDuration: 0.08),
            SKAction.run { [weak self] in
                self?.walk()
            }
        ])
    }
    
    
    func setupPuzzleAnimation(){
        let puzzleDown = SKAction.moveBy(x:0, y:-300, duration:2)
        let puzzleUp = SKAction.moveBy(x:0, y:300, duration:2)
        
        puzzleDown.timingMode = .easeInEaseOut
        puzzleUp.timingMode = .easeInEaseOut
        
        let puzzleDownUp = SKAction.sequence([puzzleDown, puzzleUp])
        let puzzleDownUpForever = SKAction.repeatForever(puzzleDownUp)
        
        let puzzleMoveLeft = SKAction.moveBy(x:-2100, y:0, duration:9)
        let puzzleMoveRight = SKAction.moveBy(x:2100, y:0, duration:0)
        let puzzleLeftRight = SKAction.sequence([puzzleMoveLeft, puzzleMoveRight])
        
        let puzzleLoop = SKAction.repeatForever(puzzleLeftRight)
        let puzzleAnimation = SKAction.group([puzzleDownUpForever, puzzleLoop])
        
        puzzle.position = CGPoint(x:2000,y:900)
        puzzleOriginalPosition = puzzle.position
        
        puzzle.run(puzzleAnimation)
    }
    
    
    // configuração do background
    func setupBackgroundAnimation() {
        for layer in [1, 2, 3, 4, 5, 7] {
            setupLayer(layer)
        }
    }
    
    
    func setupLayer(_ layer: Int) {
        let sprite1 = SKSpriteNode(imageNamed: "layer\(layer)")
        let sprite2 = SKSpriteNode(imageNamed: "layer\(layer)")
        sprite2.position = CGPoint(x: self.size.width, y: 0)
        
        let layerNode = SKNode()
        layerNode.addChild(sprite1)
        layerNode.addChild(sprite2)
        layerNode.zPosition = CGFloat(layer)
        layerNode.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        
        let moveLeft = SKAction.moveBy(x: -self.size.width, y: 0, duration: TimeInterval(3 * (10 - layer)))
        let moveBack = SKAction.moveBy(x: self.size.width, y: 0, duration: 0)
        let sequence = SKAction.sequence([moveLeft, moveBack])
        let loop = SKAction.repeatForever(sequence)
        
        layerNode.run(loop)
        self.addChild(layerNode)
    }
    
    
    
    // controles do jogador
    func startJump() {
        if playerStatus != .walk { return }
        
        //agora vai pausar porra
        soundManager.stop(sound: .step)
        soundManager.play(sound: .jump)
        
        playerStatus = .preJump
        player.removeAllActions()
        player.run(preJumpAnimation)
      
    }
    
    func jump() {
        playerStatus = .jump
        player.run(jumpAnimation)
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 1000)
    }
    
    func land() {
        playerStatus = .land
        player.removeAllActions()
        player.run(landAnimation)
       
        
        //agora vai pausar porra
        soundManager.stop(sound: .step)
        soundManager.play(sound: .land)
    }
    
    func walk() {
        playerStatus = .walk
        player.removeAllActions()
        player.run(walkAnimation)
        soundManager.play(sound: .step)
        
    }
    
    
    func getThePuzzle() {
        puzzleCount += 1
        
        soundManager.play(sound: .piece)
        
        //        player.run(pieceSoundAction)
        puzzle.removeAllActions()
        
        let puzzleFadeOut = SKAction.fadeOut(withDuration: 1)
        
        let wait = SKAction.wait(forDuration: 1)
        
        let resetPuzzle = SKAction.run {
            self.puzzle.position = self.puzzleOriginalPosition
            self.puzzle.alpha = 1.0
            self.setupPuzzleAnimation() // reinicia o movimento
        }
        
        let changeScene = SKAction.run {
            if self.puzzleCount == 3 {
                self.newScene()
            }
        }
        
        let sequence = SKAction.sequence([
            puzzleFadeOut,
            wait,
            resetPuzzle,
            changeScene
        ])
        
        puzzle.run(sequence)
    }
    
    
    
    func newScene() {
        soundManager.stop(sound: .step)    
        
        let scene = PuzzleScene(size: self.size)
        scene.scaleMode = .aspectFit
        
        soundManager.stop(sound: .step)
 
        
        
        let transition = SKTransition.fade(withDuration: 3.0)
        
        self.view?.presentScene(scene, transition: transition)
    }
    
    
    
    
    
    
    // detecção de colisão
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node!.name! == "player" {
            collision(playerNode: contact.bodyA.node!, otherNode: contact.bodyB.node!)
        } else if contact.bodyB.node!.name! == "player" {
            collision(playerNode: contact.bodyB.node!, otherNode: contact.bodyA.node!)
        }
    }
    
    
    
    func collision(playerNode: SKNode, otherNode: SKNode) {
        
        if otherNode.name! == "ground" && playerStatus == .jump {
            land()
        } 
        
        else if otherNode.name! == "puzzle" {
            getThePuzzle()
        }
    }
    
    
    
    // controles de toque
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        // Cada vez que ocorre um toque ou clique na tela a função jump é chamada
        startJump()
    }
    
    
    
    
}
