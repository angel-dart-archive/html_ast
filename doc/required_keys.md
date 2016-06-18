# Required Keys

```dart
import 'package:heaven/heaven.dart' as heaven;

class MyElem extends heaven.Element {
  List<String> requiredKeys = [
    "{}myMap",
    "[]myArr"
    "#myNum=1337",
    "@myStr=world"
  ];

  String get text => "Hello, ${state['myStr']}!";
}
```