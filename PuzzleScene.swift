import SwiftUI
import SpriteKit

struct PuzzlePiece {
    var node: SKSpriteNode
    var snapTargetPosition: CGPoint
}

class PuzzleScene: SKScene, SKPhysicsContactDelegate {
    
    let soundManager = SoundManager()
    
    var selectedNode: SKSpriteNode?
    let snapTolerance: CGFloat = 100.0
    var puzzlePieces: [String: PuzzlePiece] = [:]
    var encaixadas: Set<String> = []
    let totalPecas = 9
    
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "backgroundImage")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1  
        background.size = self.size 
        addChild(background)

        
        
        
        
        ///configuraçao fala inicial
        var textures: [SKTexture] = []
        
        //walkList.append(SKTexture(imageNamed: "walk11"))
        textures.append(SKTexture(imageNamed: "fala12"))
        textures.append(SKTexture(imageNamed: "fala22"))
        textures.append(SKTexture(imageNamed: "fala13"))
        textures.append(SKTexture(imageNamed: "fala22"))
        textures.append(SKTexture(imageNamed: "fala12"))
        textures.append(SKTexture(imageNamed: "fala14"))
        textures.append(SKTexture(imageNamed: "fala15"))
        textures.append(SKTexture(imageNamed: "fala14"))
        textures.append(SKTexture(imageNamed: "fala12"))
        textures.append(SKTexture(imageNamed: "fala22"))
        textures.append(SKTexture(imageNamed: "fala13"))
        textures.append(SKTexture(imageNamed: "fala22"))
        textures.append(SKTexture(imageNamed: "fala12"))
        
        
        
        let imageNode = SKSpriteNode(texture: textures.first)
        imageNode.position = CGPoint(x: size.width / 2, y: size.height / 2 + 270)
        imageNode.zPosition = 11
        imageNode.setScale(0.8)
        addChild(imageNode)
        
        //animação
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2) 
       
        let wait = SKAction.wait(forDuration: 1.0)
        let fadeout = SKAction.fadeOut(withDuration: 2.0)
        let remove = SKAction.run {
            imageNode.removeFromParent()
        }
        let sequence = SKAction.sequence([animation, wait, fadeout, remove])
        
        imageNode.run(sequence)
        
//        let label = SKLabelNode(text: "Monte as peças para revelar a imagem ao final!")
//        // n consegui mudar a fonte
//        label.fontName = "SourGummy.ttf" 
//        label.fontSize = 50 
//        label.fontColor = .white
//        label.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
//        label.zPosition = 10
//        self.addChild(label)
//        
//        let fadein = SKAction.fadeIn(withDuration: 1.0)
//        let wait = SKAction.wait(forDuration: 0.5)
//        let fadeout = SKAction.fadeOut(withDuration: 1.0)
//        let remove = SKAction.run {
//            label.removeFromParent()
//        }
//        let sequence = SKAction.sequence([fadein, wait, fadeout, remove])
//        label.run(sequence)
        
        
        
        
        
        
        //configuração da peça 1
        let piece1 = SKSpriteNode(imageNamed: "peca1")
        piece1.name = "piece1"
        piece1.setScale(0.3)
        piece1.position = CGPoint(x: size.width / 2 + 550, y: size.height / 2 + 300)
        addChild(piece1)
        
        //alvo da peça 1
        let targetPosition1 = CGPoint(x: size.width / 2 - 225, y: size.height / 2 + 233)
        puzzlePieces["piece1"] = PuzzlePiece(node: piece1, snapTargetPosition: targetPosition1)
        
        //alvo (só pra referência)
//        let targetVisual1 = SKShapeNode(rectOf: CGSize(width: 100, height: 100), cornerRadius: 10)
//        targetVisual1.strokeColor = .gray
//        targetVisual1.lineWidth = 2
//        targetVisual1.position = targetPosition1
//        addChild(targetVisual1)
        
        
        
        //configuração da peça 2
        let piece2 = SKSpriteNode(imageNamed: "peca2")
        piece2.name = "piece2"
        piece2.setScale(0.3)
        piece2.position = CGPoint(x: size.width / 2 - 600, y: size.height / 2 - 300)
        addChild(piece2)
        
        // alvo da peça 2
        let targetPosition2 = CGPoint(x: size.width / 2 - 16, y: size.height / 2 + 213)
        puzzlePieces["piece2"] = PuzzlePiece(node: piece2, snapTargetPosition: targetPosition2)
        
        //aalvo (só pra referência)
