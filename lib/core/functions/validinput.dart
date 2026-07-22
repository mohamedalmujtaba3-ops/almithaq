import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (type == "username") {
    if (!GetUtils.isTxt(val)) {
      return "ادخال غير صالح";
    }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "ادخال غير صالح";
    }
  }

  if (type == "text") {
    // if (!GetUtils.isTxt(val)) {
    //   return "ادخال غير صالح";
    // }
  }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "ادخال غير صالح";
    }
  }

  if (val.isEmpty) {
    return "لا يمكن تركه فارغاً";
  }

  if (val.length < min) {
    return "لا يجب ان يقل عن $min";
  }

  if (val.length > max) {
    return "لا يجب ان يزيد عن $max";
  }
}
