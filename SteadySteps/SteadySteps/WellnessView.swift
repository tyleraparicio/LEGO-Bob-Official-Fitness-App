import SwiftUI

struct WellnessView: View {
    @EnvironmentObject private var store: WellnessStore
    @State private var draft = DailyLog(dateKey: WellnessStore.dayKey())
    @State private var saved = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Notice patterns, not diagnoses. If dizziness persists, arrange a medical review even if anxiety seems related.")
                        .font(.subheadline)
                }
                Section("How are you feeling today?") {
                    rating("Dizziness", value: $draft.dizziness, low: "None", high: "Severe")
                    rating("Energy", value: $draft.energy, low: "Very low", high: "High")
                    rating("Anxiety", value: $draft.anxiety, low: "None", high: "Severe")
                }
                Section("Sleep") {
                    HStack {
                        Text("Hours slept")
                        Spacer()
                        Text(draft.sleepHours.formatted(.number.precision(.fractionLength(1))))
                            .monospacedDigit()
                            .foregroundStyle(.secondary)
                    }
                    Slider(value: $draft.sleepHours, in: 0...14, step: 0.5)
                }
                Section("Notes") {
                    TextField("Meals, hydration, triggers, or questions for your clinician", text: $draft.notes, axis: .vertical)
                        .lineLimit(3...6)
                }
                Section {
                    Button {
                        store.saveLog(draft)
                        saved = true
                    } label: {
                        Label("Save today's check-in", systemImage: "checkmark.circle")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .listRowBackground(Color.clear)
                }
                Section("Medication safety") {
                    Text("Use reminders only for your prescribed schedule. Ask your prescriber or pharmacist about missed doses; don't double up without professional advice.")
                        .font(.subheadline)
                }
            }
            .navigationTitle("Wellness")
            .onAppear { draft = store.currentLog }
            .onChange(of: store.todayKey) { _, _ in draft = store.currentLog }
            .alert("Check-in saved", isPresented: $saved) {
                Button("OK", role: .cancel) { }
            }
        }
    }

    private func rating(_ title: String, value: Binding<Int>, low: String, high: String) -> some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack {
                Text(title)
                Spacer()
                Text("\(value.wrappedValue)/5")
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
            Slider(value: Binding(get: { Double(value.wrappedValue) }, set: { value.wrappedValue = Int($0) }), in: 0...5, step: 1)
            HStack {
                Text(low)
                Spacer()
                Text(high)
            }
            .font(.caption2)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}
