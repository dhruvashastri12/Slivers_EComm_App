import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:slivers_ecomm_demo/fakeStoreResponsePojo.dart';
import 'dart:math' as math;
import 'fakeStoreResponse.dart';
import 'package:http/http.dart' show get;
import 'package:slivers_ecomm_demo/PageViewHeader.dart';
import 'package:slivers_ecomm_demo/ItemRowWidget.dart';
import 'package:slivers_ecomm_demo/ItemColumnWidget.dart';
import 'package:slivers_ecomm_demo/TopTrendingSliverBoxAdapter.dart';

void main() {
  runApp(MyApp());
}

final String fakeStoreUrl = "https://fakestoreapi.com/products";

class MyApp extends StatefulWidget {
  FakeStoreResponsePojo objFSR;

  @override
  _MyAppState createState() => _MyAppState();

  static getRandomColor() =>
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0);
}

class _MyAppState extends State<MyApp> {
  int firstIndex = 0;
  FakeStoreResponse objFakeStoreResponse;
  List<FakeStoreResponsePojo> objFSRList;

  @override
  void initState() {
    super.initState();
    // widget.objFSR = FakeStoreResponsePojo();
    // objFSRList = <FakeStoreResponsePojo>[];
    fetchData(firstIndex);
  }

  void fetchData(int itemIndex) async {
    // Future.value(objFakeStoreResponse);
    var receivedStoreResponse = await get(Uri.parse(fakeStoreUrl));
    if (receivedStoreResponse.statusCode == 200) {
      objFakeStoreResponse =
          FakeStoreResponse.fromJson(json.decode(receivedStoreResponse.body));

      widget.objFSR = FakeStoreResponsePojo();
      if (objFSRList == null) objFSRList = <FakeStoreResponsePojo>[];
      for (int i = 0; i <= objFakeStoreResponse.fakeStoreList.length; i++) {
        widget.objFSR = objFakeStoreResponse.fakeStoreList[i];
        objFSRList.add(widget.objFSR);
      }

      print(receivedStoreResponse.body);
      print(objFakeStoreResponse.fakeStoreList[0].id);
      print(objFakeStoreResponse.fakeStoreList[0].category);
      print('Product title: ${objFakeStoreResponse.fakeStoreList[0].title}');
      print(
          'Product category: ${objFakeStoreResponse.fakeStoreList[0].category}');
      print(
          'Product description: ${objFakeStoreResponse.fakeStoreList[0].description}');
    } else {
      throw Exception('Failed to load album');
    }
    setState(() {
      print("Set state from fetchData");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: (objFSRList == null) ? CircularProgressIndicator(): CustomScrollView(
          slivers: [
            SliverAppBar(title: Text('Slivers E-commerce App')),

            SliverFixedExtentList(
              itemExtent: 150,
              delegate: SliverChildListDelegate(
                  [PageViewHeader(objFSRList: objFSRList)]),
            ),

            SliverPadding(padding: EdgeInsets.all(5)),

            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ItemRowWidget(objFakeStoreResPojo: objFSRList[3]),
                  ItemRowWidget(objFakeStoreResPojo: objFSRList[19]),
                  ItemRowWidget(objFakeStoreResPojo: objFSRList[11])
                ],
              ),
            ),

            SliverPadding(padding: EdgeInsets.all(5)),

            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  // height of item is passed in maxCrossAxisExtent
                  maxCrossAxisExtent: 200),

              ///Lazy building of list
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  /// To convert infinite list to a list with "n" no of items,
                  /// uncomment the following line:
                  /// if (index > n) return null;

                  return ItemColumnWidget(
                    objFakeStoreResPojo: objFSRList[index],
                    itemImageHeight: 120,
                  );
                },

                /// or set childCount to limit no.of items
                childCount: 4,
              ),
            ),

            SliverPadding(padding: EdgeInsets.all(5)),

            SliverToBoxAdapter(
              child: TopTrendingSliverBoxAdapter(objFSRList: objFSRList),
            ),

            SliverPadding(padding: EdgeInsets.all(5)),

            // This builds an infinite scrollable list of differently colored Containers.
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  // To convert infinite list to a list with three items, uncomment the following line:
                  // if (index > 3) return null;
                  // return Container(color: getRandomColor(), height: 150.0);

                  return ItemRowWidget(objFakeStoreResPojo: objFSRList[index]);
                },
                // Or, uncomment the following line:
                childCount: 4,
              ),
            ),

            SliverPadding(padding: EdgeInsets.all(5)),

            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                ///no.of items in the horizontal axis
                crossAxisCount: 3,
              ),

              ///Lazy building of list
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  /// To convert infinite list to a list with "n" no of items,
                  /// uncomment the following line:
                  /// if (index > n) return null;

                  return ItemColumnWidget(
                    objFakeStoreResPojo: objFSRList[index],
                    itemImageHeight: 60,
                  );
                },

                /// or set childCount to limit no.of items
                childCount: 10,
              ),
            ),
          ],
        ));
  }
}
