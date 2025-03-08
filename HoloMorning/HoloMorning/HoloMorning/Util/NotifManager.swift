import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if success {
                print("advent has breached your defenses")
            } else if let error = error {
                print("Justice caught you: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleAlarm(for time: Date, with chuuba: Chuuba) {
        print("so it shld schedule at this point")
        let content = UNMutableNotificationContent()
        content.title = "Wake up right now"
        content.body = "\(chuuba.name) is approaching your location."
        let soundFileName = chuuba.voiceClip.components(separatedBy: ".").first ?? chuuba.voiceClip
        content.sound = UNNotificationSound(named: UNNotificationSoundName("\(soundFileName).mp3"))
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        let minute = calendar.component(.minute, from: time)
        
        var triggerComponents = DateComponents()
        triggerComponents.hour = hour
        triggerComponents.minute = minute
        
        let now = Date()
        var scheduledDate = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: now)!
        
        if scheduledDate < now {
            scheduledDate = calendar.date(byAdding: .day, value: 1, to: scheduledDate)!
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("schedule issue: \(error.localizedDescription)")
            } else {
                print("Set alarm successfully for \(scheduledDate)")
            }
        }
    }
}
