import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  late int id;
  late String name;
  late String image;
  late double price;
  ProductModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.price});
  Map<String, dynamic> toMap() {
    return {
      'pro_id': id,
      'pro_name': name,
      'pro_image': image,
      'pro_price': price
    };
  }

  ProductModel.fromDocumentSnapshot(DocumentSnapshot doc)
      : id = doc['pro_id'],
        name = doc['pro_name'],
        image = doc['pro_image'],
        price = doc['pro_price'];
}
