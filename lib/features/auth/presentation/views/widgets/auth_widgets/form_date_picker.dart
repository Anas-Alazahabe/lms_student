import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormDatePicker extends StatelessWidget {
  const FormDatePicker({
    super.key,
    //required GlobalKey<FormBuilderState> formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.10,
      child: FormBuilderDateTimePicker(
        name: 'date',
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialValue: DateTime(2006),
        inputType: InputType.date,
        firstDate: DateTime(1990),
        lastDate: DateTime(2020),
        decoration: InputDecoration(
          labelText: 'Birth Date',

          // suffixIcon: IconButton(
          //   icon: const Icon(Icons.close),
          //   onPressed: () {
          //     _formKey.currentState!.fields['date']?.didChange(null);
          //   },
          // ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFF828282)),
          ),
        ),
        // initialTime: const TimeOfDay(hour: 8, minute: 0),
        // locale: const Locale.fromSubtags(languageCode: 'fr'),
      ),
    );
  }
}
