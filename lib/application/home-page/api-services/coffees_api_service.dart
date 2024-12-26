import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vugars_coffeeshop/application/helpers/application_helper.dart';
import 'package:vugars_coffeeshop/application/home-page/api-services/abstractions/icoffee_api_service.dart';
import 'package:vugars_coffeeshop/application/home-page/models/coffee.dart';
import 'package:vugars_coffeeshop/application/shared/models/created_order.dart';
import 'package:vugars_coffeeshop/application/shared/models/order.dart';

class CoffeesApiService implements ICoffeesApiService {
  @override
  Future<List<Coffee>> getCoffeesAsync() async {
    final routeUrl = Uri.parse('${ApplicationHelper.baseApiUrl}Coffees/GetAll');
    final response = await http.get(routeUrl);
    if (response.statusCode == 200) {
      List<dynamic> coffeesJson = json.decode(response.body);
      return coffeesJson.map((json) => Coffee.fromJson(json)).toList();
    }
    return List.empty();
  }

  @override
  Future<bool> createOrderAsync(Order order) async {
    final routeUrl = Uri.parse('${ApplicationHelper.baseApiUrl}Orders/Create');
    final response = await http.post(
      routeUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<List<CreatedOrder>?> getOrdersAsync(String phoneNumber) async {
    final routeUrl =
        Uri.parse('${ApplicationHelper.baseApiUrl}Orders/GetAll/$phoneNumber');

    final response = await http.get(routeUrl);
    if(response.statusCode == 200){
      List<dynamic> orderJson = json.decode(response.body);
      return orderJson.map((json)=> CreatedOrder.fromJson(json)).toList();
    }
    return null;
  }
}
