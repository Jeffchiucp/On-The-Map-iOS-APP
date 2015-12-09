//
//  OTMPostingViewController.swift
//  OnTheMap
//
//  Created by Jeff Chiu on 12/04/15.
//  Copyright (c) 2015 Jeff Chiu. All rights reserved.
//

import UIKit
import MapKit

// MARK: OTMPostingViewController: UIViewController

class OTMPostingViewController: UIViewController {
    
    // MARK: LoginState
    
    private enum PostingState { case MapString, MediaURL }
    
    // MARK: Properties
    
    private let otmDataSource = OTMDataSource.sharedDataSource()
    private let parseClient = ParseClient.sharedClient()
    private var placemark: CLPlacemark? = nil
    var objectID: String? = nil
    
    // MARK: Outlets
    
    @IBOutlet weak var postingMapView: MKMapView!
    @IBOutlet weak var studyingLabel: UILabel!
    @IBOutlet weak var topSectionView: UIView!
    @IBOutlet weak var middleSectionView: UIView!
    @IBOutlet weak var bottomSectionView: UIView!
    @IBOutlet weak var mapStringTextField: UITextField!
    @IBOutlet weak var mediaURLTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var findButton: BorderedButton!
    @IBOutlet weak var submitButton: BorderedButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI(.MapString)
    }
    
    // MARK: Actions
    
    @IBAction func cancel(sender: AnyObject) {
        dismissController()
    }
    
    @IBAction func findOnTheMap(sender: AnyObject) {
        
        // check for empty string
        if mapStringTextField.text!.isEmpty {
            displayAlert(AppConstants.Errors.MapStringEmpty)
            return
        }
        
        // start activity indicator
        startActivity()
        
        // add placemark
        let delayInSeconds = 1.5
        let delay = delayInSeconds * Double(NSEC_PER_SEC)
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(popTime, dispatch_get_main_queue(), {
            let geocoder = CLGeocoder()
            do {
                geocoder.geocodeAddressString(self.mapStringTextField.text!, completionHandler: { (results, error) in
                    if let _ = error {
                        self.displayAlert(AppConstants.Errors.CouldNotGeocode)
                    }
                    else if (results!.isEmpty){
                        self.displayAlert(AppConstants.Errors.NoLocationFound)
                    } else {
                        self.placemark = results![0]
                        self.configureUI(.MediaURL)
                        self.postingMapView.showAnnotations([MKPlacemark(placemark: self.placemark!)], animated: true)
                    }
                })
            }
        })
    }
    
    @IBAction func submitStudentLocation(sender: AnyObject) {
        
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        // check for empty string
        if mediaURLTextField.text!.isEmpty {
            displayAlert(AppConstants.Errors.URLEmpty)
            return
        }
        
        // check if student and placemark initialized
        guard let student = otmDataSource.currentStudent,
            let placemark = placemark,
            let postedLocation = placemark.location else {
                displayAlert(AppConstants.Errors.StudentAndPlacemarkEmpty)
                return
        }
        
        // define request handler
        let handleRequest: ((NSError?, String) -> Void) = { (error, mediaURL) in
            if let _ = error {
                self.displayAlert(AppConstants.Errors.PostStudentLocationFailed) { (alert) in
                    self.dismissController()
                }
            } else {
                self.otmDataSource.currentStudent!.mediaURL = mediaURL
                self.otmDataSource.refreshStudentLocations()
                self.dismissController()
            }
        }
        
        // init new values
        let location = Location(latitude: postedLocation.coordinate.latitude, longitude: postedLocation.coordinate.longitude, mapString: mapStringTextField.text!)
        let mediaURL = mediaURLTextField.text!
            
        if let objectID = objectID {
            parseClient.updateStudentLocationWithObjectID(objectID, mediaURL: mediaURL, studentLocation: StudentLocation(objectID: objectID, student: student, location: location)) { (success, error) in
                handleRequest(error, mediaURL)
            }
        } else {
            parseClient.postStudentLocation(mediaURL, studentLocation: StudentLocation(objectID: "", student: student, location: location)) { (success, error) in
                handleRequest(error, mediaURL)
            }
        }
    }
    
    @IBAction func userDidTapView(sender: AnyObject) {
        resignIfFirstResponder(mapStringTextField)
        resignIfFirstResponder(mediaURLTextField)
    }
    
    // MARK: Display Alert
    
    private func displayAlert(message: String, completionHandler: ((UIAlertAction) -> Void)? = nil) {
        dispatch_async(dispatch_get_main_queue()) {
            self.stopActivity()
            let alert = UIAlertController(title: "", message: message, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: AppConstants.AlertActions.Dismiss, style: .Default, handler: completionHandler))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: Configure UI
    
    private func dismissController() {
        if let presentingViewController = presentingViewController {
            presentingViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    private func resignIfFirstResponder(textField: UITextField) {
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
    }
    
    private func setupUI() {
        studyingLabel.textColor = AppConstants.UI.OTMBlueColor
        findButton.setTitleColor(AppConstants.UI.OTMBlueColor, forState: .Normal)
        submitButton.setTitleColor(AppConstants.UI.OTMBlueColor, forState: .Normal)
        
        mapStringTextField.delegate = self
        mediaURLTextField.delegate = self
        
        activityIndicator.hidden = true
        activityIndicator.stopAnimating()
    }
    
    private func configureUI(state: PostingState, location: CLLocationCoordinate2D? = nil) {
        stopActivity()
        
        UIView.animateWithDuration(1.0) {
            switch(state) {
            case .MapString:
                self.topSectionView.backgroundColor = AppConstants.UI.OTMGreyColor
                self.middleSectionView.backgroundColor = AppConstants.UI.OTMBlueColor
                self.bottomSectionView.backgroundColor = AppConstants.UI.OTMGreyColor
                self.mediaURLTextField.hidden = true
                self.mapStringTextField.hidden = false
                self.cancelButton.setTitleColor(AppConstants.UI.OTMBlueColor, forState: .Normal)
                self.submitButton.hidden = true
                self.studyingLabel.hidden = false
            case .MediaURL:
                if let location = location {
                    self.postingMapView.centerCoordinate = location
                }
                self.topSectionView.backgroundColor = AppConstants.UI.OTMBlueColor
                self.middleSectionView.backgroundColor = UIColor.clearColor()
                self.bottomSectionView.backgroundColor = AppConstants.UI.OTMBlueColor
                self.mediaURLTextField.hidden = false
                self.mapStringTextField.hidden = true
                self.cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                self.findButton.hidden = true
                self.submitButton.hidden = false
                self.studyingLabel.hidden = true
            }
        }
    }
    
    // MARK: Configure UI (Activity)    
    
    private func startActivity() {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        setFindingUIEnabled(false)
        setFindingUIAlpha(0.5)
    }
    
    private func stopActivity() {
        activityIndicator.hidden = true
        activityIndicator.stopAnimating()
        setFindingUIEnabled(true)
        setFindingUIAlpha(1.0)
    }
    
    private func setFindingUIEnabled(enabled: Bool) {
        mapStringTextField.enabled = enabled
        findButton.enabled = enabled
        cancelButton.enabled = enabled
        studyingLabel.enabled = enabled
    }
    
    private func setFindingUIAlpha(alpha: CGFloat) {
        mapStringTextField.alpha = alpha
        findButton.alpha = alpha
        cancelButton.alpha = alpha
        studyingLabel.alpha = alpha
    }
}

// MARK: - OTMPostingViewController: UITextFieldDelegate

extension OTMPostingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}