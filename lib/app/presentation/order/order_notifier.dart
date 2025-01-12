import 'package:intrapos_mobile/app/domain/entity/order.dart';
import 'package:intrapos_mobile/app/domain/usecase/order_get_all.dart';
import 'package:intrapos_mobile/core/provider/app_provider.dart';

class OrderNotifier extends AppProvider {
  final OrderGetAllUseCase _orderGetAllUseCase;

  OrderNotifier(this._orderGetAllUseCase) {
    init();
  }

  List<OrderEntity> _listOrder = [];

  List<OrderEntity> get listOrder => _listOrder;

  @override
  init() async {
    await _getOrder();
  }

  _getOrder() async {
    showLoading();
    final response = await _orderGetAllUseCase();
    if (response.success) {
      _listOrder = response.data!;
    } else {
      errorMessage = response.message;
    }
    hideLoading();
  }
}