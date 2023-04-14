import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

import '../screen/home.dart';
import '../screen/home_screen.dart';

class AddProductPage2 extends StatefulWidget {
  @override
  _AddProductPage2State createState() => _AddProductPage2State();
}

class _AddProductPage2State extends State<AddProductPage2> {
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _salepriceController = TextEditingController();

  String _saleOption = 'Sale';

  File? _image3;

  Future<void> _getImage(ImageSource imageSource, int imageNumber) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image3 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _submitForm() async {
    if (_productNameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        (_image3 == null)) {
      return;
    }

    final storage = FirebaseStorage.instance;
    final productsRef = storage.ref().child('products');
    final productName = _productNameController.text;
    final priceName = _priceController.text;
    final saleName = _salepriceController.text;

    final saleOption = _saleOption;
    final imageUrls = [];

    if (_image3 != null) {
      final imageRef = productsRef.child('${productName}_3.jpg');
      final uploadTask = imageRef.putFile(_image3 as File);
      final snapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(imageUrl);
    }

    final productsCollection =
        FirebaseFirestore.instance.collection('products');
    await productsCollection.add({
      'productName': productName,
      'saleOption': saleOption,
      "price": priceName,
      "saleprice": saleName,
      'imageUrls': imageUrls,
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductsPage2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _imagePickerButton(3),
                ],
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _productNameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _salepriceController,
                decoration: const InputDecoration(
                  labelText: 'Product sale Price',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Product previous price',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sale'),
                  Radio(
                    value: 'Sale',
                    groupValue: _saleOption,
                    onChanged: (value) {
                      setState(() {
                        _saleOption = value!;
                      });
                    },
                  ),
                  SizedBox(width: 16.0),
                  Text('Wholesale'),
                  Radio(
                    value: 'Wholesale',
                    groupValue: _saleOption,
                    onChanged: (value) {
                      setState(() {
                        _saleOption = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Product'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductsPage2()),
                  );
                },
                child: Text('home page'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imagePickerButton(int imageNumber) {
    File? image;
    if (imageNumber == 3) {
      image = _image3;
    }

    return Column(
      children: [
        IconButton(
          icon: Icon(Icons.add_a_photo),
          onPressed: () {
            _getImage(ImageSource.gallery, imageNumber);
          },
        ),
        SizedBox(height: 8.0),
        image == null
            ? Text('Image $imageNumber')
            : Image.file(
                image,
                height: 100,
                width: 100,
              ),
      ],
    );
  }
}
