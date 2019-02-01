//
//  WynikiViewController.swift
//  Gra w kosci
//
//  Created by Krzysztof Szczerbowski on 19/09/2018.
//  Copyright © 2018 Krzysztof Szczerbowski. All rights reserved.
//

import UIKit
import CoreData

class WynikiViewController: UIViewController {
    
    //MARK: - UI Otulets
    @IBOutlet weak var turaLabel: UILabel!
    @IBOutlet weak var grajButton: UIBarButtonItem!
    
    //MARK: - Gracz 1 Labels
    @IBOutlet weak var g1Jedynki: UILabel!
    @IBOutlet weak var g1Dwojki: UILabel!
    @IBOutlet weak var g1Trojki: UILabel!
    @IBOutlet weak var g1Czworki: UILabel!
    @IBOutlet weak var g1Piatki: UILabel!
    @IBOutlet weak var g1Szostki: UILabel!
    @IBOutlet weak var g13Jedankowe: UILabel!
    @IBOutlet weak var g14Jednakowe: UILabel!
    @IBOutlet weak var g1Ful: UILabel!
    @IBOutlet weak var g1MalyStrit: UILabel!
    @IBOutlet weak var g1DuzyStrit: UILabel!
    @IBOutlet weak var g1General: UILabel!
    @IBOutlet weak var g1Szansa: UILabel!
    @IBOutlet weak var g1SumaPunktow: UILabel!
    
    //MARK: - Gracz 2 Labels
    @IBOutlet weak var g2Jedynki: UILabel!
    @IBOutlet weak var g2Dwojki: UILabel!
    @IBOutlet weak var g2Trojki: UILabel!
    @IBOutlet weak var g2Czworki: UILabel!
    @IBOutlet weak var g2Piatki: UILabel!
    @IBOutlet weak var g2Szostki: UILabel!
    @IBOutlet weak var g23Jedankowe: UILabel!
    @IBOutlet weak var g24Jednakowe: UILabel!
    @IBOutlet weak var g2Ful: UILabel!
    @IBOutlet weak var g2MalyStrit: UILabel!
    @IBOutlet weak var g2DuzyStrit: UILabel!
    @IBOutlet weak var g2General: UILabel!
    @IBOutlet weak var g2Szansa: UILabel!
    @IBOutlet weak var g2SumaPunktow: UILabel!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var gracz1: Player?
    var gracz2: Player?
    var tura: Tura?
    
    var aktualnyGracz: Player?
    
    //MARK: - Metody View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        turaLabel.text = "Tura: 1/13"
        
        dodajGracza()
        
        aktualnyGracz = gracz1
        
        rozpocznijGre()
        
        aktualizujDaneGraczy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! KosciViewController
        guard let aktualnyGraczPrzeslij = aktualnyGracz else {fatalError()}
        destinationVC.selectedPlayer = aktualnyGraczPrzeslij
        destinationVC.delegate = self
    }
    
    //MARK: - Rozpocznij grę
    
    func rozpocznijGre() {
        tura = Tura(context: context)
        saveProgress()
    }
    
    func dodajGracza() {
        gracz1 = Player(context: context)
        gracz1?.scoreSum = 0
        gracz1?.token = true
        
        gracz2 = Player(context: context)
        gracz2?.scoreSum = 0
        gracz2?.token = false
        
        saveProgress()
    }
    
    //MARK: - Obsluga wielu graczy
    
    func zmienAktualnegoGracza() {
        gracz1?.token = gracz1!.token ? false : true
        gracz2?.token = gracz2!.token ? false : true
        
        aktualnyGracz = gracz1!.token ? gracz1 : gracz2
        grajButton.title = gracz1!.token ? "Gracz 1 GRAJ" : "Gracz 2 GRAJ"
    }
    
    func aktualizujDaneGraczy() {
        //Gracz 1
        guard let player1 = gracz1 else {fatalError()}
        g1Jedynki.text = player1.scoreJedynki ? "Jedynki" : "Jedynki ✔"
        g1Dwojki.text = player1.scoreDwojki ? "Dwójki" : "Dwójki ✔"
        g1Trojki.text = player1.scoreTrojki ? "Trójki" : "Trójki ✔"
        g1Czworki.text = player1.scoreCzworki ? "Czwórki" : "Czwórki ✔"
        g1Piatki.text = player1.scorePiatki ? "Piątki" : "Piątki ✔"
        g1Szostki.text = player1.scoreSzostki ? "Szóstki" : "Szóstki ✔"
        g13Jedankowe.text = player1.score3Jednakowe ? "3 Jednakowe" : "3 Jednakowe ✔"
        g14Jednakowe.text = player1.score4Jednakowe ? "4 Jednakowe" : "4 Jednakowe ✔"
        g1Ful.text = player1.scoreFul ? "Ful" : "Ful ✔"
        g1MalyStrit.text = player1.scoreMalyStrit ? "Mały Strit" : "Mały Strit ✔"
        g1DuzyStrit.text = player1.scoreDuzyStrit ? "Duży Strit" : "Duży Strit ✔"
        g1General.text = player1.scoreGeneral ? "Generał" : "Generał ✔"
        g1Szansa.text = player1.scoreSzansa ? "Szansa" : "Szansa ✔"
        g1SumaPunktow.text = "Suma: \(player1.scoreSum)"
        
        //Gracz 2
        guard let player2 = gracz2 else {fatalError()}
        g2Jedynki.text = player2.scoreJedynki ? "Jedynki" : "Jedynki ✔"
        g2Dwojki.text = player2.scoreDwojki ? "Dwójki" : "Dwójki ✔"
        g2Trojki.text = player2.scoreTrojki ? "Trójki" : "Trójki ✔"
        g2Czworki.text = player2.scoreCzworki ? "Czwórki" : "Czwórki ✔"
        g2Piatki.text = player2.scorePiatki ? "Piątki" : "Piątki ✔"
        g2Szostki.text = player2.scoreSzostki ? "Szóstki" : "Szóstki ✔"
        g23Jedankowe.text = player2.score3Jednakowe ? "3 Jednakowe" : "3 Jednakowe ✔"
        g24Jednakowe.text = player2.score4Jednakowe ? "4 Jednakowe" : "4 Jednakowe ✔"
        g2Ful.text = player2.scoreFul ? "Ful" : "Ful ✔"
        g2MalyStrit.text = player2.scoreMalyStrit ? "Mały Strit" : "Mały Strit ✔"
        g2DuzyStrit.text = player2.scoreDuzyStrit ? "Duży Strit" : "Duży Strit ✔"
        g2General.text = player2.scoreGeneral ? "Generał" : "Generał ✔"
        g2Szansa.text = player2.scoreSzansa ? "Szansa" : "Szansa ✔"
        g2SumaPunktow.text = "Suma: \(player2.scoreSum)"
    }
    
    //MARK: - Zapisz dane do context
    
    func saveProgress() {
        do {
            try context.save()
        }catch {
            print(error)
        }
    }
    
    //MARK: - Zakoncz grę

    @IBAction func zakonczPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension WynikiViewController: KosciDelegate {
    func powrotZKosciVC() {
        guard let nowaTura = tura else {fatalError()}
        
        if aktualnyGracz == gracz2 {
            nowaTura.numer += 1
        }
        
        if nowaTura.numer != 14 {
            turaLabel.text = "Tura: \(nowaTura.numer)/13"
        }
        else {
            turaLabel.text = "Koniec gry"
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
        aktualizujDaneGraczy()
        zmienAktualnegoGracza()
    }
}
