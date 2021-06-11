import 'common.dart';
import 'transformer.dart';

class PrinterOutput {
  final String _sealedClassName;
  final String _continuedStatement;
  final String _joinStatement;

  PrinterOutput(
    this._sealedClassName,
    this._continuedStatement,
    this._joinStatement,
  );

  @override
  String toString() => (StringBuffer()
        ..writeln("extension ${_sealedClassName}Ext on $_sealedClassName {")
        ..writeln(_continuedStatement)
        ..writeln(_joinStatement)
        ..writeln("}"))
      .toString();
}

class Printer {
  static const _switchResultMethodName = "switchResult";
  static const _joinMethodName = "join";

  Printer._();

  static PrinterOutput constructOutput(
    final String className,
    final Iterable<GeneratedCodeData> typeParamData,
  ) {
    String switchResultStatement(
      final Iterable<GeneratedCodeData> typeParamData,
    ) {
      String continuedTypeCheckStatement(
          final Iterable<GeneratedCodeData> typeParamData) {
        final caseBuffer = StringBuffer();
        typeParamData.forEach((it) {
          caseBuffer
            ..writeln("if (this is ${it.type}) {")
            ..writeln(it.continuedFunction)
            ..writeln("}")
            ..writeln();
        });
        return caseBuffer.toString();
      }

      return (StringBuffer()
            ..write("$typeParam $_switchResultMethodName<$typeParam>({")
            ..writeln()
            ..writeln(typeParamData
                .map((it) => it.continuedFunctionDeclaration)
                .join(",\n"))
            ..writeln(",}) {")
            ..writeln(continuedTypeCheckStatement(typeParamData))
            ..writeln('throw Exception(\'Unexpected $className\');')
            ..writeln("}"))
          .toString();
    }

    String joinStatement(final Iterable<GeneratedCodeData> typeParamData) {
      String joinTypeCheckStatement(
          final Iterable<GeneratedCodeData> typeParamData) {
        final caseBuffer = StringBuffer();
        typeParamData.forEach((it) {
          caseBuffer
            ..writeln("if (this is ${it.type}) {")
            ..writeln("r = ${it.joinFunction}")
            ..writeln("}");
        });
        return caseBuffer.toString();
      }

      return (StringBuffer()
            ..write("$typeParam $_joinMethodName<$typeParam>(")
            ..writeln()
            ..writeln(typeParamData
                .map((it) => it.joinFunctionDeclaration)
                .join(",\n"))
            ..writeln(",) {")
            ..writeln("$typeParam ${typeParam.toLowerCase()};")
            ..writeln(joinTypeCheckStatement(typeParamData))
            ..writeln("return ${typeParam.toLowerCase()};")
            ..writeln("}"))
          .toString();
    }

    return PrinterOutput(
      className,
      switchResultStatement(typeParamData),
      joinStatement(typeParamData),
    );
  }
}
