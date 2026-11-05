import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            TodayView().tabItem { Label("Today", systemImage: "house.fill") }
            MovementView().tabItem { Label("Move", systemImage: "figure.walk") }
            MealsView().tabItem { Label("Meals", systemImage: "fork.knife") }
            WellnessView().tabItem { Label("Wellness", systemImage: "heart.text.square") }
            TrendsView().tabItem { Label("Trends", systemImage: "chart.bar.fill") }
        }
    }
}

struct TodayView: View {
    @EnvironmentObject private var store: WellnessStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Small steps count.")
                            .font(.largeTitle.bold())
                        Text("Build a routine that works with your day—not against it.")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 8)

                    SafetyBanner()

                    SectionCard {
                        HStack {
                            Label("Today's habits", systemImage: "checkmark.circle.fill")
                                .font(.headline)
                            Spacer()
                            Text("\(store.todayHabits.count)/\(AppData.habits.count)")
                                .font(.subheadline.monospacedDigit())
                                .foregroundStyle(.secondary)
                        }
                        ProgressView(value: Double(store.todayHabits.count), total: Double(AppData.habits.count))
                        ForEach(AppData.habits) { habit in
                            Button { store.toggleHabit(habit.id) } label: {
                                HStack(spacing: 12) {
                                    Image(systemName: store.todayHabits.contains(habit.id) ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(Theme.accent)
                                        .font(.title3)
                                    Label(habit.name, systemImage: habit.symbol)
                                        .foregroundStyle(.primary)
                                    Spacer()
                                }
                                .padding(.vertical, 6)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    SectionCard {
                        Label("Your pace", systemImage: "leaf.fill").font(.headline)
                        Text("Begin with a few comfortable minutes of walking or gentle seated movement. Progress only when symptoms are evaluated and activity feels safe.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        HStack {
                            Text("Today's strength session")
                            Spacer()
                            Text(store.todayWorkoutDone ? "Completed" : "Optional")
                                .foregroundStyle(store.todayWorkoutDone ? Theme.accent : .secondary)
                        }
                        .font(.subheadline.weight(.medium))
                    }
                    SectionCard {
                        Label("Important reminder", systemImage: "pills.fill").font(.headline)
                        Text("If you've missed several Lexapro doses, ask your prescriber or pharmacist how to restart safely. Don't double doses or adjust your prescription on your own.")
                            .font(.subheadline)
                    }
                }
                .padding()
            }
            .background(Theme.pale.opacity(0.25))
            .navigationTitle("Today")
        }
    }
}
