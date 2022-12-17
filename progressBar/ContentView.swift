//
//  ContentView.swift
//  progressBar
//
//  Created by Jacob on 10/29/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading = true
    @State private var containerHeight: CGFloat = 0
    @State private var progressTitle: String = ""
    @State private var progress: Int = 0
    
    var maxHeight: Double {
        return min(Double(progress), containerHeight)
    }
    
    var body: some View {
        ZStack {
            if isLoading {
                HStack {
                    ZStack(alignment: .bottom) {
                        GeometryReader { geo in
                            RoundedRectangle(cornerRadius: 0)
                                .onAppear {
                                    containerHeight = geo.size.height
                                }
                        }
                        .foregroundColor(.clear)
                        .background(.linearGradient(colors: [.teal, .white], startPoint: .bottom, endPoint: .top))
                        
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 0)
                                .foregroundColor(.clear)
                                .background(.linearGradient(colors: [.indigo, .teal], startPoint: .bottom, endPoint: .top))
                                .frame(
                                    minWidth: 0,
                                    maxWidth: .infinity,
                                    minHeight: maxHeight
                                )
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text("\(progressTitle)")
                                .monospaced()
                                .foregroundColor(.white)
                                .padding()
                                .background(.clear)
                                .font(.largeTitle)
                        }
                    }
                    .onAppear {
                        progressTitle = "\(progress)%"
                        progress = 0
                        
                        Task {
                            for i in 1 ... 100 {
                                try await Task.sleep(until: .now.advanced(by: .milliseconds(30)), clock: .continuous)
                                progressTitle = "\(i)%"
                                withAnimation {
                                    progress = Int(Double(containerHeight) / 100 * Double(i))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
