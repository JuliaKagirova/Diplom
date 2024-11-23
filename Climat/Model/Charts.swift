//
//  Charts.swift
//  Climat
//
//  Created by Юлия Кагирова on 22.11.2024.
//

import UIKit
import Charts
import SwiftUI

struct ChartsView: View {
    @ObservedObject var viewModel: ChartsViewModel
    
    init(viewModel: ChartsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Chart(viewModel.tempModels) { tempModel in
            LineMark(
                x: .value("Time", tempModel.time),
                y: .value("Temperature", tempModel.temp)
            )
            .interpolationMethod(.cardinal)
            .foregroundStyle(.red)
            
            PointMark(
                x: .value("Time", tempModel.time),
                y: .value("Temperature", tempModel.temp)
            )
            .foregroundStyle(.black)
            .symbolSize(10)
        }
        .chartYAxisLabel(position: .topLeading, alignment: .leading, spacing: 10) {
            Text("°")
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartXAxisLabel {
            Text("Time")
        }
        .chartScrollableAxes(.horizontal)
    }
}
