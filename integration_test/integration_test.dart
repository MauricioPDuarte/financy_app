import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:financy_app/main.dart' as app;

import 'robots/robot_extension.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {});

  testWidgets('Onboarding Test', (WidgetTester tester) async {
    app.main();

    await tester.onboarding.processOnboarding();
  });
}
