
import 'package:flutter/foundation.dart';

const productionUrl = 'https://spprdsrvr1.shaktipumps.com:8423/sap/bc/bsp/sap/';
const rmsServerURL = "https://solar10.shaktisolarrms.com/RMSAppTest/";

userLogin(String serialNumber) {
  return Uri.parse('${productionUrl}zemp_hr_portal/setting_parameter_app.htm?lv_sernr=$serialNumber');
}

gethomeList(String pumpCodeID) {
  return Uri.parse('${rmsServerURL}MoterParamList?id=$pumpCodeID');
}
