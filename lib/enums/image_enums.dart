import 'package:altur/constants/cons_size.dart';
import 'package:flutter/material.dart';

enum ImageEnums
{
  settings,
  logo,
  carList
}

extension ImageExtension on ImageEnums{

  String get imageName
  {
    switch(this)
    {      
      case ImageEnums.settings:
        return 'ic_settings';
      
      case ImageEnums.logo:
        return 'ic_logo';
      
      case ImageEnums.carList:
        return 'ic_car';

    
    }
  }

  String get toPath => 'assets/icons/$imageName.png';

  Widget get imageWidget => Image.asset(toPath,height: ConsSize.iconSize);

}