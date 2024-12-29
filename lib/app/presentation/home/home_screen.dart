import 'package:flutter/material.dart';
import 'package:intrapos_mobile/app/presentation/home/home_notifier.dart';
import 'package:intrapos_mobile/core/helper/global_helper.dart';
import 'package:intrapos_mobile/core/widget/app_widget.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends AppWidget<HomeNotifier, void, void> {
  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
        child: RefreshIndicator(
            onRefresh: () => notifier.init(),
            child: ListView(
              children: [
                _headerLayout(context),
                _orderTodayLayout(context),
              ],
            )));
  }

  _headerLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: GlobalHelper.getColorScheme(context).primary,
                child: Text(
                  'A',
                  style: GlobalHelper.getTextTheme(context,
                          appTextStyle: AppTextStyle.HEADLINE_LARGE)
                      ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color:
                              GlobalHelper.getColorScheme(context).onPrimary),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin',
                      style: GlobalHelper.getTextTheme(context,
                              appTextStyle: AppTextStyle.TITLE_LARGE)
                          ?.copyWith(
                              color:
                                  GlobalHelper.getColorScheme(context).primary,
                              fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'eri@maulana.com',
                      style: GlobalHelper.getTextTheme(context,
                              appTextStyle: AppTextStyle.LABEL_LARGE)
                          ?.copyWith(
                              color: GlobalHelper.getColorScheme(context)
                                  .secondary),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  _orderTodayLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Order Hari Ini',
                  style: GlobalHelper.getTextTheme(context,
                          appTextStyle: AppTextStyle.TITLE_LARGE)
                      ?.copyWith(
                          color: GlobalHelper.getColorScheme(context).primary,
                          fontWeight: FontWeight.bold),
                ),
              ),
              FilledButton(onPressed: () {}, child: Text('Lihat Semua'))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(
              height: 5,
            ),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _itemOrderLayout(context);
            },
          )
        ],
      ),
    );
  }

  _itemOrderLayout(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'nama_pelanggan',
                  style: GlobalHelper.getTextTheme(context,
                          appTextStyle: AppTextStyle.BODY_LARGE)
                      ?.copyWith(
                          color: GlobalHelper.getColorScheme(context).primary,
                          fontWeight: FontWeight.bold),
                ),
                Text(
                  '11 Mei 2001 23:30',
                  style: GlobalHelper.getTextTheme(context,
                          appTextStyle: AppTextStyle.BODY_SMALL)
                      ?.copyWith(
                          color:
                              GlobalHelper.getColorScheme(context).secondary),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rp. 50.000 (1 item)',
                  style: GlobalHelper.getTextTheme(context,
                          appTextStyle: AppTextStyle.BODY_MEDIUM)
                      ?.copyWith(
                          color: GlobalHelper.getColorScheme(context).primary,
                          fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color:
                              GlobalHelper.getColorScheme(context).secondary),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'Cash',
                    style: GlobalHelper.getTextTheme(context,
                            appTextStyle: AppTextStyle.BODY_SMALL)
                        ?.copyWith(
                            color:
                                GlobalHelper.getColorScheme(context).secondary),
                  ),
                )
              ],
            )
          ],
        ));
  }
}