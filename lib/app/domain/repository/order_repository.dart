import 'package:intrapos_mobile/app/domain/entity/order.dart';
import 'package:intrapos_mobile/core/network/data_state.dart';

abstract class OrderRepository {
  Future<DataState<List<OrderEntity>>> getAll();
  Future<DataState<OrderEntity>> getById(int id);
  Future<DataState<int>> insert(OrderEntity param);
  Future<DataState> update(OrderEntity param);
}
