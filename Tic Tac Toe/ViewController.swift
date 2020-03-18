//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by S T Ξ F A N on 17/03/2020.
//  Copyright © 2020 tlemau. All rights reserved.
//

import UIKit

enum Symbol {
    case None
    case Cross
    case Circle
    
    var image: UIImage {
        switch self {
        case .None: return #imageLiteral(resourceName: "Empty")
        case .Cross: return #imageLiteral(resourceName: "Cross")
        case .Circle: return #imageLiteral(resourceName: "Circle")
        }
    }
}

enum Player {
    case Cross
    case Circle
    
    var string: String {
        switch self {
        case .Cross: return "CROSS"
        case .Circle: return "CIRCLE"
        }
    }
}

class ViewController: UIViewController {
    
    var player = Player.Cross
    var symbols = Array(repeating: Symbol.None, count: 9)
    var isGameOn = false
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var currentPlayerLabel: UILabel!
    @IBOutlet weak var symbol0Button: UIButton!
    @IBOutlet weak var symbol1Button: UIButton!
    @IBOutlet weak var symbol2Button: UIButton!
    @IBOutlet weak var symbol3Button: UIButton!
    @IBOutlet weak var symbol4Button: UIButton!
    @IBOutlet weak var symbol5Button: UIButton!
    @IBOutlet weak var symbol6Button: UIButton!
    @IBOutlet weak var symbol7Button: UIButton!
    @IBOutlet weak var symbol8Button: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        hideStart(hide: false)
        hideBoard(hide: true)
    }
    
    func hideBoard(hide: Bool) {
        backgroundImage.isHidden = hide
        currentPlayerLabel.isHidden = hide
        symbol0Button.isHidden = hide
        symbol1Button.isHidden = hide
        symbol2Button.isHidden = hide
        symbol3Button.isHidden = hide
        symbol4Button.isHidden = hide
        symbol5Button.isHidden = hide
        symbol6Button.isHidden = hide
        symbol7Button.isHidden = hide
        symbol8Button.isHidden = hide
        resetButton.isHidden = hide
    }
    
    func hideStart(hide: Bool) {
        startButton.isHidden = hide
    }
    
    func resetGame() {
        isGameOn = true
        
        player = Player.Cross
        updatePlayerText()
        
        for i in 0..<symbols.count {
            symbols[i] = Symbol.None
        }
        
        symbol0Button.setImage(Symbol.None.image, for: UIControl.State.normal)
        symbol1Button.setImage(Symbol.None.image, for: UIControl.State.normal)
        symbol2Button.setImage(Symbol.None.image, for: UIControl.State.normal)
        symbol3Button.setImage(Symbol.None.image, for: UIControl.State.normal)
        symbol4Button.setImage(Symbol.None.image, for: UIControl.State.normal)
        symbol5Button.setImage(Symbol.None.image, for: UIControl.State.normal)
        symbol6Button.setImage(Symbol.None.image, for: UIControl.State.normal)
        symbol7Button.setImage(Symbol.None.image, for: UIControl.State.normal)
        symbol8Button.setImage(Symbol.None.image, for: UIControl.State.normal)
    }
    
    func switchPlayer() {
        if (player == Player.Circle) {
            player = Player.Cross
        } else {
            player = Player.Circle
        }
        
        updatePlayerText()
    }
    
    func updatePlayerText() {
        currentPlayerLabel.text = "CURRENT PLAYER: \(player.string)"
    }
    
    func checkWinner() {
        if (!(horizontalCheck() || verticalCheck() || diagonalCheck())) {
            if (drawCheck()) {
                isGameOn = false
                
                let popup = UIAlertController(title: "Draw!", message: "No one has won", preferredStyle: UIAlertController.Style.alert)
                
                popup.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                    popup.dismiss(animated: true, completion: nil)
                }))
                
                present(popup, animated: true, completion: nil)
                
                return
            }
            
            return
        }
        
        isGameOn = false
        
        let popup = UIAlertController(title: "Congratulations!", message: "Player \(player.string) won", preferredStyle: UIAlertController.Style.alert)
        
        popup.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            popup.dismiss(animated: true, completion: nil)
        }))
        
        present(popup, animated: true, completion: nil)
    }
    
    func horizontalCheck() -> Bool {
        for y in 0...2 {
            let a = getArrayIndex(x: 0, y: y)
            let b = getArrayIndex(x: 1, y: y)
            let c = getArrayIndex(x: 2, y: y)
            
            if (symbols[a] == Symbol.None) {
                continue
            }
            
            if (symbols[a] == symbols[b] && symbols[b] == symbols[c]) {
                return true
            }
        }
        
        return false
    }
    
    func verticalCheck() -> Bool {
        for x in 0...2 {
            let a = getArrayIndex(x: x, y: 0)
            let b = getArrayIndex(x: x, y: 1)
            let c = getArrayIndex(x: x, y: 2)
            
            if (symbols[a] == Symbol.None) {
                continue
            }
            
            if (symbols[a] == symbols[b] && symbols[b] == symbols[c]) {
                return true
            }
        }
        
        return false
    }
    
    func diagonalCheck() -> Bool {
        let a = getArrayIndex(x: 0, y: 0)
        let b = getArrayIndex(x: 1, y: 1)
        let c = getArrayIndex(x: 2, y: 2)
        
        let d = getArrayIndex(x: 2, y: 0)
        let e = getArrayIndex(x: 1, y: 1)
        let f = getArrayIndex(x: 0, y: 2)
        
        if (symbols[b] == Symbol.None) {
            return false
        }
        
        if (symbols[a] == symbols[b] && symbols[b] == symbols[c]) {
            return true
        }
        
        if (symbols[d] == symbols[e] && symbols[b] == symbols[f]) {
            return true
        }
        
        return false
    }
    
    func drawCheck() -> Bool {
        for i in 0..<symbols.count {
            if (symbols[i] == Symbol.None) {
                return false
            }
        }
        
        return true
    }
    
    func getArrayIndex(x: Int, y: Int) -> Int {
        return x + 3 * y
    }
    
    @IBAction func symbol0ButtonPressed(_ sender: UIButton) {
        if (symbols[0] != Symbol.None) {
            return
        }
        
        if (player == Player.Cross) {
            symbols[0] = Symbol.Cross
            symbol0Button.setImage(Symbol.Cross.image, for: UIControl.State.normal)
        } else {
            symbols[0] = Symbol.Circle
            symbol0Button.setImage(Symbol.Circle.image, for: UIControl.State.normal)
        }
        
        checkWinner()
        switchPlayer()
    }
    
    @IBAction func symbol1ButtonPressed(_ sender: UIButton) {
        if (symbols[1] != Symbol.None || isGameOn == false) {
            return
        }
        
        if (player == Player.Cross) {
            symbols[1] = Symbol.Cross
            symbol1Button.setImage(Symbol.Cross.image, for: UIControl.State.normal)
        } else {
            symbols[1] = Symbol.Circle
            symbol1Button.setImage(Symbol.Circle.image, for: UIControl.State.normal)
        }
        
        checkWinner()
        switchPlayer()
    }
    
    @IBAction func symbol2ButtonPressed(_ sender: UIButton) {
        if (symbols[2] != Symbol.None || isGameOn == false) {
            return
        }
        
        if (player == Player.Cross) {
            symbols[2] = Symbol.Cross
            symbol2Button.setImage(Symbol.Cross.image, for: UIControl.State.normal)
        } else {
            symbols[2] = Symbol.Circle
            symbol2Button.setImage(Symbol.Circle.image, for: UIControl.State.normal)
        }
        
        checkWinner()
        switchPlayer()
    }
    
    
    @IBAction func symbol3ButtonPressed(_ sender: UIButton) {
        if (symbols[3] != Symbol.None || isGameOn == false) {
            return
        }
        
        if (player == Player.Cross) {
            symbols[3] = Symbol.Cross
            symbol3Button.setImage(Symbol.Cross.image, for: UIControl.State.normal)
        } else {
            symbols[3] = Symbol.Circle
            symbol3Button.setImage(Symbol.Circle.image, for: UIControl.State.normal)
        }
        
        checkWinner()
        switchPlayer()
    }
    
    @IBAction func symbol4ButtonPressed(_ sender: UIButton) {
        if (symbols[4] != Symbol.None || isGameOn == false) {
            return
        }
        
        if (player == Player.Cross) {
            symbols[4] = Symbol.Cross
            symbol4Button.setImage(Symbol.Cross.image, for: UIControl.State.normal)
        } else {
            symbols[4] = Symbol.Circle
            symbol4Button.setImage(Symbol.Circle.image, for: UIControl.State.normal)
        }
        
        checkWinner()
        switchPlayer()
    }
    
    @IBAction func symbol5ButtonPressed(_ sender: UIButton) {
        if (symbols[5] != Symbol.None || isGameOn == false) {
            return
        }
        
        if (player == Player.Cross) {
            symbols[5] = Symbol.Cross
            symbol5Button.setImage(Symbol.Cross.image, for: UIControl.State.normal)
        } else {
            symbols[5] = Symbol.Circle
            symbol5Button.setImage(Symbol.Circle.image, for: UIControl.State.normal)
        }
        
        checkWinner()
        switchPlayer()
    }
    
    @IBAction func symbol6ButtonPressed(_ sender: UIButton) {
        if (symbols[6] != Symbol.None || isGameOn == false) {
            return
        }
        
        if (player == Player.Cross) {
            symbols[6] = Symbol.Cross
            symbol6Button.setImage(Symbol.Cross.image, for: UIControl.State.normal)
        } else {
            symbols[6] = Symbol.Circle
            symbol6Button.setImage(Symbol.Circle.image, for: UIControl.State.normal)
        }
        
        checkWinner()
        switchPlayer()
    }
    
    @IBAction func symbol7ButtonPressed(_ sender: UIButton) {
        if (symbols[7] != Symbol.None || isGameOn == false) {
            return
        }
        
        if (player == Player.Cross) {
            symbols[7] = Symbol.Cross
            symbol7Button.setImage(Symbol.Cross.image, for: UIControl.State.normal)
        } else {
            symbols[7] = Symbol.Circle
            symbol7Button.setImage(Symbol.Circle.image, for: UIControl.State.normal)
        }
        
        checkWinner()
        switchPlayer()
    }
    
    @IBAction func symbol8ButtonPressed(_ sender: UIButton) {
        if (symbols[8] != Symbol.None || isGameOn == false) {
            return
        }
        
        if (player == Player.Cross) {
            symbols[8] = Symbol.Cross
            symbol8Button.setImage(Symbol.Cross.image, for: UIControl.State.normal)
        } else {
            symbols[8] = Symbol.Circle
            symbol8Button.setImage(Symbol.Circle.image, for: UIControl.State.normal)
        }
        
        checkWinner()
        switchPlayer()
    }
    @IBAction func startButtonPressed(_ sender: UIButton) {
        hideStart(hide: true)
        hideBoard(hide: false)
        
        updatePlayerText()
        resetGame()
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        let popup = UIAlertController(title: "Reset game", message: "Are you sure?", preferredStyle: UIAlertController.Style.alert)
        
        popup.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { (action) in
            popup.dismiss(animated: true, completion: nil)
        }))
        
        popup.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action) in
            self.resetGame()
            popup.dismiss(animated: true, completion: nil)
        }))
        
        self.present(popup, animated: true, completion: nil)
    }
}

