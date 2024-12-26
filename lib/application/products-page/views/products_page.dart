import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vugars_coffeeshop/application/core/dependency_resolver.dart';
import 'package:vugars_coffeeshop/application/create-order-page/views/create_order_page.dart';
import 'package:vugars_coffeeshop/application/home-page/api-services/abstractions/icoffee_api_service.dart';
import 'package:vugars_coffeeshop/application/home-page/models/coffee.dart';
import 'package:vugars_coffeeshop/application/home-page/view-model/home_page_view_model.dart';
import 'package:vugars_coffeeshop/application/shared/views/back_view.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomePageViewModel(
        dependencyResolver<ICoffeesApiService>(),
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 234, 234),
        body: SingleChildScrollView(
          child: Consumer<HomePageViewModel>(
            builder: (BuildContext context, HomePageViewModel viewModel,
                Widget? child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 50),
                  BackView(title: 'Products'),
                  _products(viewModel),
                  SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, left: 15, bottom: 35),
                    child: _orderButton(viewModel),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _orderButton(HomePageViewModel viewModel) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      color: Colors.orange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateOrderPage(
              viewModel: viewModel,
            ),
          ),
        );
      },
      child: Text(
        'Order',
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _products(HomePageViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      color: const Color.fromARGB(255, 247, 245, 245),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: viewModel.isLoading
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: viewModel.coffees.length,
                itemBuilder: (context, index) {
                  final coffee = viewModel.coffees[index];
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _image(coffee),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            coffee.name!,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 15),
                        _priceAndSelection(coffee, viewModel),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _priceAndSelection(Coffee coffee, HomePageViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$ ${coffee.price}',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
          ),

          MaterialButton(
            onPressed: () {
              viewModel.AddToShoppingCard(coffee);
            },
            color: Colors.orange,
            minWidth: 45,
            height: 53,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13)
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _image(Coffee coffee) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.41,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: coffee.image == null
              ? const AssetImage('assets/images/coffee1.jpg')
              : NetworkImage(
                  coffee.image!,
                ),
        ),
      ),
    );
  }
}
