import 'package:get/get.dart';
import 'soult_grid_controller.dart';

class SoultGridBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<SoultGridController>(() => SoultGridController());
    }
}
