import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, work, leisure }

Map map = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work
};

List<Data> list = [
  Data(
      title: 'Burger',
      amount: 20.5,
      date: DateTime.now(),
      category: Category.food),
  Data(
      title: 'laptop',
      amount: 301.5,
      date: DateTime.now(),
      category: Category.work)
];

class Data {
  Data(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String title;
  final String id;
  final double amount;
  final DateTime date;
  final Category category;
  String get formattingTheData {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.data});
  ExpenseBucket.forCategory(List<Data> allData, this.category)
      : data = allData.where((item) => item.category == category).toList();
  final Category category;
  final List<Data> data;
  double get sumOfExpenses {
    double sum = 0;
    for (final expense in data) {
      sum += expense.amount;
    }
    return sum;
  }
}
