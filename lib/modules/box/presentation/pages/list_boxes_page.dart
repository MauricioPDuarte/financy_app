import 'package:financy_app/modules/box/presentation/controllers/list_boxes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListBoxesPage extends StatefulWidget {
  const ListBoxesPage({super.key});

  @override
  State<ListBoxesPage> createState() => _ListBoxesPageState();
}

class _ListBoxesPageState extends State<ListBoxesPage> {
  final ListBoxesController controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: controller.logout,
              child: Icon(Icons.logout),
            )
          ],
        ),
      ),
    );
  }
}
