//
//  AKCarInfoViewController.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 23/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class AKCarInfoViewController: UIViewController {

    var carDetails : AKCar?
 
    @IBOutlet weak var manufacturer: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var horsePower: UILabel!
    @IBOutlet weak var handDrive: UILabel!
    @IBOutlet weak var seatsCount: UILabel!
    @IBOutlet weak var doors: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        manufacturer.text = carDetails?.manufacturer
        model.text = carDetails?.model
        horsePower.text = String(carDetails!.horsePower)
        handDrive.text = carDetails?.handDrive
        seatsCount.text = String(carDetails!.seatsCount)
        doors.text = String(carDetails!.doors)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing {
            performSegue(withIdentifier: "editCarSegue", sender: self)
        }
    
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backButton = UIBarButtonItem()
        backButton.title = "Cancel"
        navigationItem.backBarButtonItem = backButton
        let editCarViewController = segue.destination as! AKCarEditViewController
        editCarViewController.delegate = self
        editCarViewController.navigationItem.title = "Edit Car Details"
        editCarViewController.carDetails = self.carDetails
    }

}
