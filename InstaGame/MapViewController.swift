//
//  MapViewController.swift
//  InstaGame
//
//  Created by Haohua Sun Yin on 11/4/16.
//  Copyright © 2016 Awa Sun Yin. All rights reserved.
//

import UIKit
import GoogleMaps

class Events: NSObject {

    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    //Events Constructor
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
    
        self.name = name
        self.location = location
        self.zoom = zoom
    }
}

class MapViewController: UIViewController {
    
    var mapView: GMSMapView!
    
    var currentEvent: Events?
    let locationManager = CLLocationManager()
    
    //Source of events
    //TO DO: Change the list to a dynamic source (instead of hard coded)
    let events = [
        Events(name: "ITU Lan", location: CLLocationCoordinate2DMake(55.659568,12.590808), zoom: 15),
        Events(name: "CBS Gaming Lan", location: CLLocationCoordinate2DMake(55.68043, 12.52472), zoom: 15),
        Events(name: "DTU Lan", location: CLLocationCoordinate2DMake(55.785562, 12.521467), zoom: 15),
        Events(name: "KU Lan", location: CLLocationCoordinate2DMake(55.680230, 12.572463), zoom: 15),
        Events(name: "Viewing Party: CS:GO Season Finals", location: CLLocationCoordinate2DMake(55.681161, 12.552990), zoom: 15),
        Events(name: "FIFA Tournament by CBS Gaming", location: CLLocationCoordinate2DMake(55.681457, 12.528378), zoom: 15),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //First position always in
        //TO DO: Turn the first position into the user's current location
        let camera = GMSCameraPosition.cameraWithLatitude(55.68043, longitude: 12.52472, zoom: 15)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        view = mapView
        
        //Fixed position
        let currentLocation = CLLocationCoordinate2DMake(55.68043, 12.52472)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "First Location"
        marker.map = mapView
        
        //Adds "Next" button to browse through the available events on the map
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(MapViewController.next))
    }
    
    //Function for the "Next button"
    func next(){
        
        if currentEvent == nil {
            currentEvent = events.first
            
            mapView?.camera = GMSCameraPosition.cameraWithTarget(currentEvent!.location, zoom: currentEvent!.zoom)
            
            let marker = GMSMarker(position: currentEvent!.location)
            marker.title = currentEvent?.name
            marker.map = mapView
            
        } else {
        
            if let index = events.indexOf(currentEvent!){
                
                currentEvent = events[index + 1]
                
                mapView?.camera = GMSCameraPosition.cameraWithTarget(currentEvent!.location, zoom: currentEvent!.zoom)
                
                let marker = GMSMarker(position: currentEvent!.location)
                marker.title = currentEvent?.name
                marker.map = mapView
            
            }
        }
    }//Closes next()
}
