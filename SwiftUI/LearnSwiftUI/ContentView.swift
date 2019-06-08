//
//  ContentView.swift
//  LearnSwiftUI
//
//  Created by Matheus Costa on 08/06/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import SwiftUI

struct ContentView : View {

    var posts: [Post] = [
        .init(id: 0, username: "Username", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer sed tempor nibh. Cras convallis justo vel ex egestas varius. Morbi auctor ornare justo, vitae mollis nulla.", imageName: "image-2"),
        .init(id: 1, username: "Username", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer sed tempor nibh. Cras convallis justo vel ex egestas varius. Morbi auctor ornare justo, vitae mollis nulla.", imageName: "image-2")
    ]

    var groups: [Group] = [
        .init(id: 0, text: "Description", imageName: "image-3"),
        .init(id: 1, text: "Description", imageName: "image-3"),
        .init(id: 2, text: "Description", imageName: "image-3"),
        .init(id: 3, text: "Description", imageName: "image-3"),
        .init(id: 4, text: "Description", imageName: "image-3")
    ]

    var body: some View {
        NavigationView {
            List {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Trending")
                        HStack(spacing: 10) {
                            ForEach(groups.identified(by: \.id)) { group in
                                NavigationButton(destination: GroupDetailView(group: group)) {
                                    GroupView(group: group)
                                }
                            }
                        }
                    }
                }.frame(height: 150)

                ForEach(posts.identified(by: \.id)) { post in
                    PostView(post: post)
                }
            }.navigationBarTitle(Text("Groups"))
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
