
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';

// // import '../image/multiimage.dart';

// // class ProductsPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Products'),
// //         actions: [
// //           IconButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => AddProductPage()),
// //                 );
// //               },
// //               icon: const Icon(Icons.add))
// //         ],
// //       ),
// //       body: Column(
// //         crossAxisAlignment: CrossAxisAlignment.stretch,
// //         children: [
// //           _buildProductList(context, 'Sale'),
// //           _buildProductList(context, 'Wholesale'),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildProductList(BuildContext context, String saleOption) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
// //           child: Text(
// //             saleOption,
// //             style: const TextStyle(
// //               fontWeight: FontWeight.bold,
// //               fontSize: 20.0,
// //             ),
// //           ),
// //         ),
// //         SizedBox(
// //           height: 200.0,
// //           child: StreamBuilder<QuerySnapshot>(
// //             stream: FirebaseFirestore.instance
// //                 .collection('products')
// //                 .where('saleOption', isEqualTo: saleOption)
// //                 .snapshots(),
// //             builder: (context, snapshot) {
// //               if (!snapshot.hasData) {
// //                 return const Center(child: CircularProgressIndicator());
// //               }

// //               final products = snapshot.data!.docs;
// //               if (products.isEmpty) {
// //                 return const Center(child: Text('No Products Found'));
// //               }

// //               return ListView.builder(
// //                 scrollDirection: Axis.horizontal,
// //                 itemCount: snapshot.data!.docs.length,
// //                 itemBuilder: (context, index) {
// //                   final product = products[index];
// //                   final productName = product['productName'];
                  
// //                   final imageUrls = List<String>.from(product['imageUrls']);

// //                   return Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         SizedBox(
// //                           height: 150.0,
// //                           width: 150.0,
// //                           child: Image.network(
// //                             imageUrls[0],
// //                             fit: BoxFit.cover,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 8.0),
// //                         Text(
// //                           productName,
// //                           style: const TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 16.0,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               );
// //             },
// //           ),
// //         ),
// //         const SizedBox(height: 16.0),
// //       ],
// //     );
// //   }
// // }

// mport 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class MyCarousel extends StatefulWidget {
//   @override
//   _MyCarouselState createState() => _MyCarouselState();
// }

// class _MyCarouselState extends State<MyCarousel> {
//   int _currentIndex = 0;

//   final List<String> _images = [    'https://picsum.photos/400/300?img=1',    'https://picsum.photos/400/300?img=2',    'https://picsum.photos/400/300?img=3',    'https://picsum.photos/400/300?img=4',    'https://picsum.photos/400/300?img=5',  ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider.builder(
//           itemCount: _images.length,
//           options: CarouselOptions(
//             height: 200,
//             viewportFraction: 1.0,
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//           ),
//           itemBuilder: (BuildContext context, int index) {
//             return Image.network(_images[index]);
//           },
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: _images.asMap().entries.map((entry) {
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentIndex = entry.key;
//                 });
//               },
//               child: Container(
//                 width: 8.0,
//                 height: 8.0,
//                 margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _currentIndex == entry.key ? Colors.blue : Colors.grey,
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }