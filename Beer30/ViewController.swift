//
//  ViewController.swift
//  Beer30
//
//  Created by Clinton Medbery on 4/2/16.
//  Copyright © 2016 Programadores Sans Frontieres. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NetworkHandler.handler.readyManager { (success, error) in
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}

