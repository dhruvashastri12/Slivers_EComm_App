import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' show get;
import 'package:slivers_ecomm_demo/Networkcall/fakeStoreResponse.dart';
import 'package:slivers_ecomm_demo/Networkcall/fakeStoreResponsePojo.dart';
import 'package:slivers_ecomm_demo/Widgets/PageViewHeader.dart';
import 'package:slivers_ecomm_demo/Widgets/ItemRowWidget.dart';
import 'package:slivers_ecomm_demo/Widgets/ItemColumnWidget.dart';
import 'package:slivers_ecomm_demo/Widgets/TopTrendingSliverBoxAdapter.dart';

final String fakeStoreUrl = "https://fakestoreapi.com/products";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int firstIndex = 0;

  FakeStoreResponsePojo objFSR;

  FakeStoreResponse objFakeStoreResponse;
  List<FakeStoreResponsePojo> objFSRList;

  @override
  void initState() {
    super.initState();
    fetchData(firstIndex);
  }

  void fetchData(int itemIndex) async {
    var receivedStoreResponse = await get(Uri.parse(fakeStoreUrl));
    if (receivedStoreResponse.statusCode == 200) {
      objFakeStoreResponse =
          FakeStoreResponse.fromJson(json.decode(receivedStoreResponse.body));

      objFSR = FakeStoreResponsePojo();
      if (objFSRList == null) objFSRList = <FakeStoreResponsePojo>[];
      for (int i = 0; i < objFakeStoreResponse.fakeStoreList.length; i++) {
        objFSR = objFakeStoreResponse.fakeStoreList[i];
        objFSRList.add(objFSR);
      }

      print('Product title: ${objFakeStoreResponse.fakeStoreList[0].title}');
      print('Product category: ${objFakeStoreResponse.fakeStoreList[0].category}');
    } else {
      throw Exception('Failed to load album');
    }
    setState(() {
      print("Set state from fetchData");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: (objFSRList == null)
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
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
                      return ItemColumnWidget(
                        objFakeStoreResPojo: objFSRList[index],
                        itemImageHeight: 100,
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

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ItemRowWidget(
                          objFakeStoreResPojo: objFSRList[index]);
                    },
                    // uncomment the following line to provide definite list of items:
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
                      return ItemColumnWidget(
                        objFakeStoreResPojo: objFSRList[index],
                        itemImageHeight: 50,
                      );
                    },
                    /// or set childCount to limit no.of items
                    childCount: 10,
                  ),
                ),
              ],
            ),
    );
  }
}