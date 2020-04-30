import 'package:dio/dio.dart';
import 'package:dio_log/dio_log.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jingdong/constant/constant.dart';
import 'package:jingdong/utils/log_utl.dart';
import 'error_parser.dart';
import 'http_const.dart';
import 'interceptors.dart';
import 'model_factory.dart';

class DioUtil {
  static Dio _dio;

  static void init() {
    /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
    BaseOptions _baseOptions = BaseOptions(
        baseUrl: Constant.isRelease
            ? 'http://192.168.0.104:8080/v1/api'
            : 'http://192.168.0.104:8080/v1/api',
        connectTimeout: 10000,
        receiveTimeout: 10000);

    _dio = Dio(_baseOptions);
    _dio.interceptors.add(TokenInterceptor());
    _dio.interceptors.add(CommonParamsInterceptor());
    if (!Constant.isRelease) {
      _dio.interceptors.add(DioLogInterceptor());
    }
  }

  static void doRequest<T>(Method method, String path,
      {Map<String, dynamic> params,
      Function(T data) onSuccess,
      Function() onError,
      CancelToken cancelToken,
      Options options}) async {
    Response response;
    try {
      if (method == Method.GET) {
        response = await _dio.get(path,
            queryParameters: params,
            options: options,
            cancelToken: cancelToken);
      } else {
        response = await _dio.post(path,
            queryParameters: params,
            options: options,
            cancelToken: cancelToken);
      }
    } on DioError catch (e) {
      String errMsg = '网络异常';
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errMsg = '连接超时';
      } else if (e.type == DioErrorType.SEND_TIMEOUT) {
        errMsg = '发送超时';
      } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errMsg = '发送超时';
      }
      Fluttertoast.showToast(msg: errMsg);
      if (onError != null) {
        onError();
      }
      return;
    }

    bool hasError = ErrorHandler.hasError(response);
    if (hasError) {
      if (onError != null) {
        onError();
      }
      return;
    }

    LogUtil.d("请求返回结果：${response.data}");
    T model = ModelFactory.createModel<T>(response.data[HttpConst.DATA]);
    if (model != null) {
      if (onSuccess != null) {
        onSuccess(model);
      }
    } else {
      if (onError != null) {
        onError();
      }
    }
  }
}

enum Method { GET, POST }
