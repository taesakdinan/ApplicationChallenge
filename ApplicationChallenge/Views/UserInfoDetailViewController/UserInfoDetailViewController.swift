//
//  UserInfoDetailViewController.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 22/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import UIKit

final class UserInfoDetailViewController: UIViewController {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var companyName: UILabel!
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet private weak var catchPhrase: UILabel!
    @IBOutlet private weak var locationButton: UIButton!
    
    class func instantiateViewController() -> UserInfoDetailViewController {
        let storyboard = UIStoryboard(name: "UserInfoDetailViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserInfoDetailViewController") as! UserInfoDetailViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup() {
    }
}
