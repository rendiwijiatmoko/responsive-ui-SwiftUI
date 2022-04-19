//
//  SideBarView.swift
//  ResponsiveUI
//
//  Created by Rendi Wijiatmoko on 19/04/22.
//

import SwiftUI

struct SideBarView: View {
    @Binding var currentMenu: String
    var prop: Properties
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                
                SidebarButton(icon: "tray.and.arrow.down.fill", title: "Inbox")
                SidebarButton(icon: "paperplane", title: "Sent")
                SidebarButton(icon: "doc.fill", title: "Draft")
                SidebarButton(icon: "trash", title: "Delete")
            }
            .padding()
        }
        // MARK: Size
        .frame(width: (prop.isLandscape ? prop.size.width : prop.size.height) / 4 > 300 ? 300 : (prop.isLandscape ? prop.size.width : prop.size.height) / 4)
        .background{
            Color("LightWhite")
                .ignoresSafeArea()
        }
    }
    
    // MARK: SideBar Button
    @ViewBuilder
    func SidebarButton(icon: String, title: String)->some View {
        Button {
            currentMenu = title
        } label: {
            VStack {
                HStack(spacing:10) {
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.black)
                        .opacity(currentMenu == title ? 1 : 0)
                    
                    Image(systemName: icon)
                        .font(.callout)
                        .foregroundColor(currentMenu == title ? Color("DarkBlue") : .gray)
                    Text(title)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(currentMenu == title ? .black : .gray)
                }
                .frame(maxWidth:.infinity, alignment: .leading)
                
                Divider()
            }
        }

    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Fixing it by removing the extra space with the help of negative padding
struct PaddingModifier: ViewModifier {
    @Binding var padding: CGFloat
    var props: Properties
    
    func body(content: Content) -> some View {
        content
            .overlay{
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: PaddingKey.self, value: proxy.frame(in: .global))
                        .onPreferenceChange(PaddingKey.self) { value in
                            self.padding = -(value.minX / 3.3)
                        }
                }
            }
    }
}

// Preference Key
struct PaddingKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
