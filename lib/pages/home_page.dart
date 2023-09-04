import 'package:fav_task2/cards/fav_item_card.dart';
import 'package:fav_task2/controllers/favourites_controller.dart';
import 'package:fav_task2/pages/favourite_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FavouriteController favouriteController = Get.put(FavouriteController());

  List<dynamic> checkboxes = [
    {
      "id": 1,
      "title": "Box 1",
    },
    {
      "id": 2,
      "title": "Box 2",
    },
    {
      "id": 3,
      "title": "Box 3",
    }
  ];
  List checked = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Hey, Welcome Back",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isDismissible: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(// this is new
                              builder:
                                  (BuildContext context, StateSetter setSt) {
                            return SizedBox(
                                height: 350,
                                width: double.infinity,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 20.0,
                                          bottom: 15.0),
                                      child: const Text(
                                        'CheckBox List',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontFamily: 'Jost',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        height: 80,
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0),
                                        child: ListView.builder(

                                            itemCount: checkboxes.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(checkboxes[index]
                                                        ["title"]),
                                                    GestureDetector(
                                                      onTap:(){
                                                        setSt((){
                                                          if(checked.contains(checkboxes[index]['id'])
                                                          ){
                                                            checked.remove(checkboxes[index]['id']);
                                                          }
                                                          else{
                                                            checked.add(checkboxes[index]['id']);
                                                          }
                                                        });
                                                      },
                                                      child: checked.contains(checkboxes[index]['id']) ? const Icon(Icons.circle_outlined) : const Icon(Icons.check_circle_rounded) )

                                                  ],
                                                ),
                                              );
                                            })),
                                  ],
                                ));
                          });
                        });
                  },
                  child: const Icon(
                    Icons.waving_hand,
                    color: Colors.orange,
                    size: 30,
                  ),
                )
              ],
            ),
            Expanded(
                child: Obx(() => favouriteController
                        .favourites.value.favourites_items.isEmpty
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No Items to show now",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 25),
                          ),
                          Text("Please add some favourite items to see here",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ],
                      )
                    : ListView.builder(
                        itemCount: favouriteController
                            .favourites.value.favourites_items.length,
                        itemBuilder: (context, index) {
                          final item = favouriteController
                              .favourites.value.favourites_items[index];
                          return favCard(item, favouriteController);
                        },
                      )))
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextButton(
            onPressed: () {
              Get.to(const FavouriteItems());
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
