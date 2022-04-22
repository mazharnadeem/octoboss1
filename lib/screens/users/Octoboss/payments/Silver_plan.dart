import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:pay/pay.dart';
// import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.canvasColor,
     
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            Divider(),
            _CartTotal(),
          ],
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
 
  final _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '24.99',
    status: PaymentItemStatus.final_price,
  )
];
 
  
  @override
  Widget build(BuildContext context) {

  
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
      
          // 30.widthBox,
          Row(
            children: [
              ApplePayButton(
                paymentConfigurationAsset: 'applepay.json',
                paymentItems: _paymentItems,
                width: 200,
                height: 50,
                style: ApplePayButtonStyle.black,
                type: ApplePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: (data) {
                  print(data);
                },
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              GooglePayButton(
                paymentConfigurationAsset: 'gpay.json',
                paymentItems: _paymentItems,
                width: 200,
                height: 50,
                style: GooglePayButtonStyle.black,
                type: GooglePayButtonType.pay,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: (data) {
                  print(data);
                },
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          )
          // ElevatedButton(
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //       content: "Buying not supported yet.".text.make(),
          //     ));
          //   },
          //   style: ButtonStyle(
          //       backgroundColor:
          //           MaterialStateProperty.all(context.theme.buttonColor)),
          //   child: "Buy".text.white.make(),
          // ).w32(context)
        ],
      ),
    );
  }
}










// /// Copyright 2021 Google LLC
// ///
// /// Licensed under the Apache License, Version 2.0 (the "License");
// /// you may not use this file except in compliance with the License.
// /// You may obtain a copy of the License at
// ///
// ///     https://www.apache.org/licenses/LICENSE-2.0
// ///
// /// Unless required by applicable law or agreed to in writing, software
// /// distributed under the License is distributed on an "AS IS" BASIS,
// /// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// /// See the License for the specific language governing permissions and
// /// limitations under the License.

// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:pay/pay.dart';



// const _paymentItems = [
//   PaymentItem(
//     label: 'Total',
//     amount: '99.99',
//     status: PaymentItemStatus.final_price,
//   )
// ];

// class PayMaterialApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pay for Flutter Demo',
//       localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//       ],
//       supportedLocales: [
//         const Locale('en', ''),
//         const Locale('es', ''),
//         const Locale('de', ''),
//       ],
//       home: PaySampleApp(),
//     );
//   }
// }

// class PaySampleApp extends StatefulWidget {
//   PaySampleApp({Key? key}) : super(key: key);

//   @override
//   _PaySampleAppState createState() => _PaySampleAppState();
// }

// class _PaySampleAppState extends State<PaySampleApp> {
//   void onGooglePayResult(paymentResult) {
//     debugPrint(paymentResult.toString());
//   }

//   void onApplePayResult(paymentResult) {
//     debugPrint(paymentResult.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('T-shirt Shop'),
//       ),
//       backgroundColor: Colors.white,
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 20),
//             child: const Image(
//               image: NetworkImage('data:image/jpeg;base64,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'),
//               height: 350,
//             ),
//           ),
//           const Text(
//             'Amanda\'s Polo Shirt',
//             style: TextStyle(
//               fontSize: 20,
//               color: Color(0xff333333),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 5),
//           const Text(
//             '\$50.20',
//             style: TextStyle(
//               color: Color(0xff777777),
//               fontSize: 15,
//             ),
//           ),
//           const SizedBox(height: 15),
//           const Text(
//             'Description',
//             style: TextStyle(
//               fontSize: 15,
//               color: Color(0xff333333),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 5),
//           const Text(
//             'A versatile full-zip that you can wear all day long and even...',
//             style: TextStyle(
//               color: Color(0xff777777),
//               fontSize: 15,
//             ),
//           ),
//           GooglePayButton(
//             paymentConfigurationAsset:
//                 'gpay.json.json',
//             paymentItems: _paymentItems,
//             style: GooglePayButtonStyle.black,
//             type: GooglePayButtonType.pay,
//             margin: const EdgeInsets.only(top: 15.0),
//             onPaymentResult: onGooglePayResult,
//             loadingIndicator: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//           ApplePayButton(
//             paymentConfigurationAsset: 'applepay.json',
//             paymentItems: _paymentItems,
//             style: ApplePayButtonStyle.black,
//             type: ApplePayButtonType.buy,
//             margin: const EdgeInsets.only(top: 15.0),
//             onPaymentResult: onApplePayResult,
//             loadingIndicator: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//           const SizedBox(height: 15)
//         ],
//       ),
//     );
//   }
// }