const productionUrl = 'https://spprdsrvr1.shaktipumps.com:8423/sap/bc/bsp/sap/';

userLogin(String serialNumber) {
  return Uri.parse('${productionUrl}zemp_hr_portal/setting_parameter_app.htm?lv_sernr=$serialNumber');
}
