import SwiftUI
import AVFoundation
import UserNotifications

struct AlarmListView: View {
    @EnvironmentObject var alarmManager: AlarmManager
    @State private var selectedChuuba: Chuuba?
    @State private var showingChooseVT = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(alarmManager.alarms) { alarm in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(alarm.time, style: .date)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(alarm.time, style: .time)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text(alarm.chuuba.name)
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                            Button(action: { alarmManager.deleteAlarmById(alarm.id) }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .clipShape(Circle())
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 2)
                    }
                    .onDelete(perform: alarmManager.deleteAlarm)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Alarms")
            .toolbar {
                Button(action: { showingChooseVT = true }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                }
            }
            .sheet(isPresented: $showingChooseVT) {
                ChooseVT { chuuba in
                    selectedChuuba = chuuba
                    showingChooseVT = false
                }
            }
            .sheet(item: $selectedChuuba) { chuuba in
                AlarmCustomiserView(selected: chuuba, onConfirm: { time in
                    alarmManager.addAlarm(time: time, chuuba: chuuba)
                    selectedChuuba = nil
                }, clearSelection: {
                    selectedChuuba = nil
                })
            }
        }
    }
}

struct TabbedContentView: View {
    var body: some View {
        TabView {
            AlarmListView()
                .tabItem {
                    Label("Alarms", systemImage: "alarm.fill")
                }
        }
        .environmentObject(AlarmManager())
    }
}
