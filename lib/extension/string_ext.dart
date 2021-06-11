extension StringExt on String {
  String toLowerCaseUnderScore() => toLowerCase().replaceAll(' ', '_');
}
