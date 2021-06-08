import 'common.dart';

class GeneratedCodeData {
  static const doOnMethodName = "on";
  static const joinMethodName = "join";

  final String type;

  final String continuedFunction;
  final String continuedFunctionDeclaration;

  final String joinFunction;
  final String joinFunctionDeclaration;

  GeneratedCodeData(this.type)
      : continuedFunction = "return $doOnMethodName$type(this);",
        continuedFunctionDeclaration =
            "$typeParam Function($type) $doOnMethodName$type",
        joinFunction = "$joinMethodName$type(this);",
        joinFunctionDeclaration =
            "$typeParam Function($type) $joinMethodName$type";
}

class TypeParameterTransformer {
  TypeParameterTransformer._();

  static List<GeneratedCodeData> toGeneratedCodeData(final List<String> typeParameters) =>
      typeParameters.map((it) => GeneratedCodeData(it)).toList(growable: false);
}
