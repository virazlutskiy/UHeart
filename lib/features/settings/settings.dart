enum ThemeStyle {
  dark,
  light,
}
/// [Settings] - класс хранящий в себе настройки приложения
class Settings {
  final ThemeStyle _themeStyle;

  Settings(this._themeStyle);

  Settings copyWith({ThemeStyle? themeStyle}) => Settings(
        themeStyle ?? _themeStyle,
      );
}
