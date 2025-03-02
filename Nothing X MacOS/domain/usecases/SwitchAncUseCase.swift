//
//  SwitchAncUseCase.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/28.
//

import Foundation


class SwitchAncUseCase : SwitchAncUseCaseProtocol {
    
    private let service: NothingService
    
    init(service: NothingService) {
        self.service = service
    }
    
    func switchANC(mode: ANC) {
        service.switchANC(mode: mode)
    }
    
    
}
