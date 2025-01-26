import 'package:financy_app/core/base_module.dart';
import 'package:financy_app/modules/box/box_routes.dart';
import 'package:financy_app/modules/box/presentation/controllers/list_boxes_controller.dart';
import 'package:financy_app/modules/box/presentation/pages/list_boxes_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BoxModule extends BaseModule {
  @override
  void binds(Injector i) {
    i.add<ListBoxesController>(
        () => ListBoxesControllerImpl(logoutUserUsecase: i.get()));
  }

  @override
  void routes(RouteManager r) {
    r.child(BoxRoutes.listBoxes, child: (context) => ListBoxesPage());
  }
}
