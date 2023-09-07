import 'dart:convert';

import 'package:fav_task2/cards/fav_item_card.dart';
import 'package:fav_task2/controllers/favourites_controller.dart';
import 'package:fav_task2/models/user.dart';
import 'package:fav_task2/pages/favourite_items.dart';
import 'package:fav_task2/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FavouriteController favouriteController = Get.put(FavouriteController());
  bool loading = true;

  late List<User> fetchedData = [];
  late List<User> userData = [];
  late List<User> userDataCopy = [];

  void filterList(String query) {
    if (query == "") {
      setState(() {
        userData = userDataCopy;
      });
    } else {
      setState(() {
        userData = userData
            .where((item) => item.owner.name
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://list.ly/api/v4/lists/trending?page=1&per_page=10'));

    if (response.statusCode == 200) {
      setState(() {
        userData = (jsonDecode(response.body)['lists'] as List)
            .map((e) => User.fromJson(e))
            .toList();
        loading = false;
      });
      debugPrint("=====.. api data: ${userData.map((e) => e.toJson())}");
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    userData = favouriteController.favourites.value.favourites_items;
    userDataCopy = favouriteController.favourites.value.favourites_items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Restaurant",
          style: textBoldMd,
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black87,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hey, Welcome Back",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.waving_hand,
                        color: Colors.orange,
                        size: 30,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Obx(() => favouriteController
                              .favourites.value.favourites_items.isNotEmpty
                          ? Column(
                              children: [
                                TextField(
                                  onChanged: filterList,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12.0),
                                    // Adjust padding as needed
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Adjust border radius as needed
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      // Border color when the field is focused
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    suffixIcon: const Icon(Icons.search,
                                        color: Colors.grey),
                                    // Adjust icon color
                                    hintText: 'Search for items',
                                    // Placeholder text
                                    hintStyle: const TextStyle(
                                        color: Colors
                                            .grey), // Placeholder text style
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: userData.length,
                                    itemBuilder: (context, index) {
                                      final item = userData[index];
                                      return favCard(item);
                                    },
                                  ),
                                ),
                              ],
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "No Items to show now",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 25),
                                ),
                                Text(
                                    "Please add some favourite items to see here",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)),
                              ],
                            ))),
                ],
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextButton(
            onPressed: () {
              Get.to(const FavouriteItems(), arguments: userData);
            },
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                foregroundColor: Colors.white,
                elevation: 2,
                backgroundColor: Colors.black87),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Add Favourite Items",
              ),
            )),
      ),
    );
  }
}
