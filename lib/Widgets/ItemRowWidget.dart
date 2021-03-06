import 'package:flutter/material.dart';
import 'package:slivers_ecomm_demo/Networkcall/fakeStoreResponsePojo.dart';

class ItemRowWidget extends StatelessWidget {
  final FakeStoreResponsePojo objFakeStoreResPojo;

  ItemRowWidget({@required this.objFakeStoreResPojo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(objFakeStoreResPojo.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(objFakeStoreResPojo.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500)),
                    Text(objFakeStoreResPojo.price,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
