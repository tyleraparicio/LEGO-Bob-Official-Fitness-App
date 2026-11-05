import SwiftUI

struct MovementView: View {
    @EnvironmentObject private var store: WellnessStore
    @State private var acknowledged = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    SafetyBanner()
                    SectionCard {
                        Text("Your gentle starting plan").font(.title3.bold())
                        Text("Weeks 1–2: Try 3–5 minutes of easy walking once or twice a day if you feel steady. Add gentle desk breaks. No strenuous exercise.")
                        Text("Later, with clinician guidance and if symptoms allow, try one easy round of the exercises below. There is no deadline to progress.")
                            .foregroundStyle(.secondary)
                    }
                    ForEach(AppData.exercises) { exercise in
                        SectionCard {
                            HStack {
                                Image(systemName: exercise.symbol)
                                    .font(.title2)
                                    .foregroundStyle(Theme.accent)
                                    .frame(width: 32)
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(exercise.name).font(.headline)
                                    Text(exercise.amount).font(.subheadline).foregroundStyle(.secondary)
                                }
                            }
                            Text(exercise.instructions).font(.subheadline)
                        }
                    }
                    SectionCard {
                        Toggle("I feel steady, and this activity is appropriate for me", isOn: $acknowledged)
                            .font(.subheadline)
                        Button {
                            store.toggleWorkoutToday()
                        } label: {
                            Label(store.todayWorkoutDone ? "Undo today's completion" : "Mark gentle session complete", systemImage: store.todayWorkoutDone ? "arrow.uturn.backward" : "checkmark")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!acknowledged && !store.todayWorkoutDone)
                        Text("Logging a session is optional. Stop immediately if lightheaded, and do not exercise while impaired.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
            }
            .navigationTitle("Move")
        }
    }
}
