import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:setting_app/login/loginPage.dart';
import 'exception_handlers.dart';

Response? AccessPermissionHandler(response,context) {
  if (response != null && response.statusCode == 401) {
    Fluttertoast.showToast(
      msg: 'ACCESS DENIED',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 30,
      backgroundColor: Color.fromARGB(255, 163, 5, 5),
      textColor: Colors.white,
      fontSize: 16.0,

    );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginPage()),
            (Route<dynamic> route) => false);
  }
  return response;
}

Future<Map<String, String>> setRequestHeaders([additionalHeaders]) async {
  const contentType = 'application/json';
  Map<String, String> headers = {'Content-Type': contentType};

  dynamic token = "";
  dynamic extra = additionalHeaders != null ? additionalHeaders : {};

  return headers = {
    'Content-Type': contentType,
    'x-access-token': token != null ? token : '',
    ...extra
  };
}

Future<Object?> get(BuildContext context,url, [headers]) async {
  print("url==> $url");
  try {
    Map<String, String> requestHeaders = await setRequestHeaders(headers);
    var response = await http
        .get(url)
        .timeout(const Duration(minutes: 2));
    return AccessPermissionHandler(response,context);
  } catch (e) {
    throw ExceptionHandlers().getExceptionString(e);
  }
  // catch (error) {
  //   print('Something went wrong in HTTP Get $error');

  //   throw error;
  // }
}

Future<Object?> post(BuildContext context,url, data, [headers]) async {
  print("url==> $url");
  try {
    final encodedData = data != null ? jsonEncode(data) : null;
    Map<String, String> requestHeaders = await setRequestHeaders(headers);

    var response = await http
        .post(
          url,
          headers: requestHeaders,
          body: encodedData,
        )
        .timeout(const Duration(minutes: 2));
    return AccessPermissionHandler(response,context);
  } catch (e) {
    throw ExceptionHandlers().getExceptionString(e);
  }
}

Future<Object?> put(BuildContext context,url, data, [headers]) async {
  print("url==> $url");

  try {
    final encodedData = jsonEncode(data);
    Map<String, String> requestHeaders = await setRequestHeaders(headers);
    var response =
        await http.put(url, body: encodedData, headers: requestHeaders);
    return AccessPermissionHandler(response,context);
  } catch (e) {
    throw ExceptionHandlers().getExceptionString(e);
  }
}

Future<Object?> delete(BuildContext context,url, [headers]) async {
  print("url==> $url");
  try {
    Map<String, String> requestHeaders = await setRequestHeaders(headers);
    print('response in http delete before ');

    var response = await http.delete(url, headers: requestHeaders);
    print('response in http delete after ');
    return AccessPermissionHandler(response,context);
  } catch (e) {
    throw ExceptionHandlers().getExceptionString(e);
  }
}

Future<Object> postToAcceptMultipartRequest(
    url, data, bufferData, fileName, fieldName,
    [headers]) async {
  print("url==> $url");

  try {
    Map<String, String> requestHeaders = await setRequestHeaders(headers);
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(requestHeaders);
    request.files.add(http.MultipartFile.fromBytes(fieldName, bufferData,
        filename: fileName));
    request.fields[fieldName] = json.encode(data);
    var response = await request.send();
    return response;
  } catch (e) {
    throw ExceptionHandlers().getExceptionString(e);
  }
}

Future<Object> postDataWithMutipleFiles(url, data, files, fieldName,
    [headers]) async {
  print("url==> $url");
  try {
    Map<String, String> requestHeaders = await setRequestHeaders(headers);
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(requestHeaders);
    for (int i = 0; i < files.length; i++) {
      request.files.add(files[i]);
    }
    request.fields[fieldName] = json.encode(data);
    // request.fields[fieldName] = data;

    var response = await request.send();
    return response;
  } catch (e) {
    throw ExceptionHandlers().getExceptionString(e);
  }
}

Future<Object?> getwithoutHeader(BuildContext context,url) async {
  print("url==> $url");

  try {
    const contentType = 'application/json';
    Map<String, String> headerstemp = {'Access-Control-Allow-Origin': "*"};
    var response = await http.get(url, headers: headerstemp);
    return AccessPermissionHandler(response,context);
  } catch (e) {
    throw ExceptionHandlers().getExceptionString(e);
  }
}

Future<Object?> postwithoutdata(BuildContext context,url, [headers]) async {
  print("url==> $url");

  try {
    //final encodedData = data != null ? jsonEncode(data) : null;
    Map<String, String> requestHeaders = await setRequestHeaders(headers);

    var response = await http.post(
      url,
      headers: requestHeaders,
    );
    return AccessPermissionHandler(response,context);
  } catch (e) {
    throw ExceptionHandlers().getExceptionString(e);
  }
}
