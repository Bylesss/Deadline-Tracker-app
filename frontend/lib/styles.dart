import 'package:flutter/material.dart';

//Color Palette

const Color kPrimaryColor = Color(0xFF1565C0);
const Color kPrimaryLight = Color(0xFF42A5F5);
const Color kPrimaryDark = Color(0xFF0D47A1);
const Color kAccentColor = Color(0xFF26A69A);
const Color kAccentDark = Color(0xFF00897B);
const Color kErrorColor = Color(0xFFD32F2F);
const Color kWarningColor = Color(0xFFF57C00);
const Color kSuccessColor = Color(0xFF388E3C);

const Color kBackgroundColor = Color(0xFFF5F7FA);
const Color kSurfaceColor = Color(0xFFFFFFFF);
const Color kTextPrimary = Color(0xFF1A1C1E);
const Color kTextSecondary = Color(0xFF5F6368);
const Color kTextHint = Color(0xFF9AA0A6);
const Color kDividerColor = Color(0xFFE0E3E7);
const Color kCardShadow = Color(0x1A000000);

//App Theme

final ThemeData kAppTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Roboto',
  colorScheme: const ColorScheme.light(
    primary: kPrimaryColor,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFD4E4F7),
    secondary: kAccentColor,
    onSecondary: Colors.white,
    surface: kSurfaceColor,
    onSurface: kTextPrimary,
    error: kErrorColor,
    onError: Colors.white,
  ),
  scaffoldBackgroundColor: kBackgroundColor,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    color: kSurfaceColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: kDividerColor, width: 1),
    ),
    margin: const EdgeInsets.symmetric(vertical: 6),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      foregroundColor: kPrimaryColor,
      side: const BorderSide(color: kPrimaryColor, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kPrimaryColor,
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kSurfaceColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: kDividerColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: kDividerColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: kPrimaryColor, width: 2),
    ),
    hintStyle: const TextStyle(color: kTextHint, fontSize: 15),
    labelStyle: const TextStyle(color: kTextSecondary, fontSize: 15),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(foregroundColor: kTextPrimary),
  ),
  dividerTheme: const DividerThemeData(
    color: kDividerColor,
    thickness: 1,
    space: 0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
);

//Text Styles

const kHeadingTextStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w700,
  color: kTextPrimary,
  letterSpacing: -0.5,
  height: 1.3,
);

const kSubheadingTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: kTextPrimary,
  letterSpacing: 0.1,
);

const kBodyTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  color: kTextSecondary,
  height: 1.5,
);

const kCaptionTextStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  color: kTextHint,
  letterSpacing: 0.2,
);

const kButtonTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.white,
  letterSpacing: 0.3,
);

const kTimerTextStyle = TextStyle(
  fontSize: 72,
  fontWeight: FontWeight.w300,
  color: kTextPrimary,
  letterSpacing: -2,
  fontFeatures: [FontFeature.tabularFigures()],
);

//Button Styles

ButtonStyle kElevatedButtonStyle(Color color) {
  return ElevatedButton.styleFrom(
    elevation: 0,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    backgroundColor: color,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: kButtonTextStyle,
  );
}

ButtonStyle kOutlinedButtonStyle(Color color) {
  return OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    foregroundColor: color,
    side: BorderSide(color: color, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: kButtonTextStyle.copyWith(color: color),
  );
}

//Decorations

BoxDecoration kCardDecoration = BoxDecoration(
  color: kSurfaceColor,
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: kDividerColor),
);

BoxDecoration kSelectedDecoration = BoxDecoration(
  color: kPrimaryColor,
  borderRadius: BorderRadius.circular(10),
);

BoxDecoration kTodayDecoration = BoxDecoration(
  color: kPrimaryColor.withAlpha(25),
  borderRadius: BorderRadius.circular(10),
  border: Border.all(color: kPrimaryColor, width: 1.5),
);

//Spacing Constants

const double kPagePadding = 24.0;
const double kCardPadding = 20.0;
const double kItemSpacing = 16.0;
const double kSectionSpacing = 28.0;
