//
//  KosciViewController.swift
//  Gra w kosci
//
//  Created by Krzysztof Szczerbowski on 19/09/2018.
//  Copyright © 2018 Krzysztof Szczerbowski. All rights reserved.
//

import UIKit
import CoreData

protocol KosciDelegate {
    func powrotZKosciVC()
}

class KosciViewController: UIViewController {
    
    //MARK: - Delegate
    var delegate: KosciDelegate?
    
    //MARK: - UI Outlets
    @IBOutlet weak var pasButton: UIBarButtonItem!
    @IBOutlet weak var wykonajRzutButton: UIBarButtonItem!
    
    //MARK: - Dice Button Outlets
    @IBOutlet weak var diceButton1: UIButton!
    @IBOutlet weak var diceButton2: UIButton!
    @IBOutlet weak var diceButton3: UIButton!
    @IBOutlet weak var diceButton4: UIButton!
    @IBOutlet weak var diceButton5: UIButton!

    
    //MARK: - Other Data Objects
    var selectedPlayer: Player?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var gameStatus: Int = 0
    
    var diceSet: Rzut?
    
    var czyRozpoczetoRzucanie: Bool = false
    
    //MARK: - Metody View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        becomeFirstResponder()
        
        diceSet = Rzut(context: context)
        przygotowanieDoRzucania()
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            rzucanieRozpoczete()
            rzut()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let kontrolerNawigacji = navigationController else {fatalError()}
        kontrolerNawigacji.setToolbarHidden(false, animated: true)
    }
    
    //MARK: - Obsluga UI
    
    func przygotowanieDoRzucania() {
        pasButton.isEnabled = false
    }
    
    func rzucanieRozpoczete() {
        if czyRozpoczetoRzucanie != true {
            pasButton.isEnabled = true
            navigationItem.hidesBackButton = true
            
            diceButton1.alpha = 1
            diceButton2.alpha = 1
            diceButton3.alpha = 1
            diceButton4.alpha = 1
            diceButton5.alpha = 1
            
            czyRozpoczetoRzucanie = !czyRozpoczetoRzucanie
        }
    }
    
    //MARK: - Obsluga kosci
    
    func zablokujKosci() {
        diceButton1.isEnabled = (diceButton1.alpha == 1) ? true : false
        diceButton2.isEnabled = (diceButton2.alpha == 1) ? true : false
        diceButton3.isEnabled = (diceButton3.alpha == 1) ? true : false
        diceButton4.isEnabled = (diceButton4.alpha == 1) ? true : false
        diceButton5.isEnabled = (diceButton5.alpha == 1) ? true : false
    }
    
    @IBAction func wykonajRzut(_ sender: UIBarButtonItem) {
        rzucanieRozpoczete()
//        zablokujKosci()
        rzut()
    }
    
    @IBAction func diceSelected(_ sender: UIButton) {
        guard let zestaw = diceSet else {fatalError()}
        switch sender.tag {
        case 1:
            if zestaw.kosc1CzyMozna {
                diceButton1.alpha = (diceButton1.alpha == 1) ? 0.5 : 1
            }
        case 2:
            if zestaw.kosc2CzyMozna {
                diceButton2.alpha = (diceButton2.alpha == 1) ? 0.5 : 1
            }
        case 3:
            if zestaw.kosc3CzyMozna {
                diceButton3.alpha = (diceButton3.alpha == 1) ? 0.5 : 1
            }
        case 4:
            if zestaw.kosc4CzyMozna {
                diceButton4.alpha = (diceButton4.alpha == 1) ? 0.5 : 1
            }
        case 5:
            if zestaw.kosc5CzyMozna {
                diceButton5.alpha = (diceButton5.alpha == 1) ? 0.5 : 1
            }
        default:
            print("Nothing to do")
        }
    }
    
    func rzut() {
        if gameStatus != 4 {
            updateDiceImage(dice: diceButton1, number: 1)
            updateDiceImage(dice: diceButton2, number: 2)
            updateDiceImage(dice: diceButton3, number: 3)
            updateDiceImage(dice: diceButton4, number: 4)
            updateDiceImage(dice: diceButton5, number: 5)
            gameStatus += 1
        }
        if gameStatus == 4 {
            wykonajRzutButton.isEnabled = false
        }
    }
    
    func updateDiceImage(dice button: UIButton, number: Int) {
        if button.alpha == 1 {
            let random = Int16(Int.random(in: 1...6))
            let image = UIImage(named: "dice\(random)")
            button.setImage(image, for: .normal)
            
            switch number {
            case 1:
                diceSet?.kosc1 = random
            case 2:
                diceSet?.kosc2 = random
            case 3:
                diceSet?.kosc3 = random
            case 4:
                diceSet?.kosc4 = random
            case 5:
                diceSet?.kosc5 = random
            default:
                print("Nothing to do...")
            }
            
            saveProgress()
        }
    }
    
    //MARK: - Przejscie do tabeli wyboru punktow
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTabele" {
            let destinationVC = segue.destination as! TabeleViewController
            guard let gracz = selectedPlayer else {fatalError()}
            destinationVC.selectedPlayer = gracz
            guard let kosci = diceSet else {fatalError()}
            destinationVC.selectedDiceSet = kosci
            destinationVC.delegate = self
            saveProgress()
        }
        else if segue.identifier == "goToPostep" {
            guard let gracz = selectedPlayer else {fatalError()}
            let postepVC = segue.destination as! PostepViewController
            postepVC.selectedGracz = gracz
        }
    }
    
    //MARK: - Zapisz dane do context
    
    func saveProgress() {
        do{
            try context.save()
        }catch {
            print(error)
        }
    }
}

extension KosciViewController: TabeleDelegate {
    func powrotZTabeleVC() {
        delegate?.powrotZKosciVC()
        navigationController?.popToRootViewController(animated: true)
    }
}
