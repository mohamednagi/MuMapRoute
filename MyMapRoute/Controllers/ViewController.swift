//
//  ViewController.swift
//  MyMapRoute
//
//  Created by Sierra on 7/18/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController,MKMapViewDelegate {

    override var prefersStatusBarHidden: Bool{return true}
    @IBOutlet weak var StartPointTF: UITextField!
    @IBOutlet weak var SecondPointTF: UITextField!
    @IBOutlet weak var MyMapView: MKMapView!
    
    var startLat = defaults.double(forKey: latKey)
    var startLon = defaults.double(forKey: lonKey)
    
   // var endLat = 30.050000000000001
   // var endLon = 31.239999999999998

    override func viewDidLoad() {
        super.viewDidLoad()
        self.MyMapView.delegate=self
        print("\(startLat) && \(startLon)")
    }
    
    @IBAction func GetDirectionsBu(_ sender: UIButton) {
        APIService.GetDetails(city: "\(StartPointTF.text!)")
        let sourceLocation = CLLocationCoordinate2D(latitude: startLat, longitude: startLon)
        let destinationLocation = CLLocationCoordinate2D(latitude:endLat , longitude: endLon)
        print("retrieved :: lat : \(startLat) && lon : \(startLon)")
        let sourcePin = customPin(pinTitle: "starting point", pinSubTitle: "", location: sourceLocation)
        let destinationPin = customPin(pinTitle: "ending point", pinSubTitle: "", location: destinationLocation)
        
        self.MyMapView.addAnnotation(sourcePin)
        self.MyMapView.addAnnotation(destinationPin)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResponse = response else{
                if let error = error {
                    print("error getting direction because of : \(error.localizedDescription)")
                }
                return
            }
            let route = directionResponse.routes[0]
            self.MyMapView.add(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.MyMapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 4.0
        renderer.strokeColor = UIColor.blue
        return renderer
    }
    @IBAction func ClearDataBu(_ sender: UIButton) {
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        print("start lat : \(startLat) && start lon : \(startLon)")
    }
    
}
