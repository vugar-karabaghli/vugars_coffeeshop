import 'package:get_it/get_it.dart';
import 'package:vugars_coffeeshop/application/home-page/api-services/abstractions/icoffee_api_service.dart';
import 'package:vugars_coffeeshop/application/home-page/api-services/coffees_api_service.dart';
import 'package:vugars_coffeeshop/application/home-page/view-model/home_page_view_model.dart';

final dependencyResolver = GetIt.instance;

void resolve() {
  dependencyResolver
      .registerFactory<ICoffeesApiService>(() => CoffeesApiService());

  dependencyResolver.registerSingleton(
      HomePageViewModel(dependencyResolver<ICoffeesApiService>()));
}
