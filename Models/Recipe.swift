//
//  Recipe.swift
//  RecipeBook
//
//  Created by Pranish Nepal on 2022-06-27.
//

import Foundation

struct Recipe: Identifiable, Codable {
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
        return recipeInformation.isValid && !directions.isEmpty && !ingredients.isEmpty
    }
    
}

struct RecipeInformation: Codable {
    var name: String
    var authorName: String
    var description: String
    var category: Category
    
    enum Category: String, CaseIterable, Codable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case dessert = "Dessert"
    }
    
    var isValid: Bool {
        !name.isEmpty && !description.isEmpty && !authorName.isEmpty
    }
}

struct Direction: Codable {
    var description: String
    var isOptional: Bool
    
    init(description: String, isOptional: Bool) {
        self.description = description
        self.isOptional = isOptional
    }
    
    init() {
        self.init(description: "", isOptional: false)
    }
}


struct Ingredient: Codable {
    enum IngredientUnit: String, CaseIterable , Codable {
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
    static var mockedRecipes: [Recipe] = [
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Dal Bhat",
                    authorName: "Grandma",
                    description: "Dal Bhat Recipe from Nepal",
                    category: RecipeInformation.Category.dinner
                ),
            directions: [
                Direction(
                    description: "Put the rice on to cook when appropriate. I prefer to use a rice cooker for this",
                    isOptional: false
                ),
                Direction(
                    description: "Chop your onion, garlic and ginger and tomato",
                    isOptional: false
                ),
                Direction(
                    description: "Heat oil on high in a large pan",
                    isOptional: true
                ),
                Direction(
                    description: "Add chopped tomato and butter or ghee (optional). Stir, cover and cook for a couple of minutes.",
                    isOptional: false
                ),
                Direction(
                    description: "Season with sea salt and white pepper if needed.",
                    isOptional: false
                )
            ],
            ingredients: [
                Ingredient(
                    name: "Coriander leaf",
                    unit: .tsp,
                    quantity: 2
                ),
                Ingredient(
                    name: "Ginger",
                    unit: .tbs,
                    quantity: 1
                ),
                Ingredient(
                    name: "Onion",
                    unit: .none,
                    quantity: 1
                ),
                Ingredient(
                    name: "Cardamom Powder",
                    unit: .tsp,
                    quantity: 1
                ),
                Ingredient(
                    name: "Salt",
                    unit: .tsp,
                    quantity: 4
                ),
                Ingredient(
                    name: "Rice",
                    unit: .cups,
                    quantity: 2
                )
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Nepalese tea",
                    authorName: "John doe",
                    description: "Spiced tea",
                    category: RecipeInformation.Category.breakfast
                ),
            directions: [
                Direction(
                    description: "Steep tea in boiling water",
                    isOptional: false
                ),
                Direction(
                    description: "Add milk, sugar, cloves, cardamom and cinnamon stick",
                    isOptional: false
                ),
                Direction(
                    description: "Simmer 10 minutes to blend flavors",
                    isOptional: false
                ),
                Direction(
                    description: "Strain and serve hot",
                    isOptional: false
                )
            ],
            ingredients: [
                Ingredient(
                    name: "Tea",
                    unit: .tsp,
                    quantity: 3
                ),
                Ingredient(
                    name: "Milk",
                    unit: .cups,
                    quantity: 2
                ),
                Ingredient(
                    name: "Water",
                    unit: .cups,
                    quantity: 1
                ),
                Ingredient(
                    name: "Cloves",
                    unit: .none,
                    quantity: 4
                ),
                Ingredient(
                    name: "Cinnamon Stick",
                    unit: .none,
                    quantity: 1
                )
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Momo",
                    authorName: "Sam",
                    description: "Delicious Nepalese momos",
                    category: RecipeInformation.Category.lunch
                ),
            directions: [
                Direction(
                    description: "Mix together the flour and 1 1/2 cups room temperature water in a bowl. Knead the dough well until it is medium-firm and flexible. Cover and let rest for 1 hour",
                    isOptional: false
                ),
                Direction(
                    description: "Meanwhile, mix together the chicken, cilantro, onions, garlic, ginger, cumin, cinnamon, 2 tablespoons salt and 1/2 teaspoon pepper in a bowl",
                    isOptional: false
                ),
                Direction(
                    description: "To make the wrappers: Break off 1/2 ounce of dough and forming it into a ball. Place the ball on a flat surface and roll it into a 4-inch round with a rolling pin. Repeat with the remaining dough",
                    isOptional: false
                ),
                Direction(
                    description: "Spray a steamer pan with cooking spray",
                    isOptional: true
                ),
                Direction(
                    description: "Place a tablespoon of the chicken filling in the middle of a wrapper. Holding the wrapper in your left hand. Use your right thumb and index finger to start pinching the edges of the wrapper together. Pinch and fold until the edges of the circle close up like a little satchel. Place the momo in the prepared steamer pan. Repeat with remaining wrappers and filling",
                    isOptional: false
                ),
                Direction(
                    description: "Fill the steamer pot halfway with water and bring to a boil. Set the steamer pan with the momos on top of the pot and cover with a tight lid. Steam the momos until cooked, 8 to 9 minutes.",
                    isOptional: false
                )
            ],
            ingredients: [
                Ingredient(
                    name: "Flour",
                    unit: .cups,
                    quantity: 4
                ),
                Ingredient(
                    name: "Ground Chicken",
                    unit: .g,
                    quantity: 1000
                ),
                Ingredient(
                    name: "Fresh Cilantro",
                    unit: .cups,
                    quantity: 1
                ),
                Ingredient(
                    name: "Onions",
                    unit: .cups,
                    quantity: 1
                ),
                Ingredient(
                    name: "Cumins",
                    unit: .tsp,
                    quantity: 2
                ),
                Ingredient(
                    name: "Salt and Pepper",
                    unit: .tsp,
                    quantity: 1
                )
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Strawberry Poke Cake",
                    authorName: "Jane Doe",
                    description: "Prettiest and tastiest poke cake!",
                    category: RecipeInformation.Category.dessert
                ),
            directions: [
                Direction(
                    description: "In large bowl, beat cake mix, water, oil and egg whites with electric mixer on low speed 30 seconds. Beat on medium speed 2 minutes, scraping bowl occasionally. Pour into pan",
                    isOptional: false
                ),
                Direction(
                    description: "Bake 28 to 32 minutes or until toothpick inserted in center comes out clean. Cool on cooling rack 20 minutes",
                    isOptional: false
                ),
                Direction(
                    description: "Meanwhile, in medium bowl, pour boiling water on gelatin; stir until gelatin is dissolved. Poke cake every inch with handle of wooden spoon or tines of meat fork halfway into cake. Carefully pour strawberry gelatin evenly over top of cake. Cool completely, about 1 hour",
                    isOptional: false
                ),
                Direction(
                    description: "Spread frosting over top of cake. Drizzle red decorating gel over frosting. Cut into 4 rows by 3 rows. Garnish each piece of cake with strawberries.",
                    isOptional: true
                )
            ],
            ingredients: [
                Ingredient(
                    name: "Cake mix",
                    unit: .none,
                    quantity: 1
                ),
                Ingredient(
                    name: "Water",
                    unit: .cups,
                    quantity: 1
                ),
                Ingredient(
                    name: "Jell-O strawberry flavored gelatin",
                    unit: .oz,
                    quantity: 1
                ),
                Ingredient(
                    name: "Strawberries",
                    unit: .none,
                    quantity: 12
                ),
                Ingredient(
                    name: "Eggs",
                    unit: .none,
                    quantity: 4
                )
            ]
        ),
        