//        let targetVisual2 = SKShapeNode(rectOf: CGSize(width: 100, height: 100), cornerRadius: 10)
//        targetVisual2.strokeColor = .gray
//        targetVisual2.lineWidth = 2
//        targetVisual2.position = targetPosition2
//        addChild(targetVisual2)
//        
        
        
        //configuração da peça 3
        let piece3 = SKSpriteNode(imageNamed: "peca3")
        piece3.name = "piece3"
        piece3.setScale(0.3)
        piece3.position = CGPoint(x: size.width / 2 + 150, y: size.height / 2)
        addChild(piece3)
        
        //alvo da peça 3
        let targetPosition3 = CGPoint(x: size.width / 2 + 200, y: size.height / 2 + 215)
        puzzlePieces["piece3"] = PuzzlePiece(node: piece3, snapTargetPosition: targetPosition3)
        
        //alvo (só pra referência)
//        let targetVisual3 = SKShapeNode(rectOf: CGSize(width: 100, height: 100), cornerRadius: 10)
//        targetVisual3.strokeColor = .gray
//        targetVisual3.lineWidth = 2
//        targetVisual3.position = targetPosition3
//        addChild(targetVisual3)
//        
        
        
        // configuração da peça 4
        let piece4 = SKSpriteNode(imageNamed: "peca4")
        piece4.name = "piece4"
        piece4.setScale(0.3)
        piece4.position = CGPoint(x: size.width / 2 - 300, y: size.height / 2 - 50)
        addChild(piece4)
        
        //alvo da peça 4
        let targetPosition4 = CGPoint(x: size.width / 2 - 228, y: size.height / 2 + 32)
        puzzlePieces["piece4"] = PuzzlePiece(node: piece4, snapTargetPosition: targetPosition4)
        
        // alvo (só pra referência)
//        let targetVisual4 = SKShapeNode(rectOf: CGSize(width: 100, height: 100), cornerRadius: 10)
//        targetVisual4.strokeColor = .gray
//        targetVisual4.lineWidth = 2
//        targetVisual4.position = targetPosition4
//        addChild(targetVisual4)
        
        
        
        //configuração da peça 5
        let piece5 = SKSpriteNode(imageNamed: "peca5")
        piece5.name = "piece5"
        piece5.setScale(0.3)
        piece5.position = CGPoint(x: size.width / 2 - 550, y: size.height / 2 + 300)
        addChild(piece5)
        
        //posição alvo da peça 5
        let targetPosition5 = CGPoint(x: size.width / 2, y: size.height / 2)
        puzzlePieces["piece5"] = PuzzlePiece(node: piece5, snapTargetPosition: targetPosition5)
        
        // alvo (só pra referência)
//        let targetVisual5 = SKShapeNode(rectOf: CGSize(width: 100, height: 100), cornerRadius: 10)
//        targetVisual5.strokeColor = .gray
//        targetVisual5.lineWidth = 2
//        targetVisual5.position = targetPosition5
//        addChild(targetVisual5)
        
        
        
        // cnfiguração da peça 6
        let piece6 = SKSpriteNode(imageNamed: "peca6")
        piece6.name = "piece6"
        piece6.setScale(0.3)
        piece6.position = CGPoint(x: size.width / 2 + 500, y: size.height / 2 - 300)
        addChild(piece6)
        
        //posição alvo da peça 6
        let targetPosition6 = CGPoint(x: size.width / 2 + 218, y: size.height / 2 + 16)
        puzzlePieces["piece6"] = PuzzlePiece(node: piece6, snapTargetPosition: targetPosition6)
        
        //alvo (só pra referência)
//        let targetVisual6 = SKShapeNode(rectOf: CGSize(width: 100, height: 100), cornerRadius: 10)
//        targetVisual6.strokeColor = .gray
//        targetVisual6.lineWidth = 2
//        targetVisual6.position = targetPosition6
//        addChild(targetVisual6)
        
        
        
        //configuração da peça 7
        let piece7 = SKSpriteNode(imageNamed: "peca7")
        piece7.name = "piece7"
        piece7.setScale(0.3)
        piece7.position = CGPoint(x: size.width / 2 + 200, y: size.height / 2 + 300)
        addChild(piece7)
        
        // posição alvo da peça 7
        let targetPosition7 = CGPoint(x: size.width / 2 - 234, y: size.height / 2 - 164)
        puzzlePieces["piece7"] = PuzzlePiece(node: piece7, snapTargetPosition: targetPosition7)
        
        //alvo (só pra referência)
