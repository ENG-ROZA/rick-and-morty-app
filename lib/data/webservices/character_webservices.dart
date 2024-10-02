import 'package:dio/dio.dart';
import 'package:flutter_breakingbad/presentation/utils/constants/strings.dart';

class CharacterWebservices {
  var dio = Dio();

  CharacterWebservices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 20 * 1000),
      connectTimeout: const Duration(seconds: 20 * 1000),
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>> getAllCharacters() async {
    try {
      Response response =
          await dio.get('character'); //characters is the end point of api
      print(response.data.toString());
      print(response.statusCode.toString());

      return response.data;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }
}
