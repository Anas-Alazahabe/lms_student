// import 'package:flutter/material.dart';
// import 'package:lms_student/features/auth/presentation/views/variables/variables.dart';
// import 'package:lms_student/features/auth/presentation/views/widgets/auth_widgets/auth_text_field.dart';

// class PasswordTextField extends StatelessWidget {
//   const PasswordTextField({
//     super.key,
//     required this.viewPasswordState,
//   });
//   final void Function() viewPasswordState;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 0),
//       child: AuthTextField(
//           obscureText: hidePassword,
//           prefixIcon: const Icon(
//             Icons.password,
//           ),
//           suffixIcon: IconButton(
//             icon: Icon(
//               hidePassword ? Icons.visibility_off : Icons.visibility,
//             ),
//             onPressed: viewPasswordState,
//           ),
//           textInputType: TextInputType.visiblePassword,
//           validator: (value) => passwordValidator!(value, context),
//           onSave: (newValue) {
//             password = newValue!;
//           },
//           formatter: passwordFormatter,
//           hintText: 'كلمة المرور'),
//     );
//   }
// }
