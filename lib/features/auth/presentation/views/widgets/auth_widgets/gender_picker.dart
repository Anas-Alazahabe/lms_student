import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class GenderPicker extends StatelessWidget {
  const GenderPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.10,
      child: FormBuilderRadioGroup<String>(
        decoration: InputDecoration(
          labelText: 'Gender',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFF828282)),
          ),
        ),
        initialValue: '0',
        name: 'gender',
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
        options: [
          'ذكر',
          'أنثى',
        ]
            .map((lang) => FormBuilderFieldOption(
                  value: lang == 'ذكر' ? '0' : '1',
                  child: Text(lang),
                ))
            .toList(growable: false),
        controlAffinity: ControlAffinity.trailing,
      ),
    );
  }
}
