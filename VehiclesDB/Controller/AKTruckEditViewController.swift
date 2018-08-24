//
//  AKTruckEditViewController.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 23/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit


class AKTruckEditViewController: UIViewController {

    var vehicleDetails : AKTruck?
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
        
        manufacturer.text = vehicleDetails?.manufacturer
        model.text = vehicleDetails?.model
        horsePower.text = String(vehicleDetails!.horsePower)
        handDrive.text = vehicleDetails?.handDrive
        seatsCount.text = String(vehicleDetails!.seatsCount)
        carryingCapacityKg.text = String(vehicleDetails!.carryingCapacityKg)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func saveTruckDetails(_ sender: Any) {
        if let delegate = self.delegate {
//            delegate.changedTruckDetails(editedTruckDetails: vehicleDetails!)
            delegate.testPass = "Test!"
        }
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
