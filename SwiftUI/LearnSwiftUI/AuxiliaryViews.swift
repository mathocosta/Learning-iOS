//
//  AuxiliaryViews.swift
//  LearnSwiftUI
//
//  Created by Matheus Costa on 08/06/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import SwiftUI

// MARK: - GroupView
struct GroupView: View {
    let group: Group

    var body: some View {
        VStack(alignment: .leading) {
            Image("image-3")
                .renderingMode(.original)
                .resizable()
                .cornerRadius(5)
                .clipped()
            Text("Description")
                .font(.headline)
                .color(.primary)
                .lineLimit(nil)
                .padding(.leading, 0)
            }.frame(width: 100, height: 100)
    }
}

// MARK: - GroupDetailView
struct GroupDetailView: View {
    let group: Group

    var body: some View {
        VStack {
            Image(group.imageName)
            Text(group.text)
        }
    }
}

// MARK: - PostView
struct PostView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image("image-2")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                    .clipped()

                VStack(alignment: .leading, spacing: 4) {
                    Text(post.username).font(.headline)
                    Text("Posted 8 hrs ago").font(.subheadline)
                    }.padding(.leading, 8)
            }.padding(.leading, 16).padding(.top, 16)

            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer sed tempor nibh. Cras convallis justo vel ex egestas varius. Morbi auctor ornare justo, vitae mollis nulla.")
                .lineLimit(nil)
                .padding(.leading, 16)
                .padding(.trailing, 32)

            Image(post.imageName)
                .resizable()
                .frame(height: 200)
                .clipped()
            }.padding(.leading, -20).padding(.trailing, -20)
    }
}
