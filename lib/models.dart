import 'dart:ffi';

import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int? id;
  @Unique()
  String name;
  String age;
  String height;
  bool isMale;
  bool isCurrentUser;
  List<WeightIn>? weightIns;

  User(this.name, this.age, this.height, this.isMale, this.isCurrentUser,
      {this.id = 0});
}

@Entity()
class WeightIn {
  int? id;
  int weight;

  @Property(type: PropertyType.date)
  DateTime date;

  WeightIn(this.weight, this.date, {this.id = 0});
}
