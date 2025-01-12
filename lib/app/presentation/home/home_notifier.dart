import 'package:intrapos_mobile/app/domain/entity/order.dart';
import 'package:intrapos_mobile/app/domain/usecase/order_get_today.dart';
import 'package:intrapos_mobile/core/constant/constant.dart';
import 'package:intrapos_mobile/core/helper/shared_preferences.dart';
import 'package:intrapos_mobile/core/provider/app_provider.dart';

class HomeNotifier extends AppProvider {
  final OrderGetTodayUseCase _orderGetTodayUseCase;
  HomeNotifier(this._orderGetTodayUseCase){
    init();
  }

  String _name = '';
  String _email = '';
  List<OrderEntity> _listOrder = [];

  String get name => _name;
  String get email => _email;
  List<OrderEntity> get listOrder => _listOrder ;
  
  @override
  init() async{
    await _getDetailUser();
    await _getOrder();
  }
  
  _getDetailUser() async {
    showLoading();
    _name = await SharedPreferencesHelper.getString(PREF_NAME);
    _email = await SharedPreferencesHelper.getString(PREF_EMAIL);
    hideLoading();
  }
  
  _getOrder() async {
    showLoading();
    final response = await _orderGetTodayUseCase();
    if(response.success){
      _listOrder = response.data!;
    } else {
      errorMessage = response.message;
    }
    hideLoading();
  }
}