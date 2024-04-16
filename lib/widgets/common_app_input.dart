import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_tracker/app/app_colors.dart';

/// Common app input used in whole app
class CommonAppInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPassword;
  final bool isEnable;
  final bool isMobileNumber;
  final bool autofocus;
  final double borderRadius;
  final String hintText;
  final String headerText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? suffixIcon;
  final Widget? suffixWidget;
  final VoidCallback? onSuffixClick;
  final VoidCallback? onSubmitClick;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final Widget? prefixIcon;
  final InputDecoration? inputDecoration;
  final Color? filledColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintColor;
  final double? height;
  final int? maxLine;
  final bool? isAmount;
  final bool readOnly;
  final FocusNode? focusNode;
  final double? contentPadding;
  final double? contentPaddingVertical;
  final int? maxLength;

  const CommonAppInput(
      {Key? key,
      required this.textEditingController,
      this.textInputType = TextInputType.text,
      this.isPassword = false,
      this.isMobileNumber = false,
      this.isEnable = true,
      this.isAmount = false,
      this.borderRadius = 0,
      this.hintText = '',
      this.headerText = '',
      this.hintStyle,
      this.labelStyle,
      this.suffixIcon,
      this.suffixWidget,
      this.onSuffixClick,
      this.onSubmitClick,
      this.inputDecoration,
      this.prefixIcon,
      this.focusNode,
      this.readOnly = false,
      this.autofocus = false,
      this.textInputAction = TextInputAction.next,
      this.textCapitalization = TextCapitalization.none,
      this.filledColor,
      this.borderColor,
      this.textColor,
      this.hintColor,
      this.height,
      this.maxLine,
      this.contentPadding,
      this.contentPaddingVertical,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50.h,
      child: TextField(
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: isPassword,
        maxLines: maxLine ?? 1,
        enabled: isEnable,
        onSubmitted: (_) {
          onSubmitClick!();
        },
        cursorColor: AppColors.colorBlack,
        focusNode: focusNode,
        autofocus: autofocus,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        inputFormatters: isAmount!
            ? <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
              ]: <TextInputFormatter>[
                // FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
        autocorrect: true,
        readOnly: readOnly,
        maxLength: maxLength,
        style: GoogleFonts.montserrat(
          color: textColor ?? AppColors.colorBlack,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        decoration: inputDecoration ??
            InputDecoration(
              counterText: "",
              hintText: hintText,
              hintStyle: GoogleFonts.montserrat(
                color: hintColor ?? Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              suffixIcon:
                  suffixIcon != null ? Padding(padding: EdgeInsets.only(left: 15.w, right: 21.w), child: suffixIcon) : null,
              contentPadding: EdgeInsets.symmetric(vertical: contentPaddingVertical ?? 0.0, horizontal: contentPadding ?? 20.w),
              filled: true,
              fillColor: filledColor ?? AppColors.colorWhite,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius != 0 ? borderRadius : 12.0.r)),
                borderSide: BorderSide(color: borderColor ?? Colors.grey, width: 1.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius != 0 ? borderRadius : 12.0.r)),
                borderSide: BorderSide(color: AppColors.colorBlack, width: 1.w),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius != 0 ? borderRadius : 12.0.r)),
                borderSide: BorderSide(color: Colors.grey, width: 1.w),
              ),
            ),
      ),
    );
  }
}
