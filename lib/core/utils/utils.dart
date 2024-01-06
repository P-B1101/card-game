import 'dart:io';

import 'package:flutter/material.dart';

class Utils {
  const Utils._();

  static void exitApp() {
    exit(0);
  }

  static const maxCountDown = 5;
  
  static const lobbyPort = 1212;

  static const boardPort = 1213;
}

class UiUtils {
  const UiUtils._();

  static const duration = Duration(milliseconds: 300);

  static const curve = Curves.ease;

  static const maxInputSize = 320.0;

  static const dashboardItemWidth = 360.0;

  static const dashboardItemHeight = 80.0;

  static const maxWidth = 726.0;

  static const dialogWidth = 420.0;

  static const dropDownMaxHeight = 350.0;

  static const mapSize = 400.0;

  static const menuWidth = 250.0;

  static const companyLogoSize = 107.0;

  static const chartHeight = 500.0;

  static const chartFilterWidth = 120.0;

  static const infoColumnSize = 500.0;

  static const buttonWidth = 170.0;

  static const inputHeight = 170.0;
}
