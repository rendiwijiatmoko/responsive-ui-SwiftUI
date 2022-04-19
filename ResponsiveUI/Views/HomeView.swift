//
//  HomeView.swift
//  ResponsiveUI
//
//  Created by Rendi Wijiatmoko on 19/04/22.
//

import SwiftUI

struct HomeView: View {
    @State var currentMenu: String = "Inbox"
    @State var showMenu: Bool = false
    @State var excessPadding: CGFloat = 0
    
    // Color highlighting Current Link
    @State var navigationTag: String?
    var body: some View {
        ResponsiveView { prop in
            HStack(spacing: 0) {
                if (prop.isLandscape && !prop.isSplit) {
                    SideBarView(currentMenu: $currentMenu, prop: prop)
                }
                
                // MARK: Main View
                NavigationView {
                    MainView(prop: prop )
                        .navigationBarHidden(true)
                        .padding(.leading,  prop.isiPad && prop.isLandscape ? excessPadding : 0)
                }
                .modifier(PaddingModifier(padding: $excessPadding, props: prop))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                ZStack(alignment: .leading) {
                    if !prop.isLandscape || prop.isSplit {
                        Color.black
                            .opacity(showMenu ? 0.25 : 0)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    showMenu.toggle()
                                }
                            }
                        SideBarView(currentMenu: $currentMenu, prop: prop)
                            .offset(x: showMenu ? 0 : -300)
                    }
                }
            }
        }
        .ignoresSafeArea(.container, edges: .leading)
    }
    // MARK: Main View
    @ViewBuilder
    func MainView(prop: Properties)->some View {
        VStack(spacing:0){
            
            // MARK: Search bar
            HStack(spacing: 12) {
                if !prop.isLandscape || prop.isSplit{
                    Button {
                        withAnimation {
                            showMenu.toggle()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                }
                
                TextField("Search", text: .constant(""))
                
                Image(systemName: "magnifyingglass")
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background{
                RoundedRectangle(cornerRadius: 6)
                    .fill(.white)
            }
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 15) {
                    ForEach(users) { user in
                        NavigationLink(tag: user.id, selection: $navigationTag) {
                            DetailView(user: user, prop: prop)
                        } label: {
                            UserCardView(user: user, prop: prop)
                        }
                    }
                }
                .padding(.top, 30)
            }
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .background{
            Color("BG")
                .ignoresSafeArea()
        }
    }
    
    // MARK: User Card View
    @ViewBuilder
    func UserCardView(user: User, prop: Properties)->some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Image(user.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(user.name)
                        .fontWeight(.bold)
                    
                    Text(user.title)
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(navigationTag == user.id && prop.isiPad ? .white : .black)
                Text("Now")
                    .font(.caption)
                    .foregroundColor(navigationTag == user.id && prop.isiPad ? .white : .gray)
            }
            
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s")
                .font(.caption)
                .foregroundColor(navigationTag == user.id && prop.isiPad ? .white : .gray)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(navigationTag == user.id && prop.isiPad ? Color("DarkBlue") : Color("LightWhite"))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
