//
//  ViewController.swift
//  Hello CDP
//
//  Copyright © 2020 Salesforce. All rights reserved.
//

import UIKit
import Cdp
import SFMCSDK
import CoreLocation

class SdkStateViewController: UIViewController {
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    @IBOutlet weak var outputSegmentedControl: UISegmentedControl!
    @IBOutlet var optInSwitch: UISwitch!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var profileEventButton: UIButton!
    @IBOutlet weak var setLocationButton: UIButton!
    @IBOutlet weak var engagmentEventButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        optInSwitch.isOn = SFMCSdk.cdp.getConsent() == Consent.optIn
        //refreshOutput()
    }
    
    @IBAction func toggleConsent(_ sender: Any) {
        let consent = optInSwitch.isOn ? Consent.optIn : Consent.optOut
        SFMCSdk.cdp.setConsent(consent: consent)
        
        refreshOutput()
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        refreshOutput()
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        self.outputTextView.text = nil
        HelloCDPLogOutputter.shared.logMessages = []
    }
    
    @IBAction func sendProfileEvent(_ sender: Any) {
        let profileAttributes = [
          "isAnonymous": "0",
          "firstName": "John",
          "lastName": "Smith",
          "email": "john.smith@domain.com",
          "phoneNumber": "1234567890"
        ]
        SFMCSdk.identity.setProfileAttributes([.cdp: profileAttributes])
        
        refreshOutput()
    }
    
    @IBAction func sendEngagmentEvent(_ sender: Any) {
        // collecting the structured AddToCartEvent
        SFMCSdk.track(event: AddToCartEvent(
            lineItem: LineItem(
                catalogObjectType: "Product",
                catalogObjectId: "product-1",
                quantity: 1,
                price: 20.0,
                currency: "USD",
                // attributes can contain any custom field data
                // as long as the schema is modified to define them
                attributes: [
                    "gift_wrap": false
                ]
            )
        ))
        refreshOutput()
    }
    
    @IBAction func sendCustomEngagmentEvent(_ sender: Any) {
        // collecting an unstructured CustomEvent
        SFMCSdk.track(event: CustomEvent(
            name: "CartAbandonment",
            attributes: [
                "sku": "COFFEE-NTR-06",
                "price": 19.99
            ]
        )!)
        refreshOutput()
    }
    
    @IBAction func setLocationTracking(_ sender: Any) {
        // prepare the coordinates, use the CdpCoordinates wrapper
        let coordinates = CdpCoordinates(latitude: 54.187738, longitude: 15.554440)

        // set the location coordinates and expiration time in seconds
        SFMCSdk.cdp.setLocation(coordinates: coordinates, expiresIn: 60)

        refreshOutput()
    }
    
    func refreshOutput() {
        DispatchQueue.main.async { [weak self] in
            guard let unwrappedSelf = self else { return }
            
            if unwrappedSelf.outputSegmentedControl.selectedSegmentIndex == 0 {
                unwrappedSelf.outputTextView.text = CdpModule.shared.state // SFMCSdk.state()
            } else if unwrappedSelf.outputSegmentedControl.selectedSegmentIndex == 1 {
                unwrappedSelf.outputTextView.text = HelloCDPLogOutputter.shared.logMessages.reversed().map{ $0 }.joined(separator: "\n\n---------------------\n\n")
            }
            unwrappedSelf.outputTextView.setContentOffset(.zero, animated: true)
            
        }
    }
    
}
