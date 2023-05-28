import 'package:flutter/material.dart';
import 'package:watsappweb/screens/home_mobile.dart';
import 'package:watsappweb/screens/home_web.dart';
import 'package:watsappweb/utils/responsive.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: HomeMobile(),
        web: HomeWeb()
    );
  }
}
