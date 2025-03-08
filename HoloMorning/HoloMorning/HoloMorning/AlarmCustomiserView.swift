import SwiftUI
import Foundation

struct AlarmCustomiserView: View {
    let selected: Chuuba
    let clearSelection: () -> Void
    
    @State private var alarmTime = Date()
    @State private var showSuccessMessage = false
    @State private var isPlaying = false
    
    @State var sound_dummy = 50.0
    @State var isEdit = false;
    
    var body: some View {
        VStack(spacing: 16) {
            Image(selected.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 240)
                .cornerRadius(18)
                .shadow(radius: 4)
                .padding(.top)
            
            Text(selected.name)
                .font(.title)
                .fontWeight(.bold)
                .fontDesign(.rounded)
            
            Spacer().frame(height: 4)
            
            DatePicker("Set Alarm", selection: $alarmTime, displayedComponents: .hourAndMinute)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .buttonStyle(.bordered)
                .shadow(radius: 4)
                
            
            HStack {
                Button(action: {
                    AudioManager.shared.playSound(selected.voiceClip)
                    isPlaying = true
                }) {
                    Image(systemName: "eye.circle.fill")
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
                Button(action: {
                    AudioManager.shared.stopSound()
                    isPlaying = false
                }) {
                    Image(systemName: "stop.circle.fill")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
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
                        Text("CONFIRM").fontDesign(.rounded)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 20)
                    .padding()
                    .background(Color.green)
                    .background(.thickMaterial)
                    .foregroundColor(.white).shadow(radius: 12)
                    .cornerRadius(12)
                }
            }.contentMargins(20)
            
            if showSuccessMessage {
                Text("\(selected.name) set your alarm.")
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
            }
            
            Spacer(minLength:72)
            
            Slider(value: $sound_dummy, in: 0...100, step: 10, onEditingChanged: {editing in isEdit = editing})
                Text("\(sound_dummy)")
                        .foregroundColor(isEdit ? .blue : .green)
                        .bold()
            
            Button(action: clearSelection) {
                HStack(alignment: .bottom) {
                    Text("Back to HoloEN")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.yellow.opacity(0.8))
                .foregroundColor(.primary)
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
        .padding(.bottom)
        .padding(8)
        .navigationBarBackButtonHidden(true)
        .background(Color.mint.opacity(0.2))
    }
}
