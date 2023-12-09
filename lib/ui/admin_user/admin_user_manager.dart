import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/models/user_use_app.dart';
import '../../models/product.dart';

import 'package:flutter/foundation.dart';
import '../../models/auth_token.dart';
import '../../services/user_service.dart';

class AdminUserManager with ChangeNotifier {
  final UserService _userService = UserService();
  List<UserUseApp> _users = [];
  int get allUserCount {
    return _users.length;
  }
    List<UserUseApp> get allUser {
    return [..._users];
  }
  Future<void> fetchAllUser() async {
    _users = await _userService.fetchAllUser();
    print("#################################");
    print(_users.length);
    notifyListeners();
  }


  Future<void> deleteUser(String id) async {
    print("DELETE UID");
    print(id);
    final index = _users.indexWhere((item) => item.uid == id);
    UserUseApp? existingProduct = _users[index];
    _users.removeAt(index);
    notifyListeners();

    if (!await _userService.deleteUser(id)) {
      _users.insert(index, existingProduct);
      notifyListeners();
    }
  }
}
