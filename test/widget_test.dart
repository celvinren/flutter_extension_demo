// ignore_for_file: avoid_print
// ignore_for_file: format_comment

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('test', () {
    test('Test format string and num', () async {
      /// Format string, remove .AX and capital first letter and lowercase the rest
      const stockCodeOriginal = 'CBA.AX';

      /// Normal way
      final stockCode1RemoveAx = stockCodeOriginal.split('.').first;
      final stockCode1 =
          '${stockCode1RemoveAx[0].toUpperCase()}${stockCode1RemoveAx.substring(1).toLowerCase()}';

      /// Extension way
      final stockCode2 = stockCodeOriginal.removeAx.capitalFirstLetter;

      print(stockCode1); // Cba
      print(stockCode2); // Cba

      /// Format number to currency
      const price = 10000000007.1236;

      /// Normal way
      final priceCurrency1 =
          NumberFormat.simpleCurrency(decimalDigits: 3).format(price);

      /// Extension way
      final priceCurrency2 = price.toCurrency;

      print(priceCurrency1); // $10,000,000,007.124
      print(priceCurrency2); // $10,000,000,007.124
    });

    testWidgets('Test formate date time', (tester) async {
      /// Format DateTime
      /// 20230120 is Friday,
      /// but we want to get the date of Monday of the week 20230120 (20230116)
      /// then show the short date string
      final dateTime = DateTime(2023, 1, 20);
      await tester.pumpWidget(
        MaterialApp(home: Text(dateTime.getFirstDateOfWeek.toShortDate)),
      );
      expect(find.text('20230116'), findsOneWidget);
      print(dateTime.toLongDate);
      print(dateTime.getFirstDateOfWeek.toLongDate);
    });
  });
}

extension DateTimeExtension on DateTime {
  String get toLongDate => DateFormat('d MMM yyyy, hh:mm aa').format(this);
  String get toShortDate => DateFormat('yyyyMMdd').format(this);
  DateTime get getFirstDateOfWeek => subtract(
        Duration(days: weekday - 1),
      );
}

extension StringExtension on String {
  String get removeAx => toUpperCase().split('.AX').first;

  String get capitalFirstLetter =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
}

extension NumExtension on num {
  String get toCurrency =>
      NumberFormat.simpleCurrency(decimalDigits: 3).format(this);
}
