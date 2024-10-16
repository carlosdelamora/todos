//
//  ScrollableList.swift
//  TodosChallenge
//
//  Created by Carlos De la mora on 10/13/24.
//

import SwiftUI

struct ScrollableList: View {
    var ids: [UUID]
    @State private var scrollPosition = ScrollPosition(edge: .top)
    @State var proxy: ScrollViewProxy?
    @State var width: CGFloat = 0
    var body: some View {
        VStack {
            Button("Scroll bottom") {
                withAnimation {
                    proxy?.scrollTo("bottom_id")
                }
            }

            ScrollViewReader { proxy in
                List {
                    ForEach(ids, id: \.self) {
                        Text($0.uuidString)
                            .frame(height: 40)
                    }
                    
                    Color.clear.frame(height: 1)
                        .id("bottom_id")
                }
                .onAppear {
                    self.proxy = proxy
                }
            }
        }
    }
}


#Preview {
    ScrollableList(ids: (0..<30).map({ _ in UUID() }))
}
