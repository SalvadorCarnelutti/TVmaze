//
//  HomeRouter.swift
//  TVmaze
//
//  Created by Salvador on 12/18/21.
//

protocol PresenterToRouterHomeProtocol: AnyObject {
    func routeToSeriesDetail(homeEntity: HomeEntity)
}

final class HomeRouter: PresenterToRouterHomeProtocol  {
    func routeToSeriesDetail(homeEntity: HomeEntity) {
    }
}
