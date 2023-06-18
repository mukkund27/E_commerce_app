import 'package:intl/intl.dart';

class Formatter{
  static String formatPrice(int price){
    final numberFormat=NumberFormat("₹ #,##,###.00");
    return numberFormat.format(price);
  }
}