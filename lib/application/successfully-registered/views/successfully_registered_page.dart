import 'package:flutter/material.dart';
import 'package:vugars_coffeeshop/application/home-page/views/home_page.dart';

class SuccessfullyRegisteredPage extends StatelessWidget {
  const SuccessfullyRegisteredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Your coffee is being prepared with love and care.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _spacing(),
                _image(),
                _spacing(),
                _button(context),
                SizedBox(height: 30),
                Text(
                  'We’ll notify you when it’s ready. Sit back, relax, and get ready to enjoy your perfect cup!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _spacing() {
    return SizedBox(height: 50);
  }

  Widget _button(BuildContext context) {
    return MaterialButton(
      height: 60,
      color: Colors.orange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      child: Center(
        child: Text(
          'Home',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
    );
  }

  Widget _image() {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/thankyou.png'),
        ),
      ),
    );
  }
}
