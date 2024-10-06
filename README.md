
<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# pay_with_paymob

A Flutter package that simplifies the integration of pay_with_paymob gateway for Visa and mobile wallet payments.

## Features

- Easy integration with Paymob's payment system.
- Support for multiple payment methods: Visa and mobile wallets.
- Customizable payment view with style options.
- User data collection for payments.
- Callbacks for payment success and error handling.

## Getting started

### Prerequisites

- Flutter SDK installed on your machine.
- A Paymob account to get your API key and other necessary credentials.

### Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
 pay_with_paymob : ^1.1.2  
```

## Usage

### Initializing Payment Data

Before using the payment functionality, initialize your payment data (preferably in the `main` function):

```dart
PaymentData.initialize(
  apiKey: "Your Api key", // (Required) getting it from dashboard Select Settings -> Account Info -> API Key
  iframeId: "", // (Required) getting it from paymob Select Developers -> iframes
  integrationCardId: "", // (Required) getting it from dashboard Select Developers -> Payment Integrations -> Online Card ID
  integrationMobileWalletId: "", // (Required) getting it from dashboard Select Developers -> Payment Integrations -> Mobile Wallet ID
  
  // Optional User Data
  userData: UserData(
    email: "User Email", // (Optional) Email | Default: 'NA'
    phone: "User Phone", // (Optional) Phone | Default: 'NA'
    firstName: "User First Name", // (Optional) First Name | Default: 'NA'
    lastName: "User Last Name", // (Optional) Last Name | Default: 'NA'
  ),
  
  // Optional Style
  style: Style(
    primaryColor: Colors.blue, // (Optional) Default: Colors.blue
    scaffoldColor: Colors.white, // (Optional) Default: Colors.white
    appBarBackgroundColor: Colors.blue, // (Optional) Default: Colors.blue
    appBarForegroundColor: Colors.white, // (Optional) Default: Colors.white
    textStyle: TextStyle(), // (Optional) Default: TextStyle()
    buttonStyle: ElevatedButton.styleFrom(), // (Optional) Default: ElevatedButton.styleFrom(...)
    circleProgressColor: Colors.blue, // (Optional) Default: Colors.blue
    unselectedColor: Colors.grey, // (Optional) Default: Colors.grey
    showMobileWalletIcons: true, // (Optional) Default: true
  ),
);
```

### Navigating to Payment View

After initializing, navigate to the payment view as follows:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => PaymentView(
    onPaymentSuccess: () {
      // Handle payment success
    },
    onPaymentError: () {
      // Handle payment error
    },
    price: 100, // (Required) Total Price e.g. 100 => 100 LE
  )),
);
```

## Additional information

For more details and support, please check the [documentation](https://github.com/dev-KarimAhmed/paymob_payment_package).

If you encounter any issues, feel free to open an issue on the GitHub repository. Contributions are welcome!

```

تأكد من تحديث أي روابط أو معلومات تتعلق بالحزمة حسب الحاجة. إذا كان لديك أي تعديلات أو إضافات أخرى، لا تتردد في إخباري!
