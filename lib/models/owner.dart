class Owner{
  int? id;
  String? name;

  Owner.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

