//
//  ContentView.swift
//  SystemImageViewIdentity
//
//  Created by Steven Harris on 12/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var uuidSetting = UUIDSetting(false)
    
    var body: some View {
        let _ = Self._printChanges()
        VStack(alignment: .leading) {
            Toggle("Use UUID on Header Image", isOn: $uuidSetting.uuid)
                .fixedSize()
                .padding(.horizontal)
            Text(
"""
The toggle above controls whether the magnifyingglass image in the HeaderViews below are created with a UUID id or not. When on, pressing the magnifyingglass button in the header works smoothly. When off, the button/image jumps as it is repositioned by SwiftUI when the Searchbar is shown/hidden.

The problem only appears to occur with non-default buttonStyle. Specifically, .plain shows a problem, as does .bordered (altho in that case, the background jumps around while the magnifyingglass stays still even without the UUID).
"""
            )
            .padding(.horizontal)
            Spacer()
            List {
                ForEach(0..<3, id:\.self) { item in
                    ListItem(item: item)
                }
            }
            .listStyle(PlainListStyle())
        }
        .environmentObject(uuidSetting)
        // See notes above about buttonStyle.
        .buttonStyle(.plain)
    }
}

class UUIDSetting: ObservableObject {
    @Published var uuid: Bool = true
    
    init(_ uuid: Bool) {
        self.uuid = uuid
    }
}

struct ListItem: View {
    
    var item: Int
    
    var body: some View {
        let _ = Self._printChanges()
        VStack {
            HeaderView(item: item)
            Spacer()
            BodyView(item: item)
        }
        .listRowBackground(Color(UIColor.lightGray))
    }
}

struct HeaderView: View {
    
    var item: Int
    @State var showSearchbar: Bool = false
    @EnvironmentObject var uuidSetting: UUIDSetting
    
    var body: some View {
        let _ = Self._printChanges()
        VStack {
            HStack(alignment: .center) {
                Text("HeaderView \(item)")
                Spacer()
                Button {
                    showSearchbar.toggle()
                } label: {
                    if uuidSetting.uuid {
                        Image(systemName: "magnifyingglass").id(UUID())
                    } else {
                        Image(systemName: "magnifyingglass")
                    }
                }
                Button {
                    // Do nothing
                } label: {
                    Image(systemName: "trash")
                }
            }
            if showSearchbar {
                Searchbar(showSearchbar: $showSearchbar)
            }
        }
    }
}

struct BodyView: View {
    
    var item: Int
    
    var body: some View {
        let _ = Self._printChanges()
        Text("BodyView \(item)")
    }
}

struct Searchbar: View {
    static var arrowDimension: CGFloat = 12
    @State var searchString: String = ""
    @Binding var showSearchbar: Bool
    @State var placeholder: String = "Search"
    @FocusState var searchIsFocused: Bool
    
    var body: some View {
        let _ = Self._printChanges()
        HStack(spacing: 4) {
            HStack(spacing: 4) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField(placeholder, text: $searchString)
                    .padding(2)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .onSubmit { search() }
                    .focused($searchIsFocused)
                if (!searchString.isEmpty) {
                    Button(action: {
                        cancelSearch()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                    })
                    .foregroundColor(.gray)
                }
            }
            .background(Color(.systemBackground))
            .cornerRadius(6)
        }
        .fixedSize(horizontal: false, vertical: true)
        .onAppear {
            searchIsFocused = true
        }
        .onDisappear {
            showSearchbar = false
        }
        
    }
    
    private func search() {
        print("Search now")
    }
    
    private func cancelSearch() {
        searchString = ""
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
