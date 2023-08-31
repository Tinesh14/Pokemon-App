import 'package:flutter/cupertino.dart';

import '../../modules/detail/ui/detail_ui.dart';
import '../../modules/home/ui/home_ui.dart';

class PageRoutes {
  static String home = "home";
  static String detail = "detail";

  Map<String, WidgetBuilder> routes() {
    return {
      home: (context) => const HomeUi(),
      detail: (context) => const DetailUi(),
    };
  }
}
