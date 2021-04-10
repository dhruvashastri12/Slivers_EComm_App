import 'package:flutter/material.dart';
import 'package:slivers_ecomm_demo/Networkcall/fakeStoreResponsePojo.dart';

class ItemColumnWidget extends StatelessWidget {
  final double itemImageHeight;
  final FakeStoreResponsePojo objFakeStoreResPojo;

  ItemColumnWidget({@required this.objFakeStoreResPojo, this.itemImageHeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.white,
        elevation: 1,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                    height: itemImageHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(objFakeStoreResPojo.image),
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(objFakeStoreResPojo.title, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(objFakeStoreResPojo.price,
                    style: TextStyle(color: Colors.black45, fontSize: 14.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
