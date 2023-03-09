//
//  ERLocationViewModel.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 9/3/23.
//

import Foundation

protocol ERLocationViewModelDelegate: AnyObject {
    func didFecthInitialLocation()
}

final class ERLocationViewModel {
    
    weak var delegate: ERLocationViewModelDelegate?
    
    private var locations: [ERLocation] = []
    
    private var apiInfo: ERGetAllLocationsResponse.Info?
    
    private var cellViewModels: [String] = []
    
    init() {
        
    }
    
    public func fetchLocations() {
        ERService.shared.execute(
            .listLocationsRequest,
            expecting: ERGetAllLocationsResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let success):
                self?.apiInfo = success.info
                self?.locations = success.results
                DispatchQueue.main.async {
                    self?.delegate?.didFecthInitialLocation()
                }                
                break
            case .failure(let failure):
                break
            }
        }
    }
    
    private var hasMoreResult: Bool {
        return false
    }
}
