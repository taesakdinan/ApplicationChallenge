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
    @IBOutlet private weak var companyNameLabel: UILabel!
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet private weak var catchPhraseLabel: UILabel!
    
    private var userInfo: User?
    
    class func instantiateViewController(userInfo: User) -> UserInfoDetailViewController {
        let storyboard = UIStoryboard(name: "UserInfoDetailViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserInfoDetailViewController") as! UserInfoDetailViewController
        vc.userInfo = userInfo
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        nameLabel.text = userInfo?.name ?? "-"
        emailLabel.text = userInfo?.email ?? "-"
        phoneLabel.text = userInfo?.phone ?? "-"
        websiteLabel.text = userInfo?.website
        companyNameLabel.text = userInfo?.company?.name ?? "-"
        positionLabel.text = userInfo?.company?.bs ?? "-"
        let catchPhrase = userInfo?.company?.catchPhrase ?? "-"
        catchPhraseLabel.text = "\"\(catchPhrase)\""
        setupAddress(address: userInfo?.address)
    }
    
    private func setupAddress(address: Address?) {
        guard let address = address else { return }
        let suite = address.suite ?? "-"
        let street = address.street ?? "-"
        let city = address.city ?? "-"
        let zipcode = address.zipcode ?? "-"
        addressLabel.text = "\(suite), st. \(street), \(city) city, \(zipcode)"
    }
}
