import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_app_only/vendor/provider/product_provider.dart';

class AttributesScreen extends StatefulWidget {
  @override
  State<AttributesScreen> createState() => _AttributesScreenState();
}

class _AttributesScreenState extends State<AttributesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _sizeController = TextEditingController();
  bool _isEntered = false;

  bool _isSaved = false;

  List<String> _sizeList = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
             validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Product Brand';
                } else {
                  return null;
                }
              },
            onChanged: (value) {
              _productProvider.getFormData(brandName: value);
            },
            decoration: InputDecoration(
              labelText: 'Brand',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  width: 100,
                  child: TextFormField(
                    controller: _sizeController,
                    onChanged: (value) {
                      setState(() {
                        _isEntered = true;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Size',
                    ),
                  ),
                ),
              ),
              _isEntered == true
                  ? ElevatedButton(
                      onPressed: () {
                        _sizeList.add(_sizeController.text);
                        _sizeController.clear();
                        setState(() {
                          _isEntered = false;
                        });
                      },
                      child: Text(
                        'Add Size',
                      ),
                    )
                  : Text(''),
            ],
          ),
          if (_sizeList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _sizeList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _sizeList.removeAt(index);
                            });

                            _productProvider.getFormData(sizeList: _sizeList);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                _sizeList[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          if (_sizeList.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isSaved = true;
                });
                _productProvider.getFormData(sizeList: _sizeList);
              },
              child: _isSaved
                  ? Text('Saved')
                  : Text(
                      'Save',
                    ),
            ),
        ],
      ),
    );
  }
}
