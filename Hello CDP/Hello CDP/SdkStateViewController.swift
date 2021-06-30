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

        optInSwitch.isOn = CdpSdk.shared.consent == Consent.optIn
        refreshOutput()
    }
    
    @IBAction func toggleConsent(_ sender: Any) {
        CdpSdk.shared.consent = optInSwitch.isOn ? Consent.optIn : Consent.optOut
        
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
        let profileEvent = Event.profile(eventType: <#T##String#>, attributes: <#T##[String : Any]#>)
        CdpSdk.shared.track(event: <#T##Event#>)
        
        refreshOutput()
    }
    
    @IBAction func sendEngagmentEvent(_ sender: Any) {
        let engagementEvent = Event.engagement(eventType: <#T##String#>, attributes: <#T##[String : Any]#>)
        CdpSdk.shared.track(event: <#T##Event#>)
        
        refreshOutput()
    }
    
    @IBAction func setLocationTracking(_ sender: Any) {
        CdpSdk.shared.setLocation(coordinates: <#T##Coordinates?#>, expiresIn: <#T##Int#>)
        refreshOutput()
    }
    
    func refreshOutput() {
        DispatchQueue.main.async { [weak self] in
            guard let unwrappedSelf = self else { return }
            
            if unwrappedSelf.outputSegmentedControl.selectedSegmentIndex == 0 {
                unwrappedSelf.outputTextView.text = CdpSdk.shared.state
            } else if unwrappedSelf.outputSegmentedControl.selectedSegmentIndex == 1 {
                unwrappedSelf.outputTextView.text = HelloCDPLogOutputter.shared.logMessages.reversed().map{ $0 }.joined(separator: "\n\n---------------------\n\n")
            }
            unwrappedSelf.outputTextView.setContentOffset(.zero, animated: true)
            
        }
    }
    
}
