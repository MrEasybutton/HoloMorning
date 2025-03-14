import SwiftUI
import AVFoundation
import UserNotifications

struct Alarm: Identifiable, Codable {
    let id: UUID
    var time: Date
    var chuuba: Chuuba
}

class AlarmManager: ObservableObject {
    @Published var alarms: [Alarm] = [] {
        didSet { saveAlarms() }
    }

    init() {
        loadAlarms()
        removePastAlarms()
    }

    func addAlarm(time: Date, chuuba: Chuuba) {
        let newAlarm = Alarm(id: UUID(), time: time, chuuba: chuuba)
        alarms.append(newAlarm)
        scheduleAlarm(newAlarm)
    }

    func deleteAlarm(at indexSet: IndexSet) {
        for index in indexSet {
            let alarm = alarms[index]
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.id.uuidString])
        }
        alarms.remove(atOffsets: indexSet)
    }

    func deleteAlarmById(_ id: UUID) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
        alarms.removeAll { $0.id == id }
    }

    func scheduleAlarm(_ alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "Wake up!"
        content.body = "\(alarm.chuuba.name) is waking you up!"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("\(alarm.chuuba.voiceClip).mp3"))

        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: alarm.time)
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: notificationTrigger)

        UNUserNotificationCenter.current().add(request)

        DispatchQueue.main.asyncAfter(deadline: .now() + (alarm.time.timeIntervalSinceNow + 5)) {
            self.removePastAlarms()
        }
    }

    private func saveAlarms() {
        if let encoded = try? JSONEncoder().encode(alarms) {
            UserDefaults.standard.set(encoded, forKey: "alarms")
        }
    }

    private func loadAlarms() {
        if let savedData = UserDefaults.standard.data(forKey: "alarms"),
           let decoded = try? JSONDecoder().decode([Alarm].self, from: savedData) {
            alarms = decoded
        }
    }

    func removePastAlarms() {
        let now = Date()
        alarms = alarms.filter { $0.time >= now }
        saveAlarms()
    }
}

struct AlarmCustomiserView: View {
    let selected: Chuuba
    let onConfirm: (Date) -> Void
    let clearSelection: () -> Void

    @State private var alarmTime = Date()
    @State private var isPlaying = false
    @State private var player: AVAudioPlayer?
    @State private var volume: Float = 0.5
    @State private var showSuccessMessage = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Image(selected.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .padding(.top)

                    Text("Set Alarm for \(selected.name)")
                        .font(.title2)
                        .fontWeight(.bold)

                    DatePicker("Choose Date & Time", selection: $alarmTime, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.graphical)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .shadow(radius: 2)

                    HStack {
                        Button(action: toggleSound) {
                            Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                                .font(.system(size: 24))
                                .padding()
                                .background(isPlaying ? Color.red : Color.green)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                    }

                    Slider(value: $volume, in: 0...1, step: 0.1, onEditingChanged: { _ in
                        player?.volume = volume
                    })
                    .padding()
                    .accentColor(.blue)

                    Text("Volume: \(Int(volume * 100))")
                        .foregroundColor(.green)
                        .bold()

                    Button(action: {
                        withAnimation {
                            onConfirm(alarmTime)
                            clearSelection()
                        }
                    }) {
                        Label("Confirm", systemImage: "checkmark.circle.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                    }

                    Button(action: {
                        withAnimation {
                            clearSelection()
                        }
                    }) {
                        Label("Cancel", systemImage: "xmark.circle.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                    }
                }
                .padding()
            }
        }
    }

    private func toggleSound() {
        if isPlaying {
            player?.stop()
            isPlaying = false
        } else {
            guard let url = Bundle.main.url(forResource: selected.voiceClip, withExtension: "mp3") else { return }
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.volume = volume
                player?.play()
                isPlaying = true
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}
