//
//  Destination.swift
//  Nothing X MacOS
//
//  Created by Arunavo Ray on 21/02/23.
//

import Foundation


enum Destination: String, CaseIterable, Hashable {
    case home = "home"
    case equalizer = "equalizer"
    case controls = "controls"
    case controlsTripleTap = "controlsTripleTap"
    case controlsTapHold = "controlsTapHold"
    case settings = "settings"
    case findMyBuds = "findMyBuds"
    case connect = "connect"
    case discover = "discover"
    case discover_started = "discover_started"
    case bluetooth_off = "bluetooth_off"
}
