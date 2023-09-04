class Share{
  String? shareSource;
  String? shareDescription;
  String? image;

  Share.fromJson(Map<String, dynamic> json){
    shareSource = json['shareSource'];
    shareDescription = json['shareDescription'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() => {
    'shareSource': shareSource,
    'shareDescription': shareDescription,
    'image': image
  };
}