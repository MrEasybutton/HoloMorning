import SwiftUI

struct ContentView: View {
    @State private var selected: Chuuba?
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack {
            
            if let selected = selected {
                AlarmCustomiserView(selected: selected, clearSelection: { self.selected = nil })                    .navigationTransition(.zoom(sourceID: "zoom", in: namespace))
            } else {
                ChooseVT(onSelected: { oshi in
                    withAnimation { self.selected = oshi }
                })
                .matchedTransitionSource(id: "zoom", in: namespace)
            }
        }
        .onAppear { NotificationManager.shared.requestPermission() }
        
    }
}


