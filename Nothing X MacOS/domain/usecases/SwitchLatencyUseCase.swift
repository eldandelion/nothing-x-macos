//
//  SwitchLatencyUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/3.
//

import Foundation

class SwitchLatencyUseCase : SwitchLatencyUseCaseProtocol {
    
    private let nothingService: NothingService
    
    init(nothingService: NothingService) {
        self.nothingService = nothingService
    }
    
    func switchLatency(mode: Bool) {
        nothingService.switchLowLatency(mode: mode)
    }
}
