import 'package:personal_expense/bar%20graph/individual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData(
      {required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thurAmount,
      required this.friAmount,
      required this.satAmount});

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      // for sunday
      IndividualBar(
          x: 0,
          y: sunAmount.round()), //the round is used to convert double into int

      // for monday
      IndividualBar(x: 1, y: monAmount.round()),

      // for tuesday
      IndividualBar(x: 2, y: tueAmount.round()),

      // for wed
      IndividualBar(x: 3, y: wedAmount.round()),

      // for thur
      IndividualBar(x: 4, y: thurAmount.round()),

      // for fri
      IndividualBar(x: 5, y: friAmount.round()),

      // for sat
      IndividualBar(x: 6, y: satAmount.round()),
    ];
  }
}
