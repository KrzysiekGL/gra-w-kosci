//
//  TabeleViewController.swift
//  Gra w kosci
//
//  Created by Krzysztof Szczerbowski on 23/09/2018.
//  Copyright © 2018 Krzysztof Szczerbowski. All rights reserved.
//

import UIKit
import CoreData

protocol TabeleDelegate {
    func powrotZTabeleVC()
}

class TabeleViewController: UIViewController {
    
    //MARK: - Delegate
    var delegate: TabeleDelegate?
    
    //MARK: - Dice Image Outlets
    @IBOutlet weak var dice1: UIImageView!
    @IBOutlet weak var dice2: UIImageView!
    @IBOutlet weak var dice3: UIImageView!
    @IBOutlet weak var dice4: UIImageView!
    @IBOutlet weak var dice5: UIImageView!
    
    //MARK: - Score Label Outlets
    @IBOutlet weak var labelJedynki: UILabel!
    @IBOutlet weak var labelDwojki: UILabel!
    @IBOutlet weak var labelTrojki: UILabel!
    @IBOutlet weak var labelCzworki: UILabel!
    @IBOutlet weak var labelPiatki: UILabel!
    @IBOutlet weak var labelSzostki: UILabel!
    @IBOutlet weak var labelSzansa: UILabel!
    @IBOutlet weak var label3Jednakowe: UILabel!
    @IBOutlet weak var label4Jednakowe: UILabel!
    @IBOutlet weak var labelFul: UILabel!
    @IBOutlet weak var labelMalyStrit: UILabel!
    @IBOutlet weak var labelDuzyStrit: UILabel!
    @IBOutlet weak var labelGeneral: UILabel!
    @IBOutlet weak var labelJoker: UILabel!
    
    //MARK: - Kosci
    var jedynki: Int32 = 0
    var dwojki: Int32 = 0
    var trojki: Int32 = 0
    var czworki: Int32 = 0
    var piatki: Int32 = 0
    var szostki: Int32 = 0
    
    func policzKosci() {
        guard let wybraneKosci = selectedDiceSet else {fatalError()}
        policzKazdaKosc(kosc: wybraneKosci.kosc1)
        policzKazdaKosc(kosc: wybraneKosci.kosc2)
        policzKazdaKosc(kosc: wybraneKosci.kosc3)
        policzKazdaKosc(kosc: wybraneKosci.kosc4)
        policzKazdaKosc(kosc: wybraneKosci.kosc5)
        print("jedynki \(jedynki)", "dwojki \(dwojki)", "trojki \(trojki)", "czworki \(czworki)", "piatki \(piatki)", "szostki \(szostki)")
    }
    
    func policzKazdaKosc(kosc: Int16) {
        if kosc == 1 {
            jedynki += 1
        }
        else if kosc == 2 {
            dwojki += 1
        }
        else if kosc == 3 {
            trojki += 1
        }
        else if kosc == 4 {
            czworki += 1
        }
        else if kosc == 5 {
            piatki += 1
        }
        else if kosc == 6 {
            szostki += 1
        }
        
        print(kosc)
    }
    
    //MARK: - Wyniki z kosci
    var scoreJedynki: Int32!
    var scoreDwojki: Int32!
    var scoreTrojki: Int32!
    var scoreCzworki: Int32!
    var scorePiatki: Int32!
    var scoreSzostki: Int32!
    var score3Jednakowe: Int32!
    var score4Jednakowe: Int32!
    var scoreFul: Int32!
    var scoreMalyStrit: Int32!
    var scoreDuzyStrit: Int32!
    var scoreGeneral: Int32!
    var scoreSzansa: Int32!
    
    //MARK: - Other Data Objects
    var wybranyGracz: Player!
    var selectedPlayer: Player? {
        didSet{
            wybranyGracz = selectedPlayer
        }
    }
    
