import 'dart:ffi';
import 'package:open_weight_tracker/main.dart';
import 'package:open_weight_tracker/objectbox.g.dart';
import 'package:open_weight_tracker/objectbox_store.dart';
import 'models.dart';

class UserDataManager {
  void createOrUpdateUser(String name, String age, String height, bool isMale,
      [int? id]) {
    User user = User(
      name = name,
      age = age,
      height = height,
      isMale = isMale,
    );
    if (id != null) {
      User oldUser = findUserById(id);
      oldUser = user;
    }
    objectBox.userBox.put(user);
  }

  User findUserById(int id) {
    Query<User> query = objectBox.userBox.query(User_.id.equals(id)).build();
    final user = query.findFirst();
    query.close();
    if (user != null) {
      return user;
    } else {
      throw Error;
    }
  }
}
