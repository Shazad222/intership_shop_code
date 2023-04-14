import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../image/image2.dart';

class ProductsPage2 extends StatelessWidget {
  int _currentIndex = 0;

  final List<String> _images = [
    'https://upload.wikimedia.org/wikipedia/commons/e/e7/Hania_Aamir_photo.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/7/7b/Katrina_Kaif.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/9/9b/AishwaryaRai.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Row(
            children: [
              const Text("add data"),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProductPage2()),
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: CarouselSlider(
                options: CarouselOptions(height: 200.0, autoPlay: true),
                items: _images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(0, 255, 193, 7),
                        ),
                        child: Image.network(image),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            _buildProductList(context, 'Sale'),
            _buildProductList(context, 'Wholesale'),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(BuildContext context, String saleOption) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              saleOption,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.blueAccent),
            ),
          ),
          SizedBox(
            height: 200.0,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('saleOption', isEqualTo: saleOption)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final products = snapshot.data!.docs;
                if (products.isEmpty) {
                  return const Center(child: Text('No Products Found'));
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final productName = product['productName'];
                    final totalize = product['price'];
                    final salePrice = product['saleprice'];

                    final imageUrls = List<String>.from(product['imageUrls']);

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.network(
                                imageUrls[0],
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 13.0),
                            Text(
                              productName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.blueAccent),
                            ),
                            const SizedBox(height: 6.0),

                            // ignore: prefer_const_constructors
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '\$ ${totalize}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Text(
                                  '   \$ ${salePrice}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 26.0),
        ],
      ),
    );
  }
}
