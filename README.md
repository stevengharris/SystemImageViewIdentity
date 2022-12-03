# SystemImageViewIdentity

An Xcode project that demonstrates a SwiftUI issue with .plain and .bordered buttons containing a system image. Open the
SystemImageViewIdentify.xcodeproj in Xcode. This is a fresh Xcode 14 iOS project, with all code jammed into ContentView.swift
for convenience.

The "magnifyingglass" image is used in a button both in the HeaderView and in a hidden search view that is part of the HeaderView.
When you press the button in the HeaderView, it toggles the Searchbar off and on. When it does that, it causes the button in the 
HeaderView to be updated and repositioned. This weird behavior can be eliminated by adding a UUID id to the image itself in the 
HeaderView.

By default, the UUID is not added, so you should see the weird jumpy behavior. By toggling ON, the button is created with a UUID id, 
and the behavior is smooth. The "trash" image in the header never sees any problems and doesn't move, presumably because it does not 
also exist in the Searchbar, like the "magnifyingglass" does.

The screenshot below shows the demo. Deploy and select the magnifyingglass button/image to show the Searchbar. Watch the magnifyingglass as it 
jumps downward as the Searchbar appears. Note the trash button/image does not move. Now turn on the Toggle at the top. The list contents refresh, 
but the magnifyingglass button/images are created with .id(UUID()). Now hiding/showing the Searchbase does not cause the weird jumpy behavior 
of the magnifyingglass button in the HeaderView.

The buttons are created with .buttonStyle(.plain). A similar problem appears with .buttonsStyle(.bordered). It doesn't seem to be a problem with 
the default buttonStyle; however, using .plain was the only way I was able to detect the button press when I enable a tap gesture in the ListItem, 
which is something I need in my app (detecting taps in the button as well as the list item).

<img src="https://user-images.githubusercontent.com/1020361/205408449-8e1110c3-a8c4-4148-97a9-cbd6fbb57d93.png" alt="Screenshot" width="400"/>
