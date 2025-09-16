import 'package:test/test.dart';
import 'package:upward_mobile/utilities/hooks.dart';

void main() {
  group('Testing Hook methods', () {
    test('The firstWord function returns the correct value', () {
      expect(Hooks.firstWords("First    Legolas Nymphus", 1) == "Legolas", true);
    });
  });
}