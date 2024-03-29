//
//  ViewController.swift
//  Tic tac toe
//
//  Created by Sem Pruijs on 01/05/2019.
//  Copyright © 2019 Sem Pruijs. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var song = AVAudioPlayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        board = emptyBoardThree()
        hasWonLabel.text = ""
        numberOfTilesToWin = 3
        for button in buttons {
            button.setImage(nil, for: UIControl.State.normal)
        }
        if let bundle = Bundle.main.path(forResource: songs.randomItem(),  ofType: "m4a") {
            do {
                song = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: bundle))
                song.prepareToPlay()
            } catch {
                print(error)
            }
        } else {
            print("file not found")
        }
    }
    
    @IBOutlet weak var hasWonLabel: UILabel!

    @IBOutlet var buttons: [UIButton]!
    
    
    
    
    func printPlayerHasWon() {
        if playerHasWon() == Player.cross {
            hasWonLabel.text = "X has won!"
        } else if playerHasWon() == Player.ring {
            hasWonLabel.text = "O has won!"
        } else {
            hasWonLabel.text = ""
        }
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        let row = sender.tag / 3
        let column = sender.tag % 3
        let imageName = whoIs == .ring ? "ring.png" : "cross.png"
        
        if playerHasWon() == nil {
            if board[row][column] == nil {
                sender.setImage(UIImage(named: imageName), for: UIControl.State.normal)
                printCircelOrCross(row: row, column: column)
                renderBoard()
                printPlayerHasWon()
                hasWonLabel.text = printWinner()
            }
        }
       
        
        if draw() {
            hasWonLabel.text = "it's draw"
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        board = emptyBoardThree()
        renderBoard()
        hasWonLabel.text = ""
        for button in buttons {
            button.setImage(nil, for: UIControl.State.normal)
        }
    }
    
    
    
    @IBAction func musicButton(_ sender: Any) {
        if let bundle = Bundle.main.path(forResource: songs.randomItem(),  ofType: "m4a") {
            do {
                song = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: bundle))
                song.prepareToPlay()
            } catch {
                print(error)
            }
        } else {
            print("file not found")
        }
        song.play()
    }
    
   
    
   
    
    @IBAction func homeButton(_ sender: Any) {
        song.stop()
    }
}




