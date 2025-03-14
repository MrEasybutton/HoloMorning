import Foundation

struct Chuuba: Identifiable, Codable {
    var id = UUID()
    let name: String
    let imageName: String
    let voiceClip: String
    let gen: String
}

let chuubas: [Chuuba] = [
    Chuuba(name: "Gawr Gura", imageName: "Gawr-Gura", voiceClip: "gura_alarm", gen: "Myth"),
    Chuuba(name: "Mori Calliope", imageName: "Mori-Calliope", voiceClip: "calli_alarm", gen: "Myth"),
    Chuuba(name: "Watson Amelia", imageName: "Watson-Amelia", voiceClip: "ame_alarm", gen: "Myth"),
    Chuuba(name: "Takanashi Kiara", imageName: "Takanashi-Kiara", voiceClip: "kiara_alarm", gen: "Myth"),
    Chuuba(name: "Ninomae Ina'nis", imageName: "Ninomae-Inanis", voiceClip: "ina_alarm", gen: "Myth"),
    Chuuba(name: "IRyS", imageName: "irys", voiceClip: "irys_alarm", gen: "Project: HOPE"),
    Chuuba(name: "Ouro Kronii", imageName: "kronii", voiceClip: "kronii_alarm", gen: "Council"),
    Chuuba(name: "Nanashi Mumei", imageName: "mumei", voiceClip: "mumei_alarm", gen: "Council"),
    Chuuba(name: "Hakos Baelz", imageName: "bae", voiceClip: "bae_alarm", gen: "Council"),
    Chuuba(name: "Tsukumo Sana", imageName: "sana", voiceClip: "sana_alarm", gen: "Council"),
    Chuuba(name: "Ceres Fauna", imageName: "fauna", voiceClip: "fauna_alarm", gen: "Council"),
    Chuuba(name: "Shiori Novella", imageName: "shiori", voiceClip: "shiori_alarm", gen: "Advent"),
    Chuuba(name: "Koseki Bijou", imageName: "biboo", voiceClip: "biboo_alarm", gen: "Advent"),
    Chuuba(name: "Nerissa Ravencroft", imageName: "nerissa", voiceClip: "nerissa_alarm", gen: "Advent"),
    Chuuba(name: "FUWAMOCO Abyssgard", imageName: "fuwamoco", voiceClip: "fuwamoco_alarm", gen: "Advent"),
]
