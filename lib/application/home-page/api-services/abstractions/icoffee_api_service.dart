import 'package:vugars_coffeeshop/application/home-page/models/coffee.dart';
import 'package:vugars_coffeeshop/application/shared/models/created_order.dart';
import 'package:vugars_coffeeshop/application/shared/models/order.dart';

abstract class ICoffeesApiService {
  Future<List<Coffee>> getCoffeesAsync();
  Future<bool> createOrderAsync(Order order);
  Future<List<CreatedOrder>?> getOrdersAsync(String phoneNumber);
}
