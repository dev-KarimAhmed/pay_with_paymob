// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:pay_with_paymob/src/services/dio_helper.dart';
import 'package:pay_with_paymob/src/views/visa_view.dart';

import 'mobile_wallet_view.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({
    super.key,
    required this.onPaymentSuccess,
    required this.price,
    required this.onPaymentError,
  });

  final VoidCallback onPaymentSuccess;
  final double price;
  final VoidCallback onPaymentError;

  @override
  PaymentViewState createState() => PaymentViewState();
}

class PaymentViewState extends State<PaymentView> {
  String _selectedPaymentMethod = 'Visa';
  String redirectUrl = "";
  String paymentFirstToken = '';
  String paymentOrderId = '';
  String finalToken = '';
  final PaymentData paymentData = PaymentData();


  bool isAuthLoading = false,
      isOrderLoading = false,
      isPaymentRequestLoading = false,
      isMobileWalletLoading = false;
  bool isAuthSuccess = false,
      isOrderSuccess = false,
      isPaymentRequestSuccess = false,
      isMobileWalletSuccess = false;
  bool isAuthFailure = false,
      isOrderFailure = false,
      isPaymentRequestFailure = false,
      isMobileWalletFailure = false;

  final TextEditingController walletMobileNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAuthToken();
  }

  bool isLoading() =>
      isAuthLoading ||
      isOrderLoading ||
      isPaymentRequestLoading ||
      isMobileWalletLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paymentData.style?.scaffoldColor,
      appBar: _buildAppBar(),
      body: isLoading()
          ? Center(
              child: CircularProgressIndicator(
              color: paymentData.style?.circleProgressColor ?? Colors.blue,
            ))
          : _buildPaymentOptions(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: paymentData.style?.appBarBackgroundColor,
      foregroundColor: paymentData.style?.appBarForegroundColor,
      title: const Text('Select Payment Method'),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildPaymentOption(
            label: 'Pay with Visa',
            icon: Icons.credit_card,
            isSelected: _selectedPaymentMethod == 'Visa',
            onTap: () => _setSelectedPaymentMethod('Visa'),
          ),
          const SizedBox(height: 20),
          _buildPaymentOption(
            label: 'Pay with Mobile Wallet',
            icon: Icons.phone_android,
            isSelected: _selectedPaymentMethod == 'Mobile Wallet',
            onTap: () => _setSelectedPaymentMethod('Mobile Wallet'),
            isVisa: false,
          ),
          const SizedBox(height: 30),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            child: _selectedPaymentMethod == 'Visa'
                ? Container()
                : _buildMobileWalletForm(),
          ),
          const Spacer(),
          _buildConfirmPaymentButton(),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    bool isVisa = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? paymentData.style?.primaryColor ?? Colors.blue
                : paymentData.style?.unselectedColor ?? Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isSelected
                    ? paymentData.style?.primaryColor ?? Colors.blue
                    : paymentData.style?.unselectedColor ?? Colors.grey),
            const SizedBox(width: 10),
            Text(label, style: paymentData.style?.textStyle),
            isVisa
                ? const SizedBox()
                : paymentData.style?.showMobileWalletIcons == true
                    ? Row(
                        children: [
                          Image.asset(
                            "assets/images/vodafone.png",
                            height: 30,
                            width: 40,
                          ),
                          Image.asset(
                            "assets/images/etisalat.png",
                            height: 30,
                            width: 40,
                          ),
                          Image.asset(
                            "assets/images/we.png",
                            height: 30,
                            width: 40,
                          ),
                          Image.asset(
                            "assets/images/orange.png",
                            height: 30,
                            width: 30,
                          ),
                        ],
                      )
                    : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileWalletForm() {
    return Column(
      children: [
        TextFormField(
          controller: walletMobileNumber,
          keyboardType: TextInputType.number,
          cursorColor: paymentData.style?.primaryColor ?? Colors.blue,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.wallet,
                color: paymentData.style?.primaryColor ?? Colors.blue),
            hintText: 'Enter your mobile wallet number',
            hintStyle: paymentData.style?.textStyle,
            border: _inputBorder(),
            focusedBorder: _inputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        // _buildPayButton(),
      ],
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(
          color: paymentData.style?.primaryColor ?? Colors.blue, width: 2),
    );
  }

  Widget _buildConfirmPaymentButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await _handlePaymentConfirmation();
        },
        style: paymentData.style?.buttonStyle ?? _defaultButtonStyle(),
        child: const Text('Confirm Payment', style: TextStyle(fontSize: 18)),
      ),
    );
  }

  ButtonStyle _defaultButtonStyle() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    );
  }

  void _setSelectedPaymentMethod(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }

  Future<void> _handlePaymentConfirmation() async {
    await getOrderRegisrationId().then((_) {
      if (_selectedPaymentMethod == 'Visa') {
        widget.onPaymentSuccess;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VisaScreen(
              onError: widget.onPaymentError,
              onFinished: widget.onPaymentSuccess,
              finalToken: finalToken,
              iframeId: paymentData.iframeId,
            ),
          ),
        );
      } else {
        payWithMobileWallet(walletMobileNumber: walletMobileNumber.text)
            .then((val) {
          widget.onPaymentSuccess;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MobileWalletScreen(
                onError: widget.onPaymentError,
                onSuccess: widget.onPaymentSuccess,
                redirectUrl: redirectUrl,
              ),
            ),
          );
        });
      }
    });
  }

  Future<void> getAuthToken() async {
    _setLoadingState(isAuthLoading: true);
    try {
      final response = await DioHelper.postData(
        url: '/auth/tokens',
        data: {
          "api_key": paymentData.apiKey,
        },
      );
      paymentFirstToken = response.data['token'];
      _setSuccessState(isAuthSuccess: true);
    } catch (error) {
      _setFailureState(isAuthFailure: true);
    } finally {
      _setLoadingState(isAuthLoading: false);
    }
  }

  Future<void> getOrderRegisrationId() async {
    _setLoadingState(isOrderLoading: true);
    try {
      final response = await DioHelper.postData(
        url: '/ecommerce/orders',
        data: {
          "auth_token": paymentFirstToken,
          "delivery_needed": "false",
          "amount_cents": (widget.price * 100).toString(),
          "currency": "EGP",
          "items": [],
        },
      );
      paymentOrderId = response.data['id'].toString();

      // Proceed to request payment key
      await getPaymentRequest();

      _setSuccessState(isOrderSuccess: true);
    } catch (error) {
      _setFailureState(isOrderFailure: true);
    } finally {
      _setLoadingState(isOrderLoading: false);
    }
  }

  Future<void> getPaymentRequest() async {
    _setLoadingState(isPaymentRequestLoading: true);

    final requestData = {
      "auth_token": paymentFirstToken,
      "amount_cents": (widget.price * 100).toString(),
      "expiration": 3600,
      "order_id": paymentOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": paymentData.userData?.email ?? 'NA',
        "floor": "NA",
        "first_name": paymentData.userData?.name ?? 'NA',
        "street": "NA",
        "building": "NA",
        "phone_number": paymentData.userData?.phone ?? 'NA',
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": paymentData.userData?.lastName ?? 'NA',
        "state": "NA",
      },
      "currency": "EGP",
      "integration_id": _selectedPaymentMethod == 'Visa'
          ? paymentData.integrationCardId
          : paymentData.integrationMobileWalletId,
      "lock_order_when_paid": "false",
    };

    try {
      final response = await DioHelper.postData(
        url: '/acceptance/payment_keys',
        data: requestData,
      );
      finalToken = response.data['token'];
      _setSuccessState(isPaymentRequestSuccess: true);
    } catch (error) {
      _setFailureState(isPaymentRequestFailure: true);
    } finally {
      _setLoadingState(isPaymentRequestLoading: false);
    }
  }

  Future<void> payWithMobileWallet({required String walletMobileNumber}) async {
    _setLoadingState(isMobileWalletLoading: true);

    final paymentData = {
      "source": {
        "identifier": walletMobileNumber,
        "subtype": "WALLET",
      },
      "payment_token": finalToken,
    };

    try {
      final response = await DioHelper.postData(
        url: '/acceptance/payments/pay',
        data: paymentData,
      );

      if (response.data.containsKey('redirect_url')) {
        redirectUrl = response.data['redirect_url'].toString();
        _setSuccessState(isMobileWalletSuccess: true);
      } else {
        _setFailureState(isMobileWalletFailure: true);
      }
    } catch (error) {
      _setFailureState(isMobileWalletFailure: true);
    } finally {
      _setLoadingState(isMobileWalletLoading: false);
    }
  }

  void _setLoadingState({
    bool? isAuthLoading,
    bool? isOrderLoading,
    bool? isPaymentRequestLoading,
    bool? isMobileWalletLoading,
  }) {
    setState(() {
      if (isAuthLoading != null) this.isAuthLoading = isAuthLoading;
      if (isOrderLoading != null) this.isOrderLoading = isOrderLoading;
      if (isPaymentRequestLoading != null) {
        this.isPaymentRequestLoading = isPaymentRequestLoading;
      }
      if (isMobileWalletLoading != null) {
        this.isMobileWalletLoading = isMobileWalletLoading;
      }
    });
  }

  void _setSuccessState({
    bool? isAuthSuccess,
    bool? isOrderSuccess,
    bool? isPaymentRequestSuccess,
    bool? isMobileWalletSuccess,
  }) {
    setState(() {
      if (isAuthSuccess != null) this.isAuthSuccess = isAuthSuccess;
      if (isOrderSuccess != null) this.isOrderSuccess = isOrderSuccess;
      if (isPaymentRequestSuccess != null) {
        this.isPaymentRequestSuccess = isPaymentRequestSuccess;
      }
      if (isMobileWalletSuccess != null) {
        this.isMobileWalletSuccess = isMobileWalletSuccess;
      }
    });
  }

  void _setFailureState({
    bool? isAuthFailure,
    bool? isOrderFailure,
    bool? isPaymentRequestFailure,
    bool? isMobileWalletFailure,
  }) {
    setState(() {
      if (isAuthFailure != null) this.isAuthFailure = isAuthFailure;
      if (isOrderFailure != null) this.isOrderFailure = isOrderFailure;
      if (isPaymentRequestFailure != null) {
        this.isPaymentRequestFailure = isPaymentRequestFailure;
      }
      if (isMobileWalletFailure != null) {
        this.isMobileWalletFailure = isMobileWalletFailure;
      }
    });
  }

  @override
  void dispose() {
    walletMobileNumber.dispose();
    super.dispose();
  }
}
