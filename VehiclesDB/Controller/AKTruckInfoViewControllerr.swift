//
//  AKTruckInfoViewController.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 20/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class AKTruckInfoViewController: UIViewController {
    
    var truckDetails : AKTruck?
    var carDetails : AKCar?
    var bikeDetails : AKBike?
    
    @IBOutlet weak var manufacturer: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var horsePower: UILabel!
    @IBOutlet weak var handDrive: UILabel!
    @IBOutlet weak var seatsCount: UILabel!
    @IBOutlet weak var carryingCapacityKg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        manufacturer.text = truckDetails?.manufacturer
        model.text = truckDetails?.model
        horsePower.text = String(truckDetails!.horsePower)
        handDrive.text = truckDetails?.handDrive
        seatsCount.text = String(truckDetails!.seatsCount)
        carryingCapacityKg.text = String(truckDetails!.carryingCapacityKg)
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
        let editTruckViewControoler = segue.destination as! AKTruckEditViewController
        editTruckViewControoler.delegate = self
        editTruckViewControoler.navigationItem.title = "Edit Truck Details"
        editTruckViewControoler.truckDetails = self.truckDetails
    }
    func changedTruckDetails(editedTruckDetails: AKTruck?) -> AKTruck? {
        return editedTruckDetails
    }

}
