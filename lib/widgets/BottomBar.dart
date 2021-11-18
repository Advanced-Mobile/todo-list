import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:todo_list/pages/HomeScreen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {

  var routeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(48, 52, 57, 100),
              Color.fromRGBO(24, 25, 28, 100),
            ],
          ),
        ),
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            NavigationBarItemWidget(
              icon: Icons.home,
              onPressed: () {
                if (Get.currentRoute != '/home') {
                  print(Get.currentRoute);
                  Get.back();
                  Get.offNamed('/home');
                  setState(() {
                    routeIndex = 0;
                  });
                }
              },
              pressed: routeIndex == 0,
            ),
            NavigationBarItemWidget(
              icon: Icons.search,
              onPressed: () {
                if (Get.currentRoute != '/search') {
                  print(Get.currentRoute);
                  Get.back();
                  Get.offNamed('/search');
                  setState(() {
                    routeIndex = 1;
                  });
                }
              },
              pressed: routeIndex == 1,
            ),
            NavigationBarItemWidget(
              icon: Icons.settings,
              onPressed: () {
                if (Get.currentRoute != '/setting') {
                  print(Get.currentRoute);
                  Get.back();
                  Get.offNamed('/setting');
                  setState(() {
                    routeIndex = 2;
                  });
                }
              },
              pressed: routeIndex == 2,
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationBarItemWidget extends StatelessWidget {
  final IconData icon;
  final NeumorphicButtonClickListener onPressed;
  final bool pressed;

  NavigationBarItemWidget(
      {required this.icon, required this.onPressed, required this.pressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: NeumorphicButton(
          onPressed: onPressed,
          pressed: pressed,
          style: NeumorphicStyle(
            depth: 4,
            shadowDarkColor: Color(0xff151515),
            shadowLightColor: Color(0xff4F5C61),
            color: Color(0xff222428),
            shape: pressed ? NeumorphicShape.concave : NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.circle(),
            border: NeumorphicBorder(
              color: Color(0xff1D2328),
              width: 2,
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            icon,
            color: pressed ? Color(0xff51AD4D) : Color(0xffBFC5CA),
          ),
        ),
      ),
    );
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
  }
}

class Home extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

class HomeController extends GetxController {
  @override
  void onInit() {
    print('>>> HomeController init');
    super.onInit();
  }

  @override
  void onReady() {
    print('>>> HomeController ready');
    super.onReady();
  }
}

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}

class Search extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(controller.title),
    );
  }
}

class SearchController extends GetxController {
  final title = 'Search Screen';

  @override
  void onInit() {
    print('>>> SearchController init');
    super.onInit();
  }

  @override
  void onReady() {
    print('>>> SearchController ready');
    super.onReady();
  }

  @override
  void onClose() {
    print('>>> SearchController close');
    super.onClose();
  }
}

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
  }
}

class Setting extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(controller.title),
    );
  }
}

class SettingController extends GetxController {
  final title = 'Setting Screen';

  @override
  void onInit() {
    print('>>> SettingController init');
    super.onInit();
  }

  @override
  void onReady() {
    print('>>> SettingController ready');
    super.onReady();
  }

  @override
  void onClose() {
    print('>>> SettingController close');
    super.onClose();
  }
}
