//
//  StopRingingBudsUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/2.
//

import Foundation
class StopRingingBudsUseCase : StopRingingBudsUseCaseProtocol {
    
    private let nothingService: NothingService
    
    init(nothingService: NothingService) {
        self.nothingService = nothingService
    }
    
    func stopRingingBuds() {
        nothingService.stopRingingBuds()
    }
}
