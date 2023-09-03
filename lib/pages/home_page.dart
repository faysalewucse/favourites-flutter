import 'package:fav_task2/pages/favourite_items.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hey, Welcome Back",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.waving_hand,
                  color: Colors.orange,
                  size: 30,
                )
              ],
            ),
            Expanded(
                child: Column(
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
                        fontWeight: FontWeight.bold, color: Colors.grey)),
              ],
            ))
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextButton(
          // Within the `FirstRoute` widget
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavouriteItems()),
              );
            },
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              foregroundColor: Colors.white,
              elevation: 2,
              backgroundColor: Colors.black87),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Add Favourite Items",
            ),
          ),
        ),
      ),
    );
  }
}
