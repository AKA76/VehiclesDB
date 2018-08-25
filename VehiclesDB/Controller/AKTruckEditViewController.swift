//
//  AKTruckEditViewController.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 23/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class AKTruckEditViewController: UIViewController {

    var truckDetails : AKTruck?
    var delegate : AKTruckInfoViewController?
    
    @IBOutlet weak var manufacturer: UITextField!
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var horsePower: UITextField!
    @IBOutlet weak var handDrive: UITextField!
    @IBOutlet weak var seatsCount: UITextField!
    @IBOutlet weak var carryingCapacityKg: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let vehicle = truckDetails {
        manufacturer.text = vehicle.manufacturer
        model.text = vehicle.model
        horsePower.text = String(vehicle.horsePower)
        handDrive.text = vehicle.handDrive
        seatsCount.text = String(vehicle.seatsCount)
        carryingCapacityKg.text = String(vehicle.carryingCapacityKg)
        } else {
            print("Truck nil")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func saveTruckDetails(_ sender: Any) {
        if let delegate = self.delegate {
            truckDetails?.manufacturer = "Edited"
            delegate.truckDetails = self.truckDetails
        }
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
