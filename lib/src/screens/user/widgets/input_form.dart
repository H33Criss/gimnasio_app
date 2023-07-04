import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

typedef FormValidator = String? Function(String? value);

class InputForm extends StatefulWidget {
  final FormValidator? validator;
  final String text;
  final String? helperText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool passObscure;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? helperStyle;
  final bool enableEyeMode;
  final FloatingLabelBehavior? labelMode;
  final String? placeholder;
  const InputForm({
    super.key,
    required this.text,
    required this.controller,
    this.textInputType,
    this.validator,
    this.passObscure = false,
    this.suffixIcon,
    this.enableEyeMode = false,
    this.helperText,
    this.prefixIcon,
    this.helperStyle,
    this.labelMode,
    this.placeholder,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  late bool passObscure;
  late IconData eye;

  @override
  void initState() {
    super.initState();
    passObscure = widget.passObscure;
    eye = MdiIcons.eye;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextFormField(
      obscureText: passObscure,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      style: TextStyle(color: colors.secondary),
      decoration: InputDecoration(
          // errorText: 'Error',
          floatingLabelBehavior: widget.labelMode,
          suffixIcon: widget.enableEyeMode
              ? IconButton(
                  icon: Icon(
                    (eye),
                    color: colors.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      passObscure = !passObscure;
                      if (!passObscure) {
                        eye = MdiIcons.eyeOff;
                      } else {
                        eye = MdiIcons.eye;
                      }
                    });
                  },
                )
              : null,
          labelStyle: TextStyle(color: colors.primary),
          labelText: widget.text,
          helperText: widget.helperText,
          helperStyle: widget.helperStyle,
          prefixIcon: widget.prefixIcon,
          hintText: widget.placeholder,
          hintStyle:
              TextStyle(color: colors.primary.withOpacity(.6), fontSize: 14),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colors.primary.withOpacity(.7)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colors.primary),
          ),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: colors.error)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.error.withOpacity(.7)))
          // focusColor: Colors.green,
          ),
    );
  }
}
