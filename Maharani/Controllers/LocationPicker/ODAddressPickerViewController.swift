//
//  ODAddressPickerViewController.swift
//  Oodle
//
//  Created by Albin Jose on 25/11/21.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

protocol PlacePickerDelegate {
    func placePicked(coordinate: CLLocationCoordinate2D, address: String)
}
class ODAddressPickerViewController:BaseViewController {
    
    @IBAction func resetToCurrentLocation(_ sender: Any) {
        let currentLocation = manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 25.2048, longitude: 55.2708)
        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.latitude, longitude: currentLocation.longitude, zoom: 15.0)
        mapView.moveCamera(GMSCameraUpdate.setCamera(camera))
        pickedCoordinate = currentLocation
        geocoder.reverseGeocodeLocation(CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude), completionHandler: { [weak self] (placemarks, error) in
            if error == nil, let placemarks = placemarks, !placemarks.isEmpty {
                guard let placemark = placemarks.last else { return }
                self?.parsePlacemarks(placemark: placemark)
            }
        })
        
    }
    @IBOutlet weak var mapContainerView: UIView!
    lazy var mapView = GMSMapView()
    @IBOutlet weak var pickerMarkerImageView: UIImageView!
    @IBOutlet weak var placesTableView: UITableView!
    
    var statusBarView = UIView()
    lazy var searchBar:UISearchBar = UISearchBar()

    var pickedCoordinate: CLLocationCoordinate2D? {
        didSet {
            if let latitude = pickedCoordinate?.latitude, let longitude = pickedCoordinate?.longitude {
                coordinatesLabel?.isHidden = false
                coordinatesLabel?.text = "\(latitude)° N, \(longitude)° E"
            } else {
                coordinatesLabel?.isHidden = true
                coordinatesLabel?.text = ""
            }
        }
    }
    var pickedAddress: String = "" {
        didSet {
            addressLabel.text = pickedAddress
        }
    }
    let geocoder = CLGeocoder()
    private let manager = CLLocationManager()
    
    var titleString: String?
    var pickerMarkerImage: UIImage?

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    
    var delegate: PlacePickerDelegate?
    
    var placesArray = [PlaceModel]()
    
    var isNavigatingToPlaceSearch = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        configureLocationManager()
       // setupMap()
        
        title = titleString ?? "Search"
      //  pickerMarkerImageView.image = pickerMarkerImage ?? UIImage(named: "mapPinOrdarat")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        type = .back
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func configureLocationManager(){
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.pausesLocationUpdatesAutomatically = true
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func setupNavigationBar() {
        let doneButton = UIButton(type: UIButton.ButtonType.custom)
        doneButton.frame = CGRect(x: 0, y: 0, width: 30.0, height: 30.0)
        doneButton.addTarget(self, action: #selector(self.doneAction), for: .touchUpInside)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.black, for: .normal)
        let item0 = UIBarButtonItem(customView: doneButton)
        
        navigationItem.setRightBarButtonItems([item0], animated: true)

        navigationController?.navigationBar.prefersLargeTitles = false
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .black
    }
    
    @objc func doneAction() {
        if let coordinate = pickedCoordinate {
            delegate?.placePicked(coordinate: coordinate, address: pickedAddress)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func setupMap() {
        let currentLocation = pickedCoordinate ?? manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 25.2048, longitude: 55.2708)
        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.latitude, longitude: currentLocation.longitude, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapContainerView.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: mapContainerView.topAnchor, constant: 0).isActive = true
        mapView.bottomAnchor.constraint(equalTo: mapContainerView.bottomAnchor, constant: 0).isActive = true
        mapView.leadingAnchor.constraint(equalTo: mapContainerView.leadingAnchor, constant: 0).isActive = true
        mapView.trailingAnchor.constraint(equalTo: mapContainerView.trailingAnchor, constant: 0).isActive = true
    }
    
    func presentPlaceSearch() {
        isNavigatingToPlaceSearch = true
        let autocompleteController = CustomAutoCompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        autocompleteController.autocompleteFilter = filter
        autocompleteController.modalPresentationStyle = .fullScreen
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func fetchNearbyLocations() {
        guard let latitude = pickedCoordinate?.latitude, let longitude = pickedCoordinate?.longitude else { return }
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&rankby=distance&key=\(Config.googleApiKey)") else { return }
        
        let configue = URLSessionConfiguration.default
        let session = URLSession(configuration: configue)

        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any], let places = json["results"] as? [[String: Any]] {
                        self.parsePlaces(places: places)
                    } else{
                        
                    }
                } catch {
                    print("parsing error")
                }
            }
        })
        task.resume()
    }
    
    func parsePlaces(places: [[String: Any]]) {
        placesArray.removeAll()
        for place in places {
            do {
                var placeDict: [String: Any] = [:]
                if let geometry = place["geometry"] as? [String: Any], let location = geometry["location"] as? [String: Double] {
                    placeDict["latitude"] = location["lat"]
                    placeDict["longitude"] = location["lng"]
                }
                if let name = place["name"] as? String {
                    placeDict["name"] = name
                }
                let json = try JSONSerialization.data(withJSONObject: placeDict)
                let place = try JSONDecoder().decode(PlaceModel.self, from: json)
                placesArray.append(place)
            } catch {
                print("cast error")
            }
        }
        DispatchQueue.main.async {
            self.placesTableView.reloadData()
        }
    }
}

