import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zando_id/model/menu_Item.dart';

class MenuItems {
  static const List<MenuItem> list1 = [itemAbon];
  static const List<MenuItem> list2 = [itemDecon];
  static const itemAbon =
      MenuItem(text: 'Target', icone: FontAwesomeIcons.donate);
  static const itemDecon =
      MenuItem(text: 'Deconnection', icone: FontAwesomeIcons.signOutAlt);
}
