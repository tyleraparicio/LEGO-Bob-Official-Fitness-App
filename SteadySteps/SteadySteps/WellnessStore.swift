import Foundation
import Combine

struct DailyLog: Codable, Identifiable {
    var dateKey: String
    var dizziness: Int = 0
    var energy: Int = 3
    var anxiety: Int = 0
    var sleepHours: Double = 8
    var notes: String = ""
    var id: String { dateKey }
}

struct SavedState: Codable {
    var habits: [String: Set<String>] = [:]
    var workouts: Set<String> = []
    var groceries: Set<String> = []
    var logs: [String: DailyLog] = [:]
}

@MainActor
final class WellnessStore: ObservableObject {
    @Published private(set) var state: SavedState = .init()
    private let storageKey = "steadysteps.state.v1"

    init() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let restored = try? JSONDecoder().decode(SavedState.self, from: data) {
            state = restored
        }
    }

    static func dayKey(_ date: Date = .now) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    var todayKey: String { Self.dayKey() }
    var todayHabits: Set<String> { state.habits[todayKey] ?? [] }
    var todayWorkoutDone: Bool { state.workouts.contains(todayKey) }
    var currentLog: DailyLog { state.logs[todayKey] ?? DailyLog(dateKey: todayKey) }
    var completedWorkoutCount: Int { state.workouts.count }

    func toggleHabit(_ id: String) {
        var values = todayHabits
        if values.contains(id) { values.remove(id) } else { values.insert(id) }
        state.habits[todayKey] = values
        persist()
    }

    func toggleWorkoutToday() {
        if state.workouts.contains(todayKey) { state.workouts.remove(todayKey) }
        else { state.workouts.insert(todayKey) }
        persist()
    }

    func toggleGrocery(_ name: String) {
        if state.groceries.contains(name) { state.groceries.remove(name) }
        else { state.groceries.insert(name) }
        persist()
    }

    func saveLog(_ log: DailyLog) {
        state.logs[log.dateKey] = log
        persist()
    }

    func log(for date: Date) -> DailyLog? { state.logs[Self.dayKey(date)] }
    func workoutCompleted(on date: Date) -> Bool { state.workouts.contains(Self.dayKey(date)) }

    private func persist() {
        if let data = try? JSONEncoder().encode(state) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
}
