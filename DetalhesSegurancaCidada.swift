//
//  DetalhesSegurancaCidada.swift
//  Linceu
//
//  Created by Evandro Henrique Couto de Paula on 17/06/15.
//  Copyright (c) 2015 Esdras Bezerra da Silva. All rights reserved.
//

import UIKit
import MapKit
import MessageUI

class DetalhesSegurancaCidada: UIViewController, MKMapViewDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var labelTelefone: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var siglaLabel: UILabel!
    @IBOutlet weak var competencyTextView: UITextView!
//    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phonrButton: UIButton!
    
    var titlePin: String!
    var subTitlePin: String!
    var latPin: Double!
    var lonPin: Double!
    var coordinatePin: CLLocationCoordinate2D!
    
    var dados = [NSArray]()
    var pin: Artwork?
    var newPin: MyAnnotation?
    
    var tableIndex: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func enviarEmail(){
        if (MFMailComposeViewController.canSendMail()){
            // Send e-mail
            var emailTitle = "Titulo Email"
            var messageBody = "Digite sua mensagem"
            var toEntity = [dados[tableIndex].objectAtIndex(5)]
            
            var messageController: MFMailComposeViewController = MFMailComposeViewController()
            messageController.mailComposeDelegate = self
            messageController.setToRecipients(toEntity)
            messageController.setMessageBody(messageBody, isHTML: false)
            messageController.setSubject(emailTitle)
            
            self.presentViewController(messageController, animated: true, completion: nil)
        } else {
            println("Fail to send email!")
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        switch result.value {
            
        case MFMailComposeResultCancelled.value:
            println("Mail Cancelled")
        case MFMailComposeResultSaved.value:
            println("Mail Saved")
        case MFMailComposeResultSent.value:
            println("Mail Sent")
        case MFMailComposeResultFailed.value:
            println("Mail Failed")
        default:
            break
            
        }
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    @IBAction func makeCall(){
        let phone = String(format: "tel://%@", dados[tableIndex].objectAtIndex(8) as! String)
        let phoneFormated = NSURL(string: phone)
        UIApplication.sharedApplication().openURL(phoneFormated!)
        
    }
    
    
//    func sendEmail(email: String){
//        let formatedEmail = String(format: ", arguments: <#[CVarArgType]#>)
//        let emailUrl = NSURL(string: (email as NSString).stringfo)
//        UIApplication.sharedApplication().openURL(emailUrl!)
//    }
    
    /*  Nos temos um pino no mapa, fazer o zoom centralizar o mapa  */
    func setCenterOfMapToLoacation(location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func addPinToMapView(){
    
        let annotation = Artwork(title: self.titlePin, locationName: self.subTitlePin, coordinate: self.coordinatePin)
        
        mapView.addAnnotation(annotation)
        
        /*  Centralizar o Mapa ao redor do pino */
        setCenterOfMapToLoacation(self.coordinatePin)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let path = NSBundle.mainBundle().pathForResource("Atores", ofType: "plist")
        
        let dictionary = NSDictionary(contentsOfFile: path!)
        
        self.dados = dictionary?.objectForKey("atores") as! [NSArray]
        
        self.titlePin = dados[self.tableIndex].objectAtIndex(0) as? String
        self.nameLabel.text = self.titlePin
        self.subTitlePin = dados[self.tableIndex].objectAtIndex(1) as? String
        self.siglaLabel.text = self.subTitlePin
        self.competencyTextView.text = dados[self.tableIndex].objectAtIndex(2) as? String
        self.missionLabel.text = dados[self.tableIndex].objectAtIndex(3) as? String
        self.addressLabel.text = dados[self.tableIndex].objectAtIndex(4) as? String
        //        self.phoneLabel.text = dados[self.tableIndex].objectAtIndex(0) as? String
        self.emailButton.setTitle(dados[self.tableIndex].objectAtIndex(5) as? String, forState: .Normal)
        
        self.latPin = (self.dados[self.tableIndex].objectAtIndex(6) as! NSString).doubleValue
        self.lonPin = (self.dados[self.tableIndex].objectAtIndex(7) as! NSString).doubleValue
        self.coordinatePin = CLLocationCoordinate2D(latitude: self.latPin, longitude: self.lonPin)
        
        self.phonrButton.setTitle(dados[tableIndex].objectAtIndex(8) as? String, forState: .Normal)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
        
        addPinToMapView()
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
