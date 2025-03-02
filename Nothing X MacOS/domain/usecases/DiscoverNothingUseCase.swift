//
//  DiscoverNothingUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/28.
//

import Foundation

class DiscoverNothingUseCase : DiscoverNothingUseCaseProtocol {
    
    
    private let nothingService: NothingService
    
    init(nothingService: NothingService) {
        self.nothingService = nothingService
    }
    
    func discoverNothing() {
        nothingService.discoverNothing()
    }
    
}
