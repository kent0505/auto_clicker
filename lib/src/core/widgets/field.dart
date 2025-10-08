import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

enum FieldType {
  text,
  password,
  multiline,
  number,
  decimal,
  phone,
  url,
}

class Field extends StatelessWidget {
  const Field({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLength = 50,
    this.fieldType = FieldType.text,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.onChanged,
    this.onTap,
  });

  final TextEditingController controller;
  final String hintText;
  final int? maxLength;
  final bool readOnly;
  final FieldType fieldType;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: switch (fieldType) {
        FieldType.text => TextInputType.text,
        FieldType.password => TextInputType.text,
        FieldType.multiline => TextInputType.multiline,
        FieldType.number => TextInputType.number,
        FieldType.decimal =>
          const TextInputType.numberWithOptions(decimal: true),
        FieldType.phone => TextInputType.phone,
        FieldType.url => TextInputType.url,
      },
      obscureText: fieldType == FieldType.password,
      readOnly: readOnly,
      showCursor: !readOnly,
      enableInteractiveSelection: !readOnly,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
        if (fieldType == FieldType.number)
          FilteringTextInputFormatter.digitsOnly,
        if (fieldType == FieldType.decimal) _SingleDotInputFormatter(),
        if (fieldType == FieldType.phone) _PhoneInputFormatter()
      ],
      textCapitalization: textCapitalization,
      minLines: fieldType == FieldType.multiline ? 10 : 1,
      maxLines: fieldType == FieldType.multiline ? null : 1,
      style: const TextStyle(
        color: AppColors.text,
        fontSize: 16,
        fontFamily: AppFonts.w600,
      ),
      decoration: InputDecoration(hintText: hintText),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}

class _SingleDotInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(',', '.');
    if (RegExp(r'^[0-9]*\.?[0-9]*$').hasMatch(text)) {
      final dotCount = '.'.allMatches(text).length;
      if (dotCount > 1) return oldValue;
      return newValue.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
    return oldValue;
  }
}

class _PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;
    if (RegExp(r'^\+?[0-9]*$').hasMatch(text)) {
      if (text.contains('+') && !text.startsWith('+')) return oldValue;
      return newValue;
    }
    return oldValue;
  }
}
