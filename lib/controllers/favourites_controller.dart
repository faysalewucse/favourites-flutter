import 'package:fav_task2/models/user.dart';
import 'package:fav_task2/states/favourites.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController{
  final favourites = Favourites(favourites_items: []).obs;

  void addToFavouritesList (User item){
    favourites.update((favourites) {
      if(favourites!.favourites_items.contains(item)){
        int idx = favourites.favourites_items.indexOf(item);
        favourites.favourites_items.removeAt(idx);
      }
      else
      {
        favourites.favourites_items.add(item);
      }
    });
  }

  bool isFavorite(User item) {
    return favourites.value.favourites_items.contains(item);
  }
}