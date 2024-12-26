// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:vugars_coffeeshop/application/core/dependency_resolver.dart';
import 'package:vugars_coffeeshop/application/home-page/api-services/abstractions/icoffee_api_service.dart';
import 'package:vugars_coffeeshop/application/home-page/models/coffee.dart';
import 'package:vugars_coffeeshop/application/home-page/view-model/home_page_view_model.dart';
import 'package:vugars_coffeeshop/application/home-page/views/home_page.dart';
import 'package:vugars_coffeeshop/application/shared/views/back_view.dart';
import 'package:vugars_coffeeshop/application/successfully-registered/views/successfully_registered_page.dart';

class CreateOrderPage extends StatefulWidget {
  final HomePageViewModel viewModel;
  const CreateOrderPage({
    required this.viewModel,
  });

  @override
  State<CreateOrderPage> createState() =>
      _CreateOrderPageState(viewModel: viewModel);
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final HomePageViewModel viewModel;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
  }

  _CreateOrderPageState({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackView(title: 'Checkout'),
                    _customerInfoForm(),
                    SizedBox(height: 20),
                    _products(viewModel),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 15, left: 15, bottom: 30, top: 15),
            child: _orderButton(viewModel),
          ),
        ],
      ),
    );
  }

  Widget _orderButton(HomePageViewModel viewModel) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      color: Colors.orange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onPressed: () async {
        var result = await viewModel.createOrderAsync(_nameController.text,
            _phoneController.text, _addressController.text);
        if (result) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SuccessfullyRegisteredPage()));
        }
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
    return viewModel.isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.builder(
              shrinkWrap: true, // Ограничиваем высоту GridView
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: viewModel.getShoppingCard().length,
              itemBuilder: (context, index) {
                final coffee = viewModel.getShoppingCard()[index];
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
          );
  }

  Widget _image(Coffee coffee) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      height: 160,
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
              setState(() {
                viewModel.AddToShoppingCard(coffee);
              });
            },
            color: Colors.orange,
            minWidth: 45,
            height: 53,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _customerInfoForm() {
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          _spacing(),
          _input(title: 'Name', controller: _nameController),
          _spacing(),
          _input(title: 'Address', controller: _addressController),
          _spacing(),
          _input(title: 'Phone Number', controller: _phoneController),
        ],
      ),
    ));
  }
}

Widget _spacing({double spacing = 17}) {
  return SizedBox(height: spacing);
}

Widget _input(
    {required String title, required TextEditingController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      SizedBox(height: 7),
      TextFormField(
        controller: controller,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
            enabledBorder: _inputBorder(),
            focusedBorder: _inputBorder(isFocused: true),
            border: UnderlineInputBorder(borderSide: BorderSide.none)),
      ),
    ],
  );
}

OutlineInputBorder _inputBorder({bool isFocused = false}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: isFocused ? Colors.orange : Colors.grey),
  );
}
