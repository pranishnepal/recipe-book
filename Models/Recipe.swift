//
//  Recipe.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-27.
//

import Foundation

struct Recipe: Identifiable {
    var id: UUID = UUID()
    var recipeInformation: RecipeInformation
    var directions: [Direction]
    var ingredients: [Ingredient]

    init(
        recipeInformation: RecipeInformation,
        directions: [Direction],
        ingredients: [Ingredient]
    ) {
        self.recipeInformation = recipeInformation
        self.directions = directions
        self.ingredients = ingredients
    }
    
    init() {
        self.init(
            recipeInformation: RecipeInformation(
                name: "",
                authorName: "",
                description: "",
                category: RecipeInformation.Category.breakfast
            ),
            directions: [],
            ingredients: []
        )
    }
    
    var isValid: Bool {
        !ingredients.isEmpty && recipeInformation.isValid && !directions.isEmpty
    }
    
}

struct RecipeInformation {
    var name: String
    var authorName: String
    var description: String
    var category: Category
    
    enum Category: String, CaseIterable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case dessert = "Dessert"
    }
    
    var isValid: Bool {
        !name.isEmpty && !description.isEmpty && !authorName.isEmpty
    }
}

struct Direction {
    var description: String
    var isOptional: Bool
}


struct Ingredient {
    enum IngredientUnit: String, CaseIterable {
        case oz = "Ounces"
        case g = "Grams"
        case cups = "Cups"
        case tbs = "Tablespoons"
        case tsp = "Teaspoons"
        case none = "No units"
        
        var singularName: String {
            String(rawValue.dropLast())
        }
    }
    
    var name: String
    var unit: IngredientUnit
    var quantity: Double
    
    init(name: String, unit: IngredientUnit, quantity: Double) {
        self.name = name
        self.unit = unit
        self.quantity = quantity
    }
    
    init() {
        self.init(
            name: "",
            unit: .none,
            quantity: 1.0
        )
    }
    
    var description: String {
        let formattedQuantity = String(format: "%g", quantity)
        switch unit {
        case .none:
            let formattedName = quantity == 1 ? name : "\(name)s"
            return "\(formattedQuantity) \(formattedName)"
        default:
            if quantity == 1 {
                return "1 \(unit.singularName) \(name)"
            } else {
                return "\(formattedQuantity) \(unit.rawValue) \(name) "
            }
        }
    }

}


