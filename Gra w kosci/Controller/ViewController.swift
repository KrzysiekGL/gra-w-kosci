//
//  ViewController.swift
//  Gra w kosci
//
//  Created by Krzysztof Szczerbowski on 19/09/2018.
//  Copyright © 2018 Krzysztof Szczerbowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var rozpocznijGreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rozpocznijGreButton.layer.cornerRadius = 7
    }

    @IBAction func rozpocznijGrePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToWyniki", sender: self)

    }
    
}

