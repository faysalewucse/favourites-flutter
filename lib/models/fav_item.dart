class FavItem {
  String? _id;
  String? _name;
  String? _shareSource;
  String? _shareDescription;
  String? _image;

  FavItem(this._id, this._name, this._shareSource, this._shareDescription, this._image);

  // Getter and Setter for _id
  String? get id => _id;
  set id(String? id) {
    _id = id;
  }

  // Getter and Setter for _name
  String? get name => _name;
  set name(String? name) {
    _name = name;
  }

  // Getter and Setter for _shareSource
  String? get shareSource => _shareSource;
  set shareSource(String? shareSource) {
    _shareSource = shareSource;
  }

  // Getter and Setter for _shareDescription
  String? get shareDescription => _shareDescription;
  set shareDescription(String? shareDescription) {
    _shareDescription = shareDescription;
  }

  // Getter and Setter for _image
  String? get image => _image;
  set image(String? image) {
    _image = image;
  }
}
