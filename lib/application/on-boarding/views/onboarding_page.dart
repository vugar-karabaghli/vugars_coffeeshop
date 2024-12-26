import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:vugars_coffeeshop/application/home-page/views/home_page.dart';
import 'package:vugars_coffeeshop/application/on-boarding/model/onboarding.dart';

class OnboardingPage extends StatelessWidget {
  List<Onboarding> datas = [
    Onboarding(
        image: 'assets/images/cupofcoffee.png',
        title: 'Welcome to Vugi\'s Coffeehouse!',
        description: 'Delicious coffee, just a tap away.'),
    Onboarding(
        image: 'assets/images/img1.png',
        title: 'Discover Your Favorite Brew',
        description:
            'Explore our menu and find the coffee that fits your mood.'),
    Onboarding(
        image: 'assets/images/img2.png',
        title: 'Freshly Brewed, Just for You',
        description: 'Place your order and let us handle the rest.'),
    Onboarding(
        image: 'assets/images/img3.png',
        title: 'Let\'s start',
        description: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConcentricPageView(
      curve: Curves.linearToEaseOut,
      colors: <Color>[
        Colors.lightGreenAccent,
        const Color.fromARGB(145, 86, 52, 37),
        Colors.teal,
        Colors.brown,
      ],
      itemBuilder: (int index) {
        Onboarding data = datas[index];

        if (index == datas.length - 1) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          });
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage(data.image),
                ),
              ),
            ),
            SizedBox(height: 23),
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'PlaywriteGBS',
                  fontSize: 31,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 23),
            Text(
              data.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'PlaywriteGBS',
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            )
          ],
        );
      },
      itemCount: 4,
      physics: NeverScrollableScrollPhysics(),
    ));
  }
}