    var selectedDiceSet: Rzut?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Metody View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        
        policzKosci()
        presetnDiceSet()
        wypiszMozeliwePunktacje()
    }
    
    //MARK: - Obsluga wyswietlania kosci
    
    func presetnDiceSet() {
        dice1.image = UIImage(named: "dice\(selectedDiceSet?.kosc1 ?? 1)")
        dice2.image = UIImage(named: "dice\(selectedDiceSet?.kosc2 ?? 2)")
        dice3.image = UIImage(named: "dice\(selectedDiceSet?.kosc3 ?? 3)")
        dice4.image = UIImage(named: "dice\(selectedDiceSet?.kosc4 ?? 4)")
        dice5.image = UIImage(named: "dice\(selectedDiceSet?.kosc5 ?? 5)")
    }
    
    //MARK: - Obsluga wyboru punktacji
    
    func wypiszMozeliwePunktacje() {
        scoreJedynki = jedynki * 1
        labelJedynki.text = (wybranyGracz.scoreJedynki) ? String(scoreJedynki) : "--"
        
        scoreDwojki = dwojki * 2
        labelDwojki.text = (wybranyGracz.scoreDwojki) ? String(scoreDwojki) : "--"
        
        scoreTrojki = trojki * 3
        labelTrojki.text = (wybranyGracz.scoreTrojki) ? String(scoreTrojki) : "--"
        
        scoreCzworki = czworki * 4
        labelCzworki.text = (wybranyGracz.scoreCzworki) ? String(scoreCzworki) : "--"
        
        scorePiatki = piatki * 5
        labelPiatki.text = (wybranyGracz.scorePiatki) ? String(scorePiatki) : "--"
        
        scoreSzostki = szostki * 6
        labelSzostki.text = (wybranyGracz.scoreSzostki) ? String(scoreSzostki) : "--"
        
        //3 jednakowe
        if (jedynki >= 3 || dwojki >= 3 || trojki >= 3 || czworki >= 3 || piatki >= 3 || szostki >= 3) {
            score3Jednakowe = jedynki * 1 + dwojki * 2 + trojki * 3 + czworki * 4 + piatki * 5 + szostki * 6
            label3Jednakowe.text = (wybranyGracz.score3Jednakowe) ? String(score3Jednakowe) : "--"
        }
        else {
            score3Jednakowe = 0
            label3Jednakowe.text = (wybranyGracz.score3Jednakowe) ? "0" : "--"
        }
        
        //4 jedankowe
        if (jedynki >= 4 || dwojki >= 4 || trojki >= 4 || czworki >= 4 || piatki >= 4 || szostki >= 4) {
            score4Jednakowe = jedynki * 1 + dwojki * 2 + trojki * 3 + czworki * 4 + piatki * 5 + szostki * 6
            label4Jednakowe.text = (wybranyGracz.score4Jednakowe) ? String(score4Jednakowe) : "--"
        }
        else {
            score4Jednakowe = 0
            label4Jednakowe.text = (wybranyGracz.score4Jednakowe) ? "0" : "--"
        }
        
        //ful
        if ( (jedynki == 3 && dwojki == 2) || (jedynki == 3 && trojki == 2) || (jedynki == 3 && czworki == 2) || (jedynki == 3 && piatki == 2) || (jedynki == 3 && szostki == 2)) {
            scoreFul = 25
            labelFul.text = (wybranyGracz.scoreFul) ? "25" : "--"
        }
        else if ( (dwojki == 3 && jedynki == 2) || (dwojki == 3 && trojki == 2) || (dwojki == 3 && czworki == 2) || (dwojki == 3 && piatki == 2) || (dwojki == 3 && szostki == 2)) {
            scoreFul = 25
            labelFul.text = (wybranyGracz.scoreFul) ? "25" : "--"
        }
        else if ( (trojki == 3 && dwojki == 2) || (trojki == 3 && jedynki == 2) || (trojki == 3 && czworki == 2) || (trojki == 3 && piatki == 2) || (trojki == 3 && szostki == 2)) {
            scoreFul = 25
            labelFul.text = (wybranyGracz.scoreFul) ? "25" : "--"
        }
        else if ( (czworki == 3 && dwojki == 2) || (czworki == 3 && trojki == 2) || (czworki == 3 && jedynki == 2) || (czworki == 3 && piatki == 2) || (czworki == 3 && szostki == 2)) {
            scoreFul = 25
            labelFul.text = (wybranyGracz.scoreFul) ? "25" : "--"
        }
        else if ( (piatki == 3 && dwojki == 2) || (piatki == 3 && trojki == 2) || (piatki == 3 && czworki == 2) || (piatki == 3 && jedynki == 2) || (piatki == 3 && szostki == 2)) {
            scoreFul = 25
            labelFul.text = (wybranyGracz.scoreFul) ? "25" : "--"
        }
        else if ( (szostki == 3 && dwojki == 2) || (szostki == 3 && trojki == 2) || (szostki == 3 && czworki == 2) || (szostki == 3 && piatki == 2) || (szostki == 3 && jedynki == 2)) {
            scoreFul = 25
            labelFul.text = (wybranyGracz.scoreFul) ? "25" : "--"
        }
        else {
            scoreFul = 0
            labelFul.text = (wybranyGracz.scoreFul) ? "0" : "--"
        }
        
        //maly strit
        if ((jedynki >= 1 && dwojki >= 1 && trojki >= 1 && czworki >= 1) || (piatki >= 1 && dwojki >= 1 && trojki >= 1 && czworki >= 1) || (piatki >= 1 && szostki >= 1 && trojki >= 1 && czworki >= 1)) {
            scoreMalyStrit = 30
            labelMalyStrit.text = (wybranyGracz.scoreMalyStrit) ? "30" : "--"
        }
        else {
            scoreMalyStrit = 0
            labelMalyStrit.text = (wybranyGracz.scoreMalyStrit) ? "0" : "--"
        }
        
        //duzy strit
        if ((jedynki >= 1 && dwojki >= 1 && trojki >= 1 && czworki >= 1 && piatki >= 1) || (szostki >= 1 && dwojki >= 1 && trojki >= 1 && czworki >= 1 && piatki >= 1)) {
            scoreDuzyStrit = 40
            labelDuzyStrit.text = (wybranyGracz.scoreDuzyStrit) ? "40" : "--"
        }
        else {
            scoreDuzyStrit = 0
            labelDuzyStrit.text = (wybranyGracz.scoreDuzyStrit) ? "0" : "--"
        }
        
        //general (na razie bez jokera)
        if (jedynki == 5 || dwojki == 5 || trojki == 5 || czworki == 5 || piatki == 5 || szostki == 5) {
            scoreGeneral = 50
            labelGeneral.text = (wybranyGracz.scoreGeneral) ? "50" : "--"
        }
        else {
            scoreGeneral = 0
            labelGeneral.text = (wybranyGracz.scoreGeneral) ? "0" : "--"
        }
        
        //szansa
        scoreSzansa = jedynki * 1 + dwojki * 2 + trojki * 3 + czworki * 4 + piatki * 5 + szostki * 6
        labelSzansa.text = (wybranyGracz.scoreSzansa) ? String(scoreSzansa) : "--"
    }
    
    //wybory gracza - buttons
    @IBAction func wyborPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            if labelJedynki.text != "--" {
                wybranyGracz.scoreJedynki = false
                zakonczTure(dodaj: scoreJedynki)
            }
        case 2:
            if labelDwojki.text != "--" {
                wybranyGracz.scoreDwojki = false
                zakonczTure(dodaj: scoreDwojki)
            }
        case 3:
            if labelTrojki.text != "--" {
                wybranyGracz.scoreTrojki = false
                zakonczTure(dodaj: scoreTrojki)
            }
        case 4:
            if labelCzworki.text != "--" {
                wybranyGracz.scoreCzworki = false
                zakonczTure(dodaj: scoreCzworki)
            }
        case 5:
            if labelPiatki.text != "--" {
                wybranyGracz.scorePiatki = false
                zakonczTure(dodaj: scorePiatki)
            }
        case 6:
            if labelSzostki.text != "--" {
                wybranyGracz.scoreSzostki = false
                zakonczTure(dodaj: scoreSzostki)
            }
        case 7:
            if label3Jednakowe.text != "--" {
                wybranyGracz.score3Jednakowe = false
                zakonczTure(dodaj: score3Jednakowe)
            }
        case 8:
            if label4Jednakowe.text != "--" {
                wybranyGracz.score4Jednakowe = false
                zakonczTure(dodaj: score4Jednakowe)
            }
        case 9:
            if labelFul.text != "--" {
                wybranyGracz.scoreFul = false
                zakonczTure(dodaj: scoreFul)
            }
        case 10:
            if labelMalyStrit.text != "--" {
                wybranyGracz.scoreMalyStrit = false
                zakonczTure(dodaj: scoreMalyStrit)
            }
        case 11:
            if labelDuzyStrit.text != "--" {
                wybranyGracz.scoreDuzyStrit = false
                zakonczTure(dodaj: scoreDuzyStrit)
            }
        case 12:
            if labelGeneral.text != "--" {
                wybranyGracz.scoreGeneral = false
                wybranyGracz.scoreJoker = true
                zakonczTure(dodaj: scoreGeneral)
            }
        case 13:
            if labelSzansa.text != "--" {
                wybranyGracz.scoreSzansa = false
                zakonczTure(dodaj: scoreSzansa)
            }
        default:
            print("wywolano Jokera, ale brak funkcjonalnosci")
        }
    }
    
    func zakonczTure(dodaj punkty: Int32) {
        wybranyGracz.scoreSum += punkty
        saveProgress()
        dismiss(animated: true) {
            self.delegate?.powrotZTabeleVC()
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

/*
 
 That's the ternary conditional operator. It's like a condensed if statement:
 
 if condition {
 something
 } else {
 something else
 }
 
 is equivalent to:
 
 ternary conditional
 
 let object: Any = (condition) ? something : else something
 
 
 */
