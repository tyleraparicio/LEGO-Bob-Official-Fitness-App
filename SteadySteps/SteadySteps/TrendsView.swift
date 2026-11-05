import SwiftUI
import Charts

struct TrendPoint: Identifiable {
    let date: Date
    let dizziness: Int?
    let energy: Int?
    let workout: Bool
    var id: Date { date }
}

struct TrendsView: View {
    @EnvironmentObject private var store: WellnessStore

    private var points: [TrendPoint] {
        (0..<7).reversed().compactMap { daysAgo in
            guard let date = Calendar.current.date(byAdding: .day, value: -daysAgo, to: .now) else { return nil }
            let log = store.log(for: date)
            return TrendPoint(date: date, dizziness: log?.dizziness, energy: log?.energy, workout: store.workoutCompleted(on: date))
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    SectionCard {
                        Text("Consistency, not perfection").font(.title3.bold())
                        Text("\(store.completedWorkoutCount) gentle sessions logged overall")
                            .foregroundStyle(.secondary)
                        Text("A symptom journal may help you describe patterns to your clinician. These charts cannot identify the cause of dizziness.")
                            .font(.subheadline)
                    }
                    SectionCard {
                        Text("Last 7 days: dizziness").font(.headline)
                        Chart(points) { point in
                            if let dizziness = point.dizziness {
                                BarMark(x: .value("Day", point.date, unit: .day), y: .value("Dizziness", dizziness))
                                    .foregroundStyle(Theme.accent)
                            }
                        }
                        .chartYScale(domain: 0...5)
                        .frame(height: 180)
                        Text("Only days with saved check-ins appear.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    SectionCard {
                        Text("Last 7 days: energy").font(.headline)
                        Chart(points) { point in
                            if let energy = point.energy {
                                BarMark(x: .value("Day", point.date, unit: .day), y: .value("Energy", energy))
                                    .foregroundStyle(.blue)
                            }
                        }
                        .chartYScale(domain: 0...5)
                        .frame(height: 180)
                    }
                }
                .padding()
            }
            .navigationTitle("Trends")
        }
    }
}
