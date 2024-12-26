import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vugars_coffeeshop/application/core/dependency_resolver.dart';
import 'package:vugars_coffeeshop/application/create-order-page/views/create_order_page.dart';
import 'package:vugars_coffeeshop/application/home-page/api-services/abstractions/icoffee_api_service.dart';
import 'package:vugars_coffeeshop/application/home-page/models/coffee.dart';
import 'package:vugars_coffeeshop/application/home-page/view-model/home_page_view_model.dart';
import 'package:vugars_coffeeshop/application/home-page/views/home_page.dart';
import 'package:vugars_coffeeshop/application/shared/animations/start_up_animation.dart';

class CoffeeDetailPage extends StatefulWidget {
  final Coffee? coffee;
  const CoffeeDetailPage({super.key, this.coffee});

  @override
  State<CoffeeDetailPage> createState() => _CoffeeDetailPageState();
}

class _CoffeeDetailPageState extends State<CoffeeDetailPage>
    with SingleTickerProviderStateMixin {
  final String _fontFamily = 'PlaywriteGBS';

  late AnimationController _animationController;
  late StartUpAnimation _startUpAnimation;
  late int? _currentOption = -1;

  final List<String> _sizes = [
    'Small',
    'Medium',
    'Large',
  ];

  int _currentSize = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 400));

    _startUpAnimation = StartUpAnimation(controller: _animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _imageContainer(),
          _backArrow(),
          _burgerContainer(),
        ],
      ),
    );
  }

  Widget _burgerContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.67,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                widget.coffee!.name!,
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: _fontFamily,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 30),
              _sizesList(),
              const SizedBox(height: 30),
              _description(),
              const SizedBox(height: 30),
              _optionsList(),
              const SizedBox(height: 45),
              _orderButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderButton() {
    return ChangeNotifierProvider(
      create: (_) =>
          HomePageViewModel(dependencyResolver<ICoffeesApiService>()),
      child: Consumer<HomePageViewModel>(
        builder:
            (BuildContext context, HomePageViewModel viewModel, Widget? child) {
          return MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.07,
            color: Colors.orange,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onPressed: () async {
              viewModel.AddToShoppingCard(widget.coffee!);
              await Future.delayed(Duration(milliseconds: 500));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateOrderPage(viewModel: viewModel),
                  ));
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
        },
      ),
    );
  }

  Widget _optionsList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('More options',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        const SizedBox(height: 15),
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: widget.coffee!.moreOptions!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _item(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _item(int index) {
    final option = widget.coffee!.moreOptions![index];
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentOption = index;
        });
      },
      child: AnimatedListItem(
        index: index,
        length: 2,
        aniController: _animationController,
        animationType: AnimationType.zoom,
        child: Container(
          margin: EdgeInsets.only(right: 15),
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: _currentOption == index
                    ? Colors.green
                    : const Color.fromARGB(255, 208, 206, 206),
              ),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/cup.png'))),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.name!,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${option.price!}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _currentOption == index
                  ? Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _description() {
    return Text(
      '${widget.coffee!.description}',
      style: const TextStyle(
          fontSize: 17,
          color: Colors.black,
          fontFamily: 'PlaywriteGBS',
          fontWeight: FontWeight.w400),
    );
  }

  Widget _sizesList() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _sizes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _currentSize = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.29,
              decoration: BoxDecoration(
                  color: _currentSize == index ? Colors.black : Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  _sizes[index],
                  style: _currentSize == index
                      ? const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)
                      : const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _backArrow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: GestureDetector(
        onTap: () async {
          await _animationController.reverse();
          Navigator.pop(context);
        },
        child: Container(
          height: 50,
          width: 50,
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _imageContainer() {
    return AnimatedBuilder(
      animation: _startUpAnimation.controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(_startUpAnimation.startUp.value,
              _startUpAnimation.startUp.value, 1),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.37,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: widget.coffee!.image == null
                    ? const AssetImage('assets/images/coffee1.jpg')
                        as ImageProvider
                    : NetworkImage(widget.coffee!.image!),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _verticalSpacing() {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.01);
  }
}
