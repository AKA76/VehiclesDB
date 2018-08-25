//
//  AKBikesInfoViewController.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 21/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class AKBikeInfoViewController: UIViewController {

    var bikeDetails : AKBike?
    
    @IBOutlet weak var manufacturer: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var horsePower: UILabel!
    @IBOutlet weak var bikeType: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        manufacturer.text = bikeDetails?.manufacturer
        model.text = bikeDetails?.model
        horsePower.text = String(bikeDetails!.horsePower)
        bikeType.text = bikeDetails?.bikeType
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
        let editBikeViewController = segue.destination as! AKBikeEditViewController
        editBikeViewController.delegate = self
        editBikeViewController.navigationItem.title = "Edit Bike Details"
        editBikeViewController.bikeDetails = self.bikeDetails

    }
    
}
