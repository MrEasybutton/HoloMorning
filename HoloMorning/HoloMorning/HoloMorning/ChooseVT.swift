import SwiftUI

struct ChooseVT: View {
    let onSelected: (Chuuba) -> Void
    let groupedChuubas = Dictionary(grouping: chuubas, by: { $0.gen })
    let sortedGens = ["Myth", "Project: HOPE", "Council", "Advent"]
    let columns = [GridItem(.adaptive(minimum: 120))]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image("holo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .padding(.top)
                
                ForEach(sortedGens, id: \ .self) { gen in
                    if let chuubaList = groupedChuubas[gen] {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(gen)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(8)
                            
                            LazyVGrid(columns: columns, spacing: 12) {
                                ForEach(chuubaList) { chuuba in
                                    GridView(chuuba: chuuba)
                                        .onTapGesture { onSelected(chuuba) }
                                        .animation(.spring(), value: chuuba.id)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.cyan.opacity(0.5), Color.blue.opacity(0.3)]), startPoint: .top, endPoint: .bottom))
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
                .shadow(radius: 4)
                .padding(4)
            
            Text(chuuba.name)
                .font(.caption)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
        .frame(width: 120, height: 160)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.blue, lineWidth: 1))
        .padding(6)
    }
}
