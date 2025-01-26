import 'package:financy_app/core/core_module.dart';
import 'package:financy_app/modules/shared/shared_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BaseModule extends Module {
  List<Module> get baseImports => [
        CoreModule(),
        SharedModule(),
      ];

  List<Module> get moduleImports => const [];

  @override
  List<Module> get imports {
    var temp = baseImports;
    temp.addAll(moduleImports);
    return temp;
  }
}
