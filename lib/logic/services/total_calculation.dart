import '../../data/Model/cart_item_model.dart';

class TotalCalculation {
  static double cartTotal(List<CartModel> items) {
    double total = 0;
    for (int i = 0; i < items.length; i++) {
      total += items[i].product!.price! * items[i].quantity!;
    }
    return total;
  }
}
