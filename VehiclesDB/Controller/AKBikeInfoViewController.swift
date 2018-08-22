//
//  AKBikesInfoViewController.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 21/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class AKBikeInfoViewController: UIViewController {

    var vehicleDetails : AKBike?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        //print(vehicleDetails.type)
        self.navigationItem.title = "Bike Details"
       // someDataLabel.text = vehicleDetails?.model

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing {
            performSegue(withIdentifier: "editBikeSegue", sender: self)
        }
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backButton = UIBarButtonItem()
        backButton.title = "Cancel"
        navigationItem.backBarButtonItem = backButton
    }
    
}
