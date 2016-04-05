//
//  ViewController.swift
//  Beer30
//
//  Created by Clinton Medbery on 4/2/16.
//  Copyright © 2016 Programadores Sans Frontieres. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        checkBeerStatus()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkBeerStatus(){
        NetworkHandler.handler.readyManager { (success, result) in
            if(success == true){
                
                print(result)
                if (result["state"] != nil && result["text"] != nil) {
                    print(result["state"])
                    
                    if (result["state"] == "yellow"){
                        self.beerImageView.image = UIImage(named: "HalfBeer.png")
                        

                    } else if(result["state"] == "red"){
                        self.beerImageView.image = UIImage(named: "EmptyBeer.png")
                    } else if(result["state"] == "green"){
                        self.beerImageView.image = UIImage(named: "FullBeer.png")
                    }
                    self.informationLabel.text = result["text"].string
                    
                } else {
                    self.informationLabel.text = "Connection Error"
                }
            } else {
                self.informationLabel.text = "Connection Error"
            }
        }

    }

    @IBAction func reloadBeerStatus(sender: AnyObject) {
        informationLabel.text = "Loading..."
        self.beerImageView.image = nil
        checkBeerStatus()
    }
   
}

