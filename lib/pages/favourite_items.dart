import 'dart:convert';
import 'package:fav_task2/cards/fav_item_card.dart';
import 'package:fav_task2/controllers/favourites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user.dart';

class FavouriteItems extends StatefulWidget {
  const FavouriteItems({super.key});

  @override
  State<FavouriteItems> createState() => _FavouriteItemsState();
}

class _FavouriteItemsState extends State<FavouriteItems> {
  late List<User> userData = [];

  FavouriteController favouriteController = Get.put(FavouriteController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData = Get.arguments;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Favourite Items",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(favouriteController.favourites.value.favourites_items.length.toString()),
            Expanded(
                child: ListView.builder(
                        itemCount: userData.length,
                        itemBuilder: (context, index) {
                          final item = userData[index];
                          return favCard(item);
                        },
                      ),),
          ],
        ),
      ),
    );
  }
}
