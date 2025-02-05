import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lms_student/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_student/core/utils/functions/custom_toast.dart';
import 'package:lms_student/core/utils/service_locator.dart';
import 'package:lms_student/core/widgets/custom_button.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:lms_student/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';

class SignButton extends StatefulWidget {
  final String deviceToken;
  final VoidCallback onButtonPressed;
  final GlobalKey<FormBuilderState> formKey;
  // final Function(bool state) failedToLogState;
  // final Function(bool state) showCodeState;
  final bool showCode;
  final bool isSignIn;
  // final bool failedToLog;
  final String verificationCode;
  final String imageId;

  const SignButton({
    super.key,
    required this.deviceToken,
    required this.onButtonPressed,
    required this.formKey,
    required this.isSignIn,
    //required this.failedToLogState,
    // required this.failedToLog,
    //  required this.showCodeState,
    required this.verificationCode,
    required this.showCode,
    required this.imageId,
  });

  @override
  State<SignButton> createState() => _SignButtonState();
}

class _SignButtonState extends State<SignButton> {
  final storageCubit = getIt<SharedPreferencesCubit>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            // widget.failedToLogState(true);

            // failedToLog = true;
            if (state.errMessage ==
                'The device token has already been taken.') {
              customToast('هذا الحساب قيد الاستخدام بالفعل');
              // isSignIn = true;
              //   widget.onButtonPressed();
              // failedToLog = false;
              //  widget.failedToLogState(false);

              return;
            }
            if (state.errMessage == 'Invalid credentials') {
              // widget.showCodeState(true);
              // showCode = true;
              customToast('قيم غير صالحة');
              //  widget.onButtonPressed();
              //  widget.failedToLogState(false);

              //  failedToLog = false;
              return;
            }

            customToast(state.errMessage);
            //  widget.onButtonPressed();
          }
          if (state is AuthSuccess) {
            // failedToLog = false;
            // widget.failedToLogState(false);

            widget.onButtonPressed();
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CustomLoading(),
            );
          }

          return CustomButton(
            onPressed: () {
              if (widget.verificationCode.trim().length < 7 &&
                  widget.showCode &&
                  widget.isSignIn) {
                customToast('يجب ان يكون الرمز 7 محارف على الاقل');
                return;
              }
              // widget.formKey.currentState!.save();
              if (widget.isSignIn) {
                BlocProvider.of<AuthCubit>(context).signInWithUsernameAndToken(
                    widget.deviceToken, widget.verificationCode);
              } else {
                if (widget.formKey.currentState!.validate()) {
                  widget.formKey.currentState!.save();
                  DateFormat inputFormat = DateFormat("yyyy-MM-dd");
                  DateFormat outputFormat = DateFormat("yyyy/M/d");
                  DateTime dateTime = inputFormat.parse(
                      widget.formKey.currentState!.value['date'].toString());
                  String outputDate = outputFormat.format(dateTime);
                  BlocProvider.of<AuthCubit>(context).signUpWithNameAndToken(
                    widget.formKey.currentState!.value['full_name'],
                    //  widget.formKey.currentState!.value['email'],
                    widget.formKey.currentState!.value['address'],
                    outputDate.toString(),
                    widget.formKey.currentState!.value['year'],
                    widget.imageId,
                    widget.formKey.currentState!.value['gender'],
                    storageCubit.getId()!,
                    widget.deviceToken,
                  );
                }
              }
            },
            text: widget.isSignIn ? 'Login' : 'Continue',
          );
        },
      ),
    );
  }
}
