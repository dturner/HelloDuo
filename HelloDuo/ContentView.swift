//
//  ContentView.swift
//  HelloDuo
//
//  Created by Don Turner on 22/10/2026.
//

import SwiftUI

struct ContentView: View {
    private let info = Bundle.main.infoDictionary ?? [:]

    var body: some View {
        List {
            row("Build SDK", info["DTSDKName"])
            row("Min iOS", info["MinimumOSVersion"])
            row("Orientations", info["UISupportedInterfaceOrientations~iphone"])
            row("Requires full screen", info["UIRequiresFullScreen"])
        }
    }

    private func row(_ label: String, _ value: Any?) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(label)
            Spacer()
            Text(describe(value))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }

    private func describe(_ value: Any?) -> String {
        switch value {
        case nil:
            return "not set"
        case let flag as Bool:
            return flag ? "Yes" : "No"
        case let list as [String]:
            return list
                .map { $0.replacingOccurrences(of: "UIInterfaceOrientation", with: "") }
                .joined(separator: "\n")
        default:
            return "\(value!)"
        }
    }
}

#Preview {
    ContentView()
}
