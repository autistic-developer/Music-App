//
//  SelectedTrackPreferenceKey.swift
//  MusicApp
//
//  Created by Lalit Vinde on 01/10/23.
//

import Foundation

import SwiftUI


struct SelectedTrackPreferenceKey: PreferenceKey {
    static var defaultValue: Track? = nil

    static func reduce(value: inout Track?, nextValue: () -> Track?) {
        value = nextValue()
    }
}
