import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:vugars_coffeeshop/application/about-page/views/about_page.dart';
import 'package:vugars_coffeeshop/application/core/dependency_resolver.dart';
import 'package:vugars_coffeeshop/application/home-page/api-services/abstractions/icoffee_api_service.dart';
import 'package:vugars_coffeeshop/application/home-page/coffees.dart';
import 'package:vugars_coffeeshop/application/home-page/view-model/home_page_view_model.dart';
import 'package:vugars_coffeeshop/application/home-page/views/coffee_detail_page.dart';
import 'package:vugars_coffeeshop/application/location-page/location_page.dart';
import 'package:vugars_coffeeshop/application/orders-page/views/orders_page.dart';
import 'package:vugars_coffeeshop/application/products-page/views/products_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAdult = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          HomePageViewModel(dependencyResolver<ICoffeesApiService>()),
      child: Scaffold(
        body: _main(),
        drawer: Drawer(
          child: _burgerMenuContent(),
        ),
      ),
    );
  }

  // child: Scaffold(
  //               body: _main(),
  //               drawer: Drawer(
  //                 child: Align(
  //                   child: _burgerMenuContent(),
  //                 ),
  //               ),
  //             ),
  //           ));

  Widget _burgerMenuContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/banner1.jpg'))),
          ),
          _verticalSpacing(),
          _verticalSpacing(),
          Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).closeDrawer();
              },
              child: _menuItem(title: 'Home', icon: Icons.home),
            );
          }),
          _verticalSpacing(),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductsPage();
                    },
                  ),
                );
              },
              child: _menuItem(
                  title: 'Products', icon: Icons.local_grocery_store_sharp)),
          _verticalSpacing(),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return OrdersPage();
                    },
                  ),
                );
              },
              child: _menuItem(title: 'My Orders', icon: Icons.book_online)),
          _verticalSpacing(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LocationPage();
                  },
                ),
              );
            },
            child: _menuItem(title: 'Location', icon: Icons.location_on),
          ),
          _verticalSpacing(),
          GestureDetector(
            child: _menuItem(title: 'About Us', icon: Icons.info),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AboutPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  SizedBox _verticalSpacing() {
    return const SizedBox(height: 20);
  }

  Widget _menuItem({required String title, required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.orange,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'PlaywriteGBS',
                fontSize: 17,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Divider(
          color: Color.fromARGB(255, 214, 213, 213),
        ),
      ],
    );
  }

  Widget _main() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _banner(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.075),
          _categorySelection(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.075),
          _coffeesList(),
        ],
      ),
    );
  }

  Widget _coffeesList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Consumer<HomePageViewModel>(
        builder:
            (BuildContext context, HomePageViewModel viewModel, Widget? child) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: viewModel.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.coffees.length,
                    itemBuilder: (context, index) {
                      final coffee = viewModel.coffees[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 1300),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return CoffeeDetailPage(coffee: coffee);
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: coffee.image == null
                                        ? const AssetImage(
                                                'assets/images/coffee1.jpg')
                                            as ImageProvider
                                        : NetworkImage(coffee.image!),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget _categorySelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            child: const Text(
              'Choose a category',
              style: TextStyle(
                  fontFamily: 'PlaywriteGBS',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          MaterialButton(
            minWidth: 120,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onPressed: () {
              setState(() {
                _isAdult = true;
              });
            },
            color: _isAdult ? Colors.pink[100] : Colors.grey[300],
            height: 50,
            child: Text(
              'Adult',
              style: _isAdult
                  ? const TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)
                  : const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
            ),
          ),
          MaterialButton(
            minWidth: 120,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onPressed: () {
              setState(() {
                _isAdult = false;
              });
            },
            color: !_isAdult ? Colors.pink[100] : Colors.grey[300],
            height: 50,
            child: Text(
              'Children',
              style: !_isAdult
                  ? const TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)
                  : const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _banner() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _image(),
          _menuAndTitle(),
          Positioned(
            bottom: -30,
            left: 25,
            child: _searchBar(),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(31, 98, 97, 97),
            offset: Offset(10, 15),
          ),
        ],
      ),
      height: 80,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Center(
        child: TextField(
          decoration: InputDecoration(
            suffixIcon: const Icon(
              Icons.search,
              size: 25,
            ),
            hintText: 'Search',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
            enabledBorder: _outlinedInputBorder(),
            focusedBorder: _outlinedInputBorder(),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _outlinedInputBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.transparent),
    );
  }

  Widget _menuAndTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.white,
                ));
          }),
          const Text(
            'Best online coffee shop',
            style: TextStyle(
                fontFamily: 'PlaywriteGBS',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 40),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/banner1.jpg'),
        ),
      ),
    );
  }
}
