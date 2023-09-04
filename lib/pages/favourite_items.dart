import 'dart:convert';
import 'package:fav_task2/cards/fav_item_card.dart';
import 'package:fav_task2/controllers/favourites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class FavouriteItems extends StatefulWidget {
  const FavouriteItems({super.key});

  @override
  State<FavouriteItems> createState() => _FavouriteItemsState();
}

class _FavouriteItemsState extends State<FavouriteItems> {
  late List<User> userData = [];
  late List<User> userDataCopy;
  
  bool loading = true;

  FavouriteController favouriteController = Get.put(FavouriteController());

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://list.ly/api/v4/lists/trending?page=1&per_page=10'));

    if (response.statusCode == 200) {
      setState(() {
        userData = (jsonDecode(response.body)['lists'] as List).map((e) => User.fromJson(e)).toList();
        loading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void filterList(String query) {
    if (query == "") {
      setState(() {
        userData = userDataCopy;
      });
    } else {
      setState(() {
        userData = userData
            .where((item) => item.owner.name.toString().toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Search",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              onChanged: filterList,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                // Adjust padding as needed
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust border radius as needed
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors
                          .grey), // Border color when the field is focused
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: const Icon(Icons.search, color: Colors.grey),
                // Adjust icon color
                hintText: 'Search for items',
                // Placeholder text
                hintStyle: const TextStyle(
                    color: Colors.grey), // Placeholder text style
              ),
            ),
            Expanded(
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black87,
                        ),
                      )
                    : ListView.builder(
                        itemCount: userData.length,
                        itemBuilder: (context, index) {
                          final item = userData[index];
                          return favCard(item, favouriteController);
                        },
                      )),
          ],
        ),
      ),
    );
  }
}
