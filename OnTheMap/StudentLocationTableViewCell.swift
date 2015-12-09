//
//  StudentLocationTableViewCell.swift
//  OnTheMap
//  Created by Jeff Chiu on 12/04/15.
//  Copyright (c) 2015 Jeff Chiu. All rights reserved.
//

import UIKit

// MARK: - StudentLocationTableViewCell: UITableViewCell

class StudentLocationTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var pinImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    // Configure UI
    
    func configureWithStudentLocation(studentLocation: StudentLocation) {
        pinImageView.image = UIImage(named: "Pin")
        nameLabel.text = studentLocation.student.fullName
        urlLabel.text = studentLocation.student.mediaURL
    }
}
