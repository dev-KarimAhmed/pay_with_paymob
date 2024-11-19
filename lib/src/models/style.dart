import 'package:flutter/material.dart';

class Style {
  final Color? primaryColor,
      appBarBackgroundColor,
      appBarForegroundColor,
      unselectedColor,
      scaffoldColor , circleProgressColor;
  final TextStyle? textStyle;
  ButtonStyle? buttonStyle;
  // final bool? showMobileWalletIcons;

  Style({
    this.circleProgressColor = Colors.blue,
    this.primaryColor = Colors.blue,
    this.appBarBackgroundColor = Colors.blue,
    this.appBarForegroundColor = Colors.white,
    this.unselectedColor = Colors.grey,
    this.scaffoldColor = Colors.white,
    this.textStyle,
    this.buttonStyle,
    // this.showMobileWalletIcons = true,
  }){
     buttonStyle = buttonStyle ??
        ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Moved here to prevent constant expression error
          ),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        );
  }
}
