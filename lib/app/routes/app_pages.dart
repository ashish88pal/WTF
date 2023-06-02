import 'package:get/get.dart';

import '../modules/PickLocation/bindings/pick_location_binding.dart';
import '../modules/PickLocation/views/pick_location_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  // static const INITIAL = Routes.PICK_LOCATION;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PICK_LOCATION,
      page: () => const PickLocationView(),
      binding: PickLocationBinding(),
    ),
  ];
}
