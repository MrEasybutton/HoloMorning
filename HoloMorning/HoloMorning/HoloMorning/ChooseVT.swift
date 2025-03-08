import SwiftUI

struct ChooseVT: View {
    let onSelected: (Chuuba) -> Void
    let columns = [
        GridItem(.fixed(120)),
        GridItem(.fixed(120)),
        GridItem(.fixed(120))
    ]
    
    var body: some View {
        ScrollView {
            Grid(alignment: .center) {
                Image("holo")
                    .resizable()
                    .frame(width:288, height:117, alignment: .center)
            }
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(chuubas) { chuuba in
                    GridView(chuuba: chuuba)
                        .onTapGesture { onSelected(chuuba) }
                }
            }
            .padding()
        }
        .background(Color.cyan.opacity(0.4))
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
        .border(Color.cyan)
        .cornerRadius(4)
        .padding(8)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}
