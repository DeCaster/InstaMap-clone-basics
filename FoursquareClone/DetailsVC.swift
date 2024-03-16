//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Murad Eyvazli on 11.02.2024
//  Copyright © 2024 Murad Eyvazli. All rights reserved.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    @IBOutlet weak var detailsTypeLabel: UILabel!
    @IBOutlet weak var detailsAtmosphereLabel: UILabel!
    
    var choosenPlaceId = ""
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromParse()
        detailsMapView.delegate = self
    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: choosenPlaceId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                // Hata işleme
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                
            } else {
                //OBJECTS::
                if let choosenPlaceObject = objects?.first {
                    
                    if let placeName = choosenPlaceObject["name"] as? String {
                        self.detailsNameLabel.text = placeName
                    }
                    if let placeType = choosenPlaceObject["type"] as? String {
                        self.detailsTypeLabel.text = placeType
                    }
                    if let placeAtmosphere = choosenPlaceObject["atmosphere"] as? String {
                        self.detailsAtmosphereLabel.text = placeAtmosphere
                    }
                    if let placeLatitude = choosenPlaceObject["latitude"] as? String,
                       let placeLatitudeDouble = Double(placeLatitude) {
                        self.chosenLatitude = placeLatitudeDouble
                    }
                    if let placeLongitude = choosenPlaceObject["longitude"] as? String,
                       let placeLongitudeDouble = Double(placeLongitude) {
                        self.chosenLongitude = placeLongitudeDouble
                    }
                    if let imageData = choosenPlaceObject["image"] as? PFFileObject {
                        imageData.getDataInBackground { data, error in
                            if let imageData = data {
                                self.detailsImageView.image = UIImage(data: imageData)
                            }
                        }
                    }
                    //MAPS::
                    
                    let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035) //enlem ve boylam arasindaki farki belirleriz
                    
                    let region = MKCoordinateRegion(center: location, span: span)
                    self.detailsMapView.setRegion(region, animated: true)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.detailsNameLabel.text!
                    annotation.subtitle = self.detailsTypeLabel.text!
                    self.detailsMapView.addAnnotation(annotation)
                }
            }
        }
    }
    // i Buttonunun nerde ve nasil gozukucegini ayarliyoz
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil//eger kullaniciyla ile olgili bir annotasiya varsa
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)//pin view daha once eklendimi nilmi degilmi
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true //
            let button = UIButton(type: .detailDisclosure)//I isareti cikariyor
            pinView?.rightCalloutAccessoryView = button //sagtarafdaki aksesuari butona degisdik
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    // Bir tane i Buttonu yapyoz tiklaninca seni haritalara yonlendiricek ve gosterilen mekana nasil gidicegini gostericekdir( islemi burada yazilir )
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLongitude != 0.0 && self.chosenLatitude != 0.0 {//eger 0 deglse onda bu isleri yap
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                //geocoder coordinatlar ve yerler araindaki ismleri vererde reverse yapinca bizden target ister ve handler verir geriye
                if let placemark = placemarks?.first {
                    let mkPlaceMark = MKPlacemark(placemark: placemark)
                    let mapItem = MKMapItem(placemark: mkPlaceMark)
                    mapItem.name = self.detailsNameLabel.text
                    let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                    mapItem.openInMaps(launchOptions: launchOptions)
                }
            }
        }
    }
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
