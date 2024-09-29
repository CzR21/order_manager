// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  OrderDao? _orderDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `address` (`id` TEXT NOT NULL, `address` TEXT NOT NULL, `number` TEXT NOT NULL, `zipCode` TEXT NOT NULL, `neighborhood` TEXT NOT NULL, `city` TEXT NOT NULL, `state` TEXT NOT NULL, `complement` TEXT NOT NULL, `reference` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `client` (`id` TEXT NOT NULL, `cnpj` TEXT NOT NULL, `cpf` TEXT NOT NULL, `name` TEXT NOT NULL, `corporateName` TEXT NOT NULL, `email` TEXT NOT NULL, `birthDate` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `item` (`id` TEXT NOT NULL, `productId` TEXT NOT NULL, `name` TEXT NOT NULL, `quantity` INTEGER NOT NULL, `unitPrice` REAL NOT NULL, `orderId` TEXT NOT NULL, FOREIGN KEY (`orderId`) REFERENCES `order` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `order` (`id` TEXT NOT NULL, `number` INTEGER NOT NULL, `createdAt` TEXT NOT NULL, `updatedAt` TEXT NOT NULL, `status` TEXT NOT NULL, `discount` REAL NOT NULL, `shippingCost` REAL NOT NULL, `subTotal` REAL NOT NULL, `totalValue` REAL NOT NULL, `clientId` TEXT NOT NULL, `addressId` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `payment` (`id` TEXT NOT NULL, `installment` INTEGER NOT NULL, `value` REAL NOT NULL, `code` TEXT NOT NULL, `name` TEXT NOT NULL, `orderId` TEXT NOT NULL, FOREIGN KEY (`orderId`) REFERENCES `order` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  OrderDao get orderDao {
    return _orderDaoInstance ??= _$OrderDao(database, changeListener);
  }
}

