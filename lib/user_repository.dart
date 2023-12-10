import 'package:open_weight_tracker/main.dart';
import 'package:open_weight_tracker/objectbox.g.dart';
import 'models.dart';

class UserRepository {
  //User? get(id) => objectBox.userBox.get(id);

  void save(User user) {
    if (getUserByName(user.name) != null) {
      throw Error();
    } else {
      objectBox.userBox.put(user);
    }
  }

  User? getCurrentUser() {
    Query<User> query =
        objectBox.userBox.query(User_.isCurrentUser.equals(true)).build();
    final user = query.findFirst();
    return user;
  }

  User? getUserById(int id) => objectBox.userBox.get(id);

  User? getUserByName(String name) {
    Query<User> query =
        objectBox.userBox.query(User_.name.equals(name)).build();
    final user = query.findFirst();
    return user;
  }

  bool isValidUserName(String userName) {
    if (getUserByName(userName) == null) {
      return true;
    } else {
      return false;
    }
  }
}
// docker run --rm -it --volume F:\"System User folders"\Tiedostot\weight_loss_obx-store:/db --publish 8081:8081 objectboxio/admin:latest