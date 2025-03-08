import Foundation

struct Chuuba: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let voiceClip: String
}

let chuubas: [Chuuba] = [
    Chuuba(name: "Gawr Gura", imageName: "Gawr-Gura", voiceClip: "gura_alarm"),
    Chuuba(name: "Mori Calliope", imageName: "Mori-Calliope", voiceClip: "calli_alarm"),
    Chuuba(name: "Watson Amelia", imageName: "Watson-Amelia", voiceClip: "ame_alarm"),
    Chuuba(name: "Takanashi Kiara", imageName: "Takanashi-Kiara", voiceClip: "kiara_alarm"),
    Chuuba(name: "Ninomae Ina'nis", imageName: "Ninomae-Inanis", voiceClip: "ina_alarm")
]
