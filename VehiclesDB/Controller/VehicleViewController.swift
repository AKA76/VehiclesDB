//
//  ViewController.swift
//  VehiclesDB
//
//  Created by Andrei Kucherenko on 19/08/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VehicleViewController: UITableViewController {
    
    var isImportedData : Bool = false
    var itemArray = ["Trucks", "Cars", "Bikes"]
    var bikesArray = [AKBike]()
    var trucksArray = [AKTruck]()
    var carsArray = [AKCar]()
    let VEHICLESDB_URL = "http://azcltd.com/testTask/iOS/list.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isImportedData {
            print("Importing ...")
            getVehiclesData(url:VEHICLESDB_URL)
        }else {
            print ("Already imported!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    //MARK: - Networking
    func getVehiclesData(url:(String)) {
        Alamofire.request(url, method: .get, parameters: nil).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! The vehicle data was got.")
                let vehiclesJSON : JSON = JSON(response.result.value!)
                self.updateVehiclesData(json: vehiclesJSON)
                self.isImportedData = true
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
                print("wrong vehicle type")
            }
        }
        self.tableView.reloadData()
    }
    //MARK : - TableView Datasource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return itemArray[section]
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return trucksArray.count
        case 1:
            return carsArray.count
        default:
            return bikesArray.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {

        let cell : UITableViewCell =
            tableView.dequeueReusableCell (withIdentifier: "VehiclesItemCell", for: indexPath)
        
        if (indexPath.section == 0) {
            cell.textLabel?.text = trucksArray[indexPath.row].model
            cell.detailTextLabel?.text = trucksArray[indexPath.row].manufacturer
        }else if (indexPath.section == 1 ) {
            cell.textLabel?.text = carsArray[indexPath.row].model
            cell.detailTextLabel?.text = carsArray[indexPath.row].manufacturer
        }else{
            cell.textLabel?.text = bikesArray[indexPath.row].model
            cell.detailTextLabel?.text = bikesArray[indexPath.row].manufacturer
        }

        return cell
    }
    //MARK : - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
