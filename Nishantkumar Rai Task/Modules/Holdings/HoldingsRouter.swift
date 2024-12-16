//
//  HoldingsRouter.swift
//  Nishantkumar Rai Task
//
//  Created by Nishant Rai on 14/12/24.
//
import UIKit

protocol HoldingsProtocol {}

class HoldingsRouter: HoldingsProtocol {
    static func createHoldingsModule() -> UIViewController {
        let view = HoldingsViewController()
        let presenter = HoldingsPresenter()
        let interactor = HoldingsInteractor(coreDataService: CoreDataService())
        let router = HoldingsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
}
