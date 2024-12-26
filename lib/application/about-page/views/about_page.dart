import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter/material.dart';
import 'package:vugars_coffeeshop/application/shared/views/back_view.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  List<String> images = [
    'assets/images/about1.jpg',
    'assets/images/about2.jpg',
    'assets/images/about3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 50, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackView(title: 'About us'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _images(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text(
                'Welcome to Vugi\'s Coffee Shop',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              const Text(
                'We believe that coffee is more than just a drink. It is an art, a ritual and a way to bring people together.\n\nEvery cup we make begins with carefully selected beans grown on the world\'s finest plantations.We work directly with farmers to ensure quality and support fair trade.\n\nAt Vugi\'s Coffee Shop we strive to create an atmosphere of warmth and comfort. Here you will find a place where you can relax, enjoy aromatic coffee and spend time with friends or alone, enjoying the moment.\n\nOur team of baristas are true professionals who are passionate about their work. We experiment with new recipes and offer a wide selection of drinks to ensure there is something for everyone.\n\nThank you for being with us. Let every cup of coffee inspire you to new achievements!',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PlaywriteGBS'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container item(int index) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width * 0.41,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            images[index],
          ),
        ),
      ),
    );
  }

  Widget _images() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return AnimatedListItem(
            index: index,
            length: images.length,
            aniController: _animationController,
            animationType: AnimationType.zoomLeft,
            child: item(index),
          );
        },
      ),
    );
  }
}
