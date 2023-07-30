import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:combo_shop/crud_image.dart';
import 'package:combo_shop/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeShop extends StatefulWidget {
  const HomeShop({super.key});

  @override
  State<HomeShop> createState() => _HomeShopState();
}

class _HomeShopState extends State<HomeShop> {
  CollectionReference usersdata =
      FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeShop'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageScreen(),
                    ));
              },
              icon: Icon(Icons.image))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersdata.snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasError
              ? const Center(
                  child: Icon(
                    Icons.info,
                    color: Colors.red,
                  ),
                )
              : snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var pro = ProductModel.fromDocumentSnapshot(
                            snapshot.data!.docs[index]);
                        return productCart(pro);
                      },
                    );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var data = ProductModel(
                  id: 234,
                  image:
                      'https://cdn.s-liquor.com.kh/wp-content/uploads/2020/07/Red-Bull-250ml-01.png',
                  name: 'Red Bull',
                  price: 1.6)
              .toMap();

          await FirebaseFirestore.instance.collection('products').add(data);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget productCart(ProductModel pro) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: NetworkImage(pro.image))),
            ),
            Column(
              children: [
                Text(pro.name),
                Text('\$ ${pro.price}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
