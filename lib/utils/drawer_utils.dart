import 'package:order_manager/settings/app_routes.dart';
import '../data/models/components/drawer_model.dart';

class DrawerUtils {

  static List<DrawerModel> drawerList = [
    const DrawerModel(
      title: "Home",
      route: AppRoutes.home,
    ),
    const DrawerModel(
      title: "Pedidos",
      route: AppRoutes.order,
    ),
    const DrawerModel(
      title: "Relatórios",
      route: AppRoutes.report,
    ),
  ];
}