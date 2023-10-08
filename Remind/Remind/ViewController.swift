//
//  ViewController.swift
//  Remind
//
//  Created by LC on 2023/9/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        RemindImage.color = .yellow
//        RemindManager.config.backgroundColor = .gray
//        RemindManager.config.padding = 30
        // Do any additional setup after loading the view.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.rmd.show("Do any additional setup after loading the view")
    }
}

