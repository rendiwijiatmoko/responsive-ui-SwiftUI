//
//  DetailView.swift
//  ResponsiveUI
//
//  Created by Rendi Wijiatmoko on 19/04/22.
//

import SwiftUI

struct DetailView: View {
    var user: User
    var prop: Properties
    
    // Dismissing View
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    
                    // Hiding it from ipad
                    .opacity(prop.isLandscape || !prop.isSplit ? (prop.isiPad ? 0 : 1) : 1)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "trash")
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                }
                
                Divider()
                
                HStack(spacing: 15) {
                    Image(user.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 55)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 6) {
                            Text(user.name)
                                .fontWeight(.semibold)
                            if prop.isiPad {
                                Text("<rendiwijiatmoko2@gmail.com>")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        if !prop.isiPad {
                            Text("<rendiwijiatmoko2@gmail.com>")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Text(user.title)
                            .font(.title3.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Now")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                // Dummy Test
                Text("""
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
""")
                .multilineTextAlignment(.leading)
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
