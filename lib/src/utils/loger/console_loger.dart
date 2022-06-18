import 'package:flutter/cupertino.dart';

void printError(String text) {
  print('🛑 :\x1B[31m$text\x1B[0m');
}

void printWarning(String text) {
  print('⚠ :\x1B[33m$text\x1B[0m');
}

void printInfo(String text) {
  print('📘 :\x1B[34m$text\x1B[0m');
}

void printOk(String text) {
  print('🎁 :\x1B[32m$text\x1B[0m');
}

//very bad logs extra un necessary
void printTrace() {
  debugPrintStack(label: 'sarmad', maxFrames: 2);
}

void customTrace() {
  var fullTrace = StackTrace.current;
  var traceString = fullTrace.toString().split("\n")[1];
  print(traceString);
}

var bottom = "^~~~~~~~~~~~~~~~^^~~~~~~~~~~~~~~~^";

void logTrace(
  String key, [
  dynamic value,
]) {
  dynamic val = "";
  if (value != null) {
    val = value.toString();
  }

  print('📘 :\x1B[36m$key \x1B[0m :--> \x1B[32m $val \x1B[0m');
  var fullTrace = StackTrace.current;
  var traceString = fullTrace.toString().split("\n")[1];
  print(traceString);
  print('📘 :\x1B[32m$bottom\x1B[0m');
}
