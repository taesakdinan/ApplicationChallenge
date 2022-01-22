//
//  DetailInteractor.swift
//  ApplicationChallenge
//
//  Created by Sakdinan Sukkhasem on 21/1/22.
//  Copyright (c) 2022 Sakdinan. All rights reserved.
//
import Foundation

protocol DetailBusinessLogic {
    func doSomething(request: Detail.Something.Request)
}

protocol DetailDataStore {
//    var name: String { get set }
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore {
    var presenter: DetailPresentationLogic?
    var worker: DetailWorker?
//    var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Detail.Something.Request) {
        worker = DetailWorker()
        worker?.doSomeWork()
        
        let response = Detail.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
