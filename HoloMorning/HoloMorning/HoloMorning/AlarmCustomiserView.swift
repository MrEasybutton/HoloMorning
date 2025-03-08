import SwiftUI

struct AlarmCustomiserView: View {
    let selected: Chuuba
    let clearSelection: () -> Void
    
    @State private var alarmTime = Date()
    @State private var showSuccessMessage = false
    @State private var isPlaying = false
    // comment test
    
    var body: some View {
        VStack(spacing: 20) {
            Image(selected.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .cornerRadius(15)
                .shadow(radius: 3)
                .padding(.top)
            
            Text(selected.name)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer().frame(height: 20)
            
            DatePicker("Set the alarm time", selection: $alarmTime, displayedComponents: .hourAndMinute)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
            
            HStack {
                Button(action: {
                    AudioManager.shared.playSound(selected.voiceClip)
                    isPlaying = true
                }) {
                    HStack {
                        Image(systemName: "play.circle.fill")
                        Text("Preview")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
                }
                
                Button(action: {
                    AudioManager.shared.stopSound()
                    isPlaying = false
                }) {
                    HStack {
                        Image(systemName: "stop.circle.fill")
                        Text("Stop")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
                }
            }
            
            Button(action: {
                NotificationManager.shared.scheduleAlarm(for: alarmTime, with: selected)
                showSuccessMessage = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showSuccessMessage = false
                }
            }) {
                HStack {
                    Image(systemName: "alarm.fill")
                    Text("Confirm")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
            }
            
            if showSuccessMessage {
                Text("\(selected.name) set your alarm.")
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
            }
            
            Spacer()
            
            Button(action: clearSelection) {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Back to HoloEN")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.yellow.opacity(0.8))
                .foregroundColor(.primary)
                .cornerRadius(16)
                .padding(.horizontal)
            }
        }
        .padding(.bottom)
        .navigationTitle("Customize")
        .navigationBarBackButtonHidden(true)
    }
}
