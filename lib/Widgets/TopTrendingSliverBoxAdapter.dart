import 'package:flutter/material.dart';
import 'package:slivers_ecomm_demo/Networkcall/fakeStoreResponsePojo.dart';

// ignore: must_be_immutable
class TopTrendingSliverBoxAdapter extends StatelessWidget {

  List<FakeStoreResponsePojo> objFSRList;
  
  TopTrendingSliverBoxAdapter({@required this.objFSRList});

  @override
  Widget build(BuildContext context) {
    if(objFSRList == null) objFSRList = <FakeStoreResponsePojo>[];
    return Container(
      color: Colors.deepOrange[100],
      child: Column(
        children: [
          Text('Top Trending',
              style: TextStyle(color: Colors.black, fontSize: 22.0)),
          Container(
            height: 250.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: objFSRList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: 120, // manages card width
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(objFSRList[index].image),
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top:5, bottom:5),
                              child: Text(objFSRList[index].title, maxLines: 4, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(objFSRList[index].price, textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 16.0, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
