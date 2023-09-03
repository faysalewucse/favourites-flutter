import 'dart:convert';
import 'package:fav_task2/providers/favourites.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FavouriteItems extends StatefulWidget {
  const FavouriteItems({super.key});

  @override
  State<FavouriteItems> createState() => _FavouriteItemsState();
}

class _FavouriteItemsState extends State<FavouriteItems> {
  late List<dynamic> favourite_items;
  var all_favourite_items;
  bool loading = true;

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://list.ly/api/v4/lists/trending?page=1&per_page=10'));

    if (response.statusCode == 200) {
      setState(() {
        favourite_items = json.decode(response.body)['lists'];
        all_favourite_items = favourite_items;
        loading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void filterList(String query){

    if(query == ""){
      setState(() {
        favourite_items = all_favourite_items;
      });
    }
    else{
      setState(() {
        favourite_items = favourite_items.where((item) => item['owner']['name'].toLowerCase().contains(query.toLowerCase())).toList();
      });
    }
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
     fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final favourites = Provider.of<Favourites>(context);
    final List<dynamic> favedList = favourites.faved;

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
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Adjust padding as needed
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey), // Border color when the field is focused
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: const Icon(Icons.search, color: Colors.grey), // Adjust icon color
                hintText: 'Search for items', // Placeholder text
                hintStyle: const TextStyle(color: Colors.grey), // Placeholder text style
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
                        itemCount: favourite_items.length,
                        itemBuilder: (context, index) {
                          final item = favourite_items[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(
                                            48), // Image radius
                                        child: Image.network(
                                          "https:" + item['share']['image'],
                                          height: 40,
                                          width: 40,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Name: " + item['owner']['name']),
                                        SizedBox(
                                          width: 150,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Share Source:",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                  item['share']['shareSource']),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if(favedList.contains(item[index])){
                                              int idx = favedList.indexOf(item[index]);
                                              favourites.removeFav(idx);
                                            }
                                            else{
                                              favourites.addToFav(item[index]);
                                            }
                                          });
                                        },
                                        child: favedList.contains(item[index])
                                            ? const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : const Icon(Icons.favorite_border))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Share Description:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    Text(item['share']['shareDescription']),
                                  ],
                                ),
                                // "https:"+item['share']['image'],
                              ],
                            ),
                          );
                        },
                      )),
          ],
        ),
      ),
    );
  }
}
