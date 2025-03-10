//
//  StopNothingDiscoveryUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/10.
//

import Foundation

class StopNothingDiscoveryUseCase : StopNothingDiscoveryUseCaseProtocol {
    
    
    private let nothingService: NothingService
    
    init(nothingService: NothingService) {
        self.nothingService = nothingService
    }
    
    func stopNothingDiscovery() {
        nothingService.stopNothingDiscovery()
    }
    
}
