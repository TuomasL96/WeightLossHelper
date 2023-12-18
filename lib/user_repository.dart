import 'package:flutter/material.dart';
import 'package:open_weight_tracker/main.dart';
import 'package:open_weight_tracker/objectbox.g.dart';
import 'models.dart';

class UserRepository {
  late User currentUser = getCurrentUserFromDB();

  void saveUser(User user) {
    if (getUserByName(user.name) != null) {
      throw Error();
    } else {
      objectBox.userBox.put(user);
    }
  }

  void saveManyUsers(List<User> users) {
    objectBox.userBox.putMany(users);
  }

  User getCurrentUserFromDB() {
    Query<User> query =
        objectBox.userBox.query(User_.isCurrentUser.equals(true)).build();
    final user = query.findFirst();
    if (user != null) {
      return user;
    } else {
      throw ErrorDescription('NO CURRENT USER IN');
    }
  }

  bool dbHasCurrentUser() {
    Query<User?> query =
        objectBox.userBox.query(User_.isCurrentUser.equals(true)).build();
    final user = query.findFirst();
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  User getCurrentUser() => currentUser;

  void setCurrentUser(User user) {
    User? oldCurrentUser = currentUser;
    User newCurrentUser = user;
    newCurrentUser.isCurrentUser == true;
    oldCurrentUser.isCurrentUser == false;
    saveManyUsers([oldCurrentUser, newCurrentUser]);
  }

  User? getUserById(int id) => objectBox.userBox.get(id);

  User? getUserByName(String name) {
    Query<User> query =
        objectBox.userBox.query(User_.name.equals(name)).build();
    final user = query.findFirst();
    return user;
  }

  List<User> getAllUsers() => objectBox.userBox.getAll();

  bool isValidUserName(String userName) {
    if (getUserByName(userName) == null) {
      return true;
    } else {
      return false;
    }
  }

  void saveWeighIn(DateTime date, double weight) {
    currentUser.weighIns!.add(WeighIn(date, weight));
  }
}
// docker run --rm -it --volume F:\"System User folders"\Tiedostot\weight_loss_obx-store:/db --publish 8081:8081 objectboxio/admin:latest