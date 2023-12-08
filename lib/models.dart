import 'dart:ffi';

import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int? id;

  String? name;
  String? age;
  String? height;
  bool? isMale;
  List? weightIn;
}

@Entity()
class WeightIn {
  @Id()
  int? id;
  DateTime? dateTime;
  int? weight;
}
