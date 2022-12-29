import 'package:challenge2/core/widgets/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../gen/core/data/model/note/note/note.dart';

class ItemNote extends StatelessWidget {
  const ItemNote({Key? key, required this.data, required this.onClick})
      : super(key: key);

  final Note data;
  final Function(Note) onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onClick(data);
        },
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 20, 0),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  width: 1,
                  color: AppColors.grey_border,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 20, top: 10),
                    alignment: Alignment.bottomLeft,
                    child: Text(data.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: Colors.black)),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 20, bottom: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text(data.content,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.black)),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ));
  }
}
