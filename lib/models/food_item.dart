class FoodItem{
   final String? id;
   final String? name;
   final String? image;

   FoodItem({required this.id, required this.name, required this.image});

   factory FoodItem.fromJson(Map<String, dynamic> json){
     return FoodItem(
       id: json["idMeal"],
       name: json['strMeal'],
       image: json['strMealThumb'],
     );
   }
}