import 'package:altur/constants/cons_size.dart';
import 'package:altur/enums/icon_enums.dart';
import 'package:altur/widgets/text/index.dart';
import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  const SubTitleWidget({super.key, required this.text, required this.callback, this.buttonText = "Tümü"});
  final String text;
  final VoidCallback callback;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextSubtitle(text:text),
                InkWell(
                  onTap: callback,
                  child: Row(
                    children: [
                      TextBody(text: buttonText, color: Colors.black54,),
                      SizedBox(width: ConsSize.space/4,),
                      IconEnums.getMore.iconWidget
                    ],
                  ),
                ),

              ],
            ),
            Divider(),
            SizedBox(height: ConsSize.space/2,),
      ],
    );
}
}