import 'package:flutter/cupertino.dart';
import 'package:intrapos_mobile/core/constant/constant.dart';
import 'package:intrapos_mobile/core/helper/shared_preferences.dart';
import 'package:intrapos_mobile/core/provider/app_provider.dart';

class LoginNotifier extends AppProvider {
  LoginNotifier() {
    init();
  }

  TextEditingController _baseUrlController = TextEditingController();

  TextEditingController get baseUrlController => _baseUrlController;

  @override
  init() async {
    await _getBaseUrl();
  }

  _getBaseUrl() async {
    showLoading();
    final baseUrlPref = await SharedPreferencesHelper.getString(PREF_BASE_URL);
    if (baseUrlPref == null) {
      _baseUrlController.text = 'https://pos.introtech.com';
      await SharedPreferencesHelper.setString(
          PREF_BASE_URL, _baseUrlController.text);
    } else {
      _baseUrlController.text = baseUrlPref;
    }
    hideLoading();
  }

  saveBaseUrl() {
    SharedPreferencesHelper.setString(PREF_BASE_URL, _baseUrlController.text);
  }
}
