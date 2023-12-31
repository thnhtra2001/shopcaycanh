import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../models/product.dart';

import '../shared/dialog_utils.dart';

import '../products/products_manager.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  EditProductScreen(
    Product? product, {
    super.key,
  }) {
    if (product == null) {
      this.product = Product(
        id: null,
        title: '',
        price: 0,
        description: '',
        imageUrl: '',
        owner: '',
        origin: '',
        status: '',
        type: '',
        sl: 0,
        price0: 0
      );
    } else {
      this.product = product;
    }
  }

  late final Product product;
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Product _editedProduct;

  var _isLoading = false;
  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') ||
        value.startsWith('https') && (value.endsWith('.png')) ||
        value.endsWith('.jpg') ||
        value.endsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editedProduct = widget.product;
    _imageUrlController.text = _editedProduct.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final productsManager = context.read<ProductsManager>();
      if (_editedProduct.id != null) {
        await productsManager.updateProduct(_editedProduct);
      } else {
        await productsManager.addProduct(_editedProduct);
      }
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong.');
    }
    setState(() {
      _isLoading = false;
    });
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: <Widget>[
                    buildTitleField(),
                    buildOwnerField(),
                    buildTypeField(),
                    buildOriginField(),
                    buildStatusField(),
                    buildSLField(),
                    buildPrice0Field(),
                    buildPriceField(),
                    buildDescriptionField(),
                    buildProductPreview(),
                  ],
                ),
              ),
            ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedProduct.title,
      decoration: const InputDecoration(labelText: 'Tên cây cảnh'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(title: value);
      },
    );
  }

    TextFormField buildOwnerField() {
    return TextFormField(
      initialValue: _editedProduct.owner,
      decoration: const InputDecoration(labelText: 'Người bán'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(owner: value);
      },
    );
  }

      TextFormField buildTypeField() {
    return TextFormField(
      initialValue: _editedProduct.type,
      decoration: const InputDecoration(labelText: 'Loại cây'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(type: value);
      },
    );
  }

    TextFormField buildOriginField() {
    return TextFormField(
      initialValue: _editedProduct.origin,
      decoration: const InputDecoration(labelText: 'Xuất xứ'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(origin: value);
      },
    );
  }
    TextFormField buildStatusField() {
    return TextFormField(
      initialValue: _editedProduct.title,
      decoration: const InputDecoration(labelText: 'Tình trạng'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(status: value);
      },
    );
  }
    TextFormField buildPrice0Field() {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    return TextFormField(
      initialValue: formatCurrency.format(_editedProduct.price0),
      decoration: const InputDecoration(labelText: 'Giá gốc'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')),],
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a price';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        if (int.parse(value) <= 0) {
          return 'Please enter a number greater than zero';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(price0: int.parse(value!));
      },
    );
  }
  TextFormField buildSLField() {
    return TextFormField(
      initialValue: _editedProduct.sl.toString(),
      decoration: const InputDecoration(labelText: 'Số lượng'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a price';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        if (int.parse(value) <= 0) {
          return 'Please enter a number greater than zero';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(sl: int.parse(value!));
      },
    );
  }
  TextFormField buildPriceField() {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    return TextFormField(
      initialValue: formatCurrency.format(_editedProduct.price),
      decoration: const InputDecoration(labelText: 'Giá bán'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')),],
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a price';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        if (int.parse(value) <= 0) {
          return 'Please enter a number greater than zero';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(price: int.parse(value!));
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedProduct.description,
      decoration: const InputDecoration(labelText: 'Mô tả'),
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description';
        }
        if (value.length < 10) {
          return 'Should be at least 10 character long.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(description: value);
      },
    );
  }

  Widget buildProductPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageUrlController.text.isEmpty
              ? const Text('Ảnh')
              : FittedBox(
                  child: Image.network(
                    _imageUrlController.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: buildImageURLField(),
        ),
      ],
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL cây cảnh'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an image URL';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(imageUrl: value);
      },
    );
  }
}
