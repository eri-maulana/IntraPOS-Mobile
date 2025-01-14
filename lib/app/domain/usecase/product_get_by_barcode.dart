import 'package:intrapos_mobile/app/domain/entity/product.dart';
import 'package:intrapos_mobile/app/domain/repository/product_repository.dart';
import 'package:intrapos_mobile/core/network/data_state.dart';
import 'package:intrapos_mobile/core/use_case/app_use_case.dart';

class ProductGetByBarcodeUseCase
    extends AppUseCase<Future<DataState<ProductEntity>>, String> {
  final ProductRepository _productRepository;

  ProductGetByBarcodeUseCase(this._productRepository);
  @override
  Future<DataState<ProductEntity>> call({String? param}) {
    return _productRepository.getByBarcode(param!);
  }
}
