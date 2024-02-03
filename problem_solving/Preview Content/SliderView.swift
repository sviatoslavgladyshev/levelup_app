//
//  SliderView.swift
//  problem_solving
//
//  Created by Britt Bauer Burney on 12/18/23.
//

import SwiftUI
import Firebase

struct SliderView: View {
    @State private var slider1Value: Double = 0.0
    @State private var slider2Value: Double = 0.0
    @State private var slider3Value: Double = 0.0
    @State private var slider4Value: Double = 0.0
    @State private var slider5Value: Double = 0.0

    var body: some View {
        VStack {
            Text("What are your characteristics?")
                .font(.system(size: 24))
                .bold()
        }
       
        CustomHeightSpacer(height: 10)
      
        VStack {
            Slider(value: $slider1Value, in: 0...1, step: 0.001)
            Text("Adventurous: \(slider1Value.formattedPercentage)")

            Slider(value: $slider2Value, in: 0...1, step: 0.001)
            Text("Creative: \(slider2Value.formattedPercentage)")

            Slider(value: $slider3Value, in: 0...1, step: 0.001)
            Text("Compassionate: \(slider3Value.formattedPercentage)")

            Slider(value: $slider4Value, in: 0...1, step: 0.001)
            Text("Independent: \(slider4Value.formattedPercentage)")

            Slider(value: $slider5Value, in: 0...1, step: 0.001)
            Text("Organized: \(slider5Value.formattedPercentage)")
        }
        .padding()
        
        CustomHeightSpacer(height: 10)
        
        Button() {
          //  addData()
        } label: {
            Text("Next")
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(width: 320)
                .background(Color(.purple))
                .font(.title2)
                .cornerRadius(20)
        }
    }
}

extension Double {
    var formattedPercentage: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

#Preview {
    SliderView()
}
