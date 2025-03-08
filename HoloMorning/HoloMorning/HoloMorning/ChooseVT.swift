import SwiftUI

struct ChooseVT: View {
    let onSelected: (Chuuba) -> Void
    
    let columns = [
        GridItem(.fixed(125)),
        GridItem(.fixed(125)),
        GridItem(.fixed(125))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(chuubas) { chuuba in
                    GridView(chuuba: chuuba)
                        .onTapGesture { onSelected(chuuba) }
                }
            }
            .padding()
        }
    }
}

struct GridView: View {
    let chuuba: Chuuba
    
    var body: some View {
        VStack {
            Image(chuuba.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .cornerRadius(10)
                .shadow(radius: 2)
            
            Text(chuuba.name)
                .font(.caption)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
        .frame(width: 100, height: 160)
        .padding(8)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.2), radius: 8)
    }
}
