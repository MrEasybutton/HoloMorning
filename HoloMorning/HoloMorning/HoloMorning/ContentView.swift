import SwiftUI

struct ContentView: View {
    @State private var selected: Chuuba?
    
    var body: some View {
        NavigationStack {
            
            if let selected = selected {
                AlarmCustomiserView(selected: selected, clearSelection: { self.selected = nil })
            } else {
                ChooseVT(onSelected: { oshi in
                    withAnimation { self.selected = oshi }
                })
                .navigationTitle("HoloDB")
            }
        }
        .onAppear { NotificationManager.shared.requestPermission() }
        
    }
}


