import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/models/product_model.dart';
import 'package:flutter_application/product_item.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ProductModel> products = List<ProductModel>.empty(growable: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products.add(ProductModel(
        id: "1", productName: "aaa", productImage: "", productPrice: 500));
    products.add(ProductModel(
        id: "2",
        productName: "bbb",
        productImage: "http://localhost:5000/uploads/1657443600962--fff.png",
        productPrice: 5300));
  }

  Widget productList(products) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/add-product");
                  },
                  style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.green,
                      minimumSize: const Size(88, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: const Text("Add Product"),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ListView.builder(
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ProductItem(
                      model: products[index],
                      onDelete: (ProductModel model) {},
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Node JS - CRUD App"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: productList(products),
    );
  }
}
