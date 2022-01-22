//
//  PickerDialogViewController.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 21/1/22.
//  Copyright © 2022 Sakdinan. All rights reserved.
//

import UIKit

final class CountryPickerViewController: UIViewController {
    
    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    
    var currentIndexSelected = 0
    var onSelected: ((_ index: Int) -> Void)?
    var dataList: [String] = [] {
        didSet {
            pickerView?.reloadAllComponents()
        }
    }
    private var kAnimateDuration: TimeInterval { 0.33 }
    
    class func instantiateViewController() -> CountryPickerViewController {
        let dialogVC = CountryPickerViewController(nibName: "CountryPickerViewController", bundle: Bundle(for: Self.self))
        dialogVC.providesPresentationContextTransitionStyle = true
        dialogVC.definesPresentationContext = true
        dialogVC.modalPresentationStyle = .overCurrentContext
        dialogVC.modalTransitionStyle = .crossDissolve
        return dialogVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if dataList.count > currentIndexSelected {
            pickerView.selectRow(currentIndexSelected, inComponent: 0, animated: false)
        }
    }
    
    // MARK: - Private methods
    private func setup() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        backgroundView.addGestureRecognizer(tapGesture)
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func dismiss() {
        dismiss(animated: true)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss()
    }
    
    @IBAction private func pressedDoneButton(_ sender: UIButton) {
        onSelected?(currentIndexSelected)
        dismiss()
    }
}
extension CountryPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentIndexSelected = row
    }
}

extension CountryPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
}
