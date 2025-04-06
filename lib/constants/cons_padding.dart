import 'package:altur/constants/cons_size.dart';
import 'package:flutter/material.dart';



class ConsPadding extends EdgeInsets{

  ///All - Standart Padding - ConsSize.space/2
  const ConsPadding.itemMargin(): super.symmetric(horizontal: ConsSize.space / 2 , vertical: ConsSize.space / 2);

  const ConsPadding.inputPadding(): super.symmetric(vertical: ConsSize.space / 2);

  const ConsPadding.contentPadding(): super.symmetric(vertical: ConsSize.space / 4, horizontal: ConsSize.space/2);

}