import 'package:floor/floor.dart';
import '../../data/entities/orders/address_entity.dart';
import '../../data/entities/orders/cliente_entity.dart';
import '../../data/entities/orders/item_entity.dart';
import '../../data/entities/orders/order_entity.dart';
import '../../data/entities/orders/payment_entity.dart';

@dao
abstract class OrderDao {

  @Query('SELECT * FROM `order`')
  Future<List<OrderEntity>> findOrders();

  @Query('SELECT * FROM client')
  Future<List<ClientEntity>> findClients();

  @Query('SELECT * FROM address')
  Future<List<AddressEntity>> findAddress();

  @Query('SELECT * FROM item')
  Future<List<ItemEntity>> findItems();

  @Query('SELECT * FROM payment')
  Future<List<PaymentEntity>> findPayments();

  @Query('SELECT * FROM client WHERE id = :clientId')
  Future<ClientEntity?> findClientForOrder(String clientId);

  @Query('SELECT * FROM address WHERE id = :addressId')
  Future<AddressEntity?> findAddressForOrder(String addressId);

  @Query('SELECT * FROM item WHERE orderId = :orderId')
  Future<List<ItemEntity>> findItemsForOrder(String orderId);

  @Query('SELECT * FROM payment WHERE orderId = :orderId')
  Future<List<PaymentEntity>> findPaymentsForOrder(String orderId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrder(OrderEntity order);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertClient(ClientEntity client);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAddress(AddressEntity address);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertItems(List<ItemEntity> items);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPayments(List<PaymentEntity> payments);
}