import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id = 0;

  String? name;
  String? age;
  String? height;
  bool? isMale;
  List? weightIns;
}
