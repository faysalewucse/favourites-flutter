import 'package:flutter/foundation.dart';

class Favourites with ChangeNotifier, DiagnosticableTreeMixin {
  late List<dynamic> _faved;

  List<dynamic> get faved => _faved;

  void addToFav(dynamic value) {
    _faved.add(value);
    notifyListeners();
  }

  void removeFav(int index) {
    _faved.removeAt(index);
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<dynamic>('faved', faved));
  }
}
