import 'package:flutter/material.dart';
import '../../models/http_exception.dart';
import 'package:shopcaycanh/ui/shared/app_drawer.dart';

import '../shared/dialog_utils.dart';
import '../../services/user_service.dart';

class PersonalScreen extends StatefulWidget {
  static const routeName = '/personal';

  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late Future<Map<String, dynamic>> _futureFetchUserInformation;

  @override
  void initState() {
    super.initState();
    _futureFetchUserInformation = UserService().fetchUserInformation();
  }

  final Map<String, dynamic> _data = {
    'email': '',
    'phone': '',
    'name': '',
    'birthday': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _birthFieldController =
      ValueNotifier<TextEditingController>(TextEditingController());

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {
      await UserService().updateUserInformation(_data);
    } catch (error) {
      showErrorDialog(context,
          (error is HttpException) ? error.toString() : 'Có lỗi xảy ra');
    }

    _isSubmitting.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Thông tin cá phân')),
      drawer: AppDrawer(),
      body: FutureBuilder<Map<String, dynamic>>(
          future: _futureFetchUserInformation,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Container(
                  alignment: Alignment.topCenter,
                  width: deviceSize.width * 0.95,
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          _buildEmailField(snapshot.data!['email']),
                          _buildNameField(snapshot.data!['name']),
                          _buildPhoneField(snapshot.data!['phone']),
                          _buildBirthField(snapshot.data!['birthday'] ?? ''),
                          const SizedBox(
                            height: 20,
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: _isSubmitting,
                            builder: (context, isSubmitting, child) {
                              if (isSubmitting) {
                                return const CircularProgressIndicator();
                              }
                              return _buildSubmitButton();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        textStyle: TextStyle(
          color: Theme.of(context).primaryTextTheme.titleLarge?.color,
        ),
      ),
      child: Text('Lưu thay đổi'),
    );
  }

  Widget _buildEmailField(initValue) {
    return Column(
      children: [
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          child: const Text('Địa chỉ email:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(bottom: 8),
          child: TextFormField(
            enabled: false,
            initialValue: initValue,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.red, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                prefixIcon: Icon(Icons.email)),
            style: TextStyle(fontSize: 18, color: Colors.grey),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email không hợp lệ!')),
                );
              }
              return null;
            },
            onSaved: (value) {
              _data['email'] = value!;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField(initValue) {
    return Column(
      children: [
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          child: const Text('Số điện thoại:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(bottom: 8),
          child: TextFormField(
            initialValue: initValue,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.red, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                prefixIcon: Icon(Icons.phone)),
            style: TextStyle(fontSize: 18),
            keyboardType: TextInputType.phone,
            validator: (value) {
              String pattern = r'^(?:[+0]9)?[0-9]{10}$';
              RegExp regex = RegExp(pattern);

              if (!regex.hasMatch(value!)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Số điện thoại không hợp lệ!')),
                );
              }
              return null;
            },
            onSaved: (value) {
              _data['phone'] = value!;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNameField(initValue) {
    return Column(
      children: [
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          child: Text('Họ Tên',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Container(
            height: 40,
            margin: EdgeInsets.only(bottom: 8),
            child: TextFormField(
                initialValue: initValue,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    prefixIcon: Icon(Icons.person)),
                style: TextStyle(fontSize: 18),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.length < 5) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tên không hợp lệ!')),
                    );
                  }
                  return null;
                },
                onSaved: (value) {
                  _data['name'] = value!;
                })),
      ],
    );
  }

  Widget _buildBirthField(initValue) {
    _birthFieldController.value.text = initValue;

    return Column(
      children: [
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          child: const Text('Ngày sinh:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(bottom: 8),
          child: ValueListenableBuilder(
              valueListenable: _birthFieldController,
              builder: (context, birthFieldController, child) {
                return TextFormField(
                  controller: _birthFieldController.value,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      prefixIcon: Icon(Icons.calendar_month)),
                  style: TextStyle(fontSize: 18),
                  onTap: () async {
                    DateTime? datePicked = DateTime.now();
                    FocusScope.of(context).requestFocus(new FocusNode());

                    datePicked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));

                    _birthFieldController.value.text = datePicked != null
                        ? datePicked.toString().split(' ')[0]
                        : '';
                  },
                  onSaved: (value) {
                    _data['birthday'] = _birthFieldController.value.text;
                  },
                );
              }),
        ),
      ],
    );
  }
}
