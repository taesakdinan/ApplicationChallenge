//
//  DetailPresenter.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 21/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailPresentationLogic {
    func presentSomething(response: Detail.Something.Response)
}

class DetailPresenter: DetailPresentationLogic {
    weak var viewController: DetailDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Detail.Something.Response) {
        let viewModel = Detail.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}