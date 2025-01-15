import 'package:intrapos_mobile/app/domain/entity/payment_method.dart';
import 'package:intrapos_mobile/app/domain/repository/payment_method_repository.dart';
import 'package:intrapos_mobile/core/network/data_state.dart';
import 'package:intrapos_mobile/core/use_case/app_use_case.dart';

class PaymentMethodGetAllUseCase
    extends AppUseCase<Future<DataState<List<PaymentMethodEntity>>>, void> {
  final PaymentMethodRepository _paymentMethodRepository;

  PaymentMethodGetAllUseCase(this._paymentMethodRepository);
  @override
  Future<DataState<List<PaymentMethodEntity>>> call({void param}) {
    return _paymentMethodRepository.getAll();
  }
}
