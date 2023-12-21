// ignore_for_file: dead_code
import 'package:flutter/material.dart';
import 'package:personal_expense/data/hive_database.dart';
import 'package:personal_expense/dateTime/date_time_helper.dart';
import 'package:personal_expense/models/expense_model.dart';

class ExpenseData extends ChangeNotifier {
  // list of all expense
  List<ExpenseItem> overAllExpenseList = [];

  List<ExpenseItem> getAllExpenseList() {
    return overAllExpenseList;
  }

  //prepare data to display
  final db = HiveDatabase();
  void prepareData() {
    //if there is exist data
    if (db.readData().isNotEmpty) {
      overAllExpenseList = db.readData();
    }
  }

  //add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overAllExpenseList.add(newExpense);

    notifyListeners();
    db.saveData(overAllExpenseList);
  }

  // delete expense
  void deleteExpese(ExpenseItem expense) {
    overAllExpenseList.remove(expense);

    notifyListeners();
    db.saveData(overAllExpenseList);
  }

  // get week days
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  // get the week day start from (sunday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    // get today date
    DateTime today = DateTime.now();

    // go backward to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  /*

  convert all expense into  daily expense summary

  */
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      // dd/mm/yyyy : totalAmountOfTheDay
    };

    for (var expense in overAllExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = expense.amount;

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        // Use square bracket syntax to add a new entry
        dailyExpenseSummary[date] = amount;
      }
    }

    return dailyExpenseSummary;
  }
}
