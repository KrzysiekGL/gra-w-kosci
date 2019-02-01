//
//  PostepViewController.swift
//  Gra w kosci
//
//  Created by Krzysztof Szczerbowski on 28/09/2018.
//  Copyright © 2018 Krzysztof Szczerbowski. All rights reserved.
//

import UIKit

class PostepViewController: UIViewController {
    
    let tickSign = " ✔"
    
    var gracz: Player!
    var selectedGracz: Player? {
        didSet {
            gracz = selectedGracz
        }
    }
    
    //MARK: - UI Labels
    @IBOutlet weak var jedynkilabel: UILabel!
    @IBOutlet weak var dwojkiLabel: UILabel!
    @IBOutlet weak var trojkiLabel: UILabel!
    @IBOutlet weak var czworkiLabel: UILabel!
    @IBOutlet weak var piatkiLabel: UILabel!
    @IBOutlet weak var szostkiLabel: UILabel!
    @IBOutlet weak var trzyJednakoweLabel: UILabel!
    @IBOutlet weak var czteryJedankoweLabel: UILabel!
    @IBOutlet weak var fulLabel: UILabel!
    @IBOutlet weak var malyStritLabel: UILabel!
    @IBOutlet weak var duzyStritLabel: UILabel!
    @IBOutlet weak var generalLabel: UILabel!
    @IBOutlet weak var szansaLabel: UILabel!
    
    let jedynki = "Jedynki"
    let dwojki = "Dwójki"
    let trojki = "Trójki"
    let czworki = "Czwórki"
    let piatki = "Piątki"
    let szostki = "Szóstki"
    let trzyJedankowe = "3 Jednakowe"
    let czteryJednakowe = "4 Jednakowe"
    let ful = "Ful"
    let malyStrit = "Mały Strit"
    let duzyStrit = "Duży Strit"
    let general = "Generał"
    let szansa = "Szansa"
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zaktualizujPostepGracza()
    }
    
    func zaktualizujPostepGracza() {        
        jedynkilabel.text = gracz.scoreJedynki ? jedynki : jedynki + tickSign
        dwojkiLabel.text = gracz.scoreDwojki ? dwojki : dwojki + tickSign
        trojkiLabel.text = gracz.scoreTrojki ? trojki : trojki + tickSign
        czworkiLabel.text = gracz.scoreCzworki ? czworki : czworki + tickSign
        piatkiLabel.text = gracz.scorePiatki ? piatki : piatki +  tickSign
        szostkiLabel.text = gracz.scoreSzostki ? szostki : szostki + tickSign
        trzyJednakoweLabel.text = gracz.score3Jednakowe ? trzyJedankowe : trzyJedankowe + tickSign
        czteryJedankoweLabel.text = gracz.score4Jednakowe ? czteryJednakowe : czteryJednakowe + tickSign
        fulLabel.text = gracz.scoreFul ? ful : ful + tickSign
        malyStritLabel.text = gracz.scoreMalyStrit ? malyStrit : malyStrit + tickSign
        duzyStritLabel.text = gracz.scoreDuzyStrit ? duzyStrit : duzyStrit + tickSign
        generalLabel.text = gracz.scoreGeneral ? general : general + tickSign
        szansaLabel.text = gracz.scoreSzansa ? szansa : szansa + tickSign
        
        scoreLabel.text = "Score: \(gracz.scoreSum)"
    }
}
