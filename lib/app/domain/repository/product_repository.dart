import 'package:intrapos_mobile/app/domain/entity/product.dart';
import 'package:intrapos_mobile/core/network/data_state.dart';

abstract class ProductRepository {
  Future<DataState<List<ProductEntity>>> getAll();
  Future<DataState<ProductEntity>> getByBarcode(String param);
}
