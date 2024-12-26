import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vugars_coffeeshop/application/home-page/models/coffee.dart';
import 'package:vugars_coffeeshop/application/shared/models/created_order.dart';
import 'package:vugars_coffeeshop/application/shared/views/back_view.dart';

class OrderDetailPage extends StatefulWidget {
  final CreatedOrder order;
  const OrderDetailPage(this.order, {super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState(order);
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  final CreatedOrder order;
  _OrderDetailPageState(this.order);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _nameController.text = order.fullName!;
    _phoneController.text = order.phoneNumber!;
    _addressController.text = order.address!;
  }

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
                    _products(order),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _products(CreatedOrder order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: order.items!.length,
        itemBuilder: (context, index) {
          final item = order.items?[index];
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
                _image(),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    item!.name!,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 15),
                _priceAndSelection(item),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _image() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: const AssetImage('assets/images/coffee1.jpg'),
        ),
      ),
    );
  }

  Widget _priceAndSelection(Items item) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$ ${item.unitPrice}',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
          ),
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
