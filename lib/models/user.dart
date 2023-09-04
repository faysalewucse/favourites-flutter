import 'package:fav_task2/models/owner.dart';
import 'package:fav_task2/models/share.dart';

class User {
  final Owner owner;
  final Share share;

  User({required this.owner, required this.share});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      owner: Owner.fromJson(json['owner']),
      share: Share.fromJson(json['share'])
    );
  }

  Map<String, dynamic> toJson() => {
    'owner': owner,
    'share': share
  };

}

