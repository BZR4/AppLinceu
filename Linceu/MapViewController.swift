//
//  MapViewController.swift
//  Linceu
//
//  Created by Esdras Bezerra da Silva on 02/06/15.
//  Copyright (c) 2015 Esdras Bezerra da Silva. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate { //  Settar o Delegate
    
    //  property para o locationManager
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        displayAlertWhitTitle("Titulo", message: "Mensagem")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  Alert Controller para exibicao de imagens de controle no switch case
    func displayAlertWhitTitle(title: String, message: String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        controller.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil)) //  OK é passado para o botao que representa acao
        presentViewController(controller, animated: true, completion: nil)
    }
    
    //  Criacao do Loacation Manager
    func createLocationManager(#startImmediately: Bool){
        locationManager = CLLocationManager()
        if let manager = locationManager{
            println("Successfully created the location manager")
            manager.delegate = self
            if startImmediately{
                manager.startUpdatingLocation()
            }
        }
    }
    
    //  O Alert Controller nao pode ser excutado no ViewDidLoad
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        
        /*  O servico de loaclizacao esta disponivel no dispositivo?    */
        if CLLocationManager.locationServicesEnabled(){
            
            /*  Nos temos autorizacao para aceessar os servicos de localizacao? */
            switch CLLocationManager.authorizationStatus(){
            
            case .AuthorizedAlways:
                createLocationManager(startImmediately: true)
                
            case .AuthorizedWhenInUse:
                createLocationManager(startImmediately: true)
            case .Denied:
                displayAlertWhitTitle("Note Determinated", message: "Location Services are nor allowed for this app")
            case .NotDetermined:
                createLocationManager(startImmediately: false)
                if let manager = self.locationManager{
                    manager.requestWhenInUseAuthorization()
                }
            case .Restricted:
                displayAlertWhitTitle("Restricted", message: "Location services are not enabled")
            }
        }else{
            println("Loaction services are not enabled")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
