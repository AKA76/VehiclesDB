//
//  VehiclesViewController.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 19/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VehiclesViewController: UITableViewController {
    
    var isDataImported : Bool = false
    var itemArray = ["Trucks", "Cars", "Bikes"]
    var bikesArray = [AKBike]()
    var trucksArray = [AKTruck]()
    var carsArray = [AKCar]()
    let VEHICLESDB_URL = "http://azcltd.com/testTask/iOS/list.json"
    let VEHICLESIMG_URL = "http://azcltd.com/testTask/iOS/"
    let sectionColor = UIColor(red:0.16, green:0.67, blue:0.75, alpha:0.7)

    var someData : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isEditing = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        if !isDataImported {
            print("Importing ...")
            getVehiclesData(url:VEHICLESDB_URL)
        }else {
            print ("Already imported!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    //MARK: - Choose vehicle type
    func getVehicleType(vehicleType: Int) -> Array<Any> {
        switch (vehicleType) {
        case 0:
            return trucksArray
        case 1:
            return carsArray
        default:
            return bikesArray
        }

    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        if let cell = sender as? UITableViewCell {
            let indexPathRow = tableView.indexPath(for: cell)!.row
            if segue.identifier == "truckDetailsSegue" {
                let truckInfoViewController = segue.destination as! AKTruckInfoViewController
                truckInfoViewController.truckDetails = trucksArray[indexPathRow]
                truckInfoViewController.navigationItem.title = "Truck Details"
            } else  if segue.identifier == "carDetailsSegue" {
                let carInfoViewController = segue.destination as! AKCarInfoViewController
                carInfoViewController.carDetails = carsArray[indexPathRow]
                carInfoViewController.navigationItem.title = "Car Details"
            } else if segue.identifier == "bikeDetailsSegue" {
                let bikeInfoViewController = segue.destination as! AKBikeInfoViewController
                bikeInfoViewController.bikeDetails = bikesArray[indexPathRow]
                bikeInfoViewController.navigationItem.title = "Bike Details"
            }
        }

        if segue.identifier == "truckAddSegue" {
            let addTruckViewController = segue.destination as! AKTruckEditViewController
            addTruckViewController.navigationItem.title = "New truck"
        }else if segue.identifier == "carAddSegue" {
            let addCarViewController = segue.destination as! AKCarEditViewController
            addCarViewController.navigationItem.title = "New car"
        }else if segue.identifier == "bikeAddBikeSegue" {
            let addBikeViewController = segue.destination as! AKBikeEditViewController
            addBikeViewController.navigationItem.title = "New bike"
        }
        
    }
    //MARK: - Networking
    func getVehiclesData(url:(String)) {
        Alamofire.request(url, method: .get, parameters: nil).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Vehicles data was got.")
                let vehiclesJSON : JSON = JSON(response.result.value!)
                self.updateVehiclesData(json: vehiclesJSON)
                self.isDataImported = true
            }else{
                print ("Connections Issues.\nError \(String(describing: response.result.error))")
            }
        }
    }
    
    //MARK: - JSON Parsing
    func updateVehiclesData(json: JSON){
        let vehiclesArray = json["vehicles"]
        for vehicle in vehiclesArray {
            switch (vehicle.1["type"]) {
            case "truck":
                let truck = AKTruck()
                truck.type = vehicle.1["type"].stringValue
                truck.manufacturer = vehicle.1["manufacturer"].stringValue
                truck.model = vehicle.1["model"].stringValue
                truck.horsePower = vehicle.1["horsePower"].intValue
                truck.handDrive = vehicle.1["handDrive"].stringValue
                truck.seatsCount = vehicle.1["seatsCount"].intValue
                truck.carryingCapacityKg = vehicle.1["carryingCapacityKg"].intValue
                if let fetchedImages = vehicle.1["images"].arrayObject as? [String] {
                    truck.images = fetchedImages
                }
                trucksArray.append(truck)
            case "car":
                let car = AKCar()
                car.type = vehicle.1["type"].stringValue
                car.manufacturer = vehicle.1["manufacturer"].stringValue
                car.model = vehicle.1["model"].stringValue
                car.horsePower = vehicle.1["horsePower"].intValue
                car.handDrive = vehicle.1["handDrive"].stringValue
                car.seatsCount = vehicle.1["seatsCount"].intValue
                car.doors = vehicle.1["doors"].intValue
                if let fetchedImages = vehicle.1["images"].arrayObject as? [String] {
                    car.images = fetchedImages
                }
                carsArray.append(car)
            case "bike":
                let bike = AKBike()
                bike.type = vehicle.1["type"].stringValue
                bike.manufacturer = vehicle.1["manufacturer"].stringValue
                bike.model = vehicle.1["model"].stringValue
                bike.horsePower = vehicle.1["horsePower"].intValue
                bike.bikeType = vehicle.1["bikeType"].stringValue
                if let fetchedImages = vehicle.1["images"].arrayObject as? [String] {
                    bike.images = fetchedImages
                }
                bikesArray.append(bike)
            default:
                print("Wrong vehicle type")
            }
        }
        self.tableView.reloadData()
    }
    
    //MARK: - TableView Datasource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView()
        sectionHeader.backgroundColor = sectionColor
        let sectionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 28))
        sectionLabel.text = itemArray[section]
        sectionLabel.textAlignment = .center
        sectionLabel.textColor = UIColor.white
        sectionHeader.addSubview(sectionLabel)
        let addButton: UIButton = UIButton(frame: CGRect(x:tableView.frame.size.width-40, y:0, width:28, height:28))
        addButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size:28)
        addButton.setTitle("+", for: .normal)
        // Pass type of vehicle to function using tag parameter of UIButton
        addButton.tag = section
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        sectionHeader.addSubview(addButton)
        return sectionHeader
    }
    //MARK: - Add New Vehicle
    @objc func addButtonTapped(sender: UIButton) {
        let type = sender.tag
        switch type {
        case 0:
            performSegue(withIdentifier: "truckAddSegue", sender: nil)
        case 1:
            performSegue(withIdentifier: "carAddSegue", sender: nil)
        default:
            performSegue(withIdentifier: "bikeAddSegue", sender: nil)
        }
        print("Add Vehicle type \(type)")
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let vehicleTypeArray =  getVehicleType(vehicleType: section)
        return vehicleTypeArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {

        let cell : UITableViewCell =
            tableView.dequeueReusableCell (withIdentifier: "VehiclesItemCell", for: indexPath)
        let vehicle = getVehicleType(vehicleType: indexPath.section) as! Array<AKVehicle>
        cell.textLabel?.text = vehicle[indexPath.row].model
        cell.detailTextLabel?.text = vehicle[indexPath.row].manufacturer
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            performSegue(withIdentifier: "truckDetailsSegue", sender: tableView.cellForRow(at: indexPath))
        } else  if indexPath.section == 1 {
            performSegue(withIdentifier: "carDetailsSegue", sender: tableView.cellForRow(at: indexPath))
        } else if indexPath.section == 2 {
            performSegue(withIdentifier: "bikeDetailsSegue", sender: tableView.cellForRow(at: indexPath))
        }
    
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section == proposedDestinationIndexPath.section {
            
            switch (sourceIndexPath.section) {
            case 0:
                let movedObject = self.trucksArray[sourceIndexPath.row]
                trucksArray.remove(at: proposedDestinationIndexPath.row)
                trucksArray.insert(movedObject, at: proposedDestinationIndexPath.row)
            case 1:
                let movedObject = self.carsArray[sourceIndexPath.row]
                carsArray.remove(at: proposedDestinationIndexPath.row)
                carsArray.insert(movedObject, at: proposedDestinationIndexPath.row)
            default:
                let movedObject = self.bikesArray[sourceIndexPath.row]
                bikesArray.remove(at: proposedDestinationIndexPath.row)
                bikesArray.insert(movedObject, at: proposedDestinationIndexPath.row)
            }
            return proposedDestinationIndexPath
        } else {
            return sourceIndexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            switch (indexPath.section) {
            case 0:
                trucksArray.remove(at: indexPath.row)
            case 1:
                carsArray.remove(at: indexPath.row)
            default:
                bikesArray.remove(at: indexPath.row)
            }
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
            tableView.endUpdates()
        }
    }
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

