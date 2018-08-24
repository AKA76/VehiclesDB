//
//  AKTruckInfoViewController.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 20/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit
protocol returnEditValue {
//    var editedTruckDetails : AKTruck?
    func changedTruckDetails(editedTruckDetails: AKTruck?) -> AKTruck?
}

class AKTruckInfoViewController: UIViewController, returnEditValue {
    
    var vehicleDetails : AKTruck?
    var testPass : String?
    
    @IBOutlet weak var manufacturer: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var horsePower: UILabel!
    @IBOutlet weak var handDrive: UILabel!
    @IBOutlet weak var seatsCount: UILabel!
    @IBOutlet weak var carryingCapacityKg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Truck Details"
        
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
        let vc = segue.destination as! AKTruckEditViewController
        vc.delegate = self
        vc.vehicleDetails = self.vehicleDetails
    }
    func changedTruckDetails(editedTruckDetails: AKTruck?) -> AKTruck? {
        return editedTruckDetails
    }


}
