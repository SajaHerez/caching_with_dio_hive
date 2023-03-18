import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';

import 'cache.dart';
import 'dio_client.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CacheOptions cacheOption;
  late DioClient client;
  late dynamic response;

  init() async {
    cacheOption = await Cache.getCachOptions();
    print(cacheOption.policy);
    client = await DioClient(cacheOption);
    response = await client.getResponse();
    print("inside init >>>>>>>>>>>");
  }

  @override
  void initState() {
    init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder(
        future: response,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Here cached data is available :',
                ),
                Text(snapshot.data.toString()),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(" some error here "),
            );
          } else if (snapshot.hasData == false) {
            return const Center(
              child: Text(" on data here"),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Get Data',
        child: const Icon(Icons.add),
      ),
    );
  }
}
