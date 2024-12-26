import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vugars_coffeeshop/application/core/dependency_resolver.dart';
import 'package:vugars_coffeeshop/application/home-page/api-services/abstractions/icoffee_api_service.dart';
import 'package:vugars_coffeeshop/application/home-page/view-model/home_page_view_model.dart';
import 'package:vugars_coffeeshop/application/orders-page/views/order_detail_page.dart';
import 'package:vugars_coffeeshop/application/shared/models/created_order.dart';
import 'package:vugars_coffeeshop/application/shared/views/back_view.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) =>
              HomePageViewModel(dependencyResolver<ICoffeesApiService>())
                ..getOrdersAsync(),
          child: Consumer<HomePageViewModel>(
            builder: (BuildContext context, HomePageViewModel viewModel,
                Widget? child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    BackView(title: 'My Orders'),
                    SizedBox(
                      height: 30,
                    ),
                    viewModel.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : _handleData(viewModel.orders),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _handleData(List<CreatedOrder> orders) {
    return orders.isEmpty
        ? _emptyView()
        : Expanded(
            child: ListView.separated(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailPage(order),
                        ));
                  },
                  child: _item(order),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 15,
                );
              },
            ),
          );
  }

  Widget _emptyView() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Center(
          child: Icon(
            Icons.info,
            size: 70,
            color: Colors.orange,
          ),
        ),
        SizedBox(height: 15),
        Text(
          'No orders found. Start exploring and place your first order!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'PlaywriteGBS',
            fontSize: 17,
          ),
        )
      ],
    );
  }

  Widget _item(CreatedOrder order) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ordered by: ${order.fullName!}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(height: 7),
              Text(
                DateFormat('dd/MM/yyyy').format(
                  DateTime.parse(order.created!),
                ),
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              )
            ],
          ),
          Text(
            '${order.totalPrice!}\$',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
