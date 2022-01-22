import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  /// Product ID.
  String? id;

  /// Product owner id.
  String? ownerId;

  /// Product owner name.
  String? ownerName;

  /// Product owner photo url.
  String? ownerPhoto;

  /// Product owner university.
  String? university;
  String? ownerLight;

  /// Product description.
  String? description;

  /// Product Hashtags.
  List tags;

  /// Product creation date.
  Timestamp? createAt;

  /// Product price.
  double price;

  /// Product currency.
  String? currency;

  /// Product photos.
  List photos;

  /// Product status.
  bool isSold;

  Products({
    this.id,
    required this.ownerId,
    required this.ownerName,
    required this.ownerPhoto,
    required this.university,
    required this.description,
    required this.price,
    required this.photos,
    required this.currency,
    this.isSold = false,
    this.tags = const [],
    this.createAt,
    this.ownerLight,
  });

  factory Products.fromMap(Map<String, dynamic> data, {String? uid}) => Products(
        id: uid,
        description: data["description"],
        price: data["price"],
        photos: data["photos"],
        currency: data["currency"],
        ownerId: data["owner"]["id"],
        ownerName: data["owner"]["name"],
        ownerPhoto: data["owner"]["photo_url"],
        university: data["owner"]["university"],
        isSold: data["is_sold"],
        tags: data["tags"],
        createAt: data["created_at"],
        ownerLight: data["light"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "data": {
          "owner": {
            "id": ownerId,
            "name": ownerName,
            "photo_url": ownerPhoto,
            "university": university,
            "light": ownerLight
          },
          "description": description,
          "price": price,
          "currency": currency,
          "photos": photos,
          "is_sold": isSold,
          "tags": tags,
          "created_at": createAt ?? Timestamp.now(),
        }
      };
}