extension ODAddressPickerViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {

        pickedCoordinate = position.target
        geocoder.reverseGeocodeLocation(CLLocation(latitude: position.target.latitude, longitude: position.target.longitude), completionHandler: { [weak self] (placemarks, error) in
            if error == nil, let placemarks = placemarks, !placemarks.isEmpty {
                guard let placemark = placemarks.last else { return }
                self?.parsePlacemarks(placemark: placemark)
            }
        })
        fetchNearbyLocations()
    }
    
    func parsePlacemarks(placemark: CLPlacemark) {
        var address = ""
        if let name = placemark.name, !name.isEmpty {
            address = name
        }
        if let street = placemark.thoroughfare, !street.isEmpty {
            address += ", \(street)"
        }
        if let city = placemark.locality, !city.isEmpty {
            address += ", \(city)"
        }
        pickedAddress = address
    }
}

extension ODAddressPickerViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedAlways) || (status == .authorizedWhenInUse) {
            manager.startUpdatingLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error:\(error.localizedDescription)")
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()

        if let _ = pickedCoordinate { return }
        
        let updatedLocation:CLLocation = locations.first!
        
        let newCoordinate: CLLocationCoordinate2D = updatedLocation.coordinate
        
        let usrDefaults:UserDefaults = UserDefaults.standard
        
        usrDefaults.set("\(newCoordinate.latitude)", forKey: "current_latitude")
        usrDefaults.set("\(newCoordinate.longitude)", forKey: "current_longitude")
        usrDefaults.synchronize()
        
        let camera = GMSCameraPosition.camera(withLatitude: newCoordinate.latitude, longitude: newCoordinate.longitude, zoom: 15)
        mapView.camera = camera
        
        
        pickedCoordinate = newCoordinate
        geocoder.reverseGeocodeLocation(CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude), completionHandler: { [weak self] (placemarks, error) in
            if error == nil, let placemarks = placemarks, !placemarks.isEmpty {
                guard let placemark = placemarks.last else { return }
                self?.parsePlacemarks(placemark: placemark)
            }
        })
        setupMap()
        //        geoFire?.setLocation(updatedLocation, forKey: "Test2973827")
        
        
        //        let marker = GMSMarker(position: newCoordinate)
        //
        //        print("Latitude :- \(newCoordinate.latitude)")
        //        print("Longitude :-\(newCoordinate.longitude)")
        //        marker.map = mapView
        //
        //        marker.title = "Current Location"
    }
}


extension ODAddressPickerViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        print("Place name: \(place.name)")
//        print("Place ID: \(place.placeID)")
//        print("Place attributions: \(place.attributions)")
        pickedAddress = place.formattedAddress ?? ""
        pickedCoordinate = place.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15)
        mapView.camera = camera
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

extension ODAddressPickerViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        presentPlaceSearch()
    }
}

extension ODAddressPickerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if placesArray.count == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                tableView.isHidden = true
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                tableView.isHidden = false
            })
        }
        return placesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let placeCell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "placeCell")
        let place = placesArray[indexPath.row]
        if let nameLabel = placeCell.viewWithTag(5) as? UILabel {
            nameLabel.text = place.name ?? ""
        }
        return placeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = placesArray[indexPath.row]
        pickedAddress = place.name ?? ""
        let camera = GMSCameraPosition.camera(withLatitude: place.latitude ?? 0, longitude: place.longitude ?? 0, zoom: 15)
        mapView.camera = camera
    }
}
