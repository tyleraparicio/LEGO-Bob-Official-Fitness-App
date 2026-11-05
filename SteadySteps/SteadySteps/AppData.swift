import Foundation

struct Habit: Identifiable {
    let id: String
    let name: String
    let symbol: String
}

struct Exercise: Identifiable {
    let id: String
    let name: String
    let amount: String
    let instructions: String
    let symbol: String
}

struct Meal: Identifiable {
    let id: String
    let name: String
    let category: String
    let time: String
    let ingredients: [String]
    let steps: [String]
    let symbol: String
}

enum AppData {
    static let habits: [Habit] = [
        .init(id: "water", name: "Drink water after waking", symbol: "drop.fill"),
        .init(id: "meal", name: "Eat regular balanced meals", symbol: "fork.knife"),
        .init(id: "break", name: "Take a gentle desk break", symbol: "figure.stand"),
        .init(id: "walk", name: "Take a comfortable short walk", symbol: "figure.walk"),
        .init(id: "wind", name: "Make time to wind down", symbol: "moon.stars.fill")
    ]

    static let exercises: [Exercise] = [
        .init(id: "knee", name: "Seated knee extensions", amount: "5 each leg", instructions: "Sit upright on a stable chair. Slowly straighten one knee, lower your foot, then switch sides.", symbol: "figure.seated.side"),
        .init(id: "push", name: "Wall push-ups", amount: "5 repetitions", instructions: "Face a wall with hands at shoulder height. Slowly bend your elbows toward the wall, then push back. Breathe naturally.", symbol: "figure.strengthtraining.functional"),
        .init(id: "chair", name: "Supported sit-to-stands", amount: "3–5 repetitions", instructions: "Only if standing does not trigger dizziness: rise slowly from a sturdy chair using your hands for support, then sit back down.", symbol: "chair.fill"),
        .init(id: "heel", name: "Seated heel raises", amount: "8–10 repetitions", instructions: "Sit with feet flat. Keep toes on the floor as you gently lift and lower your heels.", symbol: "figure.cooldown")
    ]

    static let meals: [Meal] = [
        .init(id: "oats", name: "Banana peanut butter oats", category: "Breakfast", time: "5 min", ingredients: ["Oats", "Milk or water", "Banana", "Peanut butter"], steps: ["Cook oats with milk or water according to the package.", "Slice a banana on top.", "Stir in peanut butter."], symbol: "sunrise.fill"),
        .init(id: "yogurt", name: "Yogurt and fruit bowl", category: "Breakfast", time: "2 min", ingredients: ["Plain Greek yogurt", "Fruit", "Oats or granola"], steps: ["Spoon yogurt into a bowl.", "Add fruit and oats or granola."], symbol: "sunrise.fill"),
        .init(id: "chicken", name: "Rotisserie chicken rice bowl", category: "Lunch / Dinner", time: "10 min", ingredients: ["Fully cooked rotisserie chicken", "Microwave rice", "Frozen mixed vegetables"], steps: ["Prepare rice and vegetables following package directions.", "Add portions of fully cooked rotisserie chicken.", "Heat until hot throughout. Refrigerate leftovers promptly."], symbol: "fork.knife"),
        .init(id: "quesadilla", name: "Black bean quesadilla", category: "Lunch / Dinner", time: "10 min", ingredients: ["Tortillas", "Canned black beans", "Shredded cheese", "Salsa"], steps: ["Drain and rinse beans.", "Place beans and cheese in a tortilla.", "Warm in a pan until cheese melts and the filling is hot; serve with salsa."], symbol: "fork.knife"),
        .init(id: "pasta", name: "Chickpea tomato pasta", category: "Lunch / Dinner", time: "15 min", ingredients: ["Pasta", "Canned chickpeas", "Jarred tomato sauce", "Frozen spinach"], steps: ["Boil pasta following package directions.", "Drain and rinse chickpeas.", "Heat sauce, chickpeas, and spinach until hot; combine with pasta."], symbol: "fork.knife"),
        .init(id: "potato", name: "Loaded bean potato", category: "Lunch / Dinner", time: "15 min", ingredients: ["Potato", "Canned beans", "Frozen broccoli", "Shredded cheese"], steps: ["Pierce potato with a fork and microwave until fully tender.", "Heat drained beans and broccoli until hot.", "Split potato and top with beans, broccoli, and cheese."], symbol: "fork.knife")
    ]

    static var groceryItems: [String] {
        Array(Set(meals.flatMap(\.ingredients))).sorted()
    }
}
