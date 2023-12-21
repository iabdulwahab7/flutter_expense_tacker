import 'package:flutter/material.dart';
import 'package:personal_expense/components/expense_summary.dart';
import 'package:personal_expense/components/expense_tile.dart';
import 'package:personal_expense/data/expense_data.dart';
import 'package:personal_expense/models/expense_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Add new text editing controller
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //preparedata on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // add new expense
  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add New Expense"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: newExpenseNameController,
                    decoration: const InputDecoration(hintText: "Title"),
                  ),
                  TextField(
                    controller: newExpenseAmountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "Amount"),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: const Text("Save"),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("Cancel"),
                )
              ],
            ));
  }

  //delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpese(expense);
  }

  // add new expense dialogue save method
  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      // Get the text from the amount controller
      String amountString = newExpenseAmountController.text;

      // Try parsing the amount string to a double
      try {
        double amount = double.parse(amountString);

        // Create a new ExpenseItem with the parsed amount
        ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: amount,
          dateTime: DateTime.now(),
        );

        // Add the new expense to the data provider
        Provider.of<ExpenseData>(context, listen: false)
            .addNewExpense(newExpense);

        // Close the screen
        Navigator.pop(context);
      } catch (e) {
        // Handle the case where parsing fails (invalid double)
        print('Error parsing amount: $e');
        // Optionally, show an error to the user
        // You might want to display a message to the user that the entered amount is not a valid number
      }
      clear();
    }
    Navigator.pop(context);
  }

  // add new expense dialogue cancel method
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // clear controllers
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ExpenseData>(
          builder: (contenxt, value, child) => Scaffold(
              backgroundColor: Colors.grey.shade200,
              floatingActionButton: FloatingActionButton(
                onPressed: addNewExpense,
                backgroundColor: Colors.grey.shade800,
                elevation: 0,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              body: ListView(
                children: [
                  //weekly expense summary
                  ExpenseSummary(startOfWeek: value.startOfWeekDate()),

                  //Expense list
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.getAllExpenseList().length,
                      itemBuilder: (context, index) => ExpenseTile(
                            name: value.getAllExpenseList()[index].name,
                            amount: value
                                .getAllExpenseList()[index]
                                .amount
                                .toString(),
                            dateTime: value.getAllExpenseList()[index].dateTime,
                            deleteTapped: (p0) =>
                                deleteExpense(value.getAllExpenseList()[index]),
                          )),
                ],
              ))),
    );
  }
}
