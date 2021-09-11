//
//  ContentViewModel.swift
//  SwiftUI-UserLocation
//
//  Created by Ji Wang on 9/10/21.
//

import MapKit
enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 42.729921, longitude: -73.676612)
    static let startingSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // RPI Union: 42.729921, -73.676612
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.startingSpan)
    
    var locationManager: CLLocationManager?
    
    /* check if location service is enabled before using location */
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("The location service is off, go turn it on before use.")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted likely due to parental controls.")
            case .denied:
                print("You have denied this app location permission. Go into settings to change it.")
            case .authorizedAlways, .authorizedWhenInUse:
                region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.startingSpan)
            @unknown default:
                break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
