import 'package:intrapos_mobile/core/constant/constant.dart';
import 'package:intrapos_mobile/core/helper/shared_preferences.dart';
import 'package:intrapos_mobile/core/provider/app_provider.dart';

class HomeNotifier extends AppProvider {
  HomeNotifier(){
    init();
  }

  String _name = '';
  String _email = '';

  String get name => _name;
  String get email => _email;
  
  @override
  init() async{
    await _getDetailUser();
  }
  
  _getDetailUser() async {
    showLoading();
    _name = await SharedPreferencesHelper.getString(PREF_NAME);
    _email = await SharedPreferencesHelper.getString(PREF_EMAIL);
    hideLoading();
  }
}