class _$OrderDao extends OrderDao {
  _$OrderDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _orderEntityInsertionAdapter = InsertionAdapter(
            database,
            'order',
            (OrderEntity item) => <String, Object?>{
                  'id': item.id,
                  'number': item.number,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'status': item.status,
                  'discount': item.discount,
                  'shippingCost': item.shippingCost,
                  'subTotal': item.subTotal,
                  'totalValue': item.totalValue,
                  'clientId': item.clientId,
                  'addressId': item.addressId
                }),
        _clientEntityInsertionAdapter = InsertionAdapter(
            database,
            'client',
            (ClientEntity item) => <String, Object?>{
                  'id': item.id,
                  'cnpj': item.cnpj,
                  'cpf': item.cpf,
                  'name': item.name,
                  'corporateName': item.corporateName,
                  'email': item.email,
                  'birthDate': item.birthDate
                }),
        _addressEntityInsertionAdapter = InsertionAdapter(
            database,
            'address',
            (AddressEntity item) => <String, Object?>{
                  'id': item.id,
                  'address': item.address,
                  'number': item.number,
                  'zipCode': item.zipCode,
                  'neighborhood': item.neighborhood,
                  'city': item.city,
                  'state': item.state,
                  'complement': item.complement,
                  'reference': item.reference
                }),
        _itemEntityInsertionAdapter = InsertionAdapter(
            database,
            'item',
            (ItemEntity item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'name': item.name,
                  'quantity': item.quantity,
                  'unitPrice': item.unitPrice,
                  'orderId': item.orderId
                }),
        _paymentEntityInsertionAdapter = InsertionAdapter(
            database,
            'payment',
            (PaymentEntity item) => <String, Object?>{
                  'id': item.id,
                  'installment': item.installment,
                  'value': item.value,
                  'code': item.code,
                  'name': item.name,
                  'orderId': item.orderId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OrderEntity> _orderEntityInsertionAdapter;

  final InsertionAdapter<ClientEntity> _clientEntityInsertionAdapter;

  final InsertionAdapter<AddressEntity> _addressEntityInsertionAdapter;

  final InsertionAdapter<ItemEntity> _itemEntityInsertionAdapter;

  final InsertionAdapter<PaymentEntity> _paymentEntityInsertionAdapter;

  @override
  Future<List<OrderEntity>> findOrders() async {
    return _queryAdapter.queryList('SELECT * FROM `order`',
        mapper: (Map<String, Object?> row) => OrderEntity(
            id: row['id'] as String,
            number: row['number'] as int,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            status: row['status'] as String,
            discount: row['discount'] as double,
            shippingCost: row['shippingCost'] as double,
            subTotal: row['subTotal'] as double,
            totalValue: row['totalValue'] as double,
            clientId: row['clientId'] as String,
            addressId: row['addressId'] as String));
  }

  @override
  Future<List<ClientEntity>> findClients() async {
    return _queryAdapter.queryList('SELECT * FROM client',
        mapper: (Map<String, Object?> row) => ClientEntity(
            id: row['id'] as String,
            cnpj: row['cnpj'] as String,
            cpf: row['cpf'] as String,
            name: row['name'] as String,
            corporateName: row['corporateName'] as String,
            email: row['email'] as String,
            birthDate: row['birthDate'] as String));
  }

  @override
  Future<List<AddressEntity>> findAddress() async {
    return _queryAdapter.queryList('SELECT * FROM address',
        mapper: (Map<String, Object?> row) => AddressEntity(
            id: row['id'] as String,
            address: row['address'] as String,
            number: row['number'] as String,
            zipCode: row['zipCode'] as String,
            neighborhood: row['neighborhood'] as String,
            city: row['city'] as String,
            state: row['state'] as String,
            complement: row['complement'] as String,
            reference: row['reference'] as String));
  }

  @override
  Future<List<ItemEntity>> findItems() async {
    return _queryAdapter.queryList('SELECT * FROM item',
        mapper: (Map<String, Object?> row) => ItemEntity(
            id: row['id'] as String,
            productId: row['productId'] as String,
            name: row['name'] as String,
            quantity: row['quantity'] as int,
            unitPrice: row['unitPrice'] as double,
            orderId: row['orderId'] as String));
  }

  @override
  Future<List<PaymentEntity>> findPayments() async {
    return _queryAdapter.queryList('SELECT * FROM payment',
        mapper: (Map<String, Object?> row) => PaymentEntity(
            id: row['id'] as String,
            installment: row['installment'] as int,
            value: row['value'] as double,
            code: row['code'] as String,
            name: row['name'] as String,
            orderId: row['orderId'] as String));
  }

  @override
  Future<ClientEntity?> findClientForOrder(String clientId) async {
    return _queryAdapter.query('SELECT * FROM client WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ClientEntity(
            id: row['id'] as String,
            cnpj: row['cnpj'] as String,
            cpf: row['cpf'] as String,
            name: row['name'] as String,
            corporateName: row['corporateName'] as String,
            email: row['email'] as String,
            birthDate: row['birthDate'] as String),
        arguments: [clientId]);
  }

  @override
  Future<AddressEntity?> findAddressForOrder(String addressId) async {
    return _queryAdapter.query('SELECT * FROM address WHERE id = ?1',
        mapper: (Map<String, Object?> row) => AddressEntity(
            id: row['id'] as String,
            address: row['address'] as String,
            number: row['number'] as String,
            zipCode: row['zipCode'] as String,
            neighborhood: row['neighborhood'] as String,
            city: row['city'] as String,
            state: row['state'] as String,
            complement: row['complement'] as String,
            reference: row['reference'] as String),
        arguments: [addressId]);
  }

  @override
  Future<List<ItemEntity>> findItemsForOrder(String orderId) async {
    return _queryAdapter.queryList('SELECT * FROM item WHERE orderId = ?1',
        mapper: (Map<String, Object?> row) => ItemEntity(
            id: row['id'] as String,
            productId: row['productId'] as String,
            name: row['name'] as String,
            quantity: row['quantity'] as int,
            unitPrice: row['unitPrice'] as double,
            orderId: row['orderId'] as String),
        arguments: [orderId]);
  }

  @override
  Future<List<PaymentEntity>> findPaymentsForOrder(String orderId) async {
    return _queryAdapter.queryList('SELECT * FROM payment WHERE orderId = ?1',
        mapper: (Map<String, Object?> row) => PaymentEntity(
            id: row['id'] as String,
            installment: row['installment'] as int,
            value: row['value'] as double,
            code: row['code'] as String,
            name: row['name'] as String,
            orderId: row['orderId'] as String),
        arguments: [orderId]);
  }

  @override
  Future<void> insertOrder(OrderEntity order) async {
    await _orderEntityInsertionAdapter.insert(
        order, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertClient(ClientEntity client) async {
    await _clientEntityInsertionAdapter.insert(
        client, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAddress(AddressEntity address) async {
    await _addressEntityInsertionAdapter.insert(
        address, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertItems(List<ItemEntity> items) async {
    await _itemEntityInsertionAdapter.insertList(
        items, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertPayments(List<PaymentEntity> payments) async {
    await _paymentEntityInsertionAdapter.insertList(
        payments, OnConflictStrategy.replace);
  }
}
