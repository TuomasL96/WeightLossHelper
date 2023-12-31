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
  @Backlink('user')
  final weighIns = ToMany<WeighIn>();

  User(this.name, this.age, this.height, this.isMale, this.isCurrentUser,
      {this.id = 0});
}

@Entity()
class WeighIn {
  int? id;
  double weight;
  DateTime date;
  final user = ToOne<User>();

  WeighIn(this.date, this.weight, {this.id = 0});
}
