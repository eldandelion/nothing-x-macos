//
//  SwitchInEarDetectionUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/3.
//

import Foundation

class SwitchInEarDetectionUseCase : SwitchInEarDetectionUseCaseProtocol {
    
    private let nothingService: NothingService
    
    init(nothingService: NothingService) {
        self.nothingService = nothingService
    }
    
    func switchInEarDetection(mode: Bool) {
        nothingService.switchInEarDetection(mode: mode)
    }
    
}
