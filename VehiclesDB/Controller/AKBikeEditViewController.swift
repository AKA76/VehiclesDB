//
//  AKBikeEditViewController.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 23/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class AKBikeEditViewController: UIViewController {

    var bikeDetails : AKBike?
    var delegate : AKBikeInfoViewController?
    
    @IBOutlet weak var manufacturer: UITextField!
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var horsePower: UITextField!
    @IBOutlet weak var bikeType: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let vehicle = bikeDetails {
            manufacturer.text = vehicle.manufacturer
            model.text = vehicle.model
            horsePower.text = String(vehicle.horsePower)
            bikeType.text = vehicle.bikeType
        } else {
            print("Bike nil")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveBikeDetails(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.bikeDetails = self.bikeDetails
        }
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
 }
