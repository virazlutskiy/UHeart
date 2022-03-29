enum ThemeStyle {
  dark,
  light,
}

class Settings {
  final ThemeStyle _themeStyle;

  Settings(this._themeStyle);

  Settings copyWith({ThemeStyle? themeStyle}) => Settings(
        themeStyle ?? _themeStyle,
      );
}
