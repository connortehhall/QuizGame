//
//  ViewController.swift
//  QuizGame
//
//  Created by Connor Teh-Hall on 25/09/20.
//

/*
 things we need
 - menu screen
 - game screen
 - answer object
 - question objec
 */

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startGame() {
        let vc = storyboard?.instantiateViewController(identifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
}
