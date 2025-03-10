//
//  TripleTapGestureActions.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/7.
//

import Foundation

enum TripleTapGestureActions : UInt8, Codable {
    case SKIP_BACK = 8
    case SKIP_FORWARD = 9
    case VOICE_ASSISTANT = 11
    case NO_EXTRA_ACTION = 1
}
