import 'package:fav_task2/controllers/favourites_controller.dart';
import 'package:fav_task2/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget favCard(User item) {
  FavouriteController favouriteController = Get.find();

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      border: Border.all(color: Colors.grey),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(48), // Image radius
                child: Image.network(
                  "https:${item.share.image.toString()}",
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${item.owner.name.toString()}"),
                SizedBox(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Share Source:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      Text(item.share.shareSource.toString()),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                favouriteController.addToFavouritesList(item);
              },
              child: Obx(() {
                final isFavorite =
                favouriteController.isFavorite(item); // Check if the item is a favorite
                return isFavorite
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(
                  Icons.favorite_border,
                );
              }),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Share Description:",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            Text(item.share.shareDescription.toString()),
            Text(favouriteController.isFavorite(item).toString(), style: TextStyle(color: Colors.red, fontSize: 35),),
          ],
        ),
      ],
    ),
  );
}