extension Recipe {
    static let mockedRecipes: [Recipe] = [
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Dad's Mashed Potatoes",
                    authorName: "Josh",
                    description: "Buttery salty mashed potatoes",
                    category: RecipeInformation.Category.dinner
                ),
            directions: [
                Direction(
                    description: "Put peeled potatoes in water and bring to boil ~15 min (once you can cut them easily)",
                    isOptional: false
                ),
                Direction(
                    description: "In the meantime, soften the butter by heating in a microwave for 30 seconds",
                    isOptional: false
                ),
                Direction(
                    description: "Drain the soft potatoes",
                    isOptional: true
                ),
            ],
            ingredients: [
                Ingredient(
                    name: "Potatoes",
                    unit: .g,
                    quantity: 454
                ),
                Ingredient(
                    name: "Butter",
                    unit: .tbs,
                    quantity: 1
                ),
            ]
        ),
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Beet and Apple Salad",
                    authorName: "Deb Szajngarten",
                    description: "Light and refreshing summer salad made of beets, apples and fresh mint",
                    category: RecipeInformation.Category.breakfast
                ),
            directions: [
                Direction(
                    description: "Put peeled potatoes in water and bring to boil ~15 min (once you can cut them easily)",
                    isOptional: false
                ),
                Direction(
                    description: "In the meantime, soften the butter by heating in a microwave for 30 seconds",
                    isOptional: false
                ),
                Direction(
                    description: "Drain the soft potatoes",
                    isOptional: false
                ),
            ],
            ingredients: [
                Ingredient(
                    name: "Potatoes",
                    unit: .cups,
                    quantity: 454
                ),
                Ingredient(
                    name: "Apple Cider Vinegar",
                    unit: .oz,
                    quantity: 1
                ),
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Vegetarian Chili",
                    authorName: "Makeinze Gore",
                    description: "Warm, comforting, and filling vegetarian chili",
                    category: RecipeInformation.Category.lunch
                ),
            directions: [
                Direction(
                    description: "In a large pot over medium heat, heat olive oil then add onions, bell peppers and carrots",
                    isOptional: true
                ),
                Direction(
                    description: "Saute until soft - about 5 min",
                    isOptional: false
                ),
                Direction(
                    description: "Add garlic and jalapeno and cool until fragrant - about 1 min",
                    isOptional: true
                ),
            ],
            ingredients: [
                Ingredient(
                    name: "Chopped Onion",
                    unit: .none,
                    quantity: 1
                ),
                Ingredient(
                    name: "Apple Cider Vinegar",
                    unit: .tbs,
                    quantity: 2
                ),
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Banana Bread",
                    authorName: "Lisa",
                    description: "Easy to put together, and a family favorite!",
                    category: RecipeInformation.Category.dessert
                ),
            directions: [
                Direction(
                    description: "In a large pot over medium heat, heat olive oil then add onions, bell peppers and carrots",
                    isOptional: true
                ),
                Direction(
                    description: "Saute until soft - about 5 min",
                    isOptional: false
                ),
                Direction(
                    description: "Add garlic and jalapeno and cool until fragrant - about 1 min",
                    isOptional: true
                ),
            ],
            ingredients: [
                Ingredient(
                    name: "Ripe banana",
                    unit: .none,
                    quantity: 3
                ),
                Ingredient(
                    name: "Flour",
                    unit: .cups,
                    quantity: 3
                ),
            ]
        ),
        
        //---------------------------------------------------repeating-------------------------------------------------------
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Dad's Mashed Potatoes",
                    authorName: "Josh",
                    description: "Buttery salty mashed potatoes",
                    category: RecipeInformation.Category.dinner
                ),
            directions: [
                Direction(
                    description: "Put peeled potatoes in water and bring to boil ~15 min (once you can cut them easily)",
                    isOptional: false
                ),
                Direction(
                    description: "In the meantime, soften the butter by heating in a microwave for 30 seconds",
                    isOptional: false
                ),
                Direction(
                    description: "Drain the soft potatoes",
                    isOptional: true
                ),
            ],
            ingredients: [
                Ingredient(
                    name: "Potatoes",
                    unit: .g,
                    quantity: 454
                ),
                Ingredient(
                    name: "Butter",
                    unit: .tbs,
                    quantity: 1
                ),
            ]
        ),
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Beet and Apple Salad",
                    authorName: "Deb Szajngarten",
                    description: "Light and refreshing summer salad made of beets, apples and fresh mint",
                    category: RecipeInformation.Category.breakfast
                ),
            directions: [
                Direction(
                    description: "Put peeled potatoes in water and bring to boil ~15 min (once you can cut them easily)",
                    isOptional: false
                ),
                Direction(
                    description: "In the meantime, soften the butter by heating in a microwave for 30 seconds",
                    isOptional: false
                ),
                Direction(
                    description: "Drain the soft potatoes",
                    isOptional: false
                ),
            ],
            ingredients: [
                Ingredient(
                    name: "Potatoes",
                    unit: .cups,
                    quantity: 454
                ),
                Ingredient(
                    name: "Apple Cider Vinegar",
                    unit: .oz,
                    quantity: 1
                ),
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Vegetarian Chili",
                    authorName: "Makeinze Gore",
                    description: "Warm, comforting, and filling vegetarian chili",
                    category: RecipeInformation.Category.lunch
                ),
            directions: [
                Direction(
                    description: "In a large pot over medium heat, heat olive oil then add onions, bell peppers and carrots",
                    isOptional: true
                ),
                Direction(
                    description: "Saute until soft - about 5 min",
                    isOptional: false
                ),
                Direction(
                    description: "Add garlic and jalapeno and cool until fragrant - about 1 min",
                    isOptional: true
                ),
            ],
            ingredients: [
                Ingredient(
                    name: "Chopped Onion",
                    unit: .none,
                    quantity: 1
                ),
                Ingredient(
                    name: "Apple Cider Vinegar",
                    unit: .tbs,
                    quantity: 2
                ),
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Banana Bread",
                    authorName: "Lisa",
                    description: "Easy to put together, and a family favorite!",
                    category: RecipeInformation.Category.dessert
                ),
            directions: [
                Direction(
                    description: "In a large pot over medium heat, heat olive oil then add onions, bell peppers and carrots",
                    isOptional: true
                ),
                Direction(
                    description: "Saute until soft - about 5 min",
                    isOptional: false
                ),
                Direction(
                    description: "Add garlic and jalapeno and cool until fragrant - about 1 min",
                    isOptional: true
                ),
            ],
            ingredients: [
                Ingredient(
                    name: "Ripe banana",
                    unit: .none,
                    quantity: 3
                ),
                Ingredient(
                    name: "Flour",
                    unit: .cups,
                    quantity: 3
                ),
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Dad's Mashed Potatoes",
                    authorName: "Josh",
                    description: "Buttery salty mashed potatoes",
                    category: RecipeInformation.Category.dinner
                ),
            directions: [
                Direction(
                    description: "Put peeled potatoes in water and bring to boil ~15 min (once you can cut them easily)",
                    isOptional: false
                ),
                Direction(
                    description: "In the meantime, soften the butter by heating in a microwave for 30 seconds",
                    isOptional: false
                ),
                Direction(
                    description: "Drain the soft potatoes",
                    isOptional: true
                ),
            ],
            ingredients: [
                Ingredient(
                    name: "Potatoes",
                    unit: .g,
                    quantity: 454
                ),
                Ingredient(
                    name: "Butter",
                    unit: .tbs,
                    quantity: 1
                ),
            ]
        ),
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Beet and Apple Salad",
                    authorName: "Deb Szajngarten",
                    description: "Light and refreshing summer salad made of beets, apples and fresh mint",
                    category: RecipeInformation.Category.breakfast
                ),
            directions: [
                Direction(
                    description: "Put peeled potatoes in water and bring to boil ~15 min (once you can cut them easily)",
                    isOptional: false
                ),
                Direction(
                    description: "In the meantime, soften the butter by heating in a microwave for 30 seconds",
                    isOptional: false
                ),
                Direction(
                    description: "Drain the soft potatoes",
                    isOptional: false
                ),
            ],
            ingredients: [
                Ingredient(
                    name: "Potatoes",
                    unit: .cups,
                    quantity: 454
                ),
                Ingredient(
                    name: "Apple Cider Vinegar",
                    unit: .oz,
                    quantity: 1
                ),
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Vegetarian Chili",
                    authorName: "Makeinze Gore",
                    description: "Warm, comforting, and filling vegetarian chili",
                    category: RecipeInformation.Category.lunch
                ),
            directions: [
                Direction(
                    description: "In a large pot over medium heat, heat olive oil then add onions, bell peppers and carrots",
                    isOptional: true
                ),
                Direction(
                    description: "Saute until soft - about 5 min",
                    isOptional: false
                ),
                Direction(
                    description: "Add garlic and jalapeno and cool until fragrant - about 1 min",
                    isOptional: true
                ),
            ],
            ingredients: [
                Ingredient(
                    name: "Chopped Onion",
                    unit: .none,
                    quantity: 1
                ),
                Ingredient(
                    name: "Apple Cider Vinegar",
                    unit: .tbs,
                    quantity: 2
                ),
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Banana Bread",
                    authorName: "Lisa",
                    description: "Easy to put together, and a family favorite!",
                    category: RecipeInformation.Category.dessert
                ),
            directions: [
                Direction(
                    description: "In a large pot over medium heat, heat olive oil then add onions, bell peppers and carrots",
                    isOptional: true
                ),
                Direction(
                    description: "Saute until soft - about 5 min",
                    isOptional: false
                ),
                Direction(
                    description: "Add garlic and jalapeno and cool until fragrant - about 1 min",
                    isOptional: true
                ),
            ],
            ingredients: [
                Ingredient(
                    name: "Ripe banana",
                    unit: .none,
                    quantity: 3
                ),
                Ingredient(
                    name: "Flour",
                    unit: .cups,
                    quantity: 3
                ),
            ]
        )
    ]
}
