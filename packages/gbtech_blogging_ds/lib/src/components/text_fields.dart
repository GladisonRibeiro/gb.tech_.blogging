import 'package:flutter/material.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

class GbTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? value;
  final Key? keyField;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final int? maxLines;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextInputAction? textInputAction;

  const GbTextField({
    super.key,
    this.validator,
    this.value,
    this.keyField,
    this.onSaved,
    this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.maxLength,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLength: maxLength,
      maxLines: maxLines,
      controller: controller,
      onSaved: onSaved,
      key: keyField,
      initialValue: value,
      validator: validator,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(color: bodyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(color: bodyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(color: errorColor, width: 2),
        ),
        fillColor: surfaceColor,
        filled: true,
      ),
    );
  }
}

class GbPasswordField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? value;
  final Key? keyField;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  const GbPasswordField({
    super.key,
    this.validator,
    this.value,
    this.keyField,
    this.onSaved,
    this.controller,
    this.textInputAction,
  });

  @override
  State<GbPasswordField> createState() => _GbPasswordFieldState();
}

class _GbPasswordFieldState extends State<GbPasswordField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  Widget _icon = Container(
      key: const ValueKey<int>(1), child: const Icon(Icons.remove_red_eye));

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
          textInputAction: widget.textInputAction,
          obscureText: _obscureText,
          controller: widget.controller,
          onSaved: widget.onSaved,
          key: widget.keyField,
          initialValue: widget.value,
          validator: widget.validator,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(color: bodyColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(color: bodyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(color: errorColor, width: 2),
            ),
            fillColor: surfaceColor,
            filled: true,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            child: Container(
              width: 55,
              height: 55,
              color: Colors.transparent,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _icon,
              ),
            ),
            onTap: () {
              setState(
                () {
                  _obscureText = !_obscureText;
                  _icon = _obscureText
                      ? Container(
                          key: const ValueKey<int>(1),
                          child: const Icon(Icons.remove_red_eye))
                      : Container(
                          key: const ValueKey<int>(2),
                          child: const Icon(Icons.remove_red_eye_outlined),
                        );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