//        let targetVisual7 = SKShapeNode(rectOf: CGSize(width: 100, height: 100), cornerRadius: 10)
//        targetVisual7.strokeColor = .gray
//        targetVisual7.lineWidth = 2
//        targetVisual7.position = targetPosition7
//        addChild(targetVisual7)
        
        
        
        //configuração da peça 8
        let piece8 = SKSpriteNode(imageNamed: "peca8")
        piece8.name = "piece8"
        piece8.setScale(0.3)
        piece8.position = CGPoint(x: size.width / 2 + 20, y: size.height / 2 - 350)
        addChild(piece8)
        
        //posição alvo da peça 8
        let targetPosition8 = CGPoint(x: size.width / 2 - 34, y: size.height / 2 - 191)
        puzzlePieces["piece8"] = PuzzlePiece(node: piece8, snapTargetPosition: targetPosition8)
        
        // alvo (só pra referência)
//        let targetVisual8 = SKShapeNode(rectOf: CGSize(width: 100, height: 100), cornerRadius: 10)
//        targetVisual8.strokeColor = .gray
//        targetVisual8.lineWidth = 2
//        targetVisual8.position = targetPosition8
//        addChild(targetVisual8)
        
        
        
        
        //configuração da peça 9
        let piece9 = SKSpriteNode(imageNamed: "peca9")
        piece9.name = "piece9"
        piece9.setScale(0.3)
        piece9.position = CGPoint(x: size.width / 2 - 150, y: size.height / 2 + 300)
        addChild(piece9)
        
        //posição alvo da peça 9
        let targetPosition9 = CGPoint(x: size.width / 2 + 191, y: size.height / 2 - 168)
        puzzlePieces["piece9"] = PuzzlePiece(node: piece9, snapTargetPosition: targetPosition9)
        
        // alvo (só pra referência)
//        let targetVisual9 = SKShapeNode(rectOf: CGSize(width: 100, height: 100), cornerRadius: 10)
//        targetVisual9.strokeColor = .gray
//        targetVisual9.lineWidth = 2
//        targetVisual9.position = targetPosition9
//        addChild(targetVisual9)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let node = atPoint(location) as? SKSpriteNode,
           let name = node.name,
           name.starts(with: "piece") { // só seleciona se for uma peça
            selectedNode = node
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let node = selectedNode else { return }
        let location = touch.location(in: self)
        node.position = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let node = selectedNode, let name = node.name else { return }
        
        if let puzzlePiece = puzzlePieces[name] {
            let targetPosition = puzzlePiece.snapTargetPosition
            let distance = hypot(node.position.x - targetPosition.x,
                                 node.position.y - targetPosition.y)
            
            if distance <= snapTolerance {
                
                let snapAction = SKAction.move(to: targetPosition, duration: 0.2)
                node.run(snapAction)
                
                //run(SKAction.playSoundFileNamed("fitted.mp3", waitForCompletion: false))
                soundManager.play(sound: .fitted)
            }
            
            
            
            if !encaixadas.contains(name) {
                encaixadas.insert(name)
            }
            
            
            
            
            if encaixadas.count == totalPecas {
                let wait = SKAction.wait(forDuration: 0.8)
                let playWinSound = SKAction.playSoundFileNamed("win.mp3", waitForCompletion: false)
              
                
                let revealFinalImage = SKAction.run {
                    for (_, piece) in self.puzzlePieces {
                        let fade = SKAction.fadeOut(withDuration: 5.0)
                        let remove = SKAction.removeFromParent()
                        let sequence = SKAction.sequence([fade, remove])
                        piece.node.run(sequence)
                    }
                    
                    
                    let finalImage = SKSpriteNode(imageNamed: "finalImage")
                    finalImage.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
                    finalImage.zPosition = 12
                    finalImage.setScale(0.4)
                    finalImage.alpha = 0.0 
                    self.addChild(finalImage)
                    
                    finalImage.run(SKAction.fadeIn(withDuration: 2.0)) 

                }
                
                let sequence = SKAction.sequence([wait, playWinSound, revealFinalImage])
                run(sequence)
            }
            
        }
        
        selectedNode = nil
        
        
        let glow = SKAction.sequence([
            SKAction.scale(to: 0.35, duration: 0.1),
            SKAction.scale(to: 0.3, duration: 0.1)
        ])
        node.run(glow)
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedNode = nil
    }
}

