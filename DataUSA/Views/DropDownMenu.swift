//
//  DropdownMenu.swift
//  DataUSA
//
//  Created by Tiago Antunes on 16/10/2024.
//

import SwiftUI

struct DropDownMenu: View {

    enum Constants {
        static let year = "Year"
    }

    var years: [String] = []
    @Binding var selectedYear: String

    var body: some View {
        VStack {
            Picker(Constants.year, selection: $selectedYear) {
                ForEach(years, id: \.self) { year in
                    Text(year)
                }
            }
        }
    }
}
