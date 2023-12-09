import 'package:flutter/material.dart';
import 'package:open_weight_tracker/main.dart';
import 'package:open_weight_tracker/objectbox.g.dart';
import 'models.dart';

class UserRepository {
  void save(User user) {
    if (findUserByName(user.name) != null) {
      throw ErrorDescription('User already in DB');
    } else {
      objectBox.userBox.put(user);
    }
  }

  User findUserById(int id) {
    Query<User> query = objectBox.userBox.query(User_.id.equals(id)).build();
    final user = query.findFirst();
    query.close();
    if (user != null) {
      return user;
    } else {
      throw TypeError();
    }
  }

  User? findUserByName(String name) {
    Query<User> query =
        objectBox.userBox.query(User_.name.equals(name)).build();
    final user = query.findFirst();
    return user;
  }
}
// docker run --rm -it --volume F:\"System User folders"\Tiedostot\weight_loss_obx-store:/db --publish 8081:8081 objectboxio/admin:latest