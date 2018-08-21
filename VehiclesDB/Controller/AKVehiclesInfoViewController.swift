//
//  AKVehiclesInfoViewController.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 20/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class AKVehiclesInfoViewController: UIViewController {
    
    @IBOutlet weak var someDataLabel: UILabel!
    
    var vehicleDetails : AKTruck?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        someDataLabel.text = vehicleDetails?.model        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }


}
