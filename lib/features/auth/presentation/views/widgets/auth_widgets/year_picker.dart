import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lms_student/features/auth/data/models/index_address_years/year.dart';

class MyYearPicker extends StatelessWidget {
  final List<Year> years;
  const MyYearPicker({
    super.key,
    required this.years,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.10,
      child: FormBuilderDropdown<String>(
        name: 'year',
        decoration: InputDecoration(
          labelText: 'academic year',
          hintText: 'Choose the academic year',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFF828282)),
          ),
        ),
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
        items: years
            .map((year) => DropdownMenuItem(
                  alignment: AlignmentDirectional.center,
                  value: year.id.toString(),
                  child: Text(year.year!),
                ))
            .toList(),
        valueTransformer: (val) => val?.toString(),
      ),
    );
  }
}
