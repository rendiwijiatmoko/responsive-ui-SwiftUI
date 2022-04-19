//
//  ResponsiveView.swift
//  ResponsiveUI
//
//  Created by Rendi Wijiatmoko on 19/04/22.
//

import SwiftUI

// MARK: Custom View which will return the property of the view
struct ResponsiveView<Content: View>: View {
    // returning properties
    var content: (Properties) ->Content
    var body: some View {
        GeometryReader{ proxy in
            let size = proxy.size
            let isLandscape = (size.width > size.height)
            let isiPad = UIDevice.current.userInterfaceIdiom == .pad
            
            content(Properties(isLandscape: isLandscape, isiPad: isiPad, isSplit: isSplit(), size: size))
                .frame(width: size.width, height: size.height, alignment: .center)
                .onAppear{
                    // updating fraction on initial
                    updateFraction(fraction: isLandscape && !isSplit() ? 0.3 : 0.5)
                }
                .onChange(of: isSplit()) { newValue in
                    updateFraction(fraction: isLandscape && !isSplit() ? 0.3 : 0.5)
                }
                .onChange(of: isLandscape) { newValue in
                    updateFraction(fraction: newValue  && !isSplit() ? 0.3 : 0.5)
                }
        }
    }
    
    // Solving UI for Split Apps
    func isSplit ()->Bool {
        // Easy way to find
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return false
        }
        
        return screen.windows.first?.frame.size != UIScreen.main.bounds.size
    }
    
    func updateFraction(fraction: Double) {
        NotificationCenter.default.post(name: NSNotification.Name("UPDATEFRACTION"), object: nil, userInfo: [
            "fraction" : fraction
        ])
    }
}

struct Properties{
    var isLandscape: Bool
    var isiPad: Bool
    var isSplit: Bool
    var size: CGSize
}
