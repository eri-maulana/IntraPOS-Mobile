import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:intrapos_mobile/app/presentation/home/home_notifier.dart';
import 'package:intrapos_mobile/app/presentation/login/login_notifier.dart';
import 'package:intrapos_mobile/app/presentation/order/order_notifier.dart';
import 'package:intrapos_mobile/core/network/app_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final sl = GetIt.instance;

void initDependency() {
  // dio
  Dio dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      compact: false));
  dio.interceptors.add(AppInterceptor());

  sl.registerSingleton<Dio>(dio);

  //presentation
  sl.registerFactoryParam<LoginNotifier, void, void>(
    (param1, param2) => LoginNotifier(),
  );
  sl.registerFactoryParam<HomeNotifier, void, void>(
    (param1, param2) => HomeNotifier(),
  );
  sl.registerFactoryParam<OrderNotifier, void, void>(
    (param1, param2) => OrderNotifier(),
  );
}
