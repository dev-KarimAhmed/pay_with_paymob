




import 'package:pay_with_paymob/src/models/style.dart';
import 'package:pay_with_paymob/src/models/user_data.dart';

class PaymentData {
  static String _apiKey = "";
  static String _integrationCardId = "";
  static String _integrationMobileWalletId = "";
  static String _iframeId = "";
  static UserData? _userData = UserData();
  static Style? _style = Style();



  static void initialize({required String apiKey , required String iframeId , required String integrationCardId , required String integrationMobileWalletId , UserData? userData , Style? style}) {
    PaymentData._apiKey = apiKey;
    PaymentData._iframeId = iframeId;
    PaymentData._integrationCardId = integrationCardId;
    PaymentData._integrationMobileWalletId = integrationMobileWalletId;
    PaymentData._userData = userData;
    PaymentData._style = style;
  }

   String get apiKey => PaymentData._apiKey;
   String get integrationCardId => PaymentData._integrationCardId;
   String get integrationMobileWalletId => PaymentData._integrationMobileWalletId;
   String get iframeId => PaymentData._iframeId;
   UserData? get userData => PaymentData._userData;
   Style? get style => PaymentData._style;

}