        //---------------------------------------------------repeating-------------------------------------------------------
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Rice",
                    authorName: "Grandma",
                    description: "Dal Bhat Recipe from Nepal",
                    category: RecipeInformation.Category.dinner
                ),
            directions: [
                Direction(
                    description: "Put the rice on to cook when appropriate. I prefer to use a rice cooker for this",
                    isOptional: false
                ),
                Direction(
                    description: "Chop your onion, garlic and ginger and tomato",
                    isOptional: false
                ),
                Direction(
                    description: "Heat oil on high in a large pan",
                    isOptional: true
                ),
                Direction(
                    description: "Add chopped tomato and butter or ghee (optional). Stir, cover and cook for a couple of minutes.",
                    isOptional: false
                ),
                Direction(
                    description: "Season with sea salt and white pepper if needed.",
                    isOptional: false
                )
            ],
            ingredients: [
                Ingredient(
                    name: "Coriander leaf",
                    unit: .tsp,
                    quantity: 2
                ),
                Ingredient(
                    name: "Ginger",
                    unit: .tbs,
                    quantity: 1
                ),
                Ingredient(
                    name: "Onion",
                    unit: .none,
                    quantity: 1
                ),
                Ingredient(
                    name: "Cardamom Powder",
                    unit: .tsp,
                    quantity: 1
                ),
                Ingredient(
                    name: "Salt",
                    unit: .tsp,
                    quantity: 4
                ),
                Ingredient(
                    name: "Rice",
                    unit: .cups,
                    quantity: 2
                )
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Tea",
                    authorName: "John doe",
                    description: "Spiced tea",
                    category: RecipeInformation.Category.breakfast
                ),
            directions: [
                Direction(
                    description: "Steep tea in boiling water",
                    isOptional: false
                ),
                Direction(
                    description: "Add milk, sugar, cloves, cardamom and cinnamon stick",
                    isOptional: false
                ),
                Direction(
                    description: "Simmer 10 minutes to blend flavors",
                    isOptional: false
                ),
                Direction(
                    description: "Strain and serve hot",
                    isOptional: false
                )
            ],
            ingredients: [
                Ingredient(
                    name: "Tea",
                    unit: .tsp,
                    quantity: 3
                ),
                Ingredient(
                    name: "Milk",
                    unit: .cups,
                    quantity: 2
                ),
                Ingredient(
                    name: "Water",
                    unit: .cups,
                    quantity: 1
                ),
                Ingredient(
                    name: "Cloves",
                    unit: .none,
                    quantity: 4
                ),
                Ingredient(
                    name: "Cinnamon Stick",
                    unit: .none,
                    quantity: 1
                )
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Some Food",
                    authorName: "Sam",
                    description: "Delicious Nepalese momos",
                    category: RecipeInformation.Category.lunch
                ),
            directions: [
                Direction(
                    description: "Mix together the flour and 1 1/2 cups room temperature water in a bowl. Knead the dough well until it is medium-firm and flexible. Cover and let rest for 1 hour",
                    isOptional: false
                ),
                Direction(
                    description: "Meanwhile, mix together the chicken, cilantro, onions, garlic, ginger, cumin, cinnamon, 2 tablespoons salt and 1/2 teaspoon pepper in a bowl",
                    isOptional: false
                ),
                Direction(
                    description: "To make the wrappers: Break off 1/2 ounce of dough and forming it into a ball. Place the ball on a flat surface and roll it into a 4-inch round with a rolling pin. Repeat with the remaining dough",
                    isOptional: false
                ),
                Direction(
                    description: "Spray a steamer pan with cooking spray",
                    isOptional: true
                ),
                Direction(
                    description: "Place a tablespoon of the chicken filling in the middle of a wrapper. Holding the wrapper in your left hand. Use your right thumb and index finger to start pinching the edges of the wrapper together. Pinch and fold until the edges of the circle close up like a little satchel. Place the momo in the prepared steamer pan. Repeat with remaining wrappers and filling",
                    isOptional: false
                ),
                Direction(
                    description: "Fill the steamer pot halfway with water and bring to a boil. Set the steamer pan with the momos on top of the pot and cover with a tight lid. Steam the momos until cooked, 8 to 9 minutes.",
                    isOptional: false
                )
            ],
            ingredients: [
                Ingredient(
                    name: "Flour",
                    unit: .cups,
                    quantity: 4
                ),
                Ingredient(
                    name: "Ground Chicken",
                    unit: .g,
                    quantity: 1000
                ),
                Ingredient(
                    name: "Fresh Cilantro",
                    unit: .cups,
                    quantity: 1
                ),
                Ingredient(
                    name: "Onions",
                    unit: .cups,
                    quantity: 1
                ),
                Ingredient(
                    name: "Cumins",
                    unit: .tsp,
                    quantity: 2
                ),
                Ingredient(
                    name: "Salt and Pepper",
                    unit: .tsp,
                    quantity: 1
                )
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Some Cake",
                    authorName: "Jane Doe",
                    description: "Prettiest and tastiest poke cake!",
                    category: RecipeInformation.Category.dessert
                ),
            directions: [
                Direction(
                    description: "In large bowl, beat cake mix, water, oil and egg whites with electric mixer on low speed 30 seconds. Beat on medium speed 2 minutes, scraping bowl occasionally. Pour into pan",
                    isOptional: false
                ),
                Direction(
                    description: "Bake 28 to 32 minutes or until toothpick inserted in center comes out clean. Cool on cooling rack 20 minutes",
                    isOptional: false
                ),
                Direction(
                    description: "Meanwhile, in medium bowl, pour boiling water on gelatin; stir until gelatin is dissolved. Poke cake every inch with handle of wooden spoon or tines of meat fork halfway into cake. Carefully pour strawberry gelatin evenly over top of cake. Cool completely, about 1 hour",
                    isOptional: false
                ),
                Direction(
                    description: "Spread frosting over top of cake. Drizzle red decorating gel over frosting. Cut into 4 rows by 3 rows. Garnish each piece of cake with strawberries.",
                    isOptional: true
                )
            ],
            ingredients: [
                Ingredient(
                    name: "Cake mix",
                    unit: .none,
                    quantity: 1
                ),
                Ingredient(
                    name: "Water",
                    unit: .cups,
                    quantity: 1
                ),
                Ingredient(
                    name: "Jell-O strawberry flavored gelatin",
                    unit: .oz,
                    quantity: 1
                ),
                Ingredient(
                    name: "Strawberries",
                    unit: .none,
                    quantity: 12
                ),
                Ingredient(
                    name: "Eggs",
                    unit: .none,
                    quantity: 4
                )
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Some dinner",
                    authorName: "Grandma",
                    description: "Dal Bhat Recipe from Nepal",
                    category: RecipeInformation.Category.dinner
                ),
            directions: [
                Direction(
                    description: "Put the rice on to cook when appropriate. I prefer to use a rice cooker for this",
                    isOptional: false
                ),
                Direction(
                    description: "Chop your onion, garlic and ginger and tomato",
                    isOptional: false
                ),
                Direction(
                    description: "Heat oil on high in a large pan",
                    isOptional: true
                ),
                Direction(
                    description: "Add chopped tomato and butter or ghee (optional). Stir, cover and cook for a couple of minutes.",
                    isOptional: false
                ),
                Direction(
                    description: "Season with sea salt and white pepper if needed.",
                    isOptional: false
                )
            ],
            ingredients: [
                Ingredient(
                    name: "Coriander leaf",
                    unit: .tsp,
                    quantity: 2
                ),
                Ingredient(
                    name: "Ginger",
                    unit: .tbs,
                    quantity: 1
                ),
                Ingredient(
                    name: "Onion",
                    unit: .none,
                    quantity: 1
                ),
                Ingredient(
                    name: "Cardamom Powder",
                    unit: .tsp,
                    quantity: 1
                ),
                Ingredient(
                    name: "Salt",
                    unit: .tsp,
                    quantity: 4
                ),
                Ingredient(
                    name: "Rice",
                    unit: .cups,
                    quantity: 2
                )
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "A breakie",
                    authorName: "John doe",
                    description: "Spiced tea",
                    category: RecipeInformation.Category.breakfast
                ),
            directions: [
                Direction(
                    description: "Steep tea in boiling water",
                    isOptional: false
                ),
                Direction(
                    description: "Add milk, sugar, cloves, cardamom and cinnamon stick",
                    isOptional: false
                ),
                Direction(
                    description: "Simmer 10 minutes to blend flavors",
                    isOptional: false
                ),
                Direction(
                    description: "Strain and serve hot",
                    isOptional: false
                )
            ],
            ingredients: [
                Ingredient(
                    name: "Tea",
                    unit: .tsp,
                    quantity: 3
                ),
                Ingredient(
                    name: "Milk",
                    unit: .cups,
                    quantity: 2
                ),
                Ingredient(
                    name: "Water",
                    unit: .cups,
                    quantity: 1
                ),
                Ingredient(
                    name: "Cloves",
                    unit: .none,
                    quantity: 4
                ),
                Ingredient(
                    name: "Cinnamon Stick",
                    unit: .none,
                    quantity: 1
                )
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Luncheon",
                    authorName: "Sam",
                    description: "Delicious Nepalese momos",
                    category: RecipeInformation.Category.lunch
                ),
            directions: [
                Direction(
                    description: "Mix together the flour and 1 1/2 cups room temperature water in a bowl. Knead the dough well until it is medium-firm and flexible. Cover and let rest for 1 hour",
                    isOptional: false
                ),
                Direction(
                    description: "Meanwhile, mix together the chicken, cilantro, onions, garlic, ginger, cumin, cinnamon, 2 tablespoons salt and 1/2 teaspoon pepper in a bowl",
                    isOptional: false
                ),
                Direction(
                    description: "To make the wrappers: Break off 1/2 ounce of dough and forming it into a ball. Place the ball on a flat surface and roll it into a 4-inch round with a rolling pin. Repeat with the remaining dough",
                    isOptional: false
                ),
                Direction(
                    description: "Spray a steamer pan with cooking spray",
                    isOptional: true
                ),
                Direction(
                    description: "Place a tablespoon of the chicken filling in the middle of a wrapper. Holding the wrapper in your left hand. Use your right thumb and index finger to start pinching the edges of the wrapper together. Pinch and fold until the edges of the circle close up like a little satchel. Place the momo in the prepared steamer pan. Repeat with remaining wrappers and filling",
                    isOptional: false
                ),
                Direction(
                    description: "Fill the steamer pot halfway with water and bring to a boil. Set the steamer pan with the momos on top of the pot and cover with a tight lid. Steam the momos until cooked, 8 to 9 minutes.",
                    isOptional: false
                )
            ],
            ingredients: [
                Ingredient(
                    name: "Flour",
                    unit: .cups,
                    quantity: 4
                ),
                Ingredient(
                    name: "Ground Chicken",
                    unit: .g,
                    quantity: 1000
                ),
                Ingredient(
                    name: "Fresh Cilantro",
                    unit: .cups,
                    quantity: 1
                ),
                Ingredient(
                    name: "Onions",
                    unit: .cups,
                    quantity: 1
                ),
                Ingredient(
                    name: "Cumins",
                    unit: .tsp,
                    quantity: 2
                ),
                Ingredient(
                    name: "Salt and Pepper",
                    unit: .tsp,
                    quantity: 1
                )
            ]
        ),
        
        Recipe(
            recipeInformation:
                RecipeInformation(
                    name: "Rasmalai",
                    authorName: "Jane Doe",
                    description: "Prettiest and tastiest poke cake!",
                    category: RecipeInformation.Category.dessert
                ),
            directions: [
                Direction(
                    description: "In large bowl, beat cake mix, water, oil and egg whites with electric mixer on low speed 30 seconds. Beat on medium speed 2 minutes, scraping bowl occasionally. Pour into pan",
                    isOptional: false
                ),
                Direction(
                    description: "Bake 28 to 32 minutes or until toothpick inserted in center comes out clean. Cool on cooling rack 20 minutes",
                    isOptional: false
                ),
                Direction(
                    description: "Meanwhile, in medium bowl, pour boiling water on gelatin; stir until gelatin is dissolved. Poke cake every inch with handle of wooden spoon or tines of meat fork halfway into cake. Carefully pour strawberry gelatin evenly over top of cake. Cool completely, about 1 hour",
                    isOptional: false
                ),
                Direction(
                    description: "Spread frosting over top of cake. Drizzle red decorating gel over frosting. Cut into 4 rows by 3 rows. Garnish each piece of cake with strawberries.",
                    isOptional: true
                )
            ],
            ingredients: [
                Ingredient(
                    name: "Cake mix",
                    unit: .none,
                    quantity: 1
                ),
                Ingredient(
                    name: "Water",
                    unit: .cups,
                    quantity: 1
                ),
                Ingredient(
                    name: "Jell-O strawberry flavored gelatin",
                    unit: .oz,
                    quantity: 1
                ),
                Ingredient(
                    name: "Strawberries",
                    unit: .none,
                    quantity: 12
                ),
                Ingredient(
                    name: "Eggs",
                    unit: .none,
                    quantity: 4
                )
            ]
        )
        
    ]
}
