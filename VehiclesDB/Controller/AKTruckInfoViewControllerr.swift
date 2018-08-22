//
//  AKTruckInfoViewController.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 20/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class AKTruckInfoViewController: UIViewController {
    
    @IBOutlet weak var someDataLabel: UILabel!
    
    var vehicleDetails : AKTruck?
    var testPass : String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Truck Details"
        someDataLabel.text = vehicleDetails?.model

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing {
          performSegue(withIdentifier: "editTruckSegue", sender: self)
        }
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backButton = UIBarButtonItem()
        backButton.title = "Cancel"
        navigationItem.backBarButtonItem = backButton
    }

}
