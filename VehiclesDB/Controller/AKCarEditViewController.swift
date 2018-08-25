//
//  AKCarEditViewController.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 23/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class AKCarEditViewController: UIViewController {

    var carDetails : AKCar?
    var delegate : AKCarInfoViewController?
    
    @IBOutlet weak var manufacturer: UITextField!
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var horsePower: UITextField!
    @IBOutlet weak var handDrive: UITextField!
    @IBOutlet weak var seatsCount: UITextField!
    @IBOutlet weak var doors: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let vehicle = carDetails {
            manufacturer.text = vehicle.manufacturer
            model.text = vehicle.model
            horsePower.text = String(vehicle.horsePower)
            handDrive.text = vehicle.handDrive
            seatsCount.text = String(vehicle.seatsCount)
            doors.text = String(vehicle.doors)
        } else {
            print("Car nil")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveCarDetails(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.carDetails = self.carDetails
        }
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }

}
