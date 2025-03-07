import 'package:fluro/fluro.dart';
import 'package:muscletrack_admin_dashboard/ui/views/no_page_found_view.dart';

class NotFoundHandlers {
  static Handler notPageFound = Handler(handlerFunc: (context, params) {
    return NoPageFoundView();
  });
}
