import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeService extends GetConnect {
  Future<Response> fetchData() async {
    try {
      Response response = await get('https://jsonplaceholder.typicode.com/todos');
      return response;
    }
    catch(e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}