import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_client/model/product_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'http://192.168.1.104/api/product';

  static addproduct(Map pdata) async {
    debugPrint(pdata.toString());
    var url = Uri.parse(baseUrl);

    try {
      final res = await http.post(url, body: pdata);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        debugPrint(data.toString());
      } else {
        debugPrint('Failed to get response');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getProduct() async {
    List<Product> products = [];

    var url = Uri.parse(baseUrl);

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        data['products'].forEach((value) => {
              products.add(Product(
                  id: value['id'].toString(),
                  name: value['pname'],
                  desc: value['pdesc'],
                  price: value['pprice']))
            });

        debugPrint(data.toString());

        return products;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static updateProduct(id, body) async {
    var url = Uri.parse("$baseUrl/$id");

    final res = await http.put(url, body: body);

    if (res.statusCode == 200) {
      debugPrint(jsonDecode(res.body));
    } else {
      debugPrint('Failed to update data');
    }
  }

  static deleteProduct(id) async {
    var url = Uri.parse("$baseUrl/$id");

    final res = await http.delete(url);

    if (res.statusCode == 204) {
      debugPrint(jsonDecode(res.body));
    } else {
      debugPrint('Failed to delete product');
    }
  }
}
