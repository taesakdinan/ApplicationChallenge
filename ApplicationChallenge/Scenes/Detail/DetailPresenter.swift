//
//  DetailPresenter.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 21/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
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
