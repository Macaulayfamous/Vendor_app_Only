import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vendor_app_only/vendor/provider/product_provider.dart';

class ImagesScreen extends StatefulWidget {
  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();

  List<File> _image = [];

  List<String> _imageUrlList = [];

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('no Image Picked');
    } else {
      setState(() {
        _image.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider = Provider.of(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          GridView.builder(
              shrinkWrap: true,
              itemCount: _image.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3 / 3,
                  crossAxisSpacing: 8),
              itemBuilder: (context, index) {
                return index == 0
                    ? Center(
                        child: IconButton(
                          onPressed: () {
                            chooseImage();
                          },
                          icon: Icon(
                            Icons.add,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(
                              _image[index - 1],
                            ),
                          ),
                        ),
                      );
              }),
         if(_image.isNotEmpty)
          ElevatedButton(
            onPressed: () async {
              EasyLoading.show(status: 'PLEASE WAIT');
              for (var img in _image) {
                Reference ref =
                    _storage.ref().child('productImages').child(Uuid().v4());

                await ref.putFile(img).whenComplete(() async {
                  await ref.getDownloadURL().then((value) {
                    setState(() {
                      _imageUrlList.add(value);
                    });
                  });

                  EasyLoading.dismiss();
                });

                _productProvider.getFormData(imageUrlList: _imageUrlList);
              }
            },
            child: Text('Upload Images'),
          ),
        ],
      ),
    ));
  }
}
