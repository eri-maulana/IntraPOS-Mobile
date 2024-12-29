import 'package:flutter/material.dart';
import 'package:intrapos_mobile/app/presentation/home/home_screen.dart';
import 'package:intrapos_mobile/app/presentation/login/login_notifier.dart';
import 'package:intrapos_mobile/core/helper/dialog_helper.dart';
import 'package:intrapos_mobile/core/helper/global_helper.dart';
import 'package:intrapos_mobile/core/widget/app_widget.dart';
// import 'flutter/src/widgets/framework.dart';

class LoginScreen extends AppWidget<LoginNotifier, void, void> {
  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () => _onPressUrlButton(context),
                  icon: Icon(Icons.link))),
          Expanded(
            child: Center(
              child: Text(
                'Introtech Retail Assisten',
                style: GlobalHelper.getTextTheme(context,
                    appTextStyle: AppTextStyle.DISPLAY_SMALL),
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
                label: Text('Email'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              label: Text('Kata Sandi'),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: double.maxFinite,
              child: FilledButton(onPressed: () => _onPressLogin(context), child: Text('Masuk'))),
          SizedBox(
            height: 50,
          )
        ],
      ),
    ));
  }

  _onPressUrlButton(BuildContext context) {
    DialogHelper.showBottomSheetDialog(
        context: context,
        title: 'Pengaturan Base URL',
        content: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  label: Text('Base URL'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.maxFinite,
                child: FilledButton(onPressed: () {}, child: Text('Simpan')))
          ],
        ));
  }

  _onPressLogin(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    
  }
}
