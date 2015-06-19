//
//  ArarasMapViewController.swift
//  Linceu
//
//  Created by Esdras Bezerra da Silva on 03/06/15.
//  Copyright (c) 2015 Esdras Bezerra da Silva. All rights reserved.
//

import UIKit
import MapKit
import CoreData


class ArarasMapViewController: UIViewController, MKMapViewDelegate {
    
    var artworks = [Artwork]()
    
    var controller: UIAlertController?
    var pass: String!
    var name: String!
    
    var titleCrime: String!
    var subTitleCrime: String!
    var descriptionCrime: String!
    var dateCrime: NSDate?
    
    var textFieldDate: UITextField!
    
    var currentController: UIViewController?
        
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
    
    var newCoord:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setar posicao inicial a qual o mapa sera centralzado
        let initialLocation = CLLocation(latitude: -22.357241057363566, longitude: -47.38393372007)
        centerMapOnLocation(initialLocation)
        
        mapView.delegate = self
        
        // Set TapGesture
        let longPress = UILongPressGestureRecognizer(target: self, action: "action:")
        longPress.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longPress)
        
        loadCrimePins()
        
        mapView.addAnnotations(artworks)
        
        
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        var touchPoint = gestureRecognizer.locationInView(self.mapView)
        self.newCoord = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        
        self.selectCrime()
        self.persistPin()
    }
    
    
    @IBAction func mapTypeChanged(sender: AnyObject) {
                
        switch mapTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            println("1")
            mapView.mapType = MKMapType.Standard
        case 1:
            println("2")
            mapView.mapType = MKMapType.Hybrid
        case 2:
            println("3")
            mapView.mapType = MKMapType.Satellite
        default:
            println()
        }
    }
    
    
    func persistPin(){
        var alert = UIAlertController(title: "Salvar Crime", message: "Entre com os dados", preferredStyle: UIAlertControllerStyle.Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default){(action: UIAlertAction!) -> Void in
            
            let description = alert.textFields![0] as! UITextField
            
            let date = alert.textFields![1] as! UITextField
            
            self.descriptionCrime = description.text
            
            var newAnotation = MKPointAnnotation()
            newAnotation.coordinate = self.newCoord!
            newAnotation.title = self.titleCrime
            newAnotation.subtitle = self.subTitleCrime
            self.mapView.addAnnotation(newAnotation)
            
            self.saveLocationCrime(self.titleCrime, subtitle: self.subTitleCrime, coordinate: self.newCoord!, descriptionCrime: self.descriptionCrime)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default){(action: UIAlertAction!) -> Void in
            
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Descrição do Crime"
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Data do fato"
        }

        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)

    }
    
    

    
    func selectCrime(){
        
        var selectCrimeController = UIAlertController(title: "Seleção de Crime", message: "Clique sobre tipo de crime", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let rouboPessoa = UIAlertAction(title: "Roubo a Pessoa", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in
            self.titleCrime = "Roubo"
            self.subTitleCrime = "Roubo a pessoa"
        
            self.persistPin()
        })
        
        let furto = UIAlertAction(title: "Furto a Pessoa", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in
            self.titleCrime = "Furto"
            self.subTitleCrime = "Furto a pessoa"
            self.persistPin()
        })
        
        let trafico = UIAlertAction(title: "Trafico", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in
            self.titleCrime = "Tráfico"
            self.subTitleCrime = "Venda de Entorpecente"
            self.persistPin()
        })
        
        let violacao = UIAlertAction(title: "Violação de Direito", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in
            self.titleCrime = "Violação de Direitos"
            self.subTitleCrime = "Desrespeito à direitos constitucionais"
            self.persistPin()
        })
        
        let rouboVeiculo = UIAlertAction(title: "Roubo", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in
            self.titleCrime = "Roubo"
            self.subTitleCrime = "Roubo de veículos"
            self.persistPin()
        })
        
        let rouboComercial = UIAlertAction(title: "Roubo em comercio", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in
            self.titleCrime = "Roubo"
            self.subTitleCrime = "Roubo em estabelecimento comercial"
            self.persistPin()
        })
        
        let furtoResiencia = UIAlertAction(title: "Furto em Residencia", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in
            self.titleCrime = "Furto"
            self.subTitleCrime = "Furto em residência"
            self.persistPin()
        })
        
        let furtoComercio = UIAlertAction(title: "Furto em Comércio", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in
            self.titleCrime = "Furto"
            self.subTitleCrime = "Furto em estabelecimento comercial"
            self.persistPin()
        })
        
        let cancel = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: {(action: UIAlertAction!) -> Void in})
        
        selectCrimeController.addAction(rouboPessoa)
        selectCrimeController.addAction(rouboVeiculo)
        selectCrimeController.addAction(rouboComercial)
        selectCrimeController.addAction(furto)
        selectCrimeController.addAction(furtoResiencia)
        selectCrimeController.addAction(furtoComercio)
        selectCrimeController.addAction(violacao)
        selectCrimeController.addAction(cancel)
        
        presentViewController(selectCrimeController, animated: true, completion: nil)
    }

    
    let regionRadius: CLLocationDirection = 1000
    func centerMapOnLocation(location: CLLocation){
        let cordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(cordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - location manager to authorize user location for Maps app
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
        
    }
    
    func saveLocationCrime(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, descriptionCrime: String){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        var newCrimeLocation = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: managedContext) as! Location
        
        newCrimeLocation.latitude = coordinate.latitude
        newCrimeLocation.longitude = coordinate.longitude
        newCrimeLocation.crime = title
        newCrimeLocation.type = subtitle
        newCrimeLocation.descriptionCrime = descriptionCrime
        var error: NSError?
        
        managedContext.save(&error)
        
    }

    @IBAction func addCrime(sender: AnyObject) {
//        var storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        var vc: TypeCrimeViewController = storyBoard.instantiateViewControllerWithIdentifier("typeCrime") as! TypeCrimeViewController
//        self.presentViewController(vc, animated: true, completion: nil)
        
        self.selectCrime()
    
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("Title: \(self.titleCrime)")
        println("SubTitle: \(self.subTitleCrime)")
        loadCrimePins()

    }
    
    func loadCrimePins(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("Location", inManagedObjectContext: managedContext)
        
        var actualCrime = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        let fetchRequest = NSFetchRequest(entityName: "Location")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "crime != nil")
        let result: NSArray = managedContext.executeFetchRequest(fetchRequest, error: nil)!
        
        for obj in result {
            var res = obj as? NSManagedObject
            let lat = res?.valueForKey("latitude") as! Double
            let lon = res?.valueForKey("longitude") as! Double
            let pinCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            let newPin = Artwork(title: (res?.valueForKey("crime") as? String)!, locationName: (res?.valueForKey("type") as? String)!, coordinate: pinCoordinate as CLLocationCoordinate2D)
            
            artworks.append(newPin)
            
            println(NSDate())
            print("Lat: ")
            println(res?.valueForKey("latitude"))
        }
        
//        for artworkJSON in jsonData {
//            if let artworkJSON = artworkJSON.array,
//                artwork = Artwork.fromJSON(artworkJSON) {
//                    artworks.append(artwork)
//            }
//        }
        
        println(result)
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
