import 'package:canvas_demo/main.dart';
import 'package:canvas_demo/page/soult_grid/soult_grid_binding.dart';
import 'package:canvas_demo/page/soult_grid/soult_grid_view.dart';
import 'package:get/route_manager.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.index;
  static final routes = [
    GetPage(name: AppRoutes.index, page: () => MyHomePage(title: "title")),
    // binding: VerificationCodeBinding()),
    GetPage(
      name: AppRoutes.soult,
      page: () => SoultGridPage(),
      transition: Transition.native,
      binding: SoultGridBinding(),
    )
  ];
}
