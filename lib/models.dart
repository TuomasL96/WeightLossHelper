import 'dart:ffi';

import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int? id;

  String? name;
  String? age;
  String? height;
  bool? isMale;
  List? weightIn;

  User(this.name, this.age, this.height, this.isMale, {this.id = 0});
}

@Entity()
class WeightIn {
  int? id;

  DateTime? dateTime;
  int? weight;
}
