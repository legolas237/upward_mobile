import 'package:test/test.dart';
import 'package:upward_mobile/utilities/hooks.dart';

void main() {
  group('Testing Hook methods', () {
    test('The Hooks.firstWord function must returns the correct value', () {
      expect(Hooks.firstWords("Legolas      is my first name", 1) == "Legolas", true);
    });
  });
}