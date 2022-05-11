// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uheart/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(
      child: App(),
    ));

    //1. Проверяем, что загаловок на месте
    expect(find.text('UHealth'), findsOneWidget);
    //2. Поскольку дивайс не подключен, то должен быть целый список дивайсов рядом
    expect(find.text('Device'), findsWidgets);
    //3. Нажатие на наш дивайс
    await tester.tap(find.text('Device uhealth'),);
    await tester.pump();
    //4. Проверяем, что теперь на странице нет всех дивайсов
    expect(find.text('Device'), findsNothing);
    //5. Проверяем, что есть кнопка отключиться от дивайса
    await tester.tap(find.text('Disconect'),);
    await tester.pump();
    //6. Проверяем, что снова на экране дивайсов
    expect(find.text('Device'), findsWidgets);
    //7. Нажатие на наш дивайс
    await tester.tap(find.text('Device uhealth'),);
    await tester.pump();
    //8. Проверяем что один блок сатурации
    expect(find.text('CO2'), findsOneWidget);
    //9. Проверяем что один блок батареии
    expect(find.text('battery'), findsOneWidget);
    //10. Проверяем что один блок часто
    expect(find.text('rate'), findsOneWidget);
    //11. Проверяем что нет пустых данных
    expect(find.text('[]'), findsNothing);
    //12. Проверяем что можем отключиться
    await tester.tap(find.text('Disconect'),);
    await tester.pump();
  });
}
