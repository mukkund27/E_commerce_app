import 'package:intl/intl.dart';

class Formatter{
  static String formatPrice(num price){
    final numberFormat=NumberFormat("₹ #,##,###.00");
    return numberFormat.format(price);
  }
}