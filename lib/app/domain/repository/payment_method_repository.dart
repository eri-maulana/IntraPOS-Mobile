import 'package:intrapos_mobile/app/domain/entity/payment_method.dart';
import 'package:intrapos_mobile/core/network/data_state.dart';

abstract class PaymentMethodRepository {
  Future<DataState<List<PaymentMethodEntity>>> getAll();
}
