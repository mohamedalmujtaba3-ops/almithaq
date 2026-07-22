import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:almithaq/core/class/statusrequest.dart';
import 'package:almithaq/core/functions/checkinternet.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, String>> _getAuthHeaders() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token') ?? '';
  return {
    'Authorization': 'Bearer $token',
  };
}



class Crud {

  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {

  if (await checkInternet()) {
    try {
          final headers = await _getAuthHeaders();

          var response = await http.post(
            Uri.parse(linkurl),
            body: data,
            headers: {'Authorization': headers['Authorization']!},
          ).timeout(const Duration(seconds: 60));
          print(response.statusCode); 

          if (response.statusCode == 200 || response.statusCode == 201) {
            Map responsebody = jsonDecode(response.body);
            print(responsebody) ; 
            
            return Right(responsebody);
          } else {
            return const Left(StatusRequest.serverfailure);
          }

    } on TimeoutException {
        return const Left(StatusRequest.offlinefailure);
    } on Error {
        return const Left(StatusRequest.offlinefailure);
    }

  } else {
        return const Left(StatusRequest.offlinefailure);
  }

  }




  Future<Either<StatusRequest, Map>> postDataWithOneFile(String linkurl, Map data, File file,
  [String? namerequest]) async {

  if (await checkInternet()) {

    try {

          if (namerequest == null) {
            namerequest = "files";
          }
          
        final headers = await _getAuthHeaders();
        var uri = Uri.parse(linkurl);
        var request = http.MultipartRequest("POST", uri);
        request.headers['Authorization'] = headers['Authorization']!;

        if (file != null) {
          var length = await file.length();
          var stream = http.ByteStream(file.openRead());
          stream.cast();
          var MultipartFile = http.MultipartFile(namerequest, stream, length, filename: basename(file.path));
          request.files.add(MultipartFile);
        }

        // add Data To Request
        data.forEach((key, value) {
          request.fields[key] = value;
        });

        // send Request
        var myrequest = await request.send();

        // For Getting Response Body
        var response = await http.Response.fromStream(myrequest);
        if(response.statusCode == 200 || response.statusCode == 201) {
          print(response.body);
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }

    } on TimeoutException {
        return const Left(StatusRequest.offlinefailure);
    } on Error {
        return const Left(StatusRequest.offlinefailure);
    }

  } else {
        return const Left(StatusRequest.offlinefailure);
  }


  }



  
}
