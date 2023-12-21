import 'package:hive/hive.dart';
import 'package:personal_expense/models/expense_model.dart';

class HiveDatabase {
  //reference our database
  final _myBox = Hive.box("expense_database");

  //write data to database
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpenseFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
            .toIso8601String(), // Convert DateTime to a string for storage
      ];
      allExpenseFormatted.add(expenseFormatted);
    }

    _myBox.put("ALL_EXPENSES", allExpenseFormatted);
  }

  //read the data
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      double amount = savedExpenses[i][1];
      DateTime dateTime = DateTime.parse(savedExpenses[i][2]);

      ExpenseItem expense =
          ExpenseItem(name: name, amount: amount, dateTime: dateTime);

      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
