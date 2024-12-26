import 'package:flutter/material.dart';
import 'package:vugars_coffeeshop/application/home-page/api-services/abstractions/icoffee_api_service.dart';
import 'package:vugars_coffeeshop/application/home-page/models/coffee.dart';
import 'package:vugars_coffeeshop/application/shared/models/created_order.dart';
import 'package:vugars_coffeeshop/application/shared/models/order.dart';

class HomePageViewModel extends ChangeNotifier {
  final ICoffeesApiService _coffeesApiService;
  List<Coffee> _shoppingCard = [];
  List<Coffee> coffees = [];
  bool isLoading = false;
  late List<CreatedOrder> orders = [];

  HomePageViewModel(this._coffeesApiService) {
    _loadCoffees();
  }

  Future<void> _loadCoffees() async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await _coffeesApiService.getCoffeesAsync();
      if (data.isEmpty) {
        isLoading = false;
        notifyListeners();
        return;
      }
      coffees = data;
      isLoading = false;
      notifyListeners();
    } catch (ex) {
      print('Error loading coffees: $ex');
      isLoading = false;
      notifyListeners();
    }
  }

  void AddToShoppingCard(Coffee coffee) {
    _shoppingCard.add(coffee);
  }

  List<Coffee> getShoppingCard() {
    return _shoppingCard;
  }

  Future<bool> createOrderAsync(
      String name, String phoneNumber, String address) async {
    List<Item> orders = [];
    _shoppingCard.forEach((item) => orders.add(Item(name: item.name, qty: 1)));

    var order = Order(
        fullName: name,
        address: address,
        phoneNumber: phoneNumber,
        items: orders);

    final result = await _coffeesApiService.createOrderAsync(order);
    if (result) {
      _shoppingCard.clear();
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> getOrdersAsync() async {
    isLoading = true;
    notifyListeners();
    final data = await _coffeesApiService.getOrdersAsync('555471226');
    if (data != null) {
      orders = data;
      print(orders);
      isLoading = false;
      notifyListeners();
    }
  }
}
