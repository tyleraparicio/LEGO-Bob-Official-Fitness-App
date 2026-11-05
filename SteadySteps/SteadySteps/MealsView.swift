import SwiftUI

struct MealsView: View {
    @EnvironmentObject private var store: WellnessStore
    @State private var showGroceries = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Affordable, balanced meals without handling raw chicken, beef, or fish. Eat regularly and enough to feel nourished; no calorie counting required.")
                        .font(.subheadline)
                }
                Section("Recipes") {
                    ForEach(AppData.meals) { meal in
                        NavigationLink {
                            MealDetailView(meal: meal)
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: meal.symbol)
                                    .foregroundStyle(Theme.accent)
                                    .frame(width: 28)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(meal.name).font(.headline)
                                    Text("\(meal.category) · \(meal.time)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
                Section {
                    Button {
                        showGroceries = true
                    } label: {
                        Label("Open grocery checklist", systemImage: "cart")
                    }
                }
            }
            .navigationTitle("Meals")
            .sheet(isPresented: $showGroceries) { GroceryView() }
        }
    }
}

struct MealDetailView: View {
    let meal: Meal

    var body: some View {
        List {
            Section("Ingredients") {
                ForEach(meal.ingredients, id: \.self) { Text($0) }
            }
            Section("Easy instructions") {
                ForEach(Array(meal.steps.enumerated()), id: \.offset) { index, step in
                    HStack(alignment: .top, spacing: 10) {
                        Text("\(index + 1).")
                            .bold()
                            .foregroundStyle(Theme.accent)
                        Text(step)
                    }
                }
            }
        }
        .navigationTitle(meal.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GroceryView: View {
    @EnvironmentObject private var store: WellnessStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List(AppData.groceryItems, id: \.self) { item in
                Button { store.toggleGrocery(item) } label: {
                    HStack {
                        Image(systemName: store.state.groceries.contains(item) ? "checkmark.square.fill" : "square")
                            .foregroundStyle(Theme.accent)
                        Text(item).foregroundStyle(.primary)
                    }
                }
            }
            .navigationTitle("Grocery list")
            .toolbar { ToolbarItem(placement: .topBarTrailing) { Button("Done") { dismiss() } } }
        }
    }
}
