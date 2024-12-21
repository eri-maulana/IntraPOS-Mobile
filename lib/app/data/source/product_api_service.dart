import 'package:intrapos_mobile/core/constant/constant.dart';
import 'package:intrapos_mobile/core/network/data_state.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'product_api_service.g.dart';

@RestApi()
abstract class ProductApiService {
  factory ProductApiService(Dio dio) {
    return _ProductApiService(dio);
  }

  @GET(PRODUCT_URL)
  Future<HttpResponse<DataState>> getAll();

  @GET(PRODUCT_URL + '/barcode/{barcode}')
  Future<HttpResponse<DataState>> getByBarcode(
      {@Path('id') required String barcode});
}
