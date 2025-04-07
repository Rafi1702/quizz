extension GetBoolValue on String? {
  bool get getBool {
    return this == "true" ? true : false;
  }
}

extension TimeX on int {
  String get getHourlyFormat {
    return "${((this / 60) % 60).floor().toString().padLeft(2, '0')} : ${(this % 60).floor().toString().padLeft(2, '0')}";
  }
}
