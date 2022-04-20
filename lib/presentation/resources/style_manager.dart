import 'package:flutter/cupertino.dart';
import 'package:fota_mobile_app/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(double fontSize,FontWeight fontWeight,String fontFamily,Color color){
  return TextStyle(fontFamily: fontFamily,fontWeight :fontWeight,fontSize: fontSize,color: color);
}
/* Regular Style */
TextStyle getRegularStyle({double fontSize = FontSizeManager.s12,required Color color})
{
  return _getTextStyle(fontSize, FontWeightManager.regular, FontConstants.fontFamily, color);
}

/* Light Style */
TextStyle getLightStyle({double fontSize = FontSizeManager.s12,required Color color})
{
  return _getTextStyle(fontSize, FontWeightManager.light, FontConstants.fontFamily, color);
}

/* Medium Style */
TextStyle getMediumStyle({double fontSize = FontSizeManager.s12,required Color color})
{
  return _getTextStyle(fontSize, FontWeightManager.medium, FontConstants.fontFamily, color);
}

/* Thin Style */
TextStyle getThinStyle({double fontSize = FontSizeManager.s12,required Color color})
{
  return _getTextStyle(fontSize, FontWeightManager.thin, FontConstants.fontFamily, color);
}

/* Bold Style */
TextStyle getBoldStyle({double fontSize = FontSizeManager.s12,required Color color})
{
  return _getTextStyle(fontSize, FontWeightManager.bold, FontConstants.fontFamily, color);
}