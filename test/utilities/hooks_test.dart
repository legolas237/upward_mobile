import 'package:test/test.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:upward_mobile/utilities/hooks.dart';

void main() {
  group('Testing Hook methods', () {
    test('The Hooks.firstWord function must returns the correct value', () {
      expect(Hooks.firstWords("Legolas      is my first name", 1) == "Legolas", true);
    });

    test('The Hooks.retrievedFile must take the file', () async {
      // final FileSystem fileSystem = MemoryFileSystem.test();
      // final Directory appDocsDir = fileSystem.systemTempDirectory;
      // await appDocsDir.create();
      //
      // final File testFile = appDocsDir.fileSystem('test.txt');
      // await testFile.writeAsString('Hello, Flutter!');
      //
      // final String content = await testFile.readAsString();
      // expect(content, 'Hello, Flutter!');
    });
  });
}