import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../daos/orders/order_dao.dart';
import '../data/entities/orders/address_entity.dart';
import '../data/entities/orders/cliente_entity.dart';
import '../data/entities/orders/item_entity.dart';
import '../data/entities/orders/order_entity.dart';
import '../data/entities/orders/payment_entity.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [AddressEntity, ClientEntity, ItemEntity, OrderEntity, PaymentEntity])
abstract class AppDatabase extends FloorDatabase {

  OrderDao get orderDao;
}