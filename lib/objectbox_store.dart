import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'models.dart';
import '../generated/objectbox.g.dart'; // created by `flutter pub run build_runner build`

class ObjectBox {
  late final Store store;
  late final Box<User> userBox;
  late final Box<WeighIn> weighInBox;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    userBox = Box<User>(store);
    weighInBox = Box<WeighIn>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(
        directory: p.join(docsDir.path, "weight_loss_obx-store"));
    return ObjectBox._create(store);
  }
}
