
# pay_with_paymob

**A Flutter package to simplify Paymob gateway integration for Visa and mobile wallet payments.**  

## Features  

<<<<<<< HEAD
- Easy integration with Paymob's payment system.  
- Support for multiple payment methods: Visa and mobile wallets.  
- Customizable payment view with flexible style options.  
- User data collection for enhanced payment experiences.  
- Callbacks for handling payment success and errors.  

---
=======
# pay_with_paymob

A Flutter package that simplifies the integration of Paymob gateway for Visa and mobile wallet payments.
>>>>>>> f590b71af9211ba066d7a7ebe79821eab643a677

## Getting Started  

### Prerequisites  

1. Flutter SDK installed on your machine.  
2. A Paymob account to acquire the API key and other necessary credentials.  

### Installation  

Add the following line to your `pubspec.yaml` file:  

```yaml  
dependencies:  
  pay_with_paymob: ^1.3.4
```  

Run `flutter pub get` to install the package.  

<<<<<<< HEAD
---
=======
```yaml
dependencies:
 pay_with_paymob : ^1.1.2  
```
>>>>>>> f590b71af9211ba066d7a7ebe79821eab643a677

## Usage  

### Initializing Payment Data  

Before proceeding with payment, initialize your payment data (in the `main` function or the `initState` of your widget):  

```dart  
PaymentData.initialize(
  apiKey: "Your API Key", // Required: Obtain from dashboard -> Settings -> Account Info -> API Key
  iframeId: "Your Iframe ID", // Required: Obtain from Developers -> iframes
  integrationCardId: "Your Card Integration ID", // Required: Obtain from Developers -> Payment Integrations -> Online Card ID
  integrationMobileWalletId: "Your Wallet Integration ID", // Required: Obtain from Developers -> Payment Integrations -> Mobile Wallet ID

  // Optional User Data
  userData: UserData(
    email: "User Email", // Optional: Default is 'NA'
    phone: "User Phone", // Optional: Default is 'NA'
    firstName: "User First Name", // Optional: Default is 'NA'
    lastName: "User Last Name", // Optional: Default is 'NA'
  ),
  
  // Optional Style Customizations
  style: Style(
    primaryColor: Colors.blue, // Default: Colors.blue
    scaffoldColor: Colors.white, // Default: Colors.white
    appBarBackgroundColor: Colors.blue, // Default: Colors.blue
    appBarForegroundColor: Colors.white, // Default: Colors.white
    textStyle: TextStyle(), // Default: TextStyle()
    buttonStyle: ElevatedButton.styleFrom(), // Default: ElevatedButton.styleFrom()
    circleProgressColor: Colors.blue, // Default: Colors.blue
    unselectedColor: Colors.grey, // Default: Colors.grey
    showMobileWalletIcons: true, // Default: true
  ),
);
```  

### Navigating to the Payment View  

Once initialized, navigate to the payment view using:  

```dart  
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PaymentView(
      onPaymentSuccess: () {
        // Handle successful payment
      },
      onPaymentError: () {
        // Handle payment error
      },
      price: 100, // Required: Total price, e.g., 100 means 100 EGP
    ),
  ),
);
```  

---

## Additional Information  

### Test Data for Simulation  

**Visa Card:**  
- **Card Number:** 5123456789012346  
- **Card Holder Name:** Test Account  
- **Expiry Date:** 12/25  
- **CVV:** 123  

<<<<<<< HEAD
**Mobile Wallet:**  
- **Wallet Number:** 01010101010  
- **MPIN:** 123456  
- **One-Time Password:** 123456  

For further details, refer to the [documentation](https://github.com/dev-KarimAhmed/paymob_payment_package).  

### Contributions  

We welcome contributions! If you encounter issues or have suggestions, feel free to open an issue on GitHub.  
=======
تأكد من تحديث أي روابط أو معلومات تتعلق بالحزمة حسب الحاجة. إذا كان لديك أي تعديلات أو إضافات أخرى، لا تتردد في إخباري!
>>>>>>> f590b71af9211ba066d7a7ebe79821eab643a677